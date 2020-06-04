Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4518C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25A9206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591301727;
	bh=nh6iqP7pKii9WtoysGEakHtXlKm8WZrihRzKio25mpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wyJJhKeM0iftS59Po9UsjL6vu0VXit7V/FwIZWmHZgQ1PRUYhyApNW6TE14EOQv72
	 vONTzFGZM74Luu7JsiIofgjgRQyk2aeNlsdf0EF33ujsEYWnbSXQf890Hx6+8Jwq3i
	 Lrblxjx3zqrQQguEMQEPmME9DWxhlhwu/qcmq0pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgFDUP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:15:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgFDUP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:15:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8086B2067B;
        Thu,  4 Jun 2020 20:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591301726;
        bh=nh6iqP7pKii9WtoysGEakHtXlKm8WZrihRzKio25mpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L0sRYQaMkF8MApvnQWJxq7PThTjN3ACXwLABb5mU8JIeqeXPe4Vt33AYljlyvHvZ9
         BG0V+j+461wfVDLQNa1wln1Z3bGbIKL2SYzB9tYQ5gNPVLLvdo5pn1qIJ5CAncYGTD
         ZgRKqJ+Gva8WlhVQiBZe/Jm/iK1SCVekAgwqcDmI=
Date:   Thu, 4 Jun 2020 22:15:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     jorhand@linux.microsoft.com
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] software node: recursively unregister child swnodes
Message-ID: <20200604201523.GA1308830@kroah.com>
References: <20200604193623.16946-1-jorhand@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604193623.16946-1-jorhand@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 12:36:23PM -0700, jorhand@linux.microsoft.com wrote:
> From: Jordan Hand <jorhand@linux.microsoft.com>
> 
> If a child swnode is unregistered after it's parent, it can lead to
> undefined behavior.

Crashing the system is not really "undefined" :)

> When a swnode is unregistered, recursively free it's children to avoid
> this condition.

Are you sure?  Why would you be unregistering a child after it's parent?
Why not just do not do that?

> 
> Signed-off-by: Jordan Hand <jorhand@linux.microsoft.com>
> ---
>  drivers/base/swnode.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index e5eb27375416..e63093b1542b 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -619,6 +619,8 @@ static void software_node_release(struct kobject *kobj)
>  		property_entries_free(swnode->node->properties);
>  		kfree(swnode->node);
>  	}
> +
> +	list_del(&kobj->entry);
>  	ida_destroy(&swnode->child_ids);
>  	kfree(swnode);
>  }
> @@ -712,11 +714,6 @@ EXPORT_SYMBOL_GPL(software_node_register_nodes);
>   * @nodes: Zero terminated array of software nodes to be unregistered
>   *
>   * Unregister multiple software nodes at once.
> - *
> - * NOTE: Be careful using this call if the nodes had parent pointers set up in
> - * them before registering.  If so, it is wiser to remove the nodes
> - * individually, in the correct order (child before parent) instead of relying
> - * on the sequential order of the list of nodes in the array.
>   */
>  void software_node_unregister_nodes(const struct software_node *nodes)
>  {
> @@ -839,10 +836,16 @@ EXPORT_SYMBOL_GPL(fwnode_create_software_node);
>  void fwnode_remove_software_node(struct fwnode_handle *fwnode)
>  {
>  	struct swnode *swnode = to_swnode(fwnode);
> +	struct swnode *child = NULL;
>  
>  	if (!swnode)
>  		return;
>  
> +	while (!list_empty(&swnode->children)) {
> +		child = list_first_entry_or_null(&swnode->children, struct swnode, entry);
> +		fwnode_remove_software_node(&child->fwnode);

You should document that you just changed the behaivor here, as you are
now really doing fwnode_remove_software_node_and_all_children().

but again, why?  Who wants to unregister a child before a parent?

thanks,

greg k-h

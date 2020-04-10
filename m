Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03F1C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 06:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DBA20801
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 06:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586500189;
	bh=ewqiCL08vXg+nEw5HlCwN7DQxtuJHEjsgS3gMEKYkJc=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=TIttmqNpFaFQ3ggLDJugSrHqfBkxHW/HtuiMYat5bcQRu5pin9nXacsa/HmA/Z+fB
	 ofuVGhdlQKsLLMDqQvZtqSiOsw+oOzgu73YArQKYGcB0bGsGs0J8ZWU/tdGImI0OIq
	 Ryehfw5Guj0M0oOPWJOPPVtr68iXaPDR6ZivmF8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgDJG3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 02:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgDJG3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 02:29:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E3912063A;
        Fri, 10 Apr 2020 06:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586500174;
        bh=ewqiCL08vXg+nEw5HlCwN7DQxtuJHEjsgS3gMEKYkJc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=GOn67PjN1hQ3kgK1mn+v6hhn+NRkxr8UyHuHXO4cbGnJhtGw+/OBUepaMcLTARmqi
         2X8Ud8Bus6Du1R7JzhzaUVd2kLZ5fQOSZxAARFcd9wURSmGZBkRbbvtjaD3MUvpTpg
         yMgIZ+D2AMOg8hS77rC6NOCV+RHRY9LlP9HqtZGY=
Date:   Fri, 10 Apr 2020 08:29:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH AUTOSEL 5.6 14/68] driver core: Reevaluate
 dev->links.need_for_probe as suppliers are added
Message-ID: <20200410062931.GD1663372@kroah.com>
References: <20200410034634.7731-1-sashal@kernel.org>
 <20200410034634.7731-14-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410034634.7731-14-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 11:45:39PM -0400, Sasha Levin wrote:
> From: Saravana Kannan <saravanak@google.com>
> 
> [ Upstream commit 1745d299af5b373abad08fa29bff0d31dc6aff21 ]
> 
> A previous patch 03324507e66c ("driver core: Allow
> fwnode_operations.add_links to differentiate errors") forgot to update
> all call sites to fwnode_operations.add_links. This patch fixes that.
> 
> Legend:
> -> Denotes RHS is an optional/potential supplier for LHS
> => Denotes RHS is a mandatory supplier for LHS
> 
> Example:
> 
> Device A => Device X
> Device A -> Device Y
> 
> Before this patch:
> 1. Device A is added.
> 2. Device A is marked as waiting for mandatory suppliers
> 3. Device X is added
> 4. Device A is left marked as waiting for mandatory suppliers
> 
> Step 4 is wrong since all mandatory suppliers of Device A have been
> added.
> 
> After this patch:
> 1. Device A is added.
> 2. Device A is marked as waiting for mandatory suppliers
> 3. Device X is added
> 4. Device A is no longer considered as waiting for mandatory suppliers
> 
> This is the correct behavior.
> 
> Fixes: 03324507e66c ("driver core: Allow fwnode_operations.add_links to differentiate errors")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Link: https://lore.kernel.org/r/20200222014038.180923-2-saravanak@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/base/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index dbb0f9130f42d..d32a3aefff32f 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -523,9 +523,13 @@ static void device_link_add_missing_supplier_links(void)
>  
>  	mutex_lock(&wfs_lock);
>  	list_for_each_entry_safe(dev, tmp, &wait_for_suppliers,
> -				 links.needs_suppliers)
> -		if (!fwnode_call_int_op(dev->fwnode, add_links, dev))
> +				 links.needs_suppliers) {
> +		int ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
> +		if (!ret)
>  			list_del_init(&dev->links.needs_suppliers);
> +		else if (ret != -ENODEV)
> +			dev->links.need_for_probe = false;
> +	}
>  	mutex_unlock(&wfs_lock);
>  }

For some reason this wasn't for stable kernels, but I can't remember.

Saravana, any thoughts?

greg k-h

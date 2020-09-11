Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2104C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA13C221EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599841178;
	bh=AIEysMnma8oXpbG6AIqoQmLe/zMLbrm7nTct9i4ClRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qPh+y9D9dGDSjkVhLkeDU2YVMD6+dMNCpOfeWyEOS8ayZyg+NnFBKIR+R/OFLSVd/
	 NTrJxjCpUmbPqqU207z9xAqmwgVkcdUkGhjAyJxmfROPr8gk+nGsEJW/9D1vrU7LWd
	 wfAE6CTUKPiRIAVXPi394m+8e50bKS/AIki8DTGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgIKQTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgIKPaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:30:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AED3A221F1;
        Fri, 11 Sep 2020 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599832855;
        bh=AIEysMnma8oXpbG6AIqoQmLe/zMLbrm7nTct9i4ClRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mT0i8FPot4WelBgGvxutd73msYMtd3Ktgf77cdHibTuwVKVRDn4VFno9l1PmzIJWU
         hvhb2J+YtYWKGnRfzZ9vQgrChNk0kvCxvToMGUWto/AbdbT6JJyGqDHKnx6LOTBq1R
         cis00TqGiSz5x0Vg9tppQY/5IftmumCe8eKQTYa8=
Date:   Fri, 11 Sep 2020 16:01:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     akpm@linux-foundation.org, David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, mhocko@kernel.org,
        linux-mm@kvack.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        nathanl@linux.ibm.com, cheloha@linux.ibm.com,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: don't panic when links can't be created in sysfs
Message-ID: <20200911140100.GA3812164@kroah.com>
References: <20200911134831.53258-1-ldufour@linux.ibm.com>
 <20200911134831.53258-4-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911134831.53258-4-ldufour@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 03:48:31PM +0200, Laurent Dufour wrote:
> At boot time, or when doing memory hot-add operations, if the links in
> sysfs can't be created, the system is still able to run, so just report the
> error in the kernel log.
> 
> Since the number of memory blocks managed could be high, the messages are
> rate limited.
> 
> As a consequence, link_mem_sections() has no status to report anymore.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/node.c  | 25 +++++++++++++++++--------
>  include/linux/node.h | 17 ++++++++---------
>  mm/memory_hotplug.c  |  5 ++---
>  3 files changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 862516c5a5ae..749a1c8ea992 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -811,12 +811,21 @@ static int register_mem_sect_under_node(struct memory_block *mem_blk,
>  		ret = sysfs_create_link_nowarn(&node_devices[nid]->dev.kobj,
>  					&mem_blk->dev.kobj,
>  					kobject_name(&mem_blk->dev.kobj));
> -		if (ret)
> -			return ret;
> +		if (ret && ret != -EEXIST)
> +			pr_err_ratelimited(
> +				"can't create %s to %s link in sysfs (%d)\n",
> +				kobject_name(&node_devices[nid]->dev.kobj),
> +				kobject_name(&mem_blk->dev.kobj), ret);

dev_err_ratelimited()?

Same elsewhere in this patch.

thanks,

greg k-h

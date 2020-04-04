Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E0FC4332B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B86F206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586015489;
	bh=DlnItr8LdtPd3sZyj+5hn3rLTVbzxWVsalMJlvnJrUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=COk2RuAJIayc5e27Bj0sGOq7S8W9NKKsgGTKJ/2joOA4KrU0da2Hh8Aj3b6xj+t4Z
	 Z10cYSqx1fQ7xGXyxX7ipyEkPofuEdJf5VCuDhxt6yOEo0EuDMFAoCxNnl1z2+V1ku
	 EcwUBIK1UF4ocNs8u4Z+Co0T59XN7viIxw4wKAQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgDDPv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 11:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgDDPv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 11:51:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 576E5206E6;
        Sat,  4 Apr 2020 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586015487;
        bh=DlnItr8LdtPd3sZyj+5hn3rLTVbzxWVsalMJlvnJrUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P0Qig6IHvUV8VADfpIWR9P2ksxIeL47lZ0g5/R7R4K3AzAHTGF33TyqVsPZyMvlMs
         Ee4yiLpM8cYdIosIDb2yOXwgJ+RIq/T+akWU0zQaqF7LCyQJpf7N/3k/8+MfhJoSIG
         DoPMDQWWhBxjmRh0hfplZ0WBlNjgbMbLwpVgagrs=
Date:   Sat, 4 Apr 2020 17:51:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Taehee Yoo <ap420073@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, rafael@kernel.org,
        j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mitch.a.williams@intel.com
Subject: Re: [PATCH net v2 2/3] net: core: add netdev_class_has_file_ns()
 helper function
Message-ID: <20200404155122.GD1476305@kroah.com>
References: <20200404141909.26399-1-ap420073@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404141909.26399-1-ap420073@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 02:19:09PM +0000, Taehee Yoo wrote:
> This helper function is to check whether the class file "/sys/class/net/*"
> is existing or not.
> In the next patch, this helper function will be used.
> 
> Reported-by: syzbot+830c6dbfc71edc4f0b8f@syzkaller.appspotmail.com
> Fixes: b76cdba9cdb2 ("[PATCH] bonding: add sysfs functionality to bonding (large)")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> v1 -> v2:
>  - use class_has_file_ns(), which is introduced by the first patch.
> 
>  include/linux/netdevice.h | 2 +-
>  net/core/net-sysfs.c      | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 130a668049ab..a04c487c0975 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -4555,7 +4555,7 @@ int netdev_class_create_file_ns(const struct class_attribute *class_attr,
>  				const void *ns);
>  void netdev_class_remove_file_ns(const struct class_attribute *class_attr,
>  				 const void *ns);
> -
> +bool netdev_class_has_file_ns(const char *name, const void *ns);
>  static inline int netdev_class_create_file(const struct class_attribute *class_attr)
>  {
>  	return netdev_class_create_file_ns(class_attr, NULL);
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index cf0215734ceb..8a20d658eff0 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1914,6 +1914,12 @@ void netdev_class_remove_file_ns(const struct class_attribute *class_attr,
>  }
>  EXPORT_SYMBOL(netdev_class_remove_file_ns);
>  
> +bool netdev_class_has_file_ns(const char *name, const void *ns)
> +{
> +	return class_has_file_ns(&net_class, name, ns);
> +}
> +EXPORT_SYMBOL(netdev_class_has_file_ns);

Again, this feels broken, it can not solve a race condition.

greg k-h

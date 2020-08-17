Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186CDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18D320786
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgHQNme convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:42:34 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49358 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgHQNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:42:27 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 11E611C0BB7; Mon, 17 Aug 2020 15:42:25 +0200 (CEST)
Date:   Mon, 17 Aug 2020 15:42:24 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sang Yan <sangyan@huawei.com>
Cc:     kexec@lists.infradead.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, xiexiuqi@huawei.com,
        guohanjun@huawei.com, zhuling8@huawei.com, luanjianhai@huawei.com,
        luchunhua@huawei.com
Subject: Re: [PATCH 1/2] kexec: Add quick kexec support for kernel
Message-ID: <20200817134224.GA8381@bug>
References: <20200814055239.47348-1-sangyan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200814055239.47348-1-sangyan@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +config QUICK_KEXEC
> +	bool "Support for quick kexec"
> +	depends on KEXEC_CORE
> +	help
> +	  Say y here to enable this feature.

?

> +	  It use reserved memory to accelerate kexec, just like crash

uses

> +	  kexec, load new kernel and initrd to reserved memory, and
> +	  boot new kernel on that memory. It will save the time of
> +	  relocating kernel.

loads a new.... boots new... 

>  	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
>  	IORES_DESC_RESERVED			= 7,
>  	IORES_DESC_SOFT_RESERVED		= 8,
> +#ifdef CONFIG_QUICK_KEXEC
> +	IORES_DESC_QUICK_KEXEC			= 9,
> +#endif
>  };

Remove ifdef.

>  /*
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 9e93bef52968..976bf9631070 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -269,9 +269,12 @@ struct kimage {
>  	unsigned long control_page;
>  
>  	/* Flags to indicate special processing */
> -	unsigned int type : 1;
> +	unsigned int type : 2;
>  #define KEXEC_TYPE_DEFAULT 0
>  #define KEXEC_TYPE_CRASH   1
> +#ifdef CONFIG_QUICK_KEXEC
> +#define KEXEC_TYPE_QUICK   2
> +#endif
>  	unsigned int preserve_context : 1;

Here, too.

> +++ b/include/uapi/linux/kexec.h
> @@ -12,6 +12,9 @@
>  /* kexec flags for different usage scenarios */
>  #define KEXEC_ON_CRASH		0x00000001
>  #define KEXEC_PRESERVE_CONTEXT	0x00000002
> +#ifdef CONFIG_QUICK_KEXEC
> +#define KEXEC_QUICK		0x00000004
> +#endif
>  #define KEXEC_ARCH_MASK		0xffff0000

And here.

									Pavel

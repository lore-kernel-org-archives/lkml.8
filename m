Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752F7C3F2D4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466DF2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgCFHUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:20:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36532 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgCFHUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:20:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id i14so1192180wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 23:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E6cQouac72xMKeTeUbrW6BVd4FbRmkb4Xq2Ggxxmg3U=;
        b=J/Mn+CL/guGyLimjrlSy8k3NU6EDxG10GmH5bAD6hSk+WHVMQFknZVvnfVtDWrYBI4
         mCaB+1fiSMScX76dBdGrSXJrUoX/H6lseoRcF7CTfSTsR+tkrm6uHdTQAadZ3pX9KGIe
         RQQJskINyicNI2ouOk7oFZW7j7cdhZ4BmTgHbuyYD63MEVA+70T7CALyWly2A7GahvZs
         VCGlB5n32LeOVIj08HnA1NSA02eTvUBbw65+UPAmHmRIwM/E7QRwKmwUbuIVUzIvLmc8
         rcNvBk5IhDT2QywApFwq2vTFICf6mdAFV6O2QgRaF7lbYlgHQwjhQf9jSclRlCBYs1i4
         HJIw==
X-Gm-Message-State: ANhLgQ0JKyVvnT3BpQvHq0eCIdRZo6GtoMlrAuv8E+QG87wpyUIcaTdx
        yjkSCGp072OsathpPi9MN3s=
X-Google-Smtp-Source: ADFU+vsl8295myUFBjsUG+aklPkWLKkNQTt0QbTJw2EpNKme6JvyPQTozkrloYt1vw0eHl4HUGvDFQ==
X-Received: by 2002:a1c:2d86:: with SMTP id t128mr2457044wmt.38.1583479196472;
        Thu, 05 Mar 2020 23:19:56 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id r28sm50391099wra.16.2020.03.05.23.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 23:19:55 -0800 (PST)
Subject: Re: [PATCH 2/2] tty: source all tty/*/Kconfig files from tty/Kconfig
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <a1118619-5b10-91e0-2914-fba4172f1eaa@infradead.org>
From:   Jiri Slaby <jslaby@suse.com>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ee956a61-5401-0c57-e969-f27271945e6f@suse.com>
Date:   Fri, 6 Mar 2020 08:19:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a1118619-5b10-91e0-2914-fba4172f1eaa@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 03. 20, 0:45, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> 'source' (include) all of the tty/*/Kconfig files from
> drivers/tty/Kconfig instead of from drivers/char/Kconfig.
> This consolidates them both in source code and in menu
> presentation to the user.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Follows [PATCH] char: group some /dev configs together and un-split tty configs
> as [PATCH 2/2], where [PATCH (1/2)] is here:
> https://lore.kernel.org/lkml/4e90d9af-c1ec-020f-b66b-a5a02e7fbe59@infradead.org/
> 
> 
>  drivers/char/Kconfig |    5 -----
>  drivers/tty/Kconfig  |    6 ++++++
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> --- linux-next-20200304.orig/drivers/char/Kconfig
> +++ linux-next-20200304/drivers/char/Kconfig
> @@ -7,9 +7,6 @@ menu "Character devices"
>  
>  source "drivers/tty/Kconfig"
>  
> -source "drivers/tty/serial/Kconfig"
> -source "drivers/tty/serdev/Kconfig"
> -
>  config TTY_PRINTK
>  	tristate "TTY driver to output user messages via printk"
>  	depends on EXPERT && TTY
> @@ -94,8 +91,6 @@ config PPDEV
>  
>  	  If unsure, say N.
>  
> -source "drivers/tty/hvc/Kconfig"
> -
>  config VIRTIO_CONSOLE
>  	tristate "Virtio console"
>  	depends on VIRTIO && TTY
> --- linux-next-20200304.orig/drivers/tty/Kconfig
> +++ linux-next-20200304/drivers/tty/Kconfig
> @@ -478,3 +478,9 @@ config LDISC_AUTOLOAD
>  	  only set the default value of this functionality.
>  
>  endif # TTY
> +
> +source "drivers/tty/serial/Kconfig"
> +
> +source "drivers/tty/serdev/Kconfig"
> +
> +source "drivers/tty/hvc/Kconfig"

Maybe sort them alphabetically? That way, you could move the hvc/Kconfig
and serial/Kconfig inside the if-endif above and remove the whole-file
if-TTYs in the 2.

thanks,
-- 
js
suse labs

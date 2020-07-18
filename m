Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1ABC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BEF72076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ekl6YGfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGRPOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgGRPOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 11:14:06 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD14C0619D2;
        Sat, 18 Jul 2020 08:14:06 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t6so8146664pgq.1;
        Sat, 18 Jul 2020 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sP3q064VQOCv0VsgbZg8RRgy7Hqgh6IyOBD1iKUE8Uk=;
        b=Ekl6YGfLaeu7wRQ3de8Q4HvZqHrBha6I1IOKoCXkmy/JEh291Hlf9lUZ+evb9f+Txk
         fqXFnd5mAGVBbc/6rcU6R28qVHcNV+JYkUqy45EEoyGaJM1WiyVKmf87BVxtE1l9kT5X
         YST44pk0y5VMha4F7G8M6gnjrqcFrekTF++jPe2vSu0Uo2q0jghgpOsJ6eOHmanG8x7w
         m9uKgqvv4RsO16JmSYmCM63dYvAh6NZ9yWz7odvi1ORitYMXkzaIAJM/Rb90bVFt4nwu
         Mxzs9j/+NDgyLRLjobxRCup/cnMP5MT8Cy7oIfbDXI9T9squd9qqY5qtbgqzFfH+Apad
         +2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sP3q064VQOCv0VsgbZg8RRgy7Hqgh6IyOBD1iKUE8Uk=;
        b=C3yQa6DGUL61OsPbGGFGrRUgnVK83y4ywS6/0pJ6DoVTVo1vfl1NkW4abNR+MkgcvO
         dH+TJuGXQzNRkrk9yPmbuUg1oWPB9qZ5mQAmm78HSOwkOLs7WuHrHgTxC/L4pzn46LX/
         ukD4jhwzKE7UUEF9v+yVZB+fJ3GKO7iupqDIxPgOGueMAybpVu3WiMp4iXe8sepUzroh
         BtN0ZJw2aXQWmJ2Re4wtIFKQNLpwlbdlV6NPMU8MWsPAbbNviPH1X9fWG21TgyaJTfPr
         S+vUjVuKvuNmhdAJtyA2SDb4j54wT6LPhDkctKpM26KwveBAuPIPsPuFDphUGaP0hYq3
         yhsw==
X-Gm-Message-State: AOAM532tvg/bYlslhf3IRQqOnoBhV8Ra/3lzPxanyEH4Scpn+MorxEqG
        aaQt5wQsyyN+TDu5Kz5iIarzs/vl
X-Google-Smtp-Source: ABdhPJy5jaPJ6FmA9hIE3fGBWRdU7rxq5v0GnWTCugNNaw+u4vkHlHmqFzRxSL9gwQHYnqyRWlvV7g==
X-Received: by 2002:a63:5220:: with SMTP id g32mr12400818pgb.78.1595085245767;
        Sat, 18 Jul 2020 08:14:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id hg13sm5609028pjb.21.2020.07.18.08.14.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 08:14:05 -0700 (PDT)
Date:   Sat, 18 Jul 2020 08:14:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (adm1025) Replace HTTP links with HTTPS ones
Message-ID: <20200718151404.GA163308@roeck-us.net>
References: <20200713140028.34775-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713140028.34775-1-grandmaster@al2klimov.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 04:00:28PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Applied.

Guenter

> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not just HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  drivers/hwmon/adm1025.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
> index ae7b96945185..ed15185fa60f 100644
> --- a/drivers/hwmon/adm1025.c
> +++ b/drivers/hwmon/adm1025.c
> @@ -13,7 +13,7 @@
>   * resolution of about 0.5% of the nominal value). Temperature values are
>   * reported with a 1 deg resolution and a 3 deg accuracy. Complete
>   * datasheet can be obtained from Analog's website at:
> - *   http://www.onsemi.com/PowerSolutions/product.do?id=ADM1025
> + *   https://www.onsemi.com/PowerSolutions/product.do?id=ADM1025
>   *
>   * This driver also supports the ADM1025A, which differs from the ADM1025
>   * only in that it has "open-drain VID inputs while the ADM1025 has

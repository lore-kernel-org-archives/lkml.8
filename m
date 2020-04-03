Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09FDC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A40220737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J89hODt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404233AbgDCSfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:35:54 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44103 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgDCSfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:35:54 -0400
Received: by mail-oi1-f193.google.com with SMTP id v134so6950070oie.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 11:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OjM07KqdEPzpTKDaPNTVnnzl0Bo0UX8ZWFo9wvgBwFU=;
        b=J89hODt8wqg9P6qBqRezu4hQ8I16OgFJGhgzHhfxyNHFlubjMFYRh6zBKeiH4kEWWC
         O7TEWT1SAV6aYJctNOy/Todhyg1W8/VdxQHXBlkDXPytZ3oontDmcMDc3028YkA9dcUa
         bXY38+XB2ATPUZp/x5ZHW7hXhWe1r6IxfaZd4ozaTf+tWkS+jpmYwG2kWmU1yUyLN0E6
         8+0SUVKlHuhY/dxmfvUmovuk/xDe3NosgPCOmbjITqtqVgVm8cKWB6IAytOmRkUbPnIP
         HmyOBr3/r+2U0EEd9J9iTC1C0NJWVY6ZoJ8h33LDpd7q7OLUrd95wChPePtGXo9rgeHp
         3hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=OjM07KqdEPzpTKDaPNTVnnzl0Bo0UX8ZWFo9wvgBwFU=;
        b=JuOKj+WXHEchL8du67CJkBFPHJ/PWNm+g4zuTZkzSembhGY5ulEJKJjrOsDPTuwDaq
         xNgRzV/ZD+yFUYD4zOpPeGjRQJG8Yc4PqmS+V5+Kl7yTA93JAraRaUJnNLWmlfKUUMKs
         OEEI/E1CoR52OIYVPi4he64pgqvNVZM3AgOpzc9vg6AdQNhuntP1/VG4m4kg3ENHhk6O
         hvabHGoNgvCIo4NCV07LgLPJioNRndO/iuTdBlsV7a9tIJ+aJXDtk2gRmj/BvMBMMGft
         bKhoeIiq0hH6midvrzZmCIgWY6u3FH/YIJON/I5eC4gqinVTWwAY0HtfUmEjrZu4T5Yj
         FK2A==
X-Gm-Message-State: AGi0PuZ9mgpQLwI//L1ApO2b4uYQrOmZshWku2HD3e3hDEnLn0ClrJSI
        MoHkkWWHrEZUCT2kP/zX4w==
X-Google-Smtp-Source: APiQypIB04RVPDdSclHzap2W27tNYzX1/q5hZapBNjQ1r8flFjeFuZqf8PoEL61RBJwp+rNIbCqp8w==
X-Received: by 2002:aca:706:: with SMTP id 6mr4011142oih.115.1585938953167;
        Fri, 03 Apr 2020 11:35:53 -0700 (PDT)
Received: from serve.minyard.net ([47.184.130.101])
        by smtp.gmail.com with ESMTPSA id a3sm2307955oti.27.2020.04.03.11.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 11:35:52 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id BEF5918016D;
        Fri,  3 Apr 2020 18:35:51 +0000 (UTC)
Date:   Fri, 3 Apr 2020 13:35:50 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "moderated list:IPMI SUBSYSTEM" 
        <openipmi-developer@lists.sourceforge.net>
Subject: Re: [PATCH 5/5] ipmi: Add missing annotation for
 ipmi_ssif_lock_cond() and ipmi_ssif_unlock_cond()
Message-ID: <20200403183550.GS2910@minyard.net>
Reply-To: minyard@acm.org
References: <0/5>
 <20200403160505.2832-1-jbi.octave@gmail.com>
 <20200403160505.2832-6-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403160505.2832-6-jbi.octave@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 05:05:05PM +0100, Jules Irenge wrote:
> Sparse reports a warning at ipmi_ssif_unlock_cond()
> 	and ipmi_ssif_lock_cond()
> 
> warning: context imbalance in ipmi_ssif_lock_cond()
> 	- wrong count at exit
>  warning: context imbalance in ipmi_ssif_unlock_cond()
> 	- unexpected unlock
> 
> The root cause is the missing annotation at ipmi_ssif_unlock_cond()
> 	and ipmi_ssif_lock_cond()
> 
> Add the missing __acquires(&ata_scsi_rbuf_lock)
> Add the missing __releases(&ata_scsi_rbuf_lock)

Yeah, this is good, I've included it in my tree.

-corey

> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 22c6a2e61236..030e7c09e44f 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -313,6 +313,7 @@ static int start_send(struct ssif_info *ssif_info,
>  
>  static unsigned long *ipmi_ssif_lock_cond(struct ssif_info *ssif_info,
>  					  unsigned long *flags)
> +	__acquires(&ssif_info->lock)
>  {
>  	spin_lock_irqsave(&ssif_info->lock, *flags);
>  	return flags;
> @@ -320,6 +321,7 @@ static unsigned long *ipmi_ssif_lock_cond(struct ssif_info *ssif_info,
>  
>  static void ipmi_ssif_unlock_cond(struct ssif_info *ssif_info,
>  				  unsigned long *flags)
> +	__releases(&ssif_info->lock)
>  {
>  	spin_unlock_irqrestore(&ssif_info->lock, *flags);
>  }
> -- 
> 2.24.1
> 

Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C71C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F07920658
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA5tBTB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCXWyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:54:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45314 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgCXWyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:54:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id o26so169535pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 15:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Usw0gKGeskWE/iC417I2Dp6prnWh0hQ8UwNg9sUX6Y4=;
        b=ZA5tBTB/Yo7sZmwXwKaSG1ytyVoNjeC4rqiUgw9H8zyOzefxLbrzef3k6vXUPBCcdp
         mbWac+PznGohmO14FH9cQa0xDUZRx5K+ApXH+8NktUzGVZAO9r7OgDNQG10yLGmhGCEb
         FOUkdkItuFI7Dh/4iPtxCqg0kmkbFqfijQMB8OpnepGU1STuL8fBOAAc23ewPh7dzVdF
         FLMFsNQeXIFuVcRGtkUmFbhy/pTH8VBdDYhCW3SifdIbajvDsGfKDw+kooDeGvKqo+2I
         CyDti3NEbXaKCVxbSJieAWlG9PFTjEBm71Xxfes9PDGpXW6CpW8mxRE/LEAUi+GDEhuk
         ttvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Usw0gKGeskWE/iC417I2Dp6prnWh0hQ8UwNg9sUX6Y4=;
        b=gYeWMuX8W8soavZdbt+m7iWMpb4VSh8hoD6+TaulXGTl0Y49LdUTwVP1UUj3rR/vDC
         2HuNB9Ghyj+2LzxuGUE+MiTdOmMVBf/IQuPFexvFMZfWTFoMIVqIbYA5z5jA8Osi0i1Z
         peYJLhnVkYAJhL0l52BsIAnwj09QG2tMrxnK6mKg4PRd30AmyeBHFYKWnGemU9jkPBTx
         MKqiCF2C9xUSyXHXKsRPF6GIQ7g+Xr+uWeExN3+ikP9wdmnbciM6vPGqN7erj01Keo4B
         U/5l2EoCxJHatZAUMHYoGeucv62QHgS0bFrpfZ7QKe2roK9Nct1bgEFk1btxYWe+hQbL
         Tbcg==
X-Gm-Message-State: ANhLgQ3cX6uPMz7SfAPv5BZsIZxd5J+Hrtw8bOX9y4YGT7NLyqtgwTWP
        Uksz3lg0dhKYCxRAgdYsUac=
X-Google-Smtp-Source: ADFU+vuKva54N0sLjqidhpU51aKIyONyjnH0QboCxtDiIekA+tbLSuozpwUGGWJO8/MZyHwuOMmS6g==
X-Received: by 2002:a63:2c07:: with SMTP id s7mr119697pgs.230.1585090460147;
        Tue, 24 Mar 2020 15:54:20 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id o29sm17532801pfp.208.2020.03.24.15.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 15:54:19 -0700 (PDT)
Date:   Tue, 24 Mar 2020 15:54:17 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Markus Koch <markus@notsyncing.net>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] input: avoid BIT() macro usage in the serio.h UAPI header
Message-ID: <20200324225417.GG75430@dtor-ws>
References: <20200324041341.GA32335@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324041341.GA32335@asgard.redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:13:41AM +0100, Eugene Syromiatnikov wrote:
> The commit 19ba1eb15a2a ("Input: psmouse - add a custom serio protocol
> to send extra information") introduced usage of the BIT() macro
> for SERIO_* flags; this macro is not provided in UAPI headers.
> Replace if with similarly defined _BITUL() macro defined
> in <linux/const.h>.
> 
> Cc: <stable@vger.kernel.org> # v5.0+
> Fixes: 19ba1eb15a2a ("Input: psmouse - add a custom serio protocol to send extra information")
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>

Applied, thank you.

> ---
>  include/uapi/linux/serio.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/serio.h b/include/uapi/linux/serio.h
> index 50e9919..ed2a96f 100644
> --- a/include/uapi/linux/serio.h
> +++ b/include/uapi/linux/serio.h
> @@ -9,7 +9,7 @@
>  #ifndef _UAPI_SERIO_H
>  #define _UAPI_SERIO_H
>  
> -
> +#include <linux/const.h>
>  #include <linux/ioctl.h>
>  
>  #define SPIOCSTYPE	_IOW('q', 0x01, unsigned long)
> @@ -18,10 +18,10 @@
>  /*
>   * bit masks for use in "interrupt" flags (3rd argument)
>   */
> -#define SERIO_TIMEOUT	BIT(0)
> -#define SERIO_PARITY	BIT(1)
> -#define SERIO_FRAME	BIT(2)
> -#define SERIO_OOB_DATA	BIT(3)
> +#define SERIO_TIMEOUT	_BITUL(0)
> +#define SERIO_PARITY	_BITUL(1)
> +#define SERIO_FRAME	_BITUL(2)
> +#define SERIO_OOB_DATA	_BITUL(3)
>  
>  /*
>   * Serio types
> -- 
> 2.1.4
> 

-- 
Dmitry

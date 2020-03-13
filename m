Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A714CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6C9206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG80tKO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCMT1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:27:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42071 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCMT1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:27:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so13554547wrm.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1pG2P4gJmNI7Qn+nP1qasHd1nymYVND/EIcK9k9tKMg=;
        b=LG80tKO32s6P3MMoAvcgefezx+DsOR8dap92rwBTuBKgel9CwL8fK28dLQdZqH+13Q
         BDn0bD02jpUSBMmJV1N8FXyV+LdVXVFTqM+NR8hGB0pDhZzFk3R1mn5zcCvAeEJnkmJ8
         6s4s1P7pWqd8RdT+zvgsjJ27QI0qfavvn3zYpelZqTQVvjLM35cI5tV5FIaYmseEHMQT
         hAln01F48F108FzoZxxoe4vkJKphlgzV1mwGaTGGX2zBNji7hf5RjjBO2Wg7D/ZqEFK8
         /KN+uUtY4YJW71Fi7tbFLMNBMSC5+wYCJ68zHCyp6aIv6pz4URmyRWVDm8xMbw/mhoqB
         TrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1pG2P4gJmNI7Qn+nP1qasHd1nymYVND/EIcK9k9tKMg=;
        b=nfJk26RVOD19cLRGqkxpJo8D0Tuc7SugOja9SMlgh2ur4hxNL+1V/K1O12sBYymCm8
         To4miZrlu8A1QmXa2MhlcUNz9YXX40TR7+owJpTnP7EG1aSjSlz0cdUwRhE4dfjSEeGf
         HYxZ6IU6gJ7ZtrAF2zfLrL8gPge2erJFKFWnd3Lfk+fT6sXG1FkEOZ/+72mMG12Sb98k
         UTdjxE29xYyWOVryH2zeQw2iF0i70Aj0Tl180ZAfWpN4OKyr5dGVN91jcxbLSYK5j4Z3
         ktLB5JIrtBoQTWkKH/RdD08vImgBA4WA/gdGOuOlUwTFlvqkAU/njulFATJHCCwXpom1
         Efxw==
X-Gm-Message-State: ANhLgQ0bJ5reUwGd6PpCURfvS/+pdTdhdct7e/r0/etlYcFZ+oVJ245V
        ZXzQBG8AsF5t2pCuhcaPB2Q=
X-Google-Smtp-Source: ADFU+vvi7ViW/Oe085hOiFD7DEEBRsb6UehypN9PKy4YZYAW3HGcdQQ0YeSpwNsLn2ch7WRCpCPxAA==
X-Received: by 2002:adf:dec8:: with SMTP id i8mr19986530wrn.326.1584127618599;
        Fri, 13 Mar 2020 12:26:58 -0700 (PDT)
Received: from giga-mm ([62.68.26.17])
        by smtp.gmail.com with ESMTPSA id o3sm19528945wme.36.2020.03.13.12.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:26:57 -0700 (PDT)
Date:   Fri, 13 Mar 2020 20:26:56 +0100
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 008/491] ARM/CIRRUS LOGIC EP93XX ARM ARCHITECTURE:
 Use fallthrough;
Message-Id: <20200313202656.ed9ca1d31aaa1ccc9eaa9844@gmail.com>
In-Reply-To: <e26a22c41c72290be469229f578e80c9e6dae5ed.1583896348.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
        <e26a22c41c72290be469229f578e80c9e6dae5ed.1583896348.git.joe@perches.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joe,

On Tue, 10 Mar 2020 21:51:22 -0700
Joe Perches <joe@perches.com> wrote:

> Convert the various uses of fallthrough comments to fallthrough;
> 
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

I think the patch is OK, but the automatically-generated first
commit message line has a room for improvement.

But, as I understood, it has chances to be re-sent as one patch for
all files.

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/arm/mach-ep93xx/crunch.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/crunch.c b/arch/arm/mach-ep93xx/crunch.c
> index 1c05c5b..f02e978 100644
> --- a/arch/arm/mach-ep93xx/crunch.c
> +++ b/arch/arm/mach-ep93xx/crunch.c
> @@ -49,8 +49,7 @@ static int crunch_do(struct notifier_block *self, unsigned long cmd, void *t)
>  		 * FALLTHROUGH: Ensure we don't try to overwrite our newly
>  		 * initialised state information on the first fault.
>  		 */
> -		/* Fall through */
> -
> +		fallthrough;
>  	case THREAD_NOTIFY_EXIT:
>  		crunch_task_release(thread);
>  		break;

-- 
Alexander Sverdlin.

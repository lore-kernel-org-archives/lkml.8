Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9ECC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EA5206E3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgnA3KEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgBAIrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 03:47:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42065 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgBAIrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 03:47:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id e8so1155422plt.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 00:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CylU9ftSDJ0Ci9ZsmZEbddejAvubtZZm2KsEiJHwKX4=;
        b=AgnA3KEnv+bmLs+V5VpwlmEWBrJHZ/nDunw/+0aUVOjCPKZJrf2i3PfyW21086fe+M
         F6G8Et5vA0AOJ+zkClCSsOeQHoRzX0w2xGQiGckPbioLMAFiNxCSHwKRZRSMK4Vec4Xh
         VZim0nQIZ9O4CsMXF+F1B7hUEMegqIAj/F7+RxQZPXXA7gyHZakhtg1r8u8pjTDqideD
         EySJJPcZgy2zpygt7jAlvgEwQX6fVAr0dxTk4yebREQwlNjaKBIh4tej/XXWKuWfbLcn
         M8AC/SQ0D693Z6J2a+B8a5oo6fVAB6l9/MtoHKEMBVO0iLb3H5sR7APLLb1MCVmaH3Uo
         Y3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CylU9ftSDJ0Ci9ZsmZEbddejAvubtZZm2KsEiJHwKX4=;
        b=A/rDmtA+NpjwP/aj0gtxwAsE84HQ2cItGFYUO6erURhWp2AmxtT5hdGLz5fo3SR1Ot
         KxEytokkt4az+eGRvgnss7/TmbcKnKaMHdbGEBibEq2uC8v/34eILrTdG/YqzBnTSqdl
         mbaUpv/KHhM181m2JxSPO0zRDhHPQLrRVK+1q4OqcVXWPRDtJLgOupFmUUdBy/dkHn7S
         kJONwF7o18QOOQ231wkFLg57OUxErrSeDXtsdyOv5zTus+/VWKul9KR4Ko/kt7uBUdCl
         lIBGf7rnwahsdbZ8DyaDlF3ZlcTE35ZC9DNFbRB1jevjI3pX/h5bRzYp/y5ICQhhn6Zg
         8xRw==
X-Gm-Message-State: APjAAAVZD/PouR6d8YsfdLwa/Rx7U2cvIIA3hdaYwTkB58ycAIOAmiNq
        paXTniQ+PzhFkMGYPI9ojRRxBbD17JN5RK3L8Tc=
X-Google-Smtp-Source: APXvYqyIaEfAhfBwNrMQEQUHGwDCLKHG5fjRlKfmP8mxC005JDNfw24zVnSy/nOPHIjJZ0lua2r2YUOGXdBivGJZ1JI=
X-Received: by 2002:a17:90a:c24c:: with SMTP id d12mr17614144pjx.113.1580546827051;
 Sat, 01 Feb 2020 00:47:07 -0800 (PST)
MIME-Version: 1.0
References: <500b2132-ea3c-a385-1f37-05664de5f1dd@infradead.org>
In-Reply-To: <500b2132-ea3c-a385-1f37-05664de5f1dd@infradead.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 1 Feb 2020 00:46:56 -0800
Message-ID: <CAMo8BfJ8TsXthhD4pyDcAeODPaE-ueS-+nJcwV8F3JcoSN7dpA@mail.gmail.com>
Subject: Re: [PATCH] arch/xtensa: fix Kconfig typos for HAVE_SMP
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 5:59 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix typos in xtensa Kconfig help text for HAVE_SMP.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> ---
>  arch/xtensa/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied to my xtensa tree.

-- 
Thanks.
-- Max

Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1A8C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752932072A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xknSEI0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgCDOLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:11:48 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42049 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDOLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:11:48 -0500
Received: by mail-qk1-f194.google.com with SMTP id e11so1673086qkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 06:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RjvQ3OcnTVdxhTWVVbPbw3jQ/x/6RLQyYLLkFrMFFyw=;
        b=xknSEI0a5LtgMRLHayPiu5S9manH9X7mK4IBeL+c+a6ZcSud1n/8sPjCkM2NvpJtFq
         zP3ivOV3F+JqCy6mhH00Ab+ztQ63s8e6AkMYPq7z/FwOoeP01FQpysaeTjpe6ioNIjG9
         GQeQGWNkalHxc6G6vECl3+jFV7NksUhSnMgBo+m5N6bYgevR96iyZjEun9BgJP+DqNTp
         NMapld5Oefg73raghUo3xVv1LkrZkROZUz+jPvGBENqtxtyGU0r6/GuIGqtb51aj5zug
         RLPuWaSf8GC5okJ63bUB5Rqan5bi5nO055fqINvBtdTMqovmKgTVy/dHWpyL9TPXfATC
         +dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RjvQ3OcnTVdxhTWVVbPbw3jQ/x/6RLQyYLLkFrMFFyw=;
        b=h7CbvmYcwegn3+qtSKxtsyxzS7mRel7eswDHmiF61FLaabk2tDm2BomPKEvwFnc0+t
         9V6LZt76CG5QKIH5Tmlo3eRHDGMy42Z7/UGwHih8uj7p6I8ecCt1ejC5Smdl8bTRwjza
         WD87LQH268CSn78L7RPxEDaYMvzMBDK17fuX4JFIqus+vSHR/aYdtAdrlFq0XIOU1m/z
         VsSYD6S4cTbz5qYaCfrGKfh55mOAGQ47F9ri7+40RM9bPJnteQnv1iYntqjy2ckYttzt
         ALWYBESuXSDcqHrqyvwSe0l8nAxzIR32Mi/73CCRvVbwNV59RoMtd4SvYEKB3AD1q9+e
         8RCA==
X-Gm-Message-State: ANhLgQ05j+J2B2ErfvdvowfviU0nLsaD/oFqar/Y/EK8HG5+gzaUzm2p
        9mU/CUU6Agb8AjA8Q65Au+uKK3OQ0kRY6ynvEfYRScEj
X-Google-Smtp-Source: ADFU+vsA3n4BaKpliKkFsm/cu9cRnG2g7UuR3MmeFl79PXd1ENm5985cxw1N8F+dhsVjTkPQfABX67ZH07OYFt4DV3A=
X-Received: by 2002:a05:620a:1526:: with SMTP id n6mr2180188qkk.323.1583331107187;
 Wed, 04 Mar 2020 06:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20200303200149.27370-1-j.neuschaefer@gmx.net>
In-Reply-To: <20200303200149.27370-1-j.neuschaefer@gmx.net>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 4 Mar 2020 15:11:35 +0100
Message-ID: <CAMpxmJWJrQ_GAmv1snRPCL=CA-zbHH-2ZKi5ZNAgUASQ3K11tA@mail.gmail.com>
Subject: Re: [PATCH] gpio: uapi: Improve phrasing around arrays representing
 empty strings
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 3 mar 2020 o 21:06 Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> na=
pisa=C5=82(a):
>
> Character arrays can be considered empty strings (if they are
> immediately terminated), but they cannot be NULL.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Makes sense, patch applied!

Bart

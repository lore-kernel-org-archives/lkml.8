Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FEAC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE1020716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597684965;
	bh=llEJP7AXod6ZVyJo5cYQ/8SaDOMaJLKDkG+SS1JZv/o=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=BnQLkZKiKm3+K4C6TZrc5ms/12xcmJdDDPnzJG6yWM+q6ZWNf31kpghC2B3ET+HOu
	 WbKV122msuL1uZTRlknGiJKGF4k+igp/HH/4b4LOXnYYzewNknosskdpfCX2sBHddj
	 GHJevgVEjmAJplOmiGePXPIH7Kg58Sdotwa3vLHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389836AbgHQRWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731341AbgHQQpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:45:16 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBFEC061345
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 09:45:04 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i19so8699839lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BDpYbXacOYsmncSK2AxZjXV+MuH8o29BVrL5LEXIDao=;
        b=N9mA78VSzeS1Ibf4nnKhBabPs9szpKlK8P2/V2m9CB/RgA6lo1+1nKIg3E56jLovdP
         kkd5UK2dlxrEAoU4CZJ4rRiJ253W8vMgrneneJje+XRZKJqFUVZId44QVzMf+wKHMi24
         Fe7LXyvTGe4AS60d/L5+Z2cb07COtm2Yx1wcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=BDpYbXacOYsmncSK2AxZjXV+MuH8o29BVrL5LEXIDao=;
        b=RM4XCLDsBHZ5f8izJ/67hif3R689fis5NG7zlnfe9rAWmutIG3CIM08fNFUGGFGhI5
         pYJLxGT+NWTp2g2kfep1iaZlWJOW84vP93A8wU5I7oakUUhFzsriOELKLReGCyXek58x
         2XB/CyB54opRtypvNxXnCpzc75ftMQWTEvzgCsFJvBrLhrb0f9GOpBlR+JJHMm4MU41C
         cxuX8v0s9twcJzdo0YZiqiLSwYNDn+iMoKdYHcBQWorlAm0qVc6wh0TzOvOQt4k01AAV
         OcQx5kdF+uqD7LvHoouo4D+6QPY0ZqxJnAspsffBtd3LJtMB50Q9TFgWKdv6qsjwPaJJ
         uoDA==
X-Gm-Message-State: AOAM533Gq+5idJ4kjJjDu4MYOUwk61pdn8VWen60ErgIYNPmtQPVQaRd
        jkD2Ro1Isp1G8dMN9LMPgY8VEt/ELvisTw==
X-Google-Smtp-Source: ABdhPJx6aaJiEvrvX9m1AiESlKc5B+AuP3pToAHdcrW57FAeYl+/v3SbReB3jB6A/6QMRSkujYuQqw==
X-Received: by 2002:a19:431c:: with SMTP id q28mr7940063lfa.211.1597682702442;
        Mon, 17 Aug 2020 09:45:02 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id r19sm5584131lfi.58.2020.08.17.09.45.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 09:45:01 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id m22so18202387ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 09:45:01 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr6932586ljk.421.1597682701076;
 Mon, 17 Aug 2020 09:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiwfkKp93C+yLqKWAU0ChBdeBDUhgOk09_=UQ8gOKbV3w@mail.gmail.com>
 <20200816225822.GA3222@debian>
In-Reply-To: <20200816225822.GA3222@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 09:44:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOaEmFGYhnx7XLe8AbQKYpgMAzyuHuS8dYZoB2hS3C=A@mail.gmail.com>
Message-ID: <CAHk-=wgOaEmFGYhnx7XLe8AbQKYpgMAzyuHuS8dYZoB2hS3C=A@mail.gmail.com>
Subject: Re: ..build stopped... Linux 5.9-rc1
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 3:58 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> w=
rote:
>
> I am scared that I might have missed something very obvious ...am I?? And=
 the build abort...take a peek..
>
> ./arch/x86/include/asm/io.h:292:2: error: implicit declaration of functio=
n =E2=80=98slow_down_io=E2=80=99 [-Werror=3Dimplicit-function-declaration]

I'm not seeing how that would happen with a pristine codebase, but
send me your config just in case.

slow_down_io() is declared not that much further up in that file (or
in paravirt.h that gets included before for the CONFIG_PARAVIRT case).

             Linus

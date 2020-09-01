Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5080C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E7DA206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4VSDHzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgIAMdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgIAMQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:16:44 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AD1C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 05:16:37 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u27so624608lfm.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 05:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vp2v4JbUh7qcxgfYFlgQakIncyjTSb0yTOWzsVE4DE0=;
        b=B4VSDHzs0e0zyeqh5mspuUDjtxOe25+xX3BNX9MaFb+mFukd/sBPLVJPEdIMwK6jPL
         xs1msKWwfdsxTAT6x6HegS2UORR4Jg96HBYyTyZOrHv4IrwC1tfjD59i1aqS9Y+2Agnk
         3zy2W/R8Ww/PXR82YWnVtM4r8Ulx3s88ZZRMy3fR+/t3n+8ZZ0i+7V1ryZwiLHSNKkGH
         oKLemyrApvdGtJk6bmVDJFdV6SRxnUaJW6KzrLGep8tBAQO/cmhuRSsm93T9Y4svY7HC
         iq0gCH0/vRuy0XjauCOqm8GzzIPKNacG46Za24d2fNqAyEiqpk1UsbP/vbmngH+IlQ11
         M/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vp2v4JbUh7qcxgfYFlgQakIncyjTSb0yTOWzsVE4DE0=;
        b=ltf8GxWfKRNfQSDAgwoy18T8CNOv8YVXMx/yXs89jk+LhrBuqKkbp9XCsVaUm4S0bd
         8XCVTCpJdYuheMNO/Ismo19Ya5amZmw9HZjcrLHuXhXpQdxzj/TFJJ3cl8cTN/gZRT7m
         5rAO8YkRGSd+KGZR3TwPU3sN0HkyW4769uxv0yjN+0SRDCG4I+NN/o4wzhEGGE2+L1ld
         MH3H4H0rnFqKCJOGrEdf1xg57vWluJLW9pYyouCEeBmehu1UMpS5x+hvFVf3zV8/Myu8
         XLlOFDEivgwkHRNbXSq1vF3WQp/OZZpwMwByxXBszhob//a+/b4WGjh/QxGc8fvlt64D
         UpAQ==
X-Gm-Message-State: AOAM530pT53hKG+8gEbXAYrR3vGsjsgHygFa+H4KRT/ZjRDOM7j/2KFf
        QhW+U02upUanjFuOOJNt0a7eHvAL3KK1RLJLUSI=
X-Google-Smtp-Source: ABdhPJxoFyWaRfnsytczCGvJ7IQ82jpNtM+x3RdBJXdblhKML6ppcq16oaRvc65mc2KxmGRRwNVn6mZs1IteS64LFqc=
X-Received: by 2002:ac2:420d:: with SMTP id y13mr457937lfh.69.1598962595957;
 Tue, 01 Sep 2020 05:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000971bc005ae3db23d@google.com>
In-Reply-To: <000000000000971bc005ae3db23d@google.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 1 Sep 2020 09:16:24 -0300
Message-ID: <CAOMZO5Cw919kMk2t2SwTpGkij+r3L3sBhWEuAgMVooPbrnQ6rg@mail.gmail.com>
Subject: Re: WARNING in snd_pcm_plugin_build_mulaw
To:     syzbot <syzbot+23b22dc2e0b81cbfcc95@syzkaller.appspotmail.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh@kernel.org>, syzkaller-bugs@googlegroups.com,
        Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 7:08 AM syzbot
<syzbot+23b22dc2e0b81cbfcc95@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    15bc20c6 Merge tag 'tty-5.9-rc3' of git://git.kernel.org/p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1268efb1900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
> dashboard link: https://syzkaller.appspot.com/bug?extid=23b22dc2e0b81cbfcc95
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a95f41900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a452f2900000
>
> The issue was bisected to:
>
> commit f3ca3f5b0966cfc2737178cca8a7a65b09991898
> Author: Fabio Estevam <festevam@gmail.com>
> Date:   Fri Mar 27 15:57:21 2020 +0000
>
>     dt-bindings: sound: cs42l51: Remove unneeded I2C unit name
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15395f41900000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17395f41900000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13395f41900000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+23b22dc2e0b81cbfcc95@syzkaller.appspotmail.com
> Fixes: f3ca3f5b0966 ("dt-bindings: sound: cs42l51: Remove unneeded I2C unit name")

The conclusion that this commit caused the problem is strange, since
this commit is just a yaml documentation fix.

Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3660BC55183
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D32C206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HtF4fSRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgDUJgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727120AbgDUJgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:36:52 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C62C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:36:51 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id t12so6431110edw.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VvQfXYa7OuQRubb/pe1NKM1WDL58usuh9DmpVkQdaXA=;
        b=HtF4fSRlF5BL+Rp3ZBD/jsftUDAEZ06/Ef78AW4EYdxqpH7Hah/bo4k3KdHLLfhnKV
         IEIvmq5e4KsYJROS71rXPIlzo30jtTPwQVycMuz6yOoM9rsfOhj9WEUsw145a6aK1Jvk
         iqaIZtdWYGbUI5NUZXZENdkHOilOUU6jzikwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VvQfXYa7OuQRubb/pe1NKM1WDL58usuh9DmpVkQdaXA=;
        b=APp9NW0/PziUJtnubLj1pyROUadia+6EHPcsgK1O6sEhtYvkb75RntfHg3T09Huukn
         fbWYPt14OczQS5GoaeOl665I3PvqQjLT2XJvWgAb/oSd0xIk5azjtK8TB3hpOvSxEdbO
         EJuXTrukSBdbqpHB/qBug2bX9IQr4pya30hfctHta6CObkw+A3Qv5YibeGMypbkG9TC0
         51Wv1x/n0Niz+ZpQ9fqTJmwvQcXzecp38tJZ56oI1Cq9m0M4yBFEc1CFA2ILvZw7g3oI
         XErepC1FnaH99WI2L0QjuI7neL0G/lZ+byrrO0whRNkeE+wkPG1VpQe+KOgK9tBQ/Jvy
         Svhg==
X-Gm-Message-State: AGi0PuYk/M+1daa3S8J2Xfhm0/lqfn26QYHb7WqOEZ2vURNsSEx0zWyD
        YVoXUHr1wWJiKFZYIx78r3G/efuOBIPwb5kbicksCg==
X-Google-Smtp-Source: APiQypItc+QOKYRaC4wg++htE0Gc6LcZ8EgCgsTAG5CToiNPUvzzsuYG1iJV8Eg2YL+hR21Hk80UqqtI7Wbcu/Jn0S4=
X-Received: by 2002:a05:6402:3121:: with SMTP id dd1mr12660866edb.168.1587461810483;
 Tue, 21 Apr 2020 02:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <158642098777.5635.10501704178160375549.stgit@buzz>
In-Reply-To: <158642098777.5635.10501704178160375549.stgit@buzz>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 21 Apr 2020 11:36:39 +0200
Message-ID: <CAJfpegvrRxYsN5L1GSWTCZgmBR4kf00YeD9JNx=fEd4fDKuOtg@mail.gmail.com>
Subject: Re: [PATCH] ovl: skip overlayfs superblocks at global sync
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 10:29 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> Stacked filesystems like overlayfs has no own writeback, but they have to
> forward syncfs() requests to backend for keeping data integrity.
>
> During global sync() each overlayfs instance calls method ->sync_fs()
> for backend although it itself is in global list of superblocks too.
> As a result one syscall sync() could write one superblock several times
> and send multiple disk barriers.
>
> This patch adds flag SB_I_SKIP_SYNC into sb->sb_iflags to avoid that.
>
> Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Thanks, applied.

Miklos

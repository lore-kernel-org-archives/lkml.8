Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B66C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF44E2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA9KGeZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgF2StA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgF2Srn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:47:43 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D56AC02E2C3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:59:03 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q7so4901581ljm.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UGyosXZCWooG7Tjszoes4KB/+HgMWni06A9jFLNYaYU=;
        b=WA9KGeZ39tTZkIoY+OkHArQq53QMP7s+PxXqfVe+Z02/159KgvovFmugdz0BtXEsoY
         82Vlha+qNKVvrsAntFgaRckJhmTXyMZjDXOHxKE2VBXSDVKmlDjco2/BGh0ysDoTn+Eo
         wLSrOWswk9puj6tmKzCzXWo2d3xWeNzLHj5hyxq7tsY7Fys9DT/qYcVsv04RSW7AF/CB
         bEKl1Ggly2JGo4pznh9aP9C4OZ3W/P0d9N818RfeazX2GtuY6RrGT/xrafqsR5bdWJuR
         fKXOziDURBjNuEGK5OisDp5eiJff6sCDKSdjG+vHc9K/SnK6pTIIKb9zuxoU9eE5BgcY
         tfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UGyosXZCWooG7Tjszoes4KB/+HgMWni06A9jFLNYaYU=;
        b=pXaPi/ocBMJ7yvOmN2qJguwvJi1JnKS1sEVteNM12C5JkbZxMW6/57DJzzPsRyUVDs
         X5baBAVy4kEkfD2h6HAdgQL7wNueRKUiLdy/NJcWEeUIBfBpRoPcCjNCERyKFL6pzxuj
         hrkk4hp19Ecs5c5QQis5leGJaLdZZG9g+Cg5TcfRBOttSYx0Y+TTK//s0uBHab6SQi11
         c2YkfMh9I7pOl5FXwvn5nZJJwrCD+tr4ZwArcBea3yt3LicHgBPQRxYH6iVG5IQqdQmX
         s2/KVdUJIzAPvPjs+OfmCa2HF6HyhYBWN6JnSGoBL1+WJlKsNbWsVpAfmrN09RKdxzcz
         dgtA==
X-Gm-Message-State: AOAM5333uQzj0bxFYXh/5Fvz/7D1iG5Tl6/9ebv0IjkrlD+ieRxe6QmJ
        t6TE8E4rnuxCmHsSqDg+XCMWb4lJFGVMBOAMxQ==
X-Google-Smtp-Source: ABdhPJzpRYEViQEdoErIqx6gGvcPHrozg6UgphmrJ6HsxKyWoLC9iPa1OMa8YDPoc1Rf83BpJd5GVIsFkw/aguaGYJs=
X-Received: by 2002:a2e:b4a3:: with SMTP id q3mr7870793ljm.65.1593439141472;
 Mon, 29 Jun 2020 06:59:01 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date:   Mon, 29 Jun 2020 15:58:50 +0200
Message-ID: <CADDKRnAwnLKn5phH_Zxnje_rg10a-uro=H_sNq697G78BTQrkQ@mail.gmail.com>
Subject: segmentation faults with kernels >v5.8-rc2
To:     Mel Gorman <mgorman@techsingularity.net>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I frequently get segmentation faults in newer kernel >v5.8-rc2 e.g.
Chrome_ChildIOT[1298]: segfault at 40d048 ip 000056111a41970d sp
00007fdced6931b0 error 6 in chrome[561115f64000+785b000]

Bisection gave me the following
first bad commit:

e9c15badbb7b20ccdbadf5da14e0a68fbad51015 is the first bad commit
commit e9c15badbb7b20ccdbadf5da14e0a68fbad51015
Author: Mel Gorman <mgorman@techsingularity.net>
Date:   Mon Jun 15 13:13:58 2020 +0100

    fs: Do not check if there is a fsnotify watcher on pseudo inodes
...

I double checked by reverting this commit on top of v5.8-rc3 and the
segmentation faults are gone.


J=C3=B6rg

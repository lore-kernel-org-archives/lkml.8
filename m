Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7E4C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 09:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9617D207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 09:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzBzwQfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgGKJEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 05:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgGKJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 05:04:33 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CBEC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 02:04:33 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 145so7657854qke.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 02:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=l8cMBox5B81kKC1/vqo4Blm6vKckzlIDGhm+yeOYrPA=;
        b=mzBzwQfKbQ+0l3wHrKZpuigz9kJD7VWYv11MPuCD/epGoZqxMWcuH0uflFFG9plncI
         Qq4z1m/qstikCTC8kHHqmplMY/UWHrKFwBbOBfVxJezjvEdMGJ13puS9QeHzRTO2pCzW
         qTs0I8GO8VFqerAeSP4Qvuno7QMjEZYV8UN7TEbgMJF8fRUn+hWehoyy/LiGIXM4f2l/
         VxNUuJgjTPvfBm41Yb77qzhQuHWOcBaEZZlFWrXDawj1nIDIemGDgOybEiHVd0FkQtkq
         K2UD1c/nqNF2JuvDvIrFrTv5c6SCSxnerksJkxTSi/ARi7mHYWgSXG2h5vdU3Hf1cBCu
         mJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=l8cMBox5B81kKC1/vqo4Blm6vKckzlIDGhm+yeOYrPA=;
        b=mXgE6nMHbhMImHW1TxjbPqzX/wd4DGZo3+RA9ZGe+BUGt+/iuoxNFuFilX+KcOiG8B
         z681vtM5KG4qlHwjbm3nUb1kpyqzVw/rmUZPazYLAp0rmDR2e/YL8u6SsLKqGC8Q0Yb+
         DXFhQJBOgmejVRYklY/LiKlbmVTSat8bIW4Gj1bcBoO5X7Sm3eJMolj9Od3HRhW4l/Ny
         8wZHQc002viVUrHquYNuKpMbH7T0orqxfisxYoMt+5D+jnbmUav2Sbk78ajDc2A8nM0z
         ifubL5ooCniXT9quY1fZbNsIxlmYk9wLinz7WOEMj/uNnUPHJLswnUSZz29MPXM6V9r6
         Q/PQ==
X-Gm-Message-State: AOAM533OD0UyJ7OYopT3+sKXE4pShcK+XgaEcL0zV+nFccIe/yE/oMC9
        nrx5phoD6reQKE3Ti/eZVCFZhtUDLCK1MQ9p/THtqdCqsYdunQ==
X-Google-Smtp-Source: ABdhPJyDeSl3T/JCihrSmsvi2fYVle5qBE7izdlboi/lxIR+hOFtgJ+LFejvAucyMo7hTN0neWTRfa1kxeOK4VSVU9s=
X-Received: by 2002:a37:6382:: with SMTP id x124mr63325742qkb.13.1594458272346;
 Sat, 11 Jul 2020 02:04:32 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Sat, 11 Jul 2020 17:04:21 +0800
Message-ID: <CAAvDm6buDWX1rMp9ncTw9=OQtXTYLPfXZSHg-2w5XEUxUNJEAA@mail.gmail.com>
Subject: What methods or tools could be used to investigate the causes of hard
 or soft lockup?
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, list

I have frequently faced sort lockups and hard lockups.
Here are some example logs:
1. Watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [cantest:1669]
2. NMI watchdog: Watchdog detected hard LOCKUP on CPU 0

What methods or tools could be used to investigate the causes of hard
or soft lockups?
I have been stuck with such problems for a long time.
I would be grateful if somebody shed some light on this issue.

Any advice on how to proceed?

Thank you for your attention to this matter.
Best regards.

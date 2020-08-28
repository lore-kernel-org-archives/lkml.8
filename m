Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4ACC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0724321531
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598644415;
	bh=+YxXJ2bE04RKm5nl2SmuydsLNY2185Aqu8+9ltNXA8Y=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=FmSIYwbOZ+R+1BLepGeksVUiE5jJ/mL/qN5IEGo9UZiC1H+jLiSzL12vB76IjZFOC
	 q/GoLt6N98eivs4KKPwyR4GcyU27XgzAiVr5VWjyCv+a13xRRV+T+Y2vt6Pi1OyuKz
	 A09aunjLLLPIGM1hqiMHD1Ved/z/cx9uQ9BCJ4P0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgH1Txb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:53:31 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38592 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgH1Twr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:52:47 -0400
Received: by mail-oi1-f196.google.com with SMTP id j18so1692769oig.5;
        Fri, 28 Aug 2020 12:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IIC+v+rMB2R/Q/pneIzZqnD45x7WKCthyoc0N8lU/3M=;
        b=m6LyseE/eJyky1ZLmUYW2eR4nFduyugE6r7IUG8BDifu+UGSkeuamCKrO1mTjc2ikV
         2Te5KIKGNUB6cq64cUSWKrY1Zg5YyAINusKuvHiEIEp2CulHz7H5gbVSlwEW0546baXy
         DO6M0XnIHqgag/Kf/CE77GDfu9rW7sL/SwIPfmy4hm433DQVSGuikho/uslUITLUrX8M
         2zhQw79p24Iz3UUbQzB78XBLQRLDJqNX6e5ODk4easwo51hPUxXpNIv4iTo/fgulkavs
         6mImFEckLN49AgKQzXbA/oh9B2sgAJkpiB2MR+KJXywwjWeAt/6aS80Xnl1ZUnWLNVBo
         n9bg==
X-Gm-Message-State: AOAM533s5tPhPb/qxjHMB51NkBZZYxFVUT0HFqoAjc7wN2E90sV4kE/v
        cEOjcdUY0WtlvXMHeJgzNODlB6NuQHhOgcZcZ9rfUFBAV5s=
X-Google-Smtp-Source: ABdhPJyzrF39Y3pm33iU7zZ+oZcAdet36fVvj4TQXxORXmfxOOcbYTO7FRc7wDn+NySVj04B7xEMPU4UW2AT4v+55iU=
X-Received: by 2002:a54:4f14:: with SMTP id e20mr429629oiy.103.1598644366315;
 Fri, 28 Aug 2020 12:52:46 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Aug 2020 21:52:35 +0200
Message-ID: <CAJZ5v0jWBqqU_-w5yn9iGaJZT6wFnaqNHUvE9e6TRKZhxyxFkg@mail.gmail.com>
Subject: [GIT PULL] Device properties framework fix for v5.9-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-5.9-rc3

with top-most commit c15e1bdda4365a5f17cdadf22bf1c1df13884a9e

 device property: Fix the secondary firmware node handling in
set_primary_fwnode()

on top of commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5

 Linux 5.9-rc1

to receive device properties framework fix for 5.9-rc1.

This prevents the promotion of the secondary firmware node of a
device to the primary one from leaking a pointer (Heikki Krogerus).

Thanks!


---------------

Heikki Krogerus (1):
      device property: Fix the secondary firmware node handling in
set_primary_fwnode()

---------------

 drivers/base/core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

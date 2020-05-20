Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389FCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C2C20671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589987836;
	bh=8MWDFBWyxUSYk47dRRcN6PuGyi0ghXdF6T/SqVyctg4=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=Wx6d2Dcyfp8SVwyUhs2e0SyN94QBJGcp9W0Ui/+XNtoEPgnfiAO8ganBn0PRwCdMO
	 Kf8R++MHZGIwNkviW6loBl2KBs8QoqVIjd8yUG5FFa+pC43kT9clMM9kNVpzbYz7Tx
	 g/hS348LeegdC2Hok2T7W+0ylQOuzGwueanHHEk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgETPRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:17:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41656 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgETPRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:17:14 -0400
Received: by mail-ot1-f65.google.com with SMTP id 63so2731644oto.8;
        Wed, 20 May 2020 08:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=APMAJd2ccAAAHw6hrNKtkZpgfoVo+A8PajU4FrsMAFE=;
        b=Dy3aETvdnArVlbTBUJhPia6cFRb460LXMPSzxR+VUuXyanSUkSkebVSAXb/fg/NSbq
         AjjSrwfFUXlqDpj1pJWXr6iPR45IeSpGaOA9pdM8nf4YLSxmnNGMbJw1XnQyLy0Zm7U2
         cSQh8kHfyArW1IA5W/noqDKC8b450ZA1bAKCrXj87kvzwG5qORDDNVup7UOSsLRWpH3d
         irqEzGItvwKqiffyzigGhORx7ZBzlVkDLB69L/qJ30W7v/9BafKKmqdnNGND+pKUQBWI
         u8vOWJGO56JJre1tcyj4xpN9bHja5gYzSMv8Fpts7MhXgcujHbrQxHW1wuNswqkO5MBu
         A20A==
X-Gm-Message-State: AOAM532NoW53Gw3QxTKwiww4b6mIxNO2uBsmT59FwLDZeZqwxpOphEhC
        ggeyt9i/OIIbLYwXXDb3UODd3waBdOTiFhUkJtnixoFl
X-Google-Smtp-Source: ABdhPJxoPE2D697+U4admlbKECT9cJECJahPHQEDu8JvuPpj6HsQS3maF4rirsAISehOjdejt3hVjcx6nefCzronUug=
X-Received: by 2002:a9d:6c0f:: with SMTP id f15mr1842461otq.118.1589987833168;
 Wed, 20 May 2020 08:17:13 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 May 2020 17:17:02 +0200
Message-ID: <CAJZ5v0jE6tnyd741Y1B_1gzVMtcf112e1EOqjJ1AR+oUd5ee_w@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.7-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.7-rc7

with top-most commit 607b9df63057a56f6172d560d5366cca6a030c76

 ACPI: EC: PM: Avoid flushing EC work when EC GPE is inactive

on top of commit 7b301750f7f8f6503e11f1af4a03832525f58c66

 ACPI: EC: PM: Avoid premature returns from acpi_s2idle_wake()

to receive a power management fix for 5.7-rc7.

This makes a recently introduced suspend-to-idle wakeup issue
on Dell XPS13 9360 go away.

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: EC: PM: Avoid flushing EC work when EC GPE is inactive

---------------

 drivers/acpi/ec.c    |  6 +++++-
 drivers/acpi/sleep.c | 15 ++++-----------
 2 files changed, 9 insertions(+), 12 deletions(-)

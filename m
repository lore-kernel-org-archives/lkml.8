Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBBFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1AE206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591804342;
	bh=KQ8JkY6tnanz7UiDrO8RArG5d3cjFoaeFo0aUd9KOHY=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=1sU7flu8vyj/z37juy4YWOUAOR1vtOzds0vAIn+rsEPD/F9ltpOeBwHHTQXSOTCD9
	 WUxYtQx5XePOX2wXHWVxO0/RN42umj3NkWgTvvAZmPmNy26BfRaNL1VwNK8IdP/XLv
	 OqlvsGzij2uwmPHE1qhdF/AaussVjrNLK4LpHkVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgFJPwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:52:20 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36280 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgFJPwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:52:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id a137so2508445oii.3;
        Wed, 10 Jun 2020 08:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MomNjD2kd8cNJ8vXpeYV/SgtWXFuaS4gqTbhFheJNvE=;
        b=AaiRerKzO0lTn3VgAIqGPOExKslJaE4QFFxo1Qj5fk/iSgPgRf4sCtgGa7vWEJoEvl
         LvRDljHgaPQpgB5CCqSQETc3IcB1bacWhWuGVQgfMQiTs7LkObRSSAD8Mg+cBM62KIWy
         QOE9ycghs1NGLRiYeUoBcXFpBaYZ9/m8AU0Lib1HkoAU0X/Oi2e5/anQeV6ROCrzyGSn
         7IyuwfzDjSQeWjzleLIAi+BNsZIqKhSc5fL+Pf5S4ggoS5QzGm0Efb+Esv86h1HtBeIJ
         HchHa9qCwMOW3NCK22b3I/HDquDLSuuQVjxB38kuE7ZJ33Ah6k/pRQp3/LWXIKoXCXR+
         0M7g==
X-Gm-Message-State: AOAM53378NMgYXYz7UImTwilrrFs4zzCcv0xFX/m2XRfJgTgnGzmj2Pz
        NTxZwPVVvjDbDcDOr+YzO3Cs4zarFpRcW+GdOmpwaVPO
X-Google-Smtp-Source: ABdhPJwHZU0WZOW+GGh5+3jWA99X1qI8AWlBh3NQ/lK9c2COOK6KCXoU+c6wIZrdmk5kvLZ559ShCWSUjEgE63mFHsQ=
X-Received: by 2002:aca:ab92:: with SMTP id u140mr2922759oie.68.1591804338890;
 Wed, 10 Jun 2020 08:52:18 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Jun 2020 17:52:08 +0200
Message-ID: <CAJZ5v0iWARxun+oYiu5qx1p7E3=U-GJMEF3hHwYxagkSn_BRFA@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.8-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.8-rc1-2

with top-most commit ede439be684c54f01147e1f65cc565c6baaca1a4

 Merge branch 'acpica'

on top of commit 118d6e98293b30aee378a6b08d27a35320a3e34f

 Merge tag 'acpi-5.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 5.8-rc1.

These update the ACPICA code in the kernel to upstream revision
20200528 with the following changes:

 - Remove some dead code from the acpidump utility (Bob Moore).

 - Add new OperationRegion subtype keyword PlatformRtMechanism
   to the compiler (Erik Kaneda).

Thanks!


---------------

Bob Moore (2):
      ACPICA: acpidump: Removed dead code from oslinuxtbl.c
      ACPICA: Update version to 20200528

Erik Kaneda (1):
      ACPICA: iASL: add new OperationRegion subtype keyword PlatformRtMechanism

---------------

 drivers/acpi/acpica/dbdisply.c                           |  2 ++
 drivers/acpi/acpica/utdecode.c                           |  3 ++-
 include/acpi/acpixf.h                                    |  2 +-
 include/acpi/actypes.h                                   |  3 ++-
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c | 11 ++++++-----
 5 files changed, 13 insertions(+), 8 deletions(-)

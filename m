Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66167C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE8222D07
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7pYSAPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgHGGaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 02:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGGaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 02:30:17 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03678C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 23:30:16 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id q13so393841vsn.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 23:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hosiDsSF7pcUUswxQ+NwvqT+/8m2fK+HL/QoB2WtKc0=;
        b=r7pYSAPIs9Z1iB+tygPfQa+qeu+I45vUVHTXgGXXu6FU69l0cLnBK1Zo2ugqxSGxjb
         hHBb/d9rJn8jh6xmoHWjN7MuFt3pLj41BX2PVeKxofJpXZ2V/3XZRZddvRjC3dep4bO5
         vnLByj0K91pnkBkOriemEoNACk/vDicSYPhZ3/TTH4q71/BMSFYkha+oefMnu0OG03VW
         Mujeb74LzNECWR3TZW5xfLDNMQeaAneFNW6o8GuU2BPpP5tU+AMWhftKVomN+Z6fJ/ol
         7KHcz3CmbCdgisD6RKzyy3r5fHHn0hSRc3ZYJLP1I6V+1cRjCZslFuNWUX9TtcVcLqMW
         H9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hosiDsSF7pcUUswxQ+NwvqT+/8m2fK+HL/QoB2WtKc0=;
        b=a6WUWmZ3MeonSQWTiYOurL/XoGSWR/h/n8ZWsrLt1Lmk08bb35wWBgfV2ADxtQSIKP
         ML9Jp/WP991zLmzZ3Qy4NUGu1wUQxY1uXN9tfKg6DWwgXrvxX+JbSHrd7Iyo5cdUh5/T
         PxNVosOjwwe5dUI5WRAHkIMnd6gWI+E29bzsycF6hxUYcmXx2Ls95jrw7yJ7d08nnQob
         9WHbDkiW95idvTnX3fhaFndG0eD/WadqSeh8JqblgA9YR5QTeFLqyamniO+K7rxnGoo3
         iFqvMtLw1wNmqo2n3dR4YEFsuTZC+zzmWnMc5nddZhRdoqnKEsbTIjbEiZ3t7O1Ko+Uw
         8crw==
X-Gm-Message-State: AOAM531PP46KOl/lVtEi9o8+blWKph/hrv93vijqbJGAuptqaW1vg3CK
        wG1ruywwhAmKFDu2cNJ6ePjjNbN8WA9p8E+ZtgE=
X-Google-Smtp-Source: ABdhPJxjXJV1o2VuDmipNH/ersobL4XBMaFmhTjWm2MWBpJFRUC/sh6bX9szq2CJA+68+cCaxHX/iKyUGL0E08KTiEg=
X-Received: by 2002:a67:302:: with SMTP id 2mr8983457vsd.228.1596781815526;
 Thu, 06 Aug 2020 23:30:15 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 7 Aug 2020 01:30:04 -0500
Message-ID: <CABb+yY0bZ8cdRa+vWYzE4zbujgQfKK=NzZs7G4o0QkxJXscEGQ@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.9
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.9

for you to fetch changes up to 884996986347dbe3b735cfa9bc041dd98a533796:

  mailbox: mediatek: cmdq: clear task in channel before shutdown
(2020-08-03 23:56:38 -0500)

----------------------------------------------------------------
- mediatek :
    add support for mt6779 gce
    shutdown cleanup and address shift support
- qcom :
    add msm8994 apcs and sdm660 hmss compatibility
- imx :
    mark PM funcs __maybe
- pcc :
    put acpi table before bailout
- misc:
    replace http with https links

----------------------------------------------------------------
Alexander A. Klimov (1):
      mailbox: Replace HTTP links with HTTPS ones

Dennis YC Hsieh (4):
      dt-binding: gce: add gce header file for mt6779
      mailbox: cmdq: variablize address shift in platform
      mailbox: cmdq: support mt6779 gce platform definition
      mailbox: mediatek: cmdq: clear task in channel before shutdown

Hanjun Guo (1):
      mailbox: pcc: Put the PCCT table for error path

Konrad Dybcio (2):
      mailbox: qcom: Add sdm660 hmss compatible
      mailbox: qcom: Add msm8994 apcs compatible

Nathan Chancellor (1):
      mailbox: imx: Mark PM functions as __maybe_unused

 .../devicetree/bindings/mailbox/mtk-gce.txt        |   8 +-
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |   2 +
 drivers/mailbox/imx-mailbox.c                      |   8 +-
 drivers/mailbox/mtk-cmdq-mailbox.c                 |  97 +++++++--
 drivers/mailbox/omap-mailbox.c                     |   2 +-
 drivers/mailbox/pcc.c                              |   9 +-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |  10 +
 drivers/mailbox/ti-msgmgr.c                        |   2 +-
 include/dt-bindings/gce/mt6779-gce.h               | 222 +++++++++++++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h           |   2 +
 10 files changed, 338 insertions(+), 24 deletions(-)
 create mode 100644 include/dt-bindings/gce/mt6779-gce.h

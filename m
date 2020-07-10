Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CCCC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2F3206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mURRFeUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgGJRDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgGJRDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:03:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EC0C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:03:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so6687496wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bQIq5s2dqiEjFMbe0CzvCv9st0ZbiUVbOFEQGKrFNck=;
        b=mURRFeUfOBx1wJXzGFTph66BgqHt3V4hjdmsPFdNsVFXPQaHMrU5IJUWGGdYv7710W
         eOPIghtkf6x+HlTYf1cy3I+w7wN59ujxzVZz+sU7aolWPXZ1cZkcX6gKy6Qg5ywYvBgW
         eGbA2a2xMlHu/GP1lk3xan46biuy1Xq6t2TEFUYZnQ976Gu1/ya4oPToMvpHmDNO9YnN
         OvUi+cdt//YwZ6J1aZIHLAvuTQS4e+RuuNvbBIOYH0dQnxkf3rr06HoOdjc7rWnjLqsE
         9PzU1+e8Z9RnVcaurg4QMbk7tMk8PbZUaTPXCBMYR+XvDwZpx3NiXIEQjbEqKH+Ug648
         /gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bQIq5s2dqiEjFMbe0CzvCv9st0ZbiUVbOFEQGKrFNck=;
        b=B5Gw4Bqg/1nJ3T069zoDBIRhVGTOfk3RSUX/VvilT546NHiaI49l/R9REVP16qWkGo
         rg7HT4E4gpZS+mAhygp7hudgr8C5WnNKJN1P5N0iBFJGcUUbPdyfiLKAqj//92Yf7Sqf
         p1Uqiyabi0Cw7FTYxamjSQbaQfbOmKGboOsQn2sxGmvVyvw2wLw3S5YkgouGQgOK2LjZ
         uhHqVGAlv7Zs8VVeX0uCRSvNUghp5uhLPxsmz6/93EesXj+XJla7GALgMxe4cFmnS2UC
         lJ0jfnX46qzNlJXNqxzJJ1eHQ665Mq91Bhab5ruah0vM1HguX51YYpTalnUKXBo9m+ZN
         8BYw==
X-Gm-Message-State: AOAM532q3hya7yj9O9pSaordmx1zCcYpX3iTyJQZSOnFUohHJwXNztUQ
        CQfJyUNYafed5Qno3l2e2cfSEDX2
X-Google-Smtp-Source: ABdhPJzLGmptrY+IgiSU0K4LC8+1xvwXLEosLWz/REgg/voxbg/LOtpNoaLvxJBCLnSlI9S67zclxw==
X-Received: by 2002:a5d:4b0f:: with SMTP id v15mr32810907wrq.216.1594400597923;
        Fri, 10 Jul 2020 10:03:17 -0700 (PDT)
Received: from ogabbay-VM ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id r8sm10613363wrp.40.2020.07.10.10.03.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Jul 2020 10:03:16 -0700 (PDT)
Date:   Fri, 10 Jul 2020 20:03:22 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes pull request for kernel 5.8-rc4/5
Message-ID: <20200710170322.GA29124@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This pull request is for the next rc (rc4 or 5) and it contains:

1. Important bug fix for the GAUDI command parsing code.

2. Change in debugfs interface that is relevant only for GAUDI and
   therefore can still be changed in this release.

3. Workaround for a timeout problem in GOYA and GAUDI.

Details are in the tag message below.

Thanks,
Oded

The following changes since commit 897c44f0bae574c5fb318c759b060bebf9dd6013:

  virtio: virtio_console: add missing MODULE_DEVICE_TABLE() for rproc serial (2020-07-10 15:12:48 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2020-07-10

for you to fetch changes up to 788cacf308871db0a619952321bedfec8f1773e2:

  habanalabs: set 4s timeout for message to device CPU (2020-07-10 19:53:03 +0300)

----------------------------------------------------------------
This tag contains the following fixes for 5.8-rc4/5:

- Prevent user from using command WREG_BULK in PCI DMA channel. The command
  won't be parsed correctly by the driver and will cause unknown behavior.
  As the user doesn't need to use that command in that channel, its better
  to just prevent it completely.

- Change the interface of the clock gating debugfs property from true/false
  to bitmask with bit per engine. This will allow the user to debug the
  ASIC while disabling the clock gating feature with fine-grain
  granularity.

- Increase message-to-ASIC-CPU timeout to 4s (from 100ms/1s). The ASIC CPU
  might respond sometimes after a large delay due to slow external
  interfaces (such as temperature sensors) and that will result in a driver
  timeout which will lead to ASIC reset.

----------------------------------------------------------------
Oded Gabbay (3):
      habanalabs: block WREG_BULK packet on PDMA
      habanalabs: set clock gating per engine
      habanalabs: set 4s timeout for message to device CPU

 .../ABI/testing/debugfs-driver-habanalabs          |  11 +-
 drivers/misc/habanalabs/debugfs.c                  |  23 ++--
 drivers/misc/habanalabs/device.c                   |   2 +-
 drivers/misc/habanalabs/firmware_if.c              |  10 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 123 ++++++++++++++-------
 drivers/misc/habanalabs/goya/goya.c                |  20 ++--
 drivers/misc/habanalabs/habanalabs.h               |  19 +++-
 drivers/misc/habanalabs/habanalabs_drv.c           |   2 +-
 drivers/misc/habanalabs/hwmon.c                    |  19 ++--
 drivers/misc/habanalabs/sysfs.c                    |  11 +-
 10 files changed, 147 insertions(+), 93 deletions(-)

Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18761C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E61A520656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qtec.com header.i=@qtec.com header.b="ajAbHjJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505440AbgDNUCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505416AbgDNUCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:02:18 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE19C03C1A6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:02:18 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d8so1186407ljo.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iy1YXWO5laLm10GzQHnsg5e4RQXfAXSg1PWIeEl3QAU=;
        b=ajAbHjJbMiUyLCO+fE3RKVK/bVQj2yNamrMl1h60NVGyciFbu341rumSDLdDC9rQ26
         LHAjI04ozufudiPj3qciitPlc4KYnF81vt6qaxSIALxaBe0N/m88Pov0/1AW3/NhtMC3
         0YMyh8YvX9QjFsoVLjgx2eHqBxdGwgLdrW6qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iy1YXWO5laLm10GzQHnsg5e4RQXfAXSg1PWIeEl3QAU=;
        b=eO0hAOiaORbjSNeK5NgIylgcRtoSgrmAVoRsN6AbBYyGT1xLoKlckDFUDjsA4lbt02
         3jpKtPQMAwOvXGDaEJ/3smh5F631AKcjgaBzSLdjwX09Ca/r0fjauwfgxNQtXAq4Fqwv
         K2B8KIcsTI33MhqqFxMkqTjPHbXyJObvQ6NTD/MZ7aMm/upSZKKkoo8N1BwDxAeIudKn
         5by0w3214JlldPxp79TjNFstLDNW0v5q/UNAoitgDBW+Alz6HAPvNav44zn3W/QIsDCA
         /r9c2RWdFl3J1n0IaqwbUTkjDU4vJ5afBaD/mAkrmwLO1QAyb4FbOB3oDVED3dD/hwPr
         ZInQ==
X-Gm-Message-State: AGi0PuayXiVwxn2J4ZIqLiTjxyOt1rXyW6hHO0qd/I/qfabySdou8r7l
        Clp5skfq7js+ztMvfgfQq6N3ng==
X-Google-Smtp-Source: APiQypIWc7hSnSIjw52g80XaetpCRsCdbkcCRnrMGWL5hZRB0mukjm2kA26/FVi1HnDGpty8xHJ69A==
X-Received: by 2002:a2e:968d:: with SMTP id q13mr1136690lji.62.1586894536533;
        Tue, 14 Apr 2020 13:02:16 -0700 (PDT)
Received: from localhost.localdomain (62-243-86-95-cable.dk.customer.tdc.net. [62.243.86.95])
        by smtp.gmail.com with ESMTPSA id v4sm3525254ljj.104.2020.04.14.13.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:02:15 -0700 (PDT)
From:   Daniel Gomez <daniel@qtec.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Daniel Gomez <daniel@qtec.com>
Subject: [RFC PATCH 0/3] v4l2 api changes for imx378 driver
Date:   Tue, 14 Apr 2020 22:01:48 +0200
Message-Id: <20200414200151.80089-1-daniel@qtec.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I would like to discuss with you guys the next two following topics:

* VIDIOC_SUBDEV_ENUM_FRAME_INTERVAL:

I'm working on a driver for the imx378 sensor but the current v4l2-subdev API 
(VIDIOC_SUBDEV_ENUM_FRAME_INTERVAL) doesn't allow you to set up a range of frame
intervals. However, this is supported in the v4l2 device API level. My idea is
to follow the same approach as the VIDIOC_SUBDEV_ENUM_FRAME_SIZE by setting a
min and max intervals in the VIDIOC_SUBDEV_ENUM_FRAME_INTERVAL to solve this
missing support.

This is the current output of VIDIOC_ENUM_FRAMEINTERVALS in continous mode:

v4l2-ctl --list-frameintervals width=1920,height=1080,pixelformat=pRAA \
-d /dev/video0
ioctl: VIDIOC_ENUM_FRAMEINTERVALS
Interval: Continuous 0.029s - 0.607s (1.648-34.797 fps)

This is the current output of VIDIOC_SUBDEV_ENUM_FRAME_INTERVAL:

v4l2-ctl --list-subdev-frameintervals code=0x300f,width=1920,height=1080 \
-d /dev/v4l-subdev19
ioctl: VIDIOC_SUBDEV_ENUM_FRAME_INTERVAL (pad=0)
Interval: 0.029s (34.797 fps)

So, the idea would be to return the interval range from the v4l2-subdev level
to the device level. Besides that, it would also be necessary to adapt the
v4l-utils tools (compliance and ctl).

What do you think guys?
Please, follow the RFC patch series to see my suggestion.

* V4L2_CID_TEMPERATURE:

In addition to this, the driver is able to report as a v4l2 control the
temperature of the sensor. Since is quite 'general' control I also included the
v4l2 temperature control as part of the common v4l2 control list.

Would it be also possible?

In the RFC patch series you will find the the modified code for the
VIDIOC_SUBDEV_ENUM_FRAME_INTERVAL and V4L2_CID_TEMPERATURE topics as well as
the imx378 driver using the above.

Daniel Gomez (3):
  media: v4l2-subdev.h: Add min and max enum
  media: v4l2: Add v4l2 control IDs for temperature
  media: imx378: Add imx378 camera sensor driver

 drivers/media/i2c/Kconfig            |   11 +
 drivers/media/i2c/Makefile           |    1 +
 drivers/media/i2c/imx378.c           | 1829 ++++++++++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls.c |    5 +
 include/uapi/linux/v4l2-controls.h   |    4 +-
 include/uapi/linux/v4l2-subdev.h     |    6 +-
 6 files changed, 1854 insertions(+), 2 deletions(-)
 create mode 100644 drivers/media/i2c/imx378.c

--
2.25.1


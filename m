Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6B8C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C978E207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KkUdP2Ig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgETJb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 05:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgETJbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 05:31:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D1AC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 02:31:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h17so2391789wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 02:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2tHuCvrzX51mj1uQ+UwpdZjDnMBFbfdASVT6bpLiK94=;
        b=KkUdP2Igd2sVLWD2v/jgj8mU8xfvivFCa0hoQGP/ioGQcz7TFCUZozc4aO9Vsk3brC
         OnkctpfmWwV58oJY46zf8qKaqeSIW/TTp8/jz6DXzGWMPq7Ar/WdhwbHMmlZtcKMJGY2
         NAf0wEf0Sb0z0s8GQ5F0Wufb2xu96Ut4er+05P9dbMItqbTge830tSsH28XFUBxgfHWm
         eVzQkvCIqi5P9EHxDBFPdnvIU2yIoqMyvFYXIWW0sOO5op5SCgt0PptetU7TMDGfUG2X
         yLHQ3JXhhLNjE7hDoNMVPTmVTOIh/jeNYey33l5PZc4GJORVu9Sg9rTSnJI+uqlvR8In
         bDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2tHuCvrzX51mj1uQ+UwpdZjDnMBFbfdASVT6bpLiK94=;
        b=RWKHbGDQfbRYxNNcbB51RdBXXEkscSW6ENJljm8GyW8Xd+Ktwkf58tYePnLuAj4IZo
         AoKUQdAcFvb0f9ejr15jBKfFAP4nSQ51Eu5jIWlbVYgejFNhaIHaAf57Jl/Vo1pusNSV
         23bVzJH2lBkP+GZlGxjjh6cHjUIeNi5BDFXyc5UzkhQpvvZv4eP60Zhtp9QxVKyZhqzH
         jfckq6MCLaC3Xz/eihTb8vIX/gEv/ZWwzzBePiOzFD1dK2UHCTI7PVlqz2MFfEFL1chP
         kW1I+TeObZnhmQZc3g/cBaPesBhx0i8yhpZDEGw38PyRz9/Tz9X5BIpYzA3t0gxRN+Ao
         gLsg==
X-Gm-Message-State: AOAM530SLf5hgCzARjEz8PFhgCJr/iAVeE/2hQBdV3dsY2K2zaqOnkAS
        5N/2KRH+qA71EkG1bRePTjTM7g==
X-Google-Smtp-Source: ABdhPJx5k+oUlvwC1JXFJu394O0FcThxr/ncbDj/sSxUGANin8w+P0XmNFDbzi0lv8vNtBzcnA33nA==
X-Received: by 2002:a05:6000:81:: with SMTP id m1mr3364804wrx.59.1589967113591;
        Wed, 20 May 2020 02:31:53 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id l11sm2568308wmf.28.2020.05.20.02.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 02:31:53 -0700 (PDT)
Date:   Wed, 20 May 2020 10:31:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>
Subject: [GIT PULL] Immutable branch between MFD and HWMON due for the v5.8
 merge window
Message-ID: <20200520093151.GI271301@dell>
References: <1589565428-28886-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1589565428-28886-1-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-hwmon-v5.8

for you to fetch changes up to 3bce5377ef66a8700dcf7a9cb89b7aeb99326cb7:

  hwmon: Add Gateworks System Controller support (2020-05-20 10:29:17 +0100)

----------------------------------------------------------------
Immutable branch between MFD and HWMON due for the v5.8 merge window

----------------------------------------------------------------
Tim Harvey (3):
      dt-bindings: mfd: Add Gateworks System Controller bindings
      mfd: Add Gateworks System Controller core driver
      hwmon: Add Gateworks System Controller support

 .../devicetree/bindings/mfd/gateworks-gsc.yaml     | 196 +++++++++++
 Documentation/hwmon/gsc-hwmon.rst                  |  53 +++
 Documentation/hwmon/index.rst                      |   1 +
 MAINTAINERS                                        |  11 +
 drivers/hwmon/Kconfig                              |   9 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/gsc-hwmon.c                          | 390 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  15 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/gateworks-gsc.c                        | 277 +++++++++++++++
 include/linux/mfd/gsc.h                            |  76 ++++
 include/linux/platform_data/gsc_hwmon.h            |  44 +++
 12 files changed, 1074 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
 create mode 100644 Documentation/hwmon/gsc-hwmon.rst
 create mode 100644 drivers/hwmon/gsc-hwmon.c
 create mode 100644 drivers/mfd/gateworks-gsc.c
 create mode 100644 include/linux/mfd/gsc.h
 create mode 100644 include/linux/platform_data/gsc_hwmon.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

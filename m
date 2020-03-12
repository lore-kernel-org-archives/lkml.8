Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134C4C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 04:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC4620739
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 04:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3ats9uK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbgCLEi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:38:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42207 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLEi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 00:38:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id q19so4805002ljp.9;
        Wed, 11 Mar 2020 21:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BjPdSfl+t8YwAch/qVVID02ShhhB89UbCThPW66gWLQ=;
        b=J3ats9uK0YN0GDUacQWNhZ9Q+7kDlCcWnN2vo0ccfIY/D3nP6F87eOqtg56zTZKdyv
         CIPDgyovCi42xIbwEjbJptkhrFt6J1VIDK0K8sgS4/uyGJnteNpmeleMaQXBP/kLznr2
         NjAXhin+/hMJlRmbULU6cMXlgpXagldRgTBye+Sly4TOUII2c4u2Li3K9LlqxJwceFG6
         JcIAR4YpMPOfMRSY4M10O0dMCwd9Y1ayWRsbdwOY/rx0tlSZepQKKpO3+mwTC09NaC8J
         y716+pTEZsxs26RxQeajI2AO4rO5xD2z2F2kpmE58X655V2354h59GHVVZQ4hGTYLRhv
         5CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BjPdSfl+t8YwAch/qVVID02ShhhB89UbCThPW66gWLQ=;
        b=BambwGLTlHnUm2A6RMsUIfMDqeEPab4t9WyAGZFhS66h0SSckeQq4UZZVRox13BHt0
         6VuW5sH5CUTxojQXTpoYjp55ajwOL0/oID5M2IBH0Kr6Ue2tEA0n76dkSB1wWEiFnyZm
         cqYM3pCE6g/JOinBJGuCaVLFvTt7bFe9JWQ1odZVldFHAn3MwgDmYbO6RDTmIDgaVRgU
         TTCIopQbojxoS+teQqVLdAwUcL0BKDSqPr/1gDa3IiNyUPj5QGHD4osc5INl/VMIEOvy
         F2VTMlByrlqBuUxmFQ+y9Uz4QDRvuWAfdtorXiE1a3Z26Zu7lYumHqwhV7NTZTMJkt9R
         khOA==
X-Gm-Message-State: ANhLgQ1usjzstU2mSit4ESn/uHwKNkdiH6yco2qed6wlXoXH8FUpaaY2
        xJNFqf1bWeKBNROAnBhMV2Y=
X-Google-Smtp-Source: ADFU+vu2LZt4dQBS1XvD9C73vqG+rDKvlOnUkwd2xy1BWVo1NQdNEU4cWSfzVugfz8Nv6UzykF9sbA==
X-Received: by 2002:a2e:9b94:: with SMTP id z20mr3926494lji.147.1583987937218;
        Wed, 11 Mar 2020 21:38:57 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id u2sm8872866lfu.3.2020.03.11.21.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Mar 2020 21:38:56 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Jer=C3=B4me=20Brunet?= <jbrunet@baylibre.com>
Subject: [PATCH v7 0/3] arm64: dts: meson: add dts/bindings for SmartLabs SML-5442TW
Date:   Thu, 12 Mar 2020 08:38:03 +0400
Message-Id: <1583987886-6288-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds new bindings and a device-tree file for the Smartlabs
SML-5442TW set-top box. The original attempt [1] was 15-months ago but
nothing has really changed apart from a change to yaml bindings.

The QCA9377 BT device does not have bindings and early experiments to add
them are partially successful but need further work. I have dropped the
gpio-hog from the device-tree and will submit changes to add BT once the
supporting bits exist elsewhere in the kernel.

v7 - update gpio-led nodes
   - remove gpio-hog for BT enable
   - add bindings acks from Rob

v6 - removed audio nodes again

v5 - typo in card name

v4 - typos/corrections from Andreas
   - convert to yaml bindings
   - add sound node back
   - confirmed gpio-hog is necessary

v3 - change to Smartlabs LLC
   - removed sound node

v2 - removed audio nodes
   - changes soundcard name to "meson-gx-audio"
   - added missing uart-has-rtscts;

[1] https://patchwork.kernel.org/cover/10674939/

Christian Hewitt (3):
  dt-bindings: add vendor prefix for SmartLabs LLC
  dt-bindings: arm: amlogic: add support for the SmartLabs SML-5442TW
  arm64: dts: meson: add support for the SmartLabs SML-5442TW

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts | 284 +++++++++++++++++++++
 4 files changed, 288 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts

-- 
2.7.4


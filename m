Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5096C3F2D4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 04:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB5420848
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 04:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo2YvjZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgCAESP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 23:18:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38095 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgCAESP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 23:18:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id w22so4230579lfk.5;
        Sat, 29 Feb 2020 20:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RUckZGjTIfpOeMQYZ0QQ1YNFNYKeeYg+2ZgjfO7J8WA=;
        b=Wo2YvjZSHisbFe2JskaKTucoxClitLTs2mFciQ7tceYhTWwuIvAfeQpXw1M8F380vP
         /6+GV+49Q58KTj6dDULr1Rv+KSk1AtbyOoz2r1XUEFTEJFxzBcZHPOw6Mw2/JTXZUG8O
         6ypo2d1u8iKyfS9DzOJ2mkA2ygGgmgIFih232NmlL18oZSphEpCRW266hgSI5XljSTKv
         OeseASn8oZs55NZpmG+muBjm15Nf21lsRaY4otyVvUDjmk0T0U3plw1pbt/vPpCkt0+b
         zV1pNG5QimJQGB4gbRMrtDclMOuXraLH643LCAG7Fj6O0bsg9JRv3ETNJVm0uiy7rGlD
         VCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RUckZGjTIfpOeMQYZ0QQ1YNFNYKeeYg+2ZgjfO7J8WA=;
        b=NZYDG1kyrRD/r5jH2NnN80oFmYTbInmyt6P3XJQp+pA/fMyaU/kLrrn3KmbQsISbrF
         3PLnHQOGLEvy7TMQuYSoG4XQE+7Tbp+K45DOxmmkJm5PyTTxBGNI1gyZL2f+UVv6Gq5D
         yWQcFV8qDWT+aqsDpuZ1xJo5GXwjaTeCGWVcEArg3WrdUKymMX1y+yH5B7op7Oot6eX1
         onWj+XyGXa2co9XOAKABnDROiuZvFZ5u5GIdJQWjxERdHA1v904HlriudMN4eeNiQ4rF
         hphce8UHMax9R5uJTEes1OGLrfivF6rCgjjir8ltM9By5I3eM5FN6AnniaoWmXWVbE86
         O4pQ==
X-Gm-Message-State: ANhLgQ3noKiwLQXsqAfitP2EWTWEcC03dylLIcXS15jdfqNzn49nPBF8
        Tvq++/c43slZ5iET4jiPMcU=
X-Google-Smtp-Source: ADFU+vv/6spC24e91c1Z/PwBe/1cen7rK7mnuPZDtPBlg5rpJDSCrnvthLsCMcQCIb4DUEUa/tFABw==
X-Received: by 2002:a19:840d:: with SMTP id g13mr6885360lfd.162.1583036292835;
        Sat, 29 Feb 2020 20:18:12 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id y24sm9568864lfg.63.2020.02.29.20.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Feb 2020 20:18:12 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Jer=C3=B4me=20Brunet?= <jbrunet@baylibre.com>
Subject: [PATCH v6 0/3] arm64: dts: meson: add dts/bindings for SmartLabs SML-5442TW
Date:   Sun,  1 Mar 2020 08:17:18 +0400
Message-Id: <1583036241-88937-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds new bindings and a device-tree file for the Smartlabs
SML-5442TW set-top box. The previous v3 attempt [1] was 15-months ago
but nothing has really changed apart from a change to yaml bindings. I
have checked and the hci_qca driver does not provide QCA9377 bindings
so there is no alernative to the gpio-hog for enabling BT support.

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
 .../boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts | 292 +++++++++++++++++++++
 4 files changed, 296 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts

-- 
2.7.4


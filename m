Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E740C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759DC246B0
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF+PnU8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgB2MQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 07:16:58 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44388 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgB2MQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 07:16:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id 7so4099967lfz.11;
        Sat, 29 Feb 2020 04:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HUQahJ8jieCI4R4OACtWdxDB3DdcfhrTI/7VNOoaPK8=;
        b=fF+PnU8ypTPRYP2StXGZUT73bB/q0X22+IzS9vRlhTkiVKY2TQ7/D3RIQf809t0GID
         GQyq5z+7IGlHTP+Thu+DJ8pJ8CGEI9MjxzVXX+HsSgS5AeanZ9v5NTafVFIO/62vMLrX
         +OG7rW4w7XmgIyL1aWNB4zfB39z6Rl5IksWRdwjUJI9/rm2wRFxVSqJaA1RCfVVXOXsJ
         zurj3FLrv+kFuR2t+W+KISSdagPuLefEHgmZXbA8bRbLxbAfoaxH7IlcF3/fRm9dFJXx
         MdJ4jxvQ/9gSJplaJV3UEC10zSCWEeyCpP237XfweYQIDD7QoL1FeaqGwjHINgAOpvNn
         iI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HUQahJ8jieCI4R4OACtWdxDB3DdcfhrTI/7VNOoaPK8=;
        b=G3YJBLwdyk0kbwLKGtVvoRYYEdjc8Zz2/gnI1G32A/jCxFZxoZKQRv6nHag32DYrzg
         zs1hK9xn1mYpYn2iUIY0Gxnvd1TKcaxLCiB9Jvv0/6SqS72sjgWBKyWmlasxd5V9cIl0
         3vhz41Hw+ovRvKIKgp7zytPAZHfkc4LTahT3tQq5AearjVmZdZAEGI7PKmlvKwMZrd0t
         B2conqL3YI+XD2gmncR6qTBmhaBuELHeOOeS1C6ZS4HIJT8L5OvLmL5FGjQG54fHc1VM
         Fw4GvgRRfv1xM2W+jOBBGKjFk7SUqyQnd7eA1PSGsRtz3scAyRIqpDHRg0eXHKxplk93
         YgTQ==
X-Gm-Message-State: ANhLgQ3u/ilWrWGANTnpS9XZpL6o/GplDLoee4WYBGWoVt5S5smoifGU
        Mfe0B6seZrwf/RraH+f5YjU=
X-Google-Smtp-Source: ADFU+vsLBJTIEqIzdTzPSw9aHFuC1dvOqRssdzID6BwrYxGJAlETK+qn94/K1264KDgW4nbrqvGOCQ==
X-Received: by 2002:a05:6512:6c7:: with SMTP id u7mr5408308lff.176.1582978615322;
        Sat, 29 Feb 2020 04:16:55 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x1sm6270232lfq.46.2020.02.29.04.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Feb 2020 04:16:54 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Jer=C3=B4me=20Brunet?= <jbrunet@baylibre.com>
Subject: [PATCH v4 0/3] arm64: dts: meson: add dts/bindings for SmartLabs SML-5442TW
Date:   Sat, 29 Feb 2020 16:16:01 +0400
Message-Id: <1582978564-81491-1-git-send-email-christianshewitt@gmail.com>
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

It would be good if Jerome would check the audio card config. It looks
correct from dmesg output but the driver is new and there's currently
no upstream prior-art to copy. I've cribbed node details from his WIP
gitlab branches.

v4 - typos/corrections from Andreas
   - add sound node back
   - confirmed gpio-hog is necessary

v3 - change to Smartlabs LLC
   - removed sound node

v2 - removed audio nodes
   - changes soundcard name to "meson-gx-audio"
   - added missing uart-has-rtscts;

[1] https://patchwork.kernel.org/cover/10674939/

Christian Hewitt (3):
  dt-bindings: add vendor prefix for Smartlabs LLC
  dt-bindings: arm: amlogic: add support for the Smartlabs SML-5442TW
  arm64: dts: meson: add support for the Smartlabs SML-5442TW

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts | 386 +++++++++++++++++++++
 4 files changed, 390 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts

-- 
2.7.4


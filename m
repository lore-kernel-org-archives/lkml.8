Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547ABC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35955206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cC3hjgLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgDUQjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUQjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:39:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA66C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:39:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d17so17155386wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pD/cklajXrTQwt9/i5DAty8o4fVAa/YnpTHBgrSpmUo=;
        b=cC3hjgLK/ed2VS7t6nroMpSd45uSi3v2KkxWLH57GmFzchId7vQD+xE75Cy6pC+J2t
         lI0tk54G+L7wk8fp5rDFWdyVIYor0pyA/Mnb6PDKhnkLdwtJGTFlvzi1jVWH1n69PkfO
         3Z4qwVDkhJzBzxKjoZoIANPzGMuVeUb+n5I9DuhKFdprbT49RWM5326NFEqO4nrS/8oV
         cWOpLbSVVZdqvE9IvrWHNMws7DLr6a+Txmf2zG1cN6LHVwF0AgY9Q0v5dXcxMynigQKD
         Dc1SuB9Rul4UYdn1bALQCRCnUugovCUySmVINrDIdSF22my2Vr/d5yfF56kXEs/r71DN
         lGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pD/cklajXrTQwt9/i5DAty8o4fVAa/YnpTHBgrSpmUo=;
        b=RsHrBDVDK2KuIOdDpaFqn4+0MKumqb4kSYC11iao7v8Og1wvZ0A7j0DPkSTUFTgnlq
         iz2FRYDvPvqoSRXI6EpOKaIjfwx0XRqulDxWB+VaKUM0KzFh7l9exvQG/rFGq3wy4qu+
         Wqs2d/FS5IcpJ3U5/5gyu6qpzFQfjkgBm2/A3TkIG73m4j0UCsFlWAqj+tQR67ZtMhs0
         i47usuSazkbHJmpxq8dBE9o+ly7lPbw5UDr2Fz3HqZTQQ5vBNfBr+C28dIgMM4R03GJl
         LEmWlNTfkiwBfI4oKcJlgQx1v4YX4Fl3EN53UiUsy5vX+YF2bLmSoZRkvpkNe6HEWfy4
         DlHA==
X-Gm-Message-State: AGi0PubJ9tT7UkJyhBwUX7WZz2Yd2bovxVKIMtW6iZIOb3qqSHeMuvTl
        ksRChSNA8ZyosM/kZadbI9N0RQ==
X-Google-Smtp-Source: APiQypLFS/luRYy1vtvb9oit1ZVDhPgOb4uA9Tjl0mXJJSRx+3VINZ7T+gVV+hgdxPvZr8sDYsupMg==
X-Received: by 2002:a5d:688f:: with SMTP id h15mr25248133wru.352.1587487180151;
        Tue, 21 Apr 2020 09:39:40 -0700 (PDT)
Received: from starbuck.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id 33sm4578513wrp.5.2020.04.21.09.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:39:39 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] arm64: dts: meson-gx: add initial playback support
Date:   Tue, 21 Apr 2020 18:39:29 +0200
Message-Id: <20200421163935.775935-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is adding the aiu support in DT and well as basic card
support for the p230/q200 and libretech boards

I was hoping to provide the internal codec support with this series but
this is still blocked on the reset dt-bindings of the DAC [0].

So far, things are fairly stable on these boards. I have experienced
a few glitches on rare occasions. I have not been able to precisely found
out why. It seems to be linked the AIU resets and 8ch support. Maybe more
eyes (and ears) on this will help. If things get annoying and no solution
is found, I'll submit a change to restrict the output to i2s 2ch.

[0]: https://lore.kernel.org/r/20200122092526.2436421-1-jbrunet@baylibre.com

Jerome Brunet (6):
  arm64: defconfig: enable meson gx audio as module
  arm64: dts: meson-gx: add aiu support
  arm64: dts: meson: p230-q200: add initial audio playback support
  arm64: dts: meson: libretech-cc: add initial audio playback support
  arm64: dts: meson: libretech-ac: add initial audio playback support
  arm64: dts: meson: libretech-pc: add initial audio playback support

 .../dts/amlogic/meson-gx-libretech-pc.dtsi    | 40 ++++++++++++
 .../boot/dts/amlogic/meson-gx-p23x-q20x.dtsi  | 63 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     | 13 ++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   | 23 +++++++
 .../amlogic/meson-gxl-s805x-libretech-ac.dts  | 40 ++++++++++++
 .../amlogic/meson-gxl-s905x-libretech-cc.dts  | 40 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    | 23 +++++++
 arch/arm64/configs/defconfig                  |  2 +
 8 files changed, 244 insertions(+)

-- 
2.25.2


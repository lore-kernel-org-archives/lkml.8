Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611D3C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 02:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40CD720738
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 02:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xm5JNULg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgGSCpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 22:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgGSCpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 22:45:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EF8C0619D2;
        Sat, 18 Jul 2020 19:45:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so21911157wml.3;
        Sat, 18 Jul 2020 19:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KYbiuW9akHYr4iGm+mhAKAzYf50rap2sHQ/b1EeZvQE=;
        b=Xm5JNULgk+HvV4lgvqpxTOveb26IsydL5sSDuPK0E1GVOb+NGB6SaTXc0TGUReH8jc
         7+m2kBC/t4nvRSWEp0wms+TbeI2UGSdKj3hDwHrZkKXoqfcLkQ4UJyWf8sRfMxi2lA3c
         6cQFq6qqy56dloeFcH57da/Uqg7U2pCv8t2aogBTCAqj4NW3euw06yLWzLNHSOMPG38w
         SOIPAcC/SNq2dAiVijmo2DOPH5qtB93CmHdVTIkLuyBQeBSwtaftisObpMQQ2O1n94fl
         vSR5A1TUYPp+OswW8zxeZaUJ2brIdvEV7IHtOImUAEC7CiUh4PRiEYfKsUhudbl7r/5Q
         DIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KYbiuW9akHYr4iGm+mhAKAzYf50rap2sHQ/b1EeZvQE=;
        b=tZaIVReV4kS3ZRXRY5A5TvQEZXECNfYC2kt5QJTsqfmjqiu6nCYAze+ff/J7MFqrsI
         FFozUMOAHTs4xklBaj/MYs8W3pQiaSFFE3nHjHUBgrPv2Co2N/TRmGfEpOKKqADCHUvS
         Tf0+DGQyXIyvB9I2dFAMkV8a8rRUIVZgBZ8V0OyLZzKIgFN5Pb6c+V5FyTeWhPe5jFxM
         u1rVOu8BfCdLluMq1krIqikqGwXCSvquH9uFJNtjuaql2Zx9lBKnJDjEktzr02HB2QUY
         +2qKRB7CxIxrJo0SsVHo/yGboOx4WBhC9gdHuLs4FZ48NTHNkGZ2tKYOlpFqkNPo/1eP
         kiiw==
X-Gm-Message-State: AOAM532HpfPSi2DxbREqHXjMr1c4A1jEosyAGHbpXSKu9v2ANhhc3SUs
        N1u4tAp3q5lX0wNcf9Sk+JU=
X-Google-Smtp-Source: ABdhPJyQ5SsSC6XvJcXlOahk61Svf/sAlbNZHZmBPNv0Ob764zWHfiQXHNOoK5Z3xOmT5d/aq77zkQ==
X-Received: by 2002:a05:600c:2058:: with SMTP id p24mr15573644wmg.74.1595126752945;
        Sat, 18 Jul 2020 19:45:52 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id e5sm5176242wrc.37.2020.07.18.19.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 19:45:52 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 0/3] arm64: dts: meson: add more G12/SM1 soundcards
Date:   Sun, 19 Jul 2020 02:45:45 +0000
Message-Id: <20200719024548.8940-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for LPCM audio over HDMI interfaces
to the Khadas VIM3L (reusing the same config as the VIM3) and the
HardKernel ODROID-C4 devices, and HDMI + S/PDIF on U200 reference
board (reusing the config from the X96-Max box), I'm sure support
can be extended to include other hardware but this gets the HDMI
port working as a minimum capability. I have tested with VIM3L/C4
devices and a no-name S905X2 box.

v2 changes - include u200

Christian Hewitt (3):
  arm64: dts: meson: add audio playback to odroid-c4
  arm64: dts: meson: add audio playback to khadas-vim3l
  arm64: dts: meson: add audio playback to u200

 .../boot/dts/amlogic/meson-g12a-u200.dts      | 131 ++++++++++++++++++
 .../dts/amlogic/meson-sm1-khadas-vim3l.dts    |  88 ++++++++++++
 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  |  88 ++++++++++++
 3 files changed, 307 insertions(+)

-- 
2.17.1


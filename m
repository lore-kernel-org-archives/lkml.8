Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4911EC47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ADAB20752
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQWbg/TS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgEDUBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgEDUBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:01:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A78C061A0E;
        Mon,  4 May 2020 13:01:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l18so575327wrn.6;
        Mon, 04 May 2020 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xwqNTpvr36YlbOoEch1Pgho2qgj2JVScQlJ2Ca/JbVM=;
        b=MQWbg/TSygNyKyr5jE13Qw4+hnu+8Ghk/K0WTZpN5wFyh7CFc2J8wLIyLAfrj5Ty5l
         TQ5pfDHa6GsnyR6ZkTRK2LyipMDCjKf8g3+tHKaOFbPyJj6LNgGfHcWVzi7Ph0nmGbX/
         CnKIYiWdrV/Ib49qwonSgj+r1LMdU9u/u3hD+gY08rXbfihI9xKhVDH2sb2PC8z2eU/L
         K7EhzVh+3M26Jwb949bnePkL2tsfWwX2MD3V/6js9bAtf/ZkPtPeCUAqMEh3cWvCdnEu
         FMyRFDODIR+MmCrazrMyMTICU0WeHan/Ek5/1R6QU3iNRUtOu9iwrlTEPFRBHuCwidnd
         6n+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xwqNTpvr36YlbOoEch1Pgho2qgj2JVScQlJ2Ca/JbVM=;
        b=TcAesBfXkhkTRnU18Yl8Mls7CoggJWHKjUMboEJ4rbyqpz/PXXFCHhLHL3GQNGzKmB
         H+jM23Pni55F4Qn6KS7Xm/eqmj9B5b8Dy0TOe9vcn2pYrh9aT6M0FNmiFM4V8A9DyR8r
         52x4+mhYgxQhZ28k7CtW5hf9N4DgNU9o/fsYQXZJBsxXmvxr6ybSKZ1f894q3dkg8fDc
         QZrGvqotmzDO5okAcHfNK3kg6ZFGUzpzxj5ew1KJaDuHwu124eGtX2D2XyWFQkX0D18J
         H32k7R+r490OUQGaBjxSlWdNpQZupZsZ1sJSTTd7Bi180XiZj7fapKHKoxb9csKA8z22
         QIpA==
X-Gm-Message-State: AGi0PuZaW2ILUR457ozxWMKNa3dyzhDdh3mqYuAgU4g5RxRyk1EF7rHa
        YhOmX/GS/QvbaXHpzUltTB8=
X-Google-Smtp-Source: APiQypLvvE9333aRFxwKbKQHbL0iSZvAaDGcvFb14pX/z6fIIXy/aeg7zbhQ+V10PpIe2vBXj6AbyA==
X-Received: by 2002:adf:fad0:: with SMTP id a16mr1104639wrs.149.1588622470431;
        Mon, 04 May 2020 13:01:10 -0700 (PDT)
Received: from localhost.localdomain (abag125.neoplus.adsl.tpnet.pl. [83.6.170.125])
        by smtp.googlemail.com with ESMTPSA id s17sm739252wmc.48.2020.05.04.13.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 13:01:10 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 0/2] Add support for ASUS Z00T TM5P5 NT35596 panel
Date:   Mon,  4 May 2020 22:00:58 +0200
Message-Id: <20200504200102.129195-1-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v2:
- fix Kconfig indentation

changes since v1:
- make `backlight_properties props` constant
- a couple of line breaks
- change name and compatible to reflect ASUS being the vendor
- remove a redundant TODO

Konrad Dybcio (2):
  drivers: drm: panel: Add ASUS TM5P5 NT35596 panel driver
  dt-bindings: display: Document ASUS Z00T TM5P5 NT35596 panel
    compatible

 .../display/panel/asus,z00t-tm5p5-n35596.yaml |  56 +++
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-asus-z00t-tm5p5-n35596.c  | 367 ++++++++++++++++++
 4 files changed, 434 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-n35596.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c

-- 
2.26.1


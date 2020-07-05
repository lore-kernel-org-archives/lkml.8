Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8322EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B73220786
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1tK2P5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgGEG7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 02:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgGEG7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:59:37 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F022C061794;
        Sat,  4 Jul 2020 23:59:37 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dm19so25570647edb.13;
        Sat, 04 Jul 2020 23:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uj7PGXQjA9Qjyx6Apu7BwCYoAwQ6mjWMYaZTjh1xboA=;
        b=X1tK2P5x1N5NIvZTW+VcJWoJ5K7YshwD/RGTnoclfrQc9rWXzaq6x5lbh3W1VEPG3H
         GIBj3aYdZwSkmbX30wI0ltTXdk9CnsRitseiZtukzUKEk3FNTlkZwPOXIzWjeP499J/h
         xCTffMRhoUn1p7NWV3QhPZ1KwiRWnwxwdcgOzZ7IN9IH/TZ7dDyEEoJLo0yjD+zY/jSq
         U/Mez575j6Gk8PqJLH1jwIIrEPtUwfcKywMt7nrVfB+WPVnPIRMguFf5Uy51Wimot3VA
         03Tow+PpzzxaVQn7RJASKTh8RPzBXnCFS8m6FGqLmHu/X1hY90wgL2yNY9oyCjHPCC6U
         vedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uj7PGXQjA9Qjyx6Apu7BwCYoAwQ6mjWMYaZTjh1xboA=;
        b=f/OUuyeIPvO9lr4l1uz5iGCpZ5tU/IKSo8D6GDhbc5yOhMiCtq9mChXUyYQWWpbryd
         qOCyBTw/p7E7j/Ftkh7sZm66z39q/IzndNOvkThF8zjyrHi5RYzj08lI5LOepKC/b+T+
         W6EeZ2KVQBToPJHwVwHgkNH+5SOajPOIhhZLh5grcAIalQFRnDLxNy15n9JDLqSt2GXH
         hSVaxtvazvxKaRkZlPgyo8PJcMOO29/xNYaA4nqhHERINKGcbLUQcTkRf1Wk0QGHNhHW
         zgXg46duQ2RhIBeq1u04TcK3prE+ApJWOpbFz5QmR2O6bLM0orKRkPhVIe2idGXbWwy5
         EXGQ==
X-Gm-Message-State: AOAM531/ueLPLxGrhey043+2Ydc6KMlDKvJqKp2WzuSRvqlBqI2HUaQR
        FdOdPit8jmRSI94KaYKyrSc=
X-Google-Smtp-Source: ABdhPJxf8p7neXQpdYnh+iVo38AaVRoy6UlE6QLvO/bQFZ8OMYCoPcBv6DsoAxTNbMTymew/PEyO+w==
X-Received: by 2002:aa7:d989:: with SMTP id u9mr31469159eds.85.1593932375906;
        Sat, 04 Jul 2020 23:59:35 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2db3:e200:60e7:4b3:523f:884c])
        by smtp.gmail.com with ESMTPSA id q3sm15042052eds.41.2020.07.04.23.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 23:59:35 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Ondrej Jirman <megous@megous.com>, Sam Ravnborg <sam@ravnborg.org>
Cc:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust entry to renaming and conversion
Date:   Sun,  5 Jul 2020 08:59:17 +0200
Message-Id: <20200705065917.22285-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a74e81a56405 ("drm/panel: rocktech-jh057n00900: Rename the driver to
st7703") and commit 7317f4574492 ("dt-bindings: panel: Convert
rocktech,jh057n00900 to yaml") renamed and converted the files mentioned in
DRM DRIVER FOR ROCKTECH JH057N00900 PANELS, but did not adjust the entries
in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches  F: \
  Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
  warning: no file matches  F: \
  drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c

Adjust entries after this file renaming and devicetree conversion.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20200703

Ondrej, please ack this patch.
Sam, please pick this minor non-urgent patch into your -next tree.

This is the minimal change to address the warning. You might consider
changing the name of the section from ROCKTECH to ST7703, change
maintainers etc.

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9375edaef11f..8a7b92faff99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5493,8 +5493,8 @@ DRM DRIVER FOR ROCKTECH JH057N00900 PANELS
 M:	Guido Günther <agx@sigxcpu.org>
 R:	Purism Kernel Team <kernel@puri.sm>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
-F:	drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
+F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
+F:	drivers/gpu/drm/panel/panel-sitronix-st7703.c
 
 DRM DRIVER FOR SAVAGE VIDEO CARDS
 S:	Orphan / Obsolete
-- 
2.17.1


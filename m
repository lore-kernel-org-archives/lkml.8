Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98ADC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52602078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598467737;
	bh=XBr/fnbwBz/TLqTnqck7d9QMDktEe+KFnwu1ysa+BqY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eOfW1wlLiSUOMDZpeyCRSvArySMjeBZzf6OR/HNa35bQ+435DlUyb0/VhrU+tNf+7
	 Izm86CeImSiVS+sqwL5CzJiMHdv63KgV9BlEHy746xWjPrtjVXMUk+bSj3yvhiKEAg
	 8PliYjoNz4dixnbftC+GPCOUYvqM+IWOHa0sVgis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgHZSs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:48:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41348 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgHZSsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:48:55 -0400
Received: by mail-io1-f66.google.com with SMTP id m23so3206956iol.8;
        Wed, 26 Aug 2020 11:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANVjB6Oqn2d1pZe/e10TGufV/gtKnuBQp7HE23A4Kz8=;
        b=bM1ZVTcBDrTz63l+K6iKE6OY/K74r2k0IaL1R2KYui41fjk+OJFyB7ubeG7zBi0yzQ
         uYJEu8lJIEFyyfqp8OP7WiiLRICdjALUAZfjYGjyNTN51xwz7Y7GlWcH65rmRx9fYQMF
         VFhv/PuKNC3u95t0gJ6jTSHEMmrLBcqYzpW5odEAHZnulD1RYH4E6YHBg1bL6Mf/OimT
         oIMT7C6RYo9TRd25AH6DQJ3O0ks6nCHbgmu4qlK1cKuUXhnsnjJvTkKooI1dBp50ytW9
         cCLwpUrYFqbWIf//mXlt6UHunqCsNQ8EwL4IEI0aPoLg2v/EGJBjpf01zOedmrCipS18
         K7vQ==
X-Gm-Message-State: AOAM533jp0ix5O9KxfL7qGU0vxMIhfWcSM0lRmjtKYPpH0oMtAN/O2Wj
        4zRNoIo4Ze7Yvt34nJxT+gGcIuykuVVC
X-Google-Smtp-Source: ABdhPJxCGQDbXnwHYxRdKiwLONGRlHhRoTm815Iaj2AA0tWZ3EoOypxgdG+IXPtFbxHb2B2WuP+pTw==
X-Received: by 2002:a05:6602:280f:: with SMTP id d15mr5477882ioe.200.1598467734302;
        Wed, 26 Aug 2020 11:48:54 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id c2sm1609226iow.6.2020.08.26.11.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 11:48:53 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 1/3] dt-bindings: sound: Remove unused 'linux,hdmi-audio'
Date:   Wed, 26 Aug 2020 12:48:49 -0600
Message-Id: <20200826184851.3431531-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding was added in 2013 and has had no driver since 2015.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/hdmi.txt | 16 ----------------
 1 file changed, 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/hdmi.txt

diff --git a/Documentation/devicetree/bindings/sound/hdmi.txt b/Documentation/devicetree/bindings/sound/hdmi.txt
deleted file mode 100644
index 56407c30e954..000000000000
--- a/Documentation/devicetree/bindings/sound/hdmi.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Device-Tree bindings for dummy HDMI codec
-
-Required properties:
-	- compatible: should be "linux,hdmi-audio".
-
-CODEC output pins:
-  * TX
-
-CODEC input pins:
-  * RX
-
-Example node:
-
-	hdmi_audio: hdmi_audio@0 {
-		compatible = "linux,hdmi-audio";
-	};
-- 
2.25.1


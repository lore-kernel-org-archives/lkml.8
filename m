Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAF0C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979CF216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/vvZRYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgEAUsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAUsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:48:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD3EC061A0C;
        Fri,  1 May 2020 13:48:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d15so12970838wrx.3;
        Fri, 01 May 2020 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MpHLQcuIlLeV8LyFszC01tPlOciL9hnzGZlXYQVZDTg=;
        b=e/vvZRYjwEbzJsXb6aoRr6yO09dJxZk42gY+zJtDCzV/G4k1pZPoCTpwPXPei3k0pX
         3/9rqkRp5I8HqSMF8AlJjwdWS8KzFiMddY2UX8sU23FNVkk1EZ2Ge1ePR5X5DqDEdgfu
         TDiOtQ3l+bBFUYpdmS1ryD+nOHcnYPkglDVoyQYTM3/djpY3W2F46zt6KsjlQkXGN7x5
         FDFXUxNQ8K/yWBAbIvIi/rnL4CuxIApSZCNCRZW/Avn8EuCJQILD4J97/CL1pYGasInF
         WFMT4L7P1MTRPO6H/+UO2nFufQlIPbMG6ToKpQW5OzgpnVmMEG8k95F5PIY44v8pEfZE
         KapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MpHLQcuIlLeV8LyFszC01tPlOciL9hnzGZlXYQVZDTg=;
        b=UWNtDWbdbQKpfh4c0nZtsJHRdG3qkcI2SPlrtGrQ+0/lRExycp5pRjCI87GEzVzfC3
         v1sDLCPPCtyMioljmDyaqJJPfErDi0vXKGozcfJ9IKLHPxkReFwKh6WAIpPb2zXqywd9
         wil1Vh8+3DgLsm3sAJWfn1sqLOIuuVmSy0LhbeDrHF46844bceBb7PPw1zzlr1v1kLgL
         mACVOw8petuwfQAHybg2P1c5/O/2fWxK62V+hjDQ1tOqOvhh+MUwh6agtgxQnZ/tJVuk
         Lkv0/n0b/5yEWOPFU7NFSGu3cuO6Icmjf6/hjhZBjqlE2aGabZAMFP0StX/UjaBnxCB/
         oXdw==
X-Gm-Message-State: AGi0PuaICZ2Fbic9BZUkwym9P/ftVcyS4RizHezh+bjkPvCtB7kEqJ4w
        8kXplfNFIn4k7mNOR2jlPRM=
X-Google-Smtp-Source: APiQypLHZtEj6BaFIkoc4SmhqGuUMEnC4f1iMxoFKBtwNQYsPOBHwMGzDscmfp47F7SHJmJbZMHQPw==
X-Received: by 2002:adf:8563:: with SMTP id 90mr5741738wrh.74.1588366119618;
        Fri, 01 May 2020 13:48:39 -0700 (PDT)
Received: from localhost.localdomain (abag125.neoplus.adsl.tpnet.pl. [83.6.170.125])
        by smtp.googlemail.com with ESMTPSA id w12sm5938623wrk.56.2020.05.01.13.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 13:48:39 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add support for TM5P5 NT35596 video mode panel
Date:   Fri,  1 May 2020 22:48:21 +0200
Message-Id: <20200501204825.146424-1-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am aware of the fact that this is probably not the correct
naming of this panel, yet I am unable to retrieve any additional
information about it, as it is used in a smartphone to which no
schematics are released.

The driver has been generated with the help of 
linux-mdss-dsi-panel-driver-generator [1] and works perfectly
on a Asus Zenfone 2 Laser Z00T smartphone, including brighness
control and switching on/off.

[1] https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator

Konrad Dybcio (2):
  drivers: drm: panel: Add TM5P5 NT35596 panel driver
  dt-bindings: display: Document TM5P5 NT35596 panel compatible

 .../bindings/display/panel/tm5p5,nt35596.txt  |   7 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-tm5p5-nt35596.c   | 366 ++++++++++++++++++
 4 files changed, 383 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tm5p5,nt35596.txt
 create mode 100644 drivers/gpu/drm/panel/panel-tm5p5-nt35596.c

-- 
2.26.1


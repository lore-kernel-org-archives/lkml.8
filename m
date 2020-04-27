Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFE1C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F032078C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLMul7nb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgD0Nks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgD0Nkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:40:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807C9C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:40:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t14so20570163wrw.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MUIBi3Kz2bkUUb92RvvcEHJTqtbaNXF9Y7EBsbD5L0c=;
        b=OLMul7nbDDFYBho4Kvdud4pdceB9b7aPn9ASElp5wj7Km258hn12H7ulg8+XahVHqS
         D5Fnw57KJvloRVSjNdDwOpBQkCaHDgQvQoyRyeSI0t4nj3NT1ce392dR8cfqHfOuMFK1
         Ek6mnuui/vgFuGVnDI/LUgFz3HW6ExBq3gMeaFagEdQjxzxTy/PC5RaIMz3iYJaeSmRZ
         KXd9PT1YvkNTowH/b49ZVIWbdqwVKUloM0jaUwQceeWVl11LF8ep1KXqbqrgYo/hyuPy
         QJTm285KkTQQ8jsfSE8RWweLyNK7EMWFzTx9Ohhs/tb6/C0TgoLvj+75ZTK7IqVpSHSE
         mviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MUIBi3Kz2bkUUb92RvvcEHJTqtbaNXF9Y7EBsbD5L0c=;
        b=IVpDJO+nNq5FedHlrKIrpQ3I8xxaCAZvPCaltvLdoL+9ynGpl1leIaoe2Lcl6Rcup9
         X45IV85wzGwlzjJv29XoTIVuFtvq6jT5JvPNzszTM2QXd1R5O7nqNHiUN7YdTXqidusw
         mpMmRHlPjtW+Y5SX1eQmql9DQ48mD5IoUbud+ZyG696xWZN87BIQJYYFe4HMKAdMbFLX
         /3wjugJeP8NibCuBzO13phAZyVr9HFkyNKvdwYwpUHswGhFxa6fTlTLGEGMnFwdX1gFS
         6hdxnwYaNEj8+drte2zFqIONmpbo/l80jJ2TE9C8mr3/bdCvVOdGDihgXP6vvNEZwXXD
         pmMQ==
X-Gm-Message-State: AGi0PuaXOAixamND/XY0JUvYEBnx7gExHSDpMNImfOdYddTA4eTjqEQR
        XrB+gpzf5SBql9DqkLn5Ay0=
X-Google-Smtp-Source: APiQypJKb7lCTqNXQgytbzzPh7skR1WCcEpQCoDe8IIwh8BbQCBr+FlamFIWRbPLZVeRq/pA585TTA==
X-Received: by 2002:adf:84c2:: with SMTP id 60mr26971075wrg.65.1587994845296;
        Mon, 27 Apr 2020 06:40:45 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id g186sm16290640wme.7.2020.04.27.06.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 06:40:43 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
List-Id: <soc.lore.kernel.org>
To:     Max Krummenacher <max.krummenacher@toradex.com>, soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 0/5] defconfig: fix changed configs and refresh
Date:   Mon, 27 Apr 2020 15:39:58 +0200
Message-Id: <20200427134003.45188-1-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three configs have been renamed, added and/or, changed behaviour.
Clean that by using/add the new config name.
With the name change to DRM_SIMPLE_BRIDGE the related
DRM_DISPLAY_CONNECTOR got introduced, enable that additionally.

Then refresh the defconfig with make defconfig savedefconfig.
The refreshed defconfig does result in a not changed .config, all removed
config options are selected implicitly and part of .config.

IMHO, patches 1-4 are bugfixes meant for 5.7 while patch 5 is a cleanup
targeting 5.8.

Applies on linux-next/master tag: next-20200424


Changes in v3:
- new patch: added 'arm64: defconfig: add MEDIA_PLATFORM_SUPPORT' now
  needed for some enabled drivers or these drivers will silently not
  be built.
- add reviewed-by tags
- dropped 'arm64: defconfig: PCIE_TEGRA194: follow changed config symbol name'
  similar patch got applied
- as requested by Arnd, added suggestion on where to apply, 5.7 vs. 5.8.
- as requested by Arnd, amended commit message with info why some configs
  are no longer in the defconfig.

Changes in v2:
- additional patch adding DRM_DISPLAY_CONNECTOR as recommended by Geert and Laurent
- add reviewed-by tags

Max Krummenacher (5):
  arm64: defconfig: DRM_DUMB_VGA_DAC: follow changed config symbol name
  arm64: defconfig: add DRM_DISPLAY_CONNECTOR
  arm64: defconfig: ARCH_R8A7795: follow changed config symbol name
  arm64: defconfig: add MEDIA_PLATFORM_SUPPORT
  arm64: defconfig: refresh

 arch/arm64/configs/defconfig | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

-- 
2.20.1


Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE82C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1B720780
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkEXcWTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgDHOa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:30:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35264 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgDHOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:30:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id r26so143188wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 07:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mLUZTMACgOdZTJqIc//IsSs4hQHzPmyw9T3yzeJY29Q=;
        b=KkEXcWTpKhPSVYHTzs9Hu9eRt2qWT3m8MI2hK4f1yUyGMa03+nMXoKTvvGd4nVhRtK
         phKxiQIoYpHfE0wCrOFreaUywWND6BBlHak6ojF8fefiNgUsVRpJcGp5kcsRiRUPWdoI
         8tG+A4VmGE9Bx4IhwSuV3qXjvRzs6oOD4/j9atnD/SScZ9uoVd6R5TqMWdc3ULO4BgsK
         BhMRRszWbbX3Ia6uaXvKS4ahUWyw+aOssaOF190au/7Fyj00O7NPFhG2FMNRulpUbvWN
         MzdNpANFtmO0dGoMDJAQsAhSPXeCKzjzH5Jez3qBQOTiWErwY+qwXKZS21oi0n78+KWP
         9M9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mLUZTMACgOdZTJqIc//IsSs4hQHzPmyw9T3yzeJY29Q=;
        b=ISLYHjLZNwPTeOyn7hJG0NcbNe70J5d66pVN8Ot2wsJpVec4fK+1jTEYkduYxC3sLS
         UKPf7m5N+yGWBfX2A4hBmgSJYa1m7bNvBFKJQUpVK0ewySd2hxbbYRP4eEtmIhOYcBpM
         3cKv03e/AoZc8uyChv/iT0hXW7VzmPMJ4yPncFHoWnlVE7puOOSr76oa8yPyMPgs/0Y3
         HwZnxNXcu0vrTYkNfD69sKIjfcIpu2Yc0YbCjzclTWHE6DWo29X+Q16CF9UqNx0q7yKy
         PoXt0JXP2SRf6T5OFmqG+EELFmVvINTd/ObKeuRArULAvJ0saQownICIacE468P8Q0Ls
         DLKQ==
X-Gm-Message-State: AGi0Pub+6XRtu3sjYtLML44R2nMGGLRPiakdF7RiNAYoNpZsz0V9JDE2
        7ommmacS1Bi6WAmfuva7tgSCpXusrGg=
X-Google-Smtp-Source: APiQypI1steOmsQ2Cf3zIOhuPmaJhyAjfO9SJ0wyXh7OuuHQzA91KBz1hqB0Sq9hVig7S+hGpQcxRw==
X-Received: by 2002:a1c:5f56:: with SMTP id t83mr4729013wmb.61.1586356255686;
        Wed, 08 Apr 2020 07:30:55 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a10sm36268828wrm.87.2020.04.08.07.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 07:30:55 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 0/5] defconfig: fix changed configs and refresh
Date:   Wed,  8 Apr 2020 16:30:35 +0200
Message-Id: <20200408143040.57458-1-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three configs have been renamed and/or changed behaviour.
Clean that by using the new config name.
With the name change to DRM_SIMPLE_BRIDGE the related
DRM_DISPLAY_CONNECTOR got introduced, enable that additionally.

Then refresh the defconfig with make defconfig savedefconfig.

The refreshed defconfig does result in a not changed .config.

Applies on linux-next/master tag: next-20200407


Changes in v2:
- additional patch adding DRM_DISPLAY_CONNECTOR as recommended by Geert and Laurent
- add reviewed-by tags

Max Krummenacher (5):
  arm64: defconfig: DRM_DUMB_VGA_DAC: follow changed config symbol name
  arm64: defconfig: add DRM_DISPLAY_CONNECTOR
  arm64: defconfig: PCIE_TEGRA194: follow changed config symbol name
  arm64: defconfig: ARCH_R8A7795: follow changed config symbol name
  arm64: defconfig: refresh

 arch/arm64/configs/defconfig | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

-- 
2.20.1


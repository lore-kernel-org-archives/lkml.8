Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2613C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C779206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DhAuVmRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgG1LSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:18:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:55827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728934AbgG1LSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595935097;
        bh=kKz6J2TJMa/GicbvTCv76Ky9V4fO/FV3yZh5V+NhgHA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=DhAuVmRnZtbvXh5bWCK6YnKHZjfPtkWhtW9RWOCYS3tJ2NDqtLyTQDs93pIXH/U2h
         xZ9ZIMzkvYNgM521DovcY5ByOMhKH4g8PeCAgIHxKLN2rh4YcaapUG/Rx0zeY0yfHQ
         jbK6fD5cq/tu0XuLekls9fWXa0etcLhnriLQ1KgQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([80.208.215.239]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MEUz4-1jym7135gI-00FzVD; Tue, 28 Jul 2020 13:18:17 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] make hdmi work on bananapi-r2
Date:   Tue, 28 Jul 2020 13:17:55 +0200
Message-Id: <20200728111800.77641-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+y5CoX8QurDPY0IO98TiGJ9LRNcAE9xACEixzFfMq7Rc9pJV6/F
 VIOEtUITqe74q6u2ezJ4CIbpDVVJNTJugvVeL9HglsnPh8Husf3ag6TligX+Syc5hziPW09
 ER2o83PdhsHrZ1mvkVFnWBMYpn1ixkPjVaA30e4evKXJ+WzDhFbNGkKNRPet6RUPF6aFX69
 ZYJDeR5cZL/ysODW/uUsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ys97Xj7rYoM=:a2DM49E19qlfep+w6GoeVe
 KmnKZW/nZPa/niTEv9psAQfd3aObxG1KHuYQK3bIRH75w0tXG62bpW6gvn3qRfViJFp17izFV
 p+RM9df5EhTfRB/URExSFm2KcZKD/DDB+m2lsoV4rJroaBw9nk1/SSGjG/+d2l+aQYc4mlbAe
 YytkwsBLeDHxy4ZyJKhWpAI+ehfhMByhyXD1uomM8uEGIRc4sDhakLPYT5awU4o6juCogq7X6
 OwoA3URregNhMsV7XgRRT8u5+NhlINBiCLDY46tONhPlcpOS6DMvvxUVFwmH+jkL4x7/dWiZJ
 m3/puDezNlrAFjlkRdgCv0WGYxZmc8+A3zNC8eY6WI+0WJeLmS+G3Z55rl3FK+Z7nZ+Dj43wC
 9E5aS7iM7yA0OsKzVPI843uBOeEoHbHgcNPViBOv91U63AVmdvfWdxqVyXpZRfy2OgCYSGFWh
 gWBWTiRKvqi3DF4Ppg/LadfMsanx+ApS28uTZcfptOUhBOd2trh19fg2rW1PqiH/HEAq2Bbqr
 jGd+sVwwTl0ECvi5SiqnDrd0Jb899gzbCgjGoD/zoIeTD+zGKAxEk/cIqF9ft5BKlYpG9h4++
 yzOJefKFu1xBZMBM8asVfDo8uEUuFL+lHlF5QtYW+gZVaKkqrpFotVcDZOOKBypK6YvSkOg9P
 3lR+qhg0OctkqEIUp5JZ6zKRtMoVBFaiJAA0DrPnfGIwKJ4teByUalyeLcM+qBKtjt0dmCdR0
 Tgw9AOXqYqPnbcIcp3Sr4uoTrmQ4+mPMdNJj7VwHq/SpeCvXq14jmVuem2QPW8wVbz2i4Jtua
 gPenREzLtHBEalNRZjoPltvxlGSd1VwN5j4hhT7G+4vY1jVxCSycV17nD55hErVL8XCiPUgJ0
 prkepYSZXF+ximHqIZBrnltz3HBvDB8alTf7EorUDhV6o6LwZwvsjrhOgJHb7WAGASeCiki+7
 /8vsmeBJsKKanOgRc+of8QK1nkeAQn7CwlkXQpJM1XAYvT0oHNl20uPEb/yUBT8eJKgFjfqbF
 ZYVzB9bwkKSnLNLCS6DB27Jw2vsQoaKfLSe2EoRl6g/bZLQTqWVcs2obYP8TReui3HDfSBBiF
 TIhXp45Rsdj6Pgl7kVYPOFwdjobSDC/l0TY5BLJVmYphnLey7tERym3IdSzVMdgNmj/wUfjdq
 xyVs0/6c1uOvrshxWSZU2YVQm1S1aaRHjEznc8AaEtG5AR2fIkmd7SjIPjwnVFCnh1Glad/yj
 JKLV8UCCepLQfdrdienTYEVV9BcWJm8n22bI+5Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch-Series adds missing Patches/Bugfixes to get hdmi working
on BPI-R2
This is v2 of series https://patchwork.kernel.org/cover/10903309/ after
getting mmsys done

v1->v2:
 - using get_possible_crtc API instead of hardcoded
 - drop unused dts-nodes
 - refine commit-messages as far as i can :)
   "config component output by device node port" is needed to fix a WARN_O=
N()
   "fix boot up for 720 and 480 but 1080" fixes flickering,
     which may cause also some resolutions not working on some TFT (had so=
me problems on my smaller TFT)

2 Patches were already posted, but not yet merged into mainline
- config component output by device node port
  https://patchwork.kernel.org/patch/10609007/
- add display subsystem related device nodes (resend)
  https://patchwork.kernel.org/patch/10588951/

Bibby Hsieh (1):
  drm/mediatek: config component output by device node port

Jitao Shi (1):
  drm/mediatek: dpi/dsi: change the getting possible_crtc way

Ryder Lee (1):
  arm: dts: mt7623: add display subsystem related device nodes

Stu Hsieh (1):
  drm: Add get_possible_crtc API for dpi, dsi

chunhui dai (1):
  drm/mediatek: fix boot up for 720 and 480 but 1080

 arch/arm/boot/dts/mt7623.dtsi                 | 177 ++++++++++++++++++
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  85 +++++++++
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |  85 +++++++++
 drivers/gpu/drm/mediatek/mtk_dpi.c            |   3 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   |  42 +++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |   2 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  46 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   4 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c            |   3 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c       |   3 +
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h       |   1 +
 .../gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c    |   1 +
 12 files changed, 442 insertions(+), 10 deletions(-)

=2D-
2.25.1


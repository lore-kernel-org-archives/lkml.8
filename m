Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E55C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07C912078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Nv62K3KF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIAEJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:09:18 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:36639 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIAEI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:08:58 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200901040854epoutp03fd32b696eda7d62c49135c67d2fd805a~wjWVqOafs0597105971epoutp03e
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 04:08:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200901040854epoutp03fd32b696eda7d62c49135c67d2fd805a~wjWVqOafs0597105971epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598933334;
        bh=WExuTwPYkapG2SXJhxW+OhQE+hDZ5ydXARug+Z0VSb4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Nv62K3KFqZoT3UUUCNmBREMOIbYF2171+m0NDwX+brxV7EC7aZQ60MlMNQFgwGLhk
         qLmHHTAiSRFQIwVeYkD5L4rkQRbSs/l/i04Dp3og233/x5H2cR3Ui/6kIQYivFOHKD
         IDVD1gTa3UJjAldZMkwxvtAlXa1yGeMhdgv1s5qY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200901040853epcas1p1b0dff5806037df1d0e429a7804bd3506~wjWU6gNSI1138411384epcas1p1N;
        Tue,  1 Sep 2020 04:08:53 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4BgYTv267QzMqYkk; Tue,  1 Sep
        2020 04:08:51 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.75.18978.359CD4F5; Tue,  1 Sep 2020 13:08:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200901040850epcas1p2150ea195dfb20b46d6421af63b1f5129~wjWSPcyAU0064000640epcas1p2_;
        Tue,  1 Sep 2020 04:08:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200901040850epsmtrp100d80fa9760de5402200175b55f8a5f7~wjWSOkwgt3200232002epsmtrp1-;
        Tue,  1 Sep 2020 04:08:50 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-a6-5f4dc953b37a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.9F.08303.259CD4F5; Tue,  1 Sep 2020 13:08:50 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.111.64]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200901040850epsmtip16e6b0306a7440b7e3e4209ce230f06ac~wjWRx5E280395603956epsmtip1z;
        Tue,  1 Sep 2020 04:08:50 +0000 (GMT)
From:   Hoegeun Kwon <hoegeun.kwon@samsung.com>
To:     nsaenzjulienne@suse.de, eric@anholt.net, maxime@cerno.tech,
        stefan.wahren@i2se.com, dave.stevenson@raspberrypi.com
Cc:     devicetree@vger.kernel.org, tim.gover@raspberrypi.com,
        sboyd@kernel.org, mturquette@baylibre.com, kdasu.kdev@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org, hoegeun.kwon@samsung.com
Subject: [PATCH v2 0/4] drm/vc4: Support HDMI QHD or higher output
Date:   Tue,  1 Sep 2020 13:07:55 +0900
Message-Id: <20200901040759.29992-1-hoegeun.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTVxjeaW9vC7PupoCekE3KDTBwAXotleMijkzGbua2sLH9wMR0N3BX
        CPSD3rKh+yFDcIgwREFZhbAJysfA8SXSxs4OhCoyl1lGsUOYWyaTr4JaJJrJWorb/j3v+zzP
        Oc97ziviSzrwYFGWxsDqNUwOiftjvQNRsujUa+8oZQ7XBtRePoih+boGDNVfuSFAo24Xjqyf
        2wFyNZXiyDTajqGuP8YEaKlsUoDs5locVf7aIUQ1K08B+nn4DdRrbMLReecsjootV4To6Vin
        x9A8jqPfq6dAYgBd6BrCadd4sZA2Tv2I0xM3fsJpk/G2kL7gVNBdrUdweuqojUd3Nx6kiwcf
        Y/SXPa2A7r7+Gf2ga0uKeG/2zkyWyWD1UlaTrs3I0qgSyD2pyt1KxXYZFU3tQPGkVMOo2QQy
        6e2U6OSsHM+YpPQTJifP00phOI6M3bVTr80zsNJMLWdIIFldRo5uhy6GY9RcnkYVk65Vv0rJ
        ZNsUHuFH2ZkNI0NC3TFRvt22ghUAI14K/ESQiIMrtxc82F8kIfoAfLxi4vuK+wCeuloh8BUP
        APxi9ZDwmcVy3IclhBnAwrYP/xXZnozxvQROREN3mYPnxYFEPvx+2gG8Ij5RzYd/1p5bIwKI
        12FT+RnMizEiHJrOT62FEhMJ8M6gc/22EPhth3UtEySsIrjQUMX3EUlwyV23PkUAnLH1rBuC
        4b2Kw+uYg6NfzWA+cwGAFZWn1wk5vHz2hCeFyBMpCn5njvW1Q6HpSR3wYj6xES64ywReCSTE
        sOSwxCeJgHcLrAIffhEOlzfxfJiGQ2dOY165hNgHj87GHwMvGf87/2sAWsEmVsepVSxH6aj/
        /1IXWFvdrYo+UDm/GNMPeCLQD6CITwaKreY9Sok4g9l/gNVrlfq8HJbrBwrPe1Xyg4PStZ7d
        1xiUlGKbXC5HcdR2BUWRm8V3nFKlhFAxBjabZXWs/pmPJ/ILLuAVHn/fTRrnrLR6d1xbWvuj
        hHi/mpTUzqgTuS9sFrb/fbbYMKIK7kmjsz5eUL9lHxirEquNxNx0+MwrdqqXKnwOU8qbz23Y
        d28+sT8kxBH4zcPcopZL9Rc3BcmT22y3Ikqnl+sGxJfnkk65QspK7BeXhiYmqn9YNrlGVmpl
        t06WxASFRI/XTdZfcx0pmv8tfFLeW7F/8eWoIuaSf+h71/Off3P2gsvpSLQMN2o/2Lv6aVzH
        /WRL2KhxBpn1yCJplNzEagfcW8ruNleFLS81VEon+vLePfRLx8GNseaayIjc0O7FuMiWjL/I
        lp5e6+QqHnYgMm3XzdHOR+EPXxurGEq6Wk1iXCZDbeXrOeYfx2yR5EMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSnG7QSd94g/lv1C3W9h5lsXg7dzGL
        xfwj51gtrnx9z2ZxoPEyo8X75V1sFjuvrGWx2PT4GqvFx557rBaXd81hs5h4ewO7xYwf/xgt
        Lp5ytdg2azmbxbpbr9ksWvceYbf4d20jUMOKG2wWj6beZ3QQ9mh6f4zN4/2NVnaPWffPsnnc
        OXeezWPnrLvsHltvmXpsWtXJ5nG/+ziTx+Yl9R6tR3+xePRtWcXosfl0tcfnTXIBvFFcNimp
        OZllqUX6dglcGYvPHGMvmMBRcfn4D5YGxllsXYycHBICJhJ7JzWzdzFycQgJ7GCUeLPiCBNE
        QkZiVf8W1i5GDiBbWOLw4WKImo+MEh+uXWUFqWET0JX42nMdrF5EoE7iSUcjC4jNLLCUWaJl
        kgKILSzgJLG8dxFYnEVAVWLnuvtgi3kFbCUeHr3FDrFLXmL1hgPMExh5FjAyrGKUTC0ozk3P
        LTYsMMpLLdcrTswtLs1L10vOz93ECI4CLa0djHtWfdA7xMjEwXiIUYKDWUmE98Au73gh3pTE
        yqrUovz4otKc1OJDjNIcLErivF9nLYwTEkhPLEnNTk0tSC2CyTJxcEo1MC1atUUn6N3ROX/P
        cR9Mm7tnb9LPyLMum1oOTlryyZyN9WyP5fxldnXXH+cX7s9cPv+niG9UkGLy7OgC93tr73dL
        2P3ucQxUWMsU3FKuMX3q58k1E3l5J70XnujcJGnM5v42YX96af/uf3Ntdgi9bvGYsKyM1+XK
        /x6hZe+Pb72w53OE0+/DN03dp4iyB6koca19tDwxb+WNay86NPeuvm6kOzPVP3pnKtepYoWV
        j7X+5E9nz7P/+zUvcPvr0mUR8vY7wp7tNJWsMY9aJlw4x+bo69P1PL7t6omlH3KPi+5+lJr5
        h637TYf2q/2dxoGMZ2fOUfi3O+j20UMvZxq8mifE9MWRMbPHcZ4N16JYcQclluKMREMt5qLi
        RADgZUCF8QIAAA==
X-CMS-MailID: 20200901040850epcas1p2150ea195dfb20b46d6421af63b1f5129
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200901040850epcas1p2150ea195dfb20b46d6421af63b1f5129
References: <CGME20200901040850epcas1p2150ea195dfb20b46d6421af63b1f5129@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

There is a problem that the output does not work at a resolution
exceeding FHD. To solve this, we need to adjust the bvb clock at a
resolution exceeding FHD.

Rebased on top of next-20200708 and [1].

[1] : [PATCH v4 00/78] drm/vc4: Support BCM2711 Display Pipeline (Maxime's patchset)

Changes from v1:
  - Added dt-bindings documents
  - Change patch order, first fix driver and then device tree

Hoegeun Kwon (4):
  clk: bcm: rpi: Add register to control pixel bvb clk
  drm/vc4: hdmi: Add pixel bvb clock control
  dt-bindings: display: vc4: hdmi: Add bvb clock-names property
  ARM: dts: bcm2711: Add bvb clock for hdmi-pixel

 .../bindings/display/brcm,bcm2711-hdmi.yaml   | 12 ++++++---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts         |  6 +++--
 drivers/clk/bcm/clk-raspberrypi.c             |  1 +
 drivers/gpu/drm/vc4/vc4_hdmi.c                | 25 +++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_hdmi.h                |  1 +
 5 files changed, 39 insertions(+), 6 deletions(-)

-- 
2.17.1


Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F422C3B18D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22029246B3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581625211;
	bh=X7KsRH6DscUpjMQI70+Hyaz0XzZaPGTEIvt7PfxLkJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eySl6J6vup1zDp+pM/qmU3iOuT3gMP3xXhD7XOEreyuym3NJlSvbUaIFaiiQZ4QLE
	 XZ5hkFNisaYvop60dETClE1vzxtwTCX5H7xsp6rNVmw42R2RSaBaFy5a0GMQXgAWuu
	 zLFO9sKKWBrnKQFSegLilU+XbiL2cHzqdM69PSQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgBMUUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:20:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387416AbgBMUUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:20:09 -0500
Received: from ziggy.cz (unknown [37.223.145.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2590A246B3;
        Thu, 13 Feb 2020 20:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581625208;
        bh=X7KsRH6DscUpjMQI70+Hyaz0XzZaPGTEIvt7PfxLkJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yCOoK0hF34b3yyDcQbzf/27+JUNNrwSvZbPBkyUpeiIIeqJSBfLj3WPdUHCmef8J2
         yEby/JeHYQACrqMzRYxgPsD/g3wHQe/Dzna5b0GYD59cafjWoX/GSliZUjVOirtEnf
         fnUhAzQn/BnK4P+t9nBoNPFMKnd0+zG6HbmIVyU4=
From:   matthias.bgg@kernel.org
To:     robh+dt@kernel.org, mark.rutland@arm.com, ck.hu@mediatek.com,
        p.zabel@pengutronix.de, airlied@linux.ie, mturquette@baylibre.com,
        sboyd@kernel.org, ulrich.hecht+renesas@gmail.com,
        laurent.pinchart@ideasonboard.com, enric.balletbo@collabora.com
Cc:     devicetree@vger.kernel.org, drinkcat@chromium.org,
        frank-w@public-files.de, sean.wang@mediatek.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        wens@csie.org, linux-mediatek@lists.infradead.org,
        rdunlap@infradead.org, matthias.bgg@kernel.org,
        hsinyi@chromium.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        mtk01761 <wendell.lin@mediatek.com>
Subject: [PATCH v7 01/13] dt-bindings: arm: move mmsys description to display
Date:   Thu, 13 Feb 2020 21:19:41 +0100
Message-Id: <20200213201953.15268-2-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213201953.15268-1-matthias.bgg@kernel.org>
References: <20200213201953.15268-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The mmsys block provides registers and clocks for the display
subsystem. The binding description should therefore live together with
the rest of the display descriptions. Move it to display/mediatek.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---

Changes in v7:
- move the binding description

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 .../bindings/{arm => display}/mediatek/mediatek,mmsys.txt         | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{arm => display}/mediatek/mediatek,mmsys.txt (100%)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,mmsys.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
rename to Documentation/devicetree/bindings/display/mediatek/mediatek,mmsys.txt
-- 
2.24.1


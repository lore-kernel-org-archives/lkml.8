Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123FDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9ED2074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="CJjrDxZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGABdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGABdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:33:45 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C096C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 18:33:45 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l12so22682138ejn.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 18:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mnbu3qm+zpGqCdgLq1LzvBpQasplZUpyniv6lrFeAbQ=;
        b=CJjrDxZ7Cz1QNTQqL8MOg6VBc3Yg0ZKhY422wSXa1+uBaEdDlLPV+O/bqJ/5RwRTXt
         CPlm1YF+VdX2/JajN3LKNWhf/0F10bFOsIybXgExM91NYoUobbLS3EgPxQlFc0jQbLFj
         vVubGY7sgQ7WWNbuw1xzqmd5KAQ336FannKADPbuMpMXUoObSUVXhm2y3T7M13VF9kvw
         F6UyANrxSn7V4H4orYoWtbxhwsLKSJDuc0LCGCNO6EkWWXpZdKnmdIgJzlnp/fRptucC
         RyEQg7vhuLdbAycLGE7DGxaDC6c6UA1ryV5wouRXNmXRvmBfNU3J1MdKzrHgfW3nlb2Z
         6Pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mnbu3qm+zpGqCdgLq1LzvBpQasplZUpyniv6lrFeAbQ=;
        b=gAitWT4RilzLIZOh+nJAvWxKv3wE5m067flXgEQXqKggMSYjt3ikmUr7y6iZuCHqJo
         3Rvv2tWnopqXrCFJJ58I6eQ5eY1wbjX/k92QqSDZcK5F5q6t3LZp3aTrIG351PJyhYtw
         pZsF3v5IF9oGfZ1eONF5e4RbFpLVW2Hj4BENSebARynER8sQDUoyb68sqdPMF1V6P0eg
         ++ex+ZmS09BEascziGCoeE960udafe2qrG8aNvHSSfKwjI+eWpdz25DMeSmyjWLOAFXS
         hlhQ51KKSWefPbA9OB/owkIdS0Bp1FtwWk8ylIhKUQ9fgAzN7BokajZPChHKMnL3FQ7l
         zrow==
X-Gm-Message-State: AOAM530vclzZhynEGFFv0rvhgDq0LsbV9b8/0P3iBYwvz9uUMZcnZRIz
        huWFFUyGHd5Dg2shVheLoIk9Nw==
X-Google-Smtp-Source: ABdhPJykzEY+Jb7MlBrIGhdhlIJ9UwHGhfxGZE8WU0x1mILqV0xifIohr3K1AX6OK6qpp9AgnokthA==
X-Received: by 2002:a17:906:d79c:: with SMTP id pj28mr19792225ejb.397.1593567223865;
        Tue, 30 Jun 2020 18:33:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:16b8:5c28:7601:2d3c:7dcb:fbf0:3875])
        by smtp.gmail.com with ESMTPSA id d23sm3348571eja.27.2020.06.30.18.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 18:33:42 -0700 (PDT)
From:   Drew Fustini <drew@beagleboard.org>
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        devicetree@vger.kernel.org, bcousson@baylibre.com,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v4 1/2] pinctrl: single: parse #pinctrl-cells = 2
Date:   Wed,  1 Jul 2020 03:33:19 +0200
Message-Id: <20200701013320.130441-2-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701013320.130441-1-drew@beagleboard.org>
References: <20200701013320.130441-1-drew@beagleboard.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If "pinctrl-single,pins" has 3 arguments (offset, conf, mux), then
pcs_parse_one_pinctrl_entry() does an OR operation on conf and mux to
get the value to store in the register.

Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 drivers/pinctrl/pinctrl-single.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index f3a8a465d27e..a436ed7762cc 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1017,10 +1017,17 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 			break;
 		}
 
-		/* Index plus one value cell */
 		offset = pinctrl_spec.args[0];
 		vals[found].reg = pcs->base + offset;
-		vals[found].val = pinctrl_spec.args[1];
+
+		switch (pinctrl_spec.args_count) {
+		case 2:
+			vals[found].val = pinctrl_spec.args[1];
+			break;
+		case 3:
+			vals[found].val = (pinctrl_spec.args[1] | pinctrl_spec.args[2]);
+			break;
+		}
 
 		dev_dbg(pcs->dev, "%pOFn index: 0x%x value: 0x%x\n",
 			pinctrl_spec.np, offset, pinctrl_spec.args[1]);
-- 
2.25.1


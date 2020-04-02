Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741C6C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF1A20719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389891AbgDBS7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:59:53 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:49315 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388843AbgDBS7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:59:52 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M9Evp-1jN5Cy2EWl-006M1M for <linux-kernel@vger.kernel.org>; Thu, 02 Apr
 2020 20:59:51 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 48C9D650882
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 18:59:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nHh8dFzWV-7J for <linux-kernel@vger.kernel.org>;
        Thu,  2 Apr 2020 20:59:51 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 04D1864F1C0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 20:59:51 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.8.5.12) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 2 Apr 2020 20:59:50 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 2CFF680504; Thu,  2 Apr 2020 20:34:59 +0200 (CEST)
Date:   Thu, 2 Apr 2020 20:34:59 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        <devel@driverdev.osuosl.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
Subject: [PATCH v5 7/9] media: adv748x: only activate DAI if it is described
 in device tree
Message-ID: <c3c8ece14c0fbc987dc201c9b61dd22d98f83056.1585852001.git.alexander.riesen@cetitec.com>
Mail-Followup-To: Alex Riesen <alexander.riesen@cetitec.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        devel@driverdev.osuosl.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <cover.1585852001.git.alexander.riesen@cetitec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1585852001.git.alexander.riesen@cetitec.com>
X-Originating-IP: [10.8.5.12]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6C7266
X-Provags-ID: V03:K1:CrZEFR+GucID9tM025VcU/nhwJUP+Vtw43ksPJSquq8OqDY9+xQ
 MItsuyMXFj/GDE5d5nhwbR8sBfgd0AS6AKi+XR4ITtx0DgQLlG6FdgTE3TuF3v4V7iB3E+i
 EpA4kZMJu0aUXWrE2c8RmzR7cQ9A3MkQMV84eIW0QEPFrvV275j+nSxEKubeivuTST9+mLg
 HoofiCUpysPOJ70pqKCVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WTXxiun4S3A=:IGLic9rgFrXVjiJMbtu7lD
 V+MYLFD92b+TDExVgybfbpDbtVw6YlwsXQAvYoPTe+gzT4sHOvgx6I/KrJxvdOAxykAqVKt0B
 UO7mvaNi8dS4KAINhBpaeqr7uHDyqYuLpuctb24qIc4UqWbyfbt7XvKbVfOv9M5SE2KoVnM2t
 IsVst3vhEWjQ6IUv2QJKCqeax5m0x8XIx6WJR8otJnLKs6EIBnn/Ugaq+KoNjD6YCTH7ZCqgk
 JD7ru4SsqxuqoJ0LBAB9Xbr62DV30D6ZkW7gyN0+xijsRcWDingCIkXBoEQMgxiHVSnqW35nE
 JCbW2ML7Csj55il3sn7lPxz6geUZmHIZ4YwSAEiFTcbnitg+eAB6eBIRmOfwrqRy8Gt9+3YCq
 5NLWS0TNblZmKHgWHnMJsU2bXVehWhBPgJNGYRpnt10zR3wgbgeXL8s6opk1M89eQIAh9BCfM
 JbmQPWZ5vOWfpoEf9eQUYFOGNhUBfOgR06AEdPTP169n8TbHll7+4Yy+UGqq6Fj64qyt4Z8L7
 gGppbGoQKHN9gmBvwH3W0BshfJtHF4JXd0AY4VuInVKfWD5W+cU1/TpnMLjfTvhp3QZVuJmwY
 42slOuKzNjbrJJfyIaNLPIAuaRicn3WmCL+J2NPbPr7BR2PA/isaZBDQaXteQNAnCDRY+tMYe
 XBeVAxgkcH09gMurV5pU4x0dAmUfk3ZvGm8jfT2nYH1/lu18qepwKYMhsm8zUvFGvXkZ9Fm35
 ake3VZNRd8hmY8II0ygZUlFld241sQMnN2ZxwV23ywicURJ2WwNNQC/Rt4dXOmBFAAIRhN7gy
 3r06QOyxZfkoeG2bVnA3S8zIDnO3k6QBKyzELwPGWoWjBxl5JoD0BKxh0nXLU69ULbHZXSn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid setting it up even if the hardware is not actually connected
to anything physically.

Besides, the bindings explicitly notes that port definitions are
"optional if they are not connected to anything at the hardware level".

Signed-off-by: Alexander Riesen <alexander.riesen@cetitec.com>
---
 drivers/media/i2c/adv748x/adv748x-dai.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/i2c/adv748x/adv748x-dai.c b/drivers/media/i2c/adv748x/adv748x-dai.c
index 185f78023e91..f9cc47fa9ad1 100644
--- a/drivers/media/i2c/adv748x/adv748x-dai.c
+++ b/drivers/media/i2c/adv748x/adv748x-dai.c
@@ -216,6 +216,11 @@ int adv748x_dai_init(struct adv748x_dai *dai)
 	int ret;
 	struct adv748x_state *state = adv748x_dai_to_state(dai);
 
+	if (!state->endpoints[ADV748X_PORT_I2S]) {
+		adv_info(state, "no I2S port, DAI disabled\n");
+		ret = 0;
+		goto fail;
+	}
 	dai->mclk_name = kasprintf(GFP_KERNEL, "%s.%s-i2s-mclk",
 				   state->dev->driver->name,
 				   dev_name(state->dev));
-- 
2.25.1.25.g9ecbe7eb18



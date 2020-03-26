Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81A3C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E6C20409
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgCZLAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:00:08 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:40085 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgCZLAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:00:08 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MidPj-1jlpJ336lr-00fggk for <linux-kernel@vger.kernel.org>; Thu, 26 Mar
 2020 12:00:06 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 350CC6502CC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 11:00:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QPOzjhV_9Y3C for <linux-kernel@vger.kernel.org>;
        Thu, 26 Mar 2020 12:00:05 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id D77B46500AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 12:00:05 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.5.79) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Mar 2020 12:00:05 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id DD5CD80504; Thu, 26 Mar 2020 11:35:42 +0100 (CET)
Date:   Thu, 26 Mar 2020 11:35:42 +0100
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
Subject: [PATCH v4 7/9] media: adv748x: only activate DAI if it is described
 in device tree
Message-ID: <a7112a71e23d63cb6d19188e59252689e4900c70.1585218857.git.alexander.riesen@cetitec.com>
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
References: <cover.1585218857.git.alexander.riesen@cetitec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1585218857.git.alexander.riesen@cetitec.com>
X-Originating-IP: [10.8.5.79]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6D7C67
X-Provags-ID: V03:K1:jyjcLbFRqAkYVisLJ3uA1R0rveaKV5kqtpzvb9WvOsypntvh4yu
 zN7kfH+xukY0soiipLN7Gh29Z59NjrHC2Zp+Sg4q7HmK+xbqWK++yywkssVLyjqp7SlLPXf
 Xem+vl+zs7BHSn5xS13mlREQKPsJY2ImMJ0hb3x2813thE3xVtayHfM+AaSU5zB8KRYFBtR
 DtUApe7GGrfnCM26fRwSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jG5K2UJ80Jo=:IWe4qbDdigUW2WsB8esnOQ
 Gaam/jlvP7xUER9NnQYjW3tFRcKvyY0XAfFvNoHSDYP3hsTiJ/m5g9ydc+DKLTb3oe2IBdzi1
 ZnAwPFNk5VJArjxxz4znwJtaoEM0eCT1Rcl4sdvWDWznRDaW8e8XuB1w57DNhSaCkVIjr3XIZ
 8DFhr+laB93cUZ6ryLjCa0DQVUIuIu+EL8Bfclh0PvjQf+6PxSJG5MNeKTgiAxoC/P74ETlGp
 AZ+uraH34l8p6mO0AGwyBhM4AlISNWiV6OReAMR0Lk6lLF8qI8sJ2brHItGSBE0Tqi8gnawuu
 4Z/zoFCAehqQkkR/QfknTCjrlzTpjgKbQH5vPhkaH2bX3aHOIofNP6Hao0QFeau5jYZ8Xk11O
 zKXTup/fWR9i2CYFN78pBBpej+Q5Ram4SoQLivvqQ/gFh7DH8d/5MFi0cxAtIlI6vX+T9rPsu
 pflxwHIBlquafyCW+cW414piSFk6FBmHDj0sR3fQ1S1BXGPKAvmaHfI/0QDTIEmCOG06bVCaG
 tGYbIQyqznIkQ7IvPlYeNliuKdFqJryg7ngHQXjxR0Jv4l8Dtk7hgQLEhp3tXDdoKJy0Sl9tc
 sUrqD9hz3JmBY2OIycZiXk+GRBz9YlLBtW6OZyZL1sA87lWL/C2Xb9wbbq+Vzk3hnltmWrplf
 KOaZNmuCZ8kdDHGV2AqvIG0GJiJe2D1UBcvYmrc+h+Q7gPxJb1tvwU00Z+QVEksV7OL2h330R
 bGbWPOpx69RGDjAK0Er6FhDuI7tNvjrtzxHxmSsQC1T3ckhvHeV/2rSOQ7D0N9MsgxTfjQjzC
 +L4maKYrB6wtRqr6RSLWJdcaZ41WhT6TtXoMrlEzz4yTLe3gmKb6qOolGtMfKp52Wh3cdZp
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



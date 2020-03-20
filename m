Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE01CC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC9120753
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgCTQhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:37:37 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54407 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgCTQhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:37:37 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MV6G0-1ioHqz3IoQ-00S4Hb for <linux-kernel@vger.kernel.org>; Fri, 20 Mar
 2020 17:37:35 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 95671650123
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 16:37:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jsm-LFfYh_mY for <linux-kernel@vger.kernel.org>;
        Fri, 20 Mar 2020 17:37:35 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 48F4164DC1F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 17:37:35 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.5.41) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 20 Mar 2020 17:37:35 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 9E6F480504; Fri, 20 Mar 2020 17:12:02 +0100 (CET)
Date:   Fri, 20 Mar 2020 17:12:02 +0100
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
Subject: [PATCH v3 07/11] media: adv748x: only activate DAI if it is
 described in device tree
Message-ID: <ad4992170f9865f1040f6bda13452f23ea30a787.1584720678.git.alexander.riesen@cetitec.com>
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
References: <cover.1584720678.git.alexander.riesen@cetitec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1584720678.git.alexander.riesen@cetitec.com>
X-Originating-IP: [10.8.5.41]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6D7660
X-Provags-ID: V03:K1:8W7JcRWNZxswhrtPEBpb0TjtnYi5gI6AZdDJaEWKZyFQlLENZLK
 wq/KOZ9EgJglegnmuzO5tG5Ani+vIoKH79hZUgci8KWkSt+JCSppODKJ308yH28X5CkuXV2
 yTZUbUCxdSiQjkVHm+jJDF7wYPEck1sL2tJk16GTGu5VhL7xxQDPZO3rcENCSYRlSHt976h
 4a4iHi5RCtNzBh8pYLVag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PU5smy3rklA=:TEkdaWYZWoqDif/vD7NAeF
 RO54o6Xr1a9SAAebnokBvygiIxlsrQFLsG1HSk+60V5IQVb+KZhNnpBc4CBlA4iIVhE+YBPqx
 sVirHtqz5rvWVed8GcNTQpwd3oXmJkg7o4ueLWm4RRMzrl/rTY5t5hLrAMpczURHwTWDvwM7N
 +uqifW2OJNP4w8ajRgEoG3iOxnGMtrVct3j94kjF9MS1410KmT1tVwioQ7grBwZ92IEafn8+d
 lAUQy43j2EpwBW1N17KZ4W4oncUcDc9TLlsrjEoq/n9hzwKu1ckHgVrjmqwpzHFBkGvCzsVyP
 z5Xp/KjF20/4KOWfs5WJ2WxX7+vILXSnCiFui3KKqa4deeEgRHJMLgPYH63wenYpGQLkyzN3q
 sxl/To/M7xbujsgriCGsf90le7Sm5DnJJhIBJz/I/Yb4k58gwI9BLAtwLss2R5GEEt06wKffE
 i7yKKfIMMb2mLD80jQEit3S+85g8rN+BabzBzWvAhs7iPZeo5iAisSXZ9p+GiAOPpP1+DIAsu
 GkcvIX+3bYXZC2lYgZ0ljHZAWwfRm5KE0tjgT/Ryjcd4TmbQmZQbbmPLhIZ3Vl82GDLfKUACK
 K1cdkE6DrHt7FMfzVTm08Z+bpyNKoml76oCoPs9Bii1g1tUTzmDLqOr5cTluxOt/Un2MphLaG
 HkpRsVd57GDiKhuyG7eEQRhp17+3KbKIKfDxzpKg8C8B6DRsndIvL/9cl+m54WGwSMUmWDDiA
 VHwZAMm3GKUJmEDzMjG4vbXXAN6gJvxugPeEvsSmMA38dU0+KiywfHRJXeqRkIlwxsNovpoXu
 JRZchupyF0s2+gfoDrjqSxsET68sdQxfgDUIRBYI+KOZ8+ip5CUz1Kg/TccNON4V9R86DtR
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
index 1c673efd4745..f22566094568 100644
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



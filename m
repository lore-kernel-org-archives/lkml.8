Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE8FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 17:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C52206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 17:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgHIR2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 13:28:08 -0400
Received: from 20.mo4.mail-out.ovh.net ([46.105.33.73]:58761 "EHLO
        20.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgHIR2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 13:28:08 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Aug 2020 13:28:07 EDT
Received: from player739.ha.ovh.net (unknown [10.108.54.94])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id 21F9223D2EE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 19:23:01 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player739.ha.ovh.net (Postfix) with ESMTPSA id 928C511196944;
        Sun,  9 Aug 2020 17:22:52 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-98R002ca650353-51cd-4c79-b08e-5414a764e4d7,
                    949AEE3423C323647D875781C307A391B5D7792E) smtp.auth=steve@sk2.org
From:   Stephen Kitt <steve@sk2.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2] ARM: s3c64xx: use simple i2c probe function
Date:   Sun,  9 Aug 2020 19:22:43 +0200
Message-Id: <20200809172243.15192-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3527725885183315233
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkeeigdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c probe functions here don't use the id information provided in
their second argument, so the single-parameter i2c probe function
("probe_new") can be used instead.

This avoids scanning the identifier tables during probes.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
Changes since v1:
  - split into per-sub-architecture patches.

 arch/arm/mach-s3c64xx/mach-crag6410-module.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 34f1baa10c54..43b587e79d21 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -378,8 +378,7 @@ static const struct {
 	  .i2c_devs = wm2200_i2c, .num_i2c_devs = ARRAY_SIZE(wm2200_i2c) },
 };
 
-static int wlf_gf_module_probe(struct i2c_client *i2c,
-			       const struct i2c_device_id *i2c_id)
+static int wlf_gf_module_probe(struct i2c_client *i2c)
 {
 	int ret, i, j, id, rev;
 
@@ -432,7 +431,7 @@ static struct i2c_driver wlf_gf_module_driver = {
 	.driver = {
 		.name = "wlf-gf-module"
 	},
-	.probe = wlf_gf_module_probe,
+	.probe_new = wlf_gf_module_probe,
 	.id_table = wlf_gf_module_id,
 };
 

base-commit: bcf876870b95592b52519ed4aafcf9d95999bc9c
-- 
2.20.1


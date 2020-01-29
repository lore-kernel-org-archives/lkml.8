Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B44C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 00:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C0921739
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 00:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="Mn3J8Y7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgA2AT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 19:19:58 -0500
Received: from sonic316-12.consmr.mail.bf2.yahoo.com ([74.6.130.122]:43107
        "EHLO sonic316-12.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbgA2AT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 19:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1580257196; bh=kKKjXJLWl4S6ESVi2xa0NzP19iykFL3zhlmU0HdVCKI=; h=From:To:Cc:Subject:Date:References:From:Subject; b=Mn3J8Y7FjYnJ0ditajK6vsnp15I+s6jRT2HNynP7Kw98ZkI9K9VxVndPybvQcX7uDQUsmi0932jmBadAhZbLV7AIDj538ZskkxvS5s7vPWu3C9S99YM8pRhsuIrDxcZQBCE6schD7jOEJBGBj+71JGIN3wbltNFZad/R7j2Eg5dVwlQAD0XSXJQa03SgeR1tJ6JPDQGTwPnqEhYfQf0D4PbR903AEPWAhWvBW5FMhNbkRO6TCtTgpe6KWtvJgKVA3SAEoXaB8DzZa5fm1sd0DraU76ghIW0BZbCFvxR0bo+PgCzsKKiSuAVwmbQGq/pfzEGuRwPOUzvTLZVWvCmiXw==
X-YMail-OSG: rqKMGaQVM1mRqiR1okq.M2AK4suIu4hmW2M9mUJoyv9KyRIbej2uM2usBNkBJEl
 irJpmb7TApwAUEk11y5H3TZAQ4hFCsYnG0U_pbrBvYZpj3FTr4Z5FfILQNGfqKFj_kkZSGwioGXr
 2NNcmLtp.xgGWHZyWS6ROt1.DU5pFt0K2HK9jKYkR57ZD0VfRtsxVrMC6EuyZMNnSReeA56OnUAs
 jBt6fvM87L2Au6R3oSDq_P4zpb1CnaTCOme2c8Rdf.6wYNfxVDHCpXwx3X5XVdpW8r7gxG2l.Yrt
 hAC6ykxnZN_1.Vj8g5ShxztG8tB6Hac7LBMG.xA0SuB10mAVteMl7x2.jjFHFEWKJ4ihA04ufeWg
 xhiy76GtCVjoVt65Txwe_CVZK6I5zXUK1PRo47R2F0vOG4IqQG.50xPG8hhphp0_b2qfHYEgRp4l
 8aF_3G95LxVBCinvoMb6z.AP8ftup25AM6lyBc3PHdIAc6QsiCl0hEar7hREongdfTW9JCWfbyzO
 q5r_dRMX.AJhnILFmti8TKRWj6_WLWooESrhlm_XyeO6mfFz40iTbM1XqYubOAaAwmuMnzo7.HLx
 2GT.kQNSzsxo3xTIbbjWHjrjYlKTLrcxxMt1y5bvuxPSdXHqqLD0u0eWPRyOQlg05u3j3GKVbNBw
 _oTPfU4VEOWiX.ckGqN4vOdQ8AQNKY8xrYhOnAr0aaFcIvxX1KlCCbmYzcwUJVsKwmXzJNwPPCGH
 wJdnIX7wyK6pFIQfGhSwbx2anQ8PJMBhHRsjiIUgnCBW8pZE334wTE8NiYV3klHAg2d8R37xmO8G
 CUVn.a99oXTl3f6fGlFWK5AnRctjZsm61lGFFv7Sm9cySRricUnbTnPnrAWGPgZHRP417KU1kPtE
 MetOmGefe_L_cfAfyGvQUrg.cmInmNEexoX12deuRxmNaD2fYtL0xXUTzk916Cy_Z3Xx6S8SHROU
 Mdwihc_jUbNcQ31BrR7BIqvBrk2FO9OJLiBxzqJUNJ40A.mRBrjcFJusRAI_bXpox97qqkJMyfCP
 UAmdAGJtff8s04Iy1l9jtHRWSlkkAakPACRGl2soDs3WM8ym44F2rr8Gf95m00lZAOAQI_j6ThuH
 eD0UV4LN63chRkR2tqro3Hjg8vqJs3MQPZNi7wZ4fKItzEjdnhQgEd9vCwwjx36NiMNI4umP.A9Z
 XibWyh9Ix.01Mtazf7jv98QbFnIFe8AD0OXx8tMnecXZD6L6KKrd4Xbgf9B57QeImr0xNaccPZwP
 smksw.NJM92L_NhmS1VvS37.esHEqsvmedsyeTe8LVnsP7U9.cQkYlU.cC1AiRQI_J3WloXgbhtq
 2Y2segta0LZHA9bwNv2uJ7K3SGuPxX7yoWNreDiBxsp2FQLdCrp0rLrHstMOvNWLnINWYb6oIJiv
 aSvBrt2p0OPWWqxqJ01gwBi0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Wed, 29 Jan 2020 00:19:56 +0000
Received: by smtp432.mail.sg3.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2c26b9c23f2e63a4e4de6101848509d2;
          Wed, 29 Jan 2020 00:19:54 +0000 (UTC)
From:   Simon Fong <simon.fong@aol.com>
To:     linux-kernel@vger.kernel.org
Cc:     Simon Fong <simon.fongnt@yahoo.com>
Subject: [PATCH] Staging: vt6655: device_main: cleanup long line
Date:   Wed, 29 Jan 2020 08:19:50 +0800
Message-Id: <20200129001950.12031-1-simon.fong@aol.com>
X-Mailer: git-send-email 2.17.1
References: <20200129001950.12031-1-simon.fong.ref@aol.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Fong <simon.fongnt@yahoo.com>

cleanup a long line coding style warning.

Signed-off-by: Simon Fong <simon.fongnt@yahoo.com>
---
 drivers/staging/vt6655/device_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index f69fc687d4c3..0442f71494b2 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -133,7 +133,8 @@ static int device_init_td1_ring(struct vnt_private *priv);
 static int  device_rx_srv(struct vnt_private *priv, unsigned int idx);
 static int  device_tx_srv(struct vnt_private *priv, unsigned int idx);
 static bool device_alloc_rx_buf(struct vnt_private *, struct vnt_rx_desc *);
-static void device_free_rx_buf(struct vnt_private *priv, struct vnt_rx_desc *rd);
+static void device_free_rx_buf(struct vnt_private *priv,
+			       struct vnt_rx_desc *rd);
 static void device_init_registers(struct vnt_private *priv);
 static void device_free_tx_buf(struct vnt_private *, struct vnt_tx_desc *);
 static void device_free_td0_ring(struct vnt_private *priv);
-- 
2.17.1


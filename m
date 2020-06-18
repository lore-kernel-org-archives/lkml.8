Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D749DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5419207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="srQl0r5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgFRXoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:44:05 -0400
Received: from sonic315-55.consmr.mail.gq1.yahoo.com ([98.137.65.31]:40202
        "EHLO sonic315-55.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbgFRXoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1592523844; bh=Asfu5Z94gNQ7XaBROjojNrJwo7jut1Y+OrjYRXVMET0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=srQl0r5zFsbvovsydZAvPTnpNHBid90kLOrvipT+G4JOHT7xyss9yq/OGWsLZHH3V+en8ziRtU4Jgp8jr5JE+yj/tn0otaQ1ASsK2x07JCbTMqrfcg/tNrjBp4NHdVgKcYvQmEdpCvw3msv62bkryEFKiRNqvHYgvMOG6L/2sweyJsTUHuphfD0Q6SwQit+hqy7eQERz8RqtcCkrZ5L9zop/lw0PUVHNngf5Q42p7/i552YzI7p/rOmW8hjBOA58qRQYldWTxzEKk22er/xovfRDsh/UrfykROEJOvqIXsa4Xbp9DJWS24lB2exyazxrNtx2B3akos/ixRaGqB8Uqg==
X-YMail-OSG: xSrhU.cVM1kUcfO5gY9kaoFHyQgqMiRLrSfI43yWnRiOQ84HFNbvqWDF97fSYc6
 J0b9moHnopLgeZqs10Gj9apJlSZ8PME8dk4y_4DEzI0u3h5TbRXLXPCBsTGySxOj9VX.2bijtAcG
 Etxzk6UVXRZxla6mnU0tLic1Z2EdVwsmPdmv2BhAKUCTNG_FbzwUzd_eXtOBzE627deivbH2EBu7
 MknW9WsFn86JXrT18crQ2ZKDO5ulpmSp1QDhe2rBaZijH9fvGKg2.4AVn8OESeMaHjA7XzRvvT3x
 wZKrCemArwEZizKcPaROXH8_Lyw4_z51Liw_W4keitkIAAeOE9XKdBe_XGeAOAi12jDRjS8A1Mx4
 le01xyRQlnFNwNLruU3ibw4gOSb5ipPxK6CZbrsnc9zuMVilP5D2c45_uYImg9rMvHDy75VsJcUj
 owigH5ficrVcSz7EBhtNNDUFPNcta10hFqN4FBm431nUrCkEvRKceMXNVyhnSr12UKam_mGZDldP
 EwkMympLIwMpTK2YR0w5qvVtm1XzKYe0BPmsuHdpFxqG62kqkECX5f257A7qW17G9WaaovnJoDTs
 EhVtVjkAzazvcMcQTDCTaHwMFjF0m3R10DyDsLUER9mFdGu.ehlPRHou4mExSFJb8CuoN6qiwvsH
 t7GB6AwKm99sO7Gldr6tmreKwkICXv9USLfxNsOWIAJOhdaZoPxuIpVoMqW77AJK05ofwZAjHyQX
 g86udCo5C5v.UsImQdCAb5G5622jr1VVyBRlRf7Yxq440ZF0Gj7MqbGbx8VsuNOF8Om3R1EWlNya
 5Ep0B6Tg5RN6rFnrokSKCerl60NVBPFv1I5Agm_9A0gfzHhL_DlqSXz1z1MlTPQFiTBUFBO60xau
 ddp9WSy7rhLqteqVA9pmPJb5jlyriXw024VUzYiYSEuA..wX2sXDjbHyW51nR5cb9jQjhn804ogw
 K6nggt1vFkKvJMsRN22oIMw6SRqEAOl2YBhnwXwIORgigq9Nh._P98kLFDxsEzTEfvfb6ekLJlSg
 Me7eovZdHPKQC.AGufahuruA1WX_6jH22yqJ2_k_ZA__Qw8Z_CqJZpJAfzuwqbe61xasnQzrhWZM
 0gLDr3Zpt_T2g0XSAtNQ4TccIihInWLxcXn.VGgweJaJ_SRW2_mJBRYIc7VaVS0aHrHKeaOYyb7U
 9LKxbyAikoJj1b7uqf3O9mm3MlEB6uo.esGagHbVStjT_c.qFZoV82V6O1lO8Jtc8NRb2WAjTTXD
 6bz5hd4shQxwToxgBVHEerPNABVSha6ud4MTk15UKmLrqEEm5Zx1WusyWfphH7rkR1C6SZqS9sLG
 7sK25m0pldGL7P5oIAkCyxydCHC4KKDlxZi3Cx.LqlQqAzzHBvbePG_PTrdgsQZC.wPVHUT3grAE
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 18 Jun 2020 23:44:04 +0000
Received: by smtp415.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d13ff620e5f9d81f37a1475971f3080d;
          Thu, 18 Jun 2020 23:44:01 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>,
        Hongyu Jin <hongyu.jin@unisoc.com>, stable@vger.kernel.org
Subject: [PATCH v2] erofs: fix partially uninitialized misuse in z_erofs_onlinepage_fixup
Date:   Fri, 19 Jun 2020 07:43:49 +0800
Message-Id: <20200618234349.22553-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200618111936.19845-1-hsiangkao@aol.com>
References: <20200618111936.19845-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@redhat.com>

Hongyu reported "id != index" in z_erofs_onlinepage_fixup() with
specific aarch64 environment easily, which wasn't shown before.

After digging into that, I found that high 32 bits of page->private
was set to 0xaaaaaaaa rather than 0 (due to z_erofs_onlinepage_init
behavior with specific compiler options). Actually we only use low
32 bits to keep the page information since page->private is only 4
bytes on most 32-bit platforms. However z_erofs_onlinepage_fixup()
uses the upper 32 bits by mistake.

Let's fix it now.

Reported-by: Hongyu Jin <hongyu.jin@unisoc.com>
Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
change since v1:
 move .v assignment out since it doesn't need for every loop;

 fs/erofs/zdata.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 7824f5563a55..9b66c28b3ae9 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -144,22 +144,22 @@ static inline void z_erofs_onlinepage_init(struct page *page)
 static inline void z_erofs_onlinepage_fixup(struct page *page,
 	uintptr_t index, bool down)
 {
-	unsigned long *p, o, v, id;
-repeat:
-	p = &page_private(page);
-	o = READ_ONCE(*p);
+	union z_erofs_onlinepage_converter u = { .v = &page_private(page) };
+	int orig, orig_index, val;
 
-	id = o >> Z_EROFS_ONLINEPAGE_INDEX_SHIFT;
-	if (id) {
+repeat:
+	orig = atomic_read(u.o);
+	orig_index = orig >> Z_EROFS_ONLINEPAGE_INDEX_SHIFT;
+	if (orig_index) {
 		if (!index)
 			return;
 
-		DBG_BUGON(id != index);
+		DBG_BUGON(orig_index != index);
 	}
 
-	v = (index << Z_EROFS_ONLINEPAGE_INDEX_SHIFT) |
-		((o & Z_EROFS_ONLINEPAGE_COUNT_MASK) + (unsigned int)down);
-	if (cmpxchg(p, o, v) != o)
+	val = (index << Z_EROFS_ONLINEPAGE_INDEX_SHIFT) |
+		((orig & Z_EROFS_ONLINEPAGE_COUNT_MASK) + (unsigned int)down);
+	if (atomic_cmpxchg(u.o, orig, val) != orig)
 		goto repeat;
 }
 
-- 
2.24.0


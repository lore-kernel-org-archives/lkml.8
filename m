Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A943C7114F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 11:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127802081E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 11:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="mJKgCbiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgBOLuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 06:50:32 -0500
Received: from mout.web.de ([217.72.192.78]:56481 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgBOLub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 06:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581767418;
        bh=AKoI1ErJ1F/3SpqbaXivBShhVSF+4DVb1UPwPn9K9xA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References:
         In-Reply-To:References;
        b=mJKgCbiZ6DsG9pBjmp7Q/rVR1rt+ZjyUt4bwBodh29xfJDK95Hf8fOWZ8V8r1/D/D
         946137HXeT5QJiUdRyX0Y6wU6z4SJ7eloxGf9Z4hlu2mnrBH29k/ZCsurRKceJ3R3d
         LASFjszsZAHIzYwQdfkUVh82xOKaMRoU4Nrs4jLE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from md1f2u6c.ww002.siemens.net ([95.157.55.156]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MgO8g-1io06e15Py-00NgBR; Sat, 15 Feb 2020 12:50:18 +0100
From:   Jan Kiszka <jan.kiszka@web.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] riscv: Fix crash when flushing executable ioremap regions
Date:   Sat, 15 Feb 2020 12:49:44 +0100
Message-Id: <8a555b0b0934f0ba134de92f6cf9db8b1744316c.1581767384.git.jan.kiszka@web.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1581767384.git.jan.kiszka@web.de>
References: <cover.1581767384.git.jan.kiszka@web.de>
In-Reply-To: <cover.1581767384.git.jan.kiszka@web.de>
References: <cover.1581767384.git.jan.kiszka@web.de>
X-Provags-ID: V03:K1:3afGuyjXHZCaYg9y6mqcxZGBFQUaKdU7SqI4fBIhgjLUotUcjdu
 VuaSdTlCtsF3UnKqxPCCuX3NSTqYet+hsYgyVjRvAtcglfc77wGgfKg+q7l0b+vgEzSXcNM
 CiUzO8c4RrB3QFdyLZ+qc7PDN/+V1/qFsrrpPM56toO4IU9MQKuZcZYGhSJu63JCbKnsU7S
 ZlR79w+tspHae7bOSXjzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+JySpZD7Yok=:62+NnABRoebGkDXmyK+Xd0
 eIJzRv8R5y2HGLiph7dktdAh0js3t0mQv4c2wcwhvcmveAgBoNukvjArwWPZ1xJizFVJSnpMA
 T3RUtWXubYB/CYg5SHFgKRGYO8kTC75cQJaYw+oBcwlpmV2yQiDH6PdhAQTv2bPn6AkLWfYjK
 GU26KrfV5KMVSaVaufxWdY3bi99mEUq8hXTHCXUh8OfKs/NBUOUW3KFjUzncjXh7Ma6mNvSiy
 lv6sWnRtg4Qi8LnQcsI3NpGtbZGsOC60A11lgT5qj71vAlzawDn+u69zhg0WLvEfCdT/2yGHU
 aHnGP9/660kNYKEk9c4Pkwph32RGBzxYJjJOP3Bx238unJ2wV4f0K+WZwz8lCjdO7PTA28Qol
 vgFFah1+fg+aCriLfS7xuW7C6PgBAD/I7APg7Gb4N4ZOAysN/JI/Yfz8j3QlR6ljh1jBkkwjC
 QY1hyt0n/Qs+VluYFX08NJ3PNxcXiT6xLZ+dK/NRyRBGio0DrsWe41Uqghs7sVF+w2l5lck2F
 8DsI1A7BRs2MsRgSWgVHIB/UjhePROJOHNx2Wb08qblh9aODzTVOGiuj0E/NXWHZm6vlrOsOm
 e/ylsWEdqfuFKzLEuweXpenDl2TS1ZePSQY8dMvxg/kbD4FEZo0pAcNnJ44re6chXxgmUMw7j
 pyg3ubd9Lc1lMdFVzsp/bJe8LdMvAFDecJbuti4Q7zUOaOd+IYXBjYSLAzpMbaY3TZuU6pmrB
 n+52WvX0fvou7EHsREhNu3GyLkDjCTfXzEm/Mlw69mD0SXd14nyhKG/uzHTrcPqMBZDP7J0Q+
 4iVMRbrN3FV6h+nfYMSz3uRXd0zETqklRNxTKx17xU4nXt5NWCijmijRpf4f/AyaWfFNBp3bL
 LtncCTLT/I7qQiZnMPX2L+GRblBVV76VcrRmalGL4LI1tOm3gEJZNCxsDwKLSwt/oaxDMfcMS
 GUoeUQfkBWDgzNNocWAgBXSuoD73Z/Iev5BHmUT1vmhlnDjrOSdAwfJcMo6sj5U0ppwO5lPjf
 MALXxYkWxyEbSflZGkm4CyRibJAi04OzvUx3hWG3Y20yo/FYzktlMa6rItC0XGD2VdDwnewcw
 I0GqOgNfqJ9eM04gNnTxnw52AkI+NWe/HTdAjDHheGoKPX+oIlVB5OY7eYiI324KrPPOQ8byj
 PE4SKupY9fqqQYl4CwUV7f02ljqg01s5bW86QGrwBrd09KzWfqJ6BJ2gz/CIEAKGLY+oNlxPq
 gqLhcti884KhbRp+y
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Those are not backed by page structs, and pte_page is returning an
invalid pointer.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 arch/riscv/mm/cacheflush.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 8930ab7278e6..9ee2c1a387cc 100644
=2D-- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -84,7 +84,8 @@ void flush_icache_pte(pte_t pte)
 {
 	struct page *page =3D pte_page(pte);

-	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
+	if (!pfn_valid(pte_pfn(pte)) ||
+	    !test_and_set_bit(PG_dcache_clean, &page->flags))
 		flush_icache_all();
 }
 #endif /* CONFIG_MMU */
=2D-
2.16.4


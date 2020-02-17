Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F3FC7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872702064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581929339;
	bh=gAhlPg7d6SXWM2Sk5agDQ6FsMDXxbLRdqH96bR7VqE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MYt7IFTKyTpTPbSWNkH5qSY7iJX0A7zw5f76Y69kYgfKB1G64mX659a80gO+6F60k
	 w3CQiDnWNYeC96R5sW7SsvRQSKpZEz5svT3WnLSyJ8uzY1aTov6vhckXVrzJACnFgd
	 DB4VP/W8CagHnzltFrLmn9lZCn57djCU2D3IV9og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgBQIs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:48:58 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:51567 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728579AbgBQIsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:48:55 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D2310578;
        Mon, 17 Feb 2020 03:48:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 17 Feb 2020 03:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=C7OnKRF2IxPjjx3ttk61uc9uKHChW
        tpnA2tIrjpDu6k=; b=2MhlPgKZAssStM6Nu5Hj+By6eFniKbTdLkgXZ2QfXvEjE
        JGAhqlakSu52vbRGdb9sdn4dLVo70v+YnWV/aWE8I/a6wBsPPMiFxdnD2q/vHOCQ
        Eix80+29A2f66zt54XgWRAqQLYtjpUOKtpdfA+Iy6049inuwEvL2oZ1zjDMFt3qb
        8J/IAtm8Rjpwd18or6cWXHp/rfIzIyJBxpT84otPuUy6kePZPHXSrby6vWlg0Guh
        Cl2DdcL7KK18J3P7tu8zthTYIcXmRviCgRNvMDoRGGccy4ufk+j6kZaVLINOTs0d
        4gj2jl+QYxll6luSYcIphyj0xbbrwi5iaCvftGwcA==
X-ME-Sender: <xms:dVNKXhi_ovwxu1qhrNjLM1gY7swTLFiliVllRpfS8aEV0PReElax8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfsedttdertdertddtnecuhfhrohhmpedfvfhosghinhcu
    vedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppe
    dvtdefrddujeefrddvkedrudektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dVNKXgSLVn1cFtT2nTDrgE9uZLeRt7r-QORt32JlFmMFy5TkEzsjrA>
    <xmx:dVNKXi2XcKtczscFODyFZtG-gk3svs6L1FpupEF2JecKwlefKQklKw>
    <xmx:dVNKXq0RZXU5u5qMmsLNKIF7b0sK_D4IZTR5S4YbdMfW6RZsGA0g7A>
    <xmx:dVNKXptSe9UQ9U_0k80-VO9ob_kE-hy0A3dQIBCdrnLVFpRqaHMsZQ>
Received: from ares.fritz.box (203-173-28-180.dyn.iinet.net.au [203.173.28.180])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8385A328005D;
        Mon, 17 Feb 2020 03:48:51 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Christoph Lameter <cl@linux.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tools: vm: slabinfo: Add numa information for objects
Date:   Mon, 17 Feb 2020 19:48:28 +1100
Message-Id: <20200217084828.9092-3-tobin@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217084828.9092-1-tobin@kernel.org>
References: <20200217084828.9092-1-tobin@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we are not handling NUMA information for a bunch of slab
attribute files, files of form `170 N0=170 ...`.  These are

          objects
          objects_partial
          total_objects
          cpu_slabs

For other attribute files, namely `partial` and `slabs`, we do handle
the NUMA information.

Add a field to the slabinfo struct for the NUMA information and
output it during a NUMA report as is done for `slabs` and `partial`.

reference: /sys/kernel/slab/kmeme_cache_node/

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 tools/vm/slabinfo.c | 67 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 29f8ecb59cf6..65254c051da2 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -46,6 +46,10 @@ struct slabinfo {
 	unsigned long cpu_partial_alloc, cpu_partial_free;
 	int numa[MAX_NODES];
 	int numa_partial[MAX_NODES];
+	int numa_objects[MAX_NODES];
+	int numa_objects_partial[MAX_NODES];
+	int numa_total_objects[MAX_NODES];
+	int numa_cpu_slabs[MAX_NODES];
 } slabinfo[MAX_SLABS];
 
 struct aliasinfo {
@@ -394,13 +398,49 @@ static void slab_numa(struct slabinfo *s, int mode)
 	printf("\n");
 	if (mode) {
 		printf("%-21s ", "Partial slabs");
-		for(node = 0; node <= highest_node; node++) {
+		for (node = 0; node <= highest_node; node++) {
 			char b[20];
 
 			store_size(b, s->numa_partial[node]);
 			printf(" %4s", b);
 		}
 		printf("\n");
+
+		printf("%-21s ", "CPU slabs");
+		for (node = 0; node <= highest_node; node++) {
+			char b[20];
+
+			store_size(b, s->numa_cpu_slabs[node]);
+			printf(" %4s", b);
+		}
+		printf("\n");
+
+		printf("%-21s ", "Objects");
+		for (node = 0; node <= highest_node; node++) {
+			char b[20];
+
+			store_size(b, s->numa_objects[node]);
+			printf(" %4s", b);
+		}
+		printf("\n");
+
+		printf("%-21s ", "Partial objects");
+		for (node = 0; node <= highest_node; node++) {
+			char b[20];
+
+			store_size(b, s->numa_objects_partial[node]);
+			printf(" %4s", b);
+		}
+		printf("\n");
+
+		printf("%-21s ", "Total objects");
+		for (node = 0; node <= highest_node; node++) {
+			char b[20];
+
+			store_size(b, s->numa_total_objects[node]);
+			printf(" %4s", b);
+		}
+		printf("\n");
 	}
 	line++;
 }
@@ -1205,6 +1245,7 @@ static void read_slab_dir(void)
 			alias->ref = strdup(p);
 			alias++;
 			break;
+
 		   case DT_DIR:
 			if (chdir(de->d_name))
 				fatal("Unable to access slab %s\n", slab->name);
@@ -1214,13 +1255,27 @@ static void read_slab_dir(void)
 			slab->aliases = get_obj("aliases");
 			slab->align = get_obj("align");
 			slab->cache_dma = get_obj("cache_dma");
-			slab->cpu_slabs = get_obj("cpu_slabs");
+
+			slab->cpu_slabs = get_obj_and_str("cpu_slabs", &t);
+			decode_numa_list(slab->numa_cpu_slabs, t);
+			free(t);
+
 			slab->destroy_by_rcu = get_obj("destroy_by_rcu");
 			slab->hwcache_align = get_obj("hwcache_align");
 			slab->object_size = get_obj("object_size");
-			slab->objects = get_obj("objects");
-			slab->objects_partial = get_obj("objects_partial");
-			slab->objects_total = get_obj("objects_total");
+
+			slab->objects = get_obj_and_str("objects", &t);
+			decode_numa_list(slab->numa_objects, t);
+			free(t);
+
+			slab->objects_partial = get_obj_and_str("objects_partial", &t);
+			decode_numa_list(slab->numa_objects_partial, t);
+			free(t);
+
+			slab->objects_total = get_obj_and_str("total_objects", &t);
+			decode_numa_list(slab->numa_total_objects, t);
+			free(t);
+
 			slab->objs_per_slab = get_obj("objs_per_slab");
 			slab->order = get_obj("order");
 			slab->partial = get_obj("partial");
@@ -1232,9 +1287,11 @@ static void read_slab_dir(void)
 			slab->red_zone = get_obj("red_zone");
 			slab->sanity_checks = get_obj("sanity_checks");
 			slab->slab_size = get_obj("slab_size");
+
 			slab->slabs = get_obj_and_str("slabs", &t);
 			decode_numa_list(slab->numa, t);
 			free(t);
+
 			slab->store_user = get_obj("store_user");
 			slab->trace = get_obj("trace");
 			slab->alloc_fastpath = get_obj("alloc_fastpath");
-- 
2.17.1


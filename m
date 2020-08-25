Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E32C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 591692075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHYOx5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:53:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:59583 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbgHYOxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:53:14 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-97-YtiRwhI8Mw2kXkAIcHOQ7w-1; Tue, 25 Aug 2020 15:53:10 +0100
X-MC-Unique: YtiRwhI8Mw2kXkAIcHOQ7w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 25 Aug 2020 15:53:10 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Aug 2020 15:53:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'kent.overstreet@gmail.com'" <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "'Neil Horman'" <nhorman@tuxdriver.com>
Subject: [PATCH 01/13] lib/generic-radix-tree: Fix potentially corrupt tree
Thread-Topic: [PATCH 01/13] lib/generic-radix-tree: Fix potentially corrupt
 tree
Thread-Index: AdZ67fPsN9DwMYOhSA+N1EJo6aC85w==
Date:   Tue, 25 Aug 2020 14:53:10 +0000
Message-ID: <3184cab15fe94db58c7cf3fcf33f3875@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the last cmpxchg() done when increasing the tree depth fails
(because another caller has done a concurrent update) the 'new_node'
is reused later for either a array of pointers or the user data.
However the new_node->children[0] has been set non-zero this will
either end up being treated as a pointer to another node or as user data.

Rather than just setting children[0] = NULL free back the unwanted page
in the very unusual case that the cmpxchg() fails.
This removes quite a few comparisons from the normal path.

Signed-off-by: David Laight <david.laight@aculab.com>
---

Although rather nasty not really worth a backport because neither of the
2 places this code is used can possibly hit the failing path.

 lib/generic-radix-tree.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index f25eb111c051..5695fe547f9d 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -105,7 +105,7 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 			   gfp_t gfp_mask)
 {
 	struct genradix_root *v = READ_ONCE(radix->root);
-	struct genradix_node *n, *new_node = NULL;
+	struct genradix_node *n, *new_node;
 	unsigned level;
 
 	/* Increase tree depth if necessary: */
@@ -118,20 +118,19 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 		if (n && ilog2(offset) < genradix_depth_shift(level))
 			break;
 
-		if (!new_node) {
-			new_node = genradix_alloc_node(gfp_mask);
-			if (!new_node)
-				return NULL;
-		}
+		new_node = genradix_alloc_node(gfp_mask);
+		if (!new_node)
+			return NULL;
 
 		new_node->children[0] = n;
 		new_root = ((struct genradix_root *)
 			    ((unsigned long) new_node | (n ? level + 1 : 0)));
 
-		if ((v = cmpxchg_release(&radix->root, r, new_root)) == r) {
+		v = cmpxchg_release(&radix->root, r, new_root);
+		if (v == r)
 			v = new_root;
-			new_node = NULL;
-		}
+		else
+			genradix_free_node(new_node);
 	}
 
 	while (level--) {
@@ -141,20 +140,18 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 
 		n = READ_ONCE(*p);
 		if (!n) {
-			if (!new_node) {
-				new_node = genradix_alloc_node(gfp_mask);
-				if (!new_node)
-					return NULL;
-			}
-
-			if (!(n = cmpxchg_release(p, NULL, new_node)))
-				swap(n, new_node);
+			new_node = genradix_alloc_node(gfp_mask);
+			if (!new_node)
+				return NULL;
+
+			n = cmpxchg_release(p, NULL, new_node);
+			if (!n)
+				n = new_node;
+			else
+				genradix_free_node(new_node);
 		}
 	}
 
-	if (new_node)
-		genradix_free_node(new_node);
-
 	return &n->data[offset];
 }
 EXPORT_SYMBOL(__genradix_ptr_alloc);
-- 
2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


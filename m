Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F27C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D8320782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgHYOxn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:53:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:37013 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbgHYOxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:53:07 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-175-rFEUAesWPMiHrAoqCmbmjw-1; Tue, 25 Aug 2020 15:53:03 +0100
X-MC-Unique: rFEUAesWPMiHrAoqCmbmjw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 25 Aug 2020 15:53:02 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Aug 2020 15:53:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'kent.overstreet@gmail.com'" <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "'Neil Horman'" <nhorman@tuxdriver.com>
Subject: [PATCH 04/13] lib/generic-radix-tree: Optimise __genradix_ptr()
Thread-Topic: [PATCH 04/13] lib/generic-radix-tree: Optimise __genradix_ptr()
Thread-Index: AdZ67sMWfdtX/xQJSh+MRYbTkDiL9Q==
Date:   Tue, 25 Aug 2020 14:53:02 +0000
Message-ID: <d0088b5a266d4cb7bc99dd11175c77b0@AcuMS.aculab.com>
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

While gcc managed to convert the 'level' loop into one that changed the
'shift' it couldn't convert '(offset & mask) >> n' to '(offset >> n) & 511'
so avoiding body of genradix_depth_size().
Perform both optimisations in the source.

Also optimise for the common (given the only users of this code) case of
the entire radix-tree fitting in one page.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 lib/generic-radix-tree.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index 12dcaf891af9..212e04cf171a 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -58,24 +58,32 @@ void *__genradix_ptr(struct __genradix *radix, size_t offset)
 {
 	struct genradix_root *r = READ_ONCE(radix->root);
 	struct genradix_node *n = genradix_root_to_node(r);
-	unsigned level		= genradix_root_to_depth(r);
+	unsigned int shift = genradix_root_to_depth(r);
+	unsigned int idx;
 
-	if (offset >> genradix_depth_shift(level))
+	if (unlikely(!n))
 		return NULL;
 
-	while (1) {
-		if (!n)
+	if (!shift)
+		return offset < PAGE_SIZE ? n->data + offset : NULL;
+
+	shift = genradix_depth_shift(shift) - GENRADIX_ARY_SHIFT;
+
+	idx = offset >> shift;
+	if (unlikely(idx >= GENRADIX_ARY))
+		return NULL;
+
+	for (;;) {
+		n = READ_ONCE(n->children[idx]);
+		if (unlikely(!n))
 			return NULL;
-		if (!level)
-			break;
 
-		level--;
+		if (shift == PAGE_SHIFT)
+			return n->data + (offset % PAGE_SIZE);
 
-		n = n->children[offset >> genradix_depth_shift(level)];
-		offset &= genradix_depth_size(level) - 1;
+		shift -= GENRADIX_ARY_SHIFT;
+		idx = (offset >> shift) % GENRADIX_ARY;
 	}
-
-	return &n->data[offset];
 }
 EXPORT_SYMBOL(__genradix_ptr);
 
-- 
2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


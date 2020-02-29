Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B6FC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811E32468E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoAdX/XB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgB2NPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 08:15:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33489 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726933AbgB2NPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 08:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582982142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RCYWHBxLPOdlW57S3eZdORk1KAVBLC2yFlcjTiBScDs=;
        b=GoAdX/XB8Bym80wHloXgCXnHBQii/jVIFOsFm48LQf/7D9UJhf3e2kG50cIrqu62b7fAnc
        FF0+P8hpXQRbK7otyo7pbGX3Gebe6jBrQA3/0bCQd+FrmXYgDFl1YEFsEr0oqn34qXg62V
        +6eyNQrIXCPyZGYRwQr/yrynz/CKUzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-mKMc4NI0Mpi2LoTiS2PCRA-1; Sat, 29 Feb 2020 08:15:38 -0500
X-MC-Unique: mKMc4NI0Mpi2LoTiS2PCRA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E547C801E5C;
        Sat, 29 Feb 2020 13:15:36 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-211.rdu2.redhat.com [10.10.120.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2114187B08;
        Sat, 29 Feb 2020 13:15:34 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH] bitops: Always inline sign extension helpers
Date:   Sat, 29 Feb 2020 07:15:26 -0600
Message-Id: <740179324b2b18b750b16295c48357f00b5fa9ed.1582982020.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_CC_OPTIMIZE_FOR_SIZE, objtool reports:

  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: i915_=
gem_execbuffer2_ioctl()+0x5b7: call to gen8_canonical_addr() with UACCESS=
 enabled

This means i915_gem_execbuffer2_ioctl() is calling gen8_canonical_addr()
from the user_access_begin/end critical region (i.e, with SMAP
disabled).

While it's probably harmless in this case, in general we like to avoid
extra function calls in SMAP-disabled regions because it can open up
inadvertent security holes.

Fix the warning by changing the sign extension helpers to
__always_inline.  This convinces GCC to inline gen8_canonical_addr().

The sign extension functions are trivial anyway, so it makes sense to
always inline them.  With my test optimize-for-size-based config, this
actually shrinks the text size of i915_gem_execbuffer.o by 45 bytes --
and no change for vmlinux.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 47f54b459c26..9acf654f0b19 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -162,7 +162,7 @@ static inline __u8 ror8(__u8 word, unsigned int shift=
)
  *
  * This is safe to use for 16- and 8-bit types as well.
  */
-static inline __s32 sign_extend32(__u32 value, int index)
+static __always_inline __s32 sign_extend32(__u32 value, int index)
 {
 	__u8 shift =3D 31 - index;
 	return (__s32)(value << shift) >> shift;
@@ -173,7 +173,7 @@ static inline __s32 sign_extend32(__u32 value, int in=
dex)
  * @value: value to sign extend
  * @index: 0 based bit index (0<=3Dindex<64) to sign bit
  */
-static inline __s64 sign_extend64(__u64 value, int index)
+static __always_inline __s64 sign_extend64(__u64 value, int index)
 {
 	__u8 shift =3D 63 - index;
 	return (__s64)(value << shift) >> shift;
--=20
2.21.1


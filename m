Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F53C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A982B24677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4n5/D8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgB0WJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:09:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51794 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726460AbgB0WJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582841361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3gjhjVUPXNwQpqDYUVUeBbAw6akdfak24W+Lj13RneY=;
        b=b4n5/D8O6/B5uhM3xZxjp6GSF88lfUI8BjwqzlVL23wZwv10spiYe8lipMW9Wr4rtuPBbE
        JZhJtdk1sHBT5mB3fQvaF7927ZzDowUh9vw74DYmd139JH6a3nnxpf0QxeCF1hohn1UKL7
        oD/pyFcvw1g4I3gCFKcP5Q7uyKxtzqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-FADPfeCwPky93i4Zls6JDw-1; Thu, 27 Feb 2020 17:09:17 -0500
X-MC-Unique: FADPfeCwPky93i4Zls6JDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F0BE1005512;
        Thu, 27 Feb 2020 22:09:16 +0000 (UTC)
Received: from treble.redhat.com (ovpn-121-128.rdu2.redhat.com [10.10.121.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CDDA10001BD;
        Thu, 27 Feb 2020 22:09:15 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH] drm/i915: Minimize uaccess exposure in i915_gem_execbuffer2_ioctl()
Date:   Thu, 27 Feb 2020 16:08:26 -0600
Message-Id: <ed52cfb852d2772bf20f48614d75f1d1b1451995.1582841072.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
-- and indirectly, sign_extend64() -- from the user_access_begin/end
critical region (i.e, with SMAP disabled).

While it's probably harmless in this case, in general we like to avoid
extra function calls in SMAP-disabled regions because it can open up
inadvertent security holes.

Fix it by moving the gen8_canonical_addr() conversion to a separate loop
before user_access_begin() is called.

Note that gen8_canonical_addr() is now called *before* masking off the
PIN_OFFSET_MASK bits.  That should be ok because it just does a sign
extension and ignores the masked lower bits anyway.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu=
/drm/i915/gem/i915_gem_execbuffer.c
index d5a0f5ae4a8b..183cab13e028 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -2947,6 +2947,13 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev,=
 void *data,
 			u64_to_user_ptr(args->buffers_ptr);
 		unsigned int i;
=20
+		/*
+		 * Do the call to gen8_canonical_addr() outside the
+		 * uaccess-enabled region to minimize uaccess exposure.
+		 */
+		for (i =3D 0; i < args->buffer_count; i++)
+			exec2_list[i].offset =3D gen8_canonical_addr(exec2_list[i].offset);
+
 		/* Copy the new buffer offsets back to the user's exec list. */
 		/*
 		 * Note: count * sizeof(*user_exec_list) does not overflow,
@@ -2962,9 +2969,7 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, =
void *data,
 			if (!(exec2_list[i].offset & UPDATE))
 				continue;
=20
-			exec2_list[i].offset =3D
-				gen8_canonical_addr(exec2_list[i].offset & PIN_OFFSET_MASK);
-			unsafe_put_user(exec2_list[i].offset,
+			unsafe_put_user(exec2_list[i].offset & PIN_OFFSET_MASK,
 					&user_exec_list[i].offset,
 					end_user);
 		}
--=20
2.21.1


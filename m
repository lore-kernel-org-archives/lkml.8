Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECD8C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 22:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5C42070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 22:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qncHur2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgBQW1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 17:27:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52671 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgBQW1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 17:27:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so857596wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 14:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=odUhprWTj2SIxZaotcEpBmMSjl3dLxe80k3GV6bzUKo=;
        b=qncHur2VT+EFjnyOKkJKHIXSNrYe8zyPGYYXag0cfevD4Azo6yd61BKjXK1i7snMvp
         KMtygGJyD12L/qhrJ7hgF2hY9Tjj5ChccDwmudEftrCkVKcrdw0DCPp78XyZJvY6zlRk
         ybOECHlbAPzm7dlQ1NW1oHiv6fMorPbaJE2UtI092ovC5N4gDw7xj3SumYjSneSmXJPC
         mjzGfX1FXozyQ1Fk2XQEanWZsEBUaRr8wzHPJ0pcG0O1Tar0GObK3neTzGco7DDCyiBM
         gzoG649g6dY5ejZiF27fMHD1slxjYHtv5MBATwOkpXeB0rsXdP22EDSjqPB82NlDv1B6
         qVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=odUhprWTj2SIxZaotcEpBmMSjl3dLxe80k3GV6bzUKo=;
        b=Byr/7g3p5TblTOAoHKQOHsC9Q59vtkgMj9oykwzAOHFGUkm32me6S/rIG/1LH5VET3
         +wLGR7qhLYUvcJjnk8odou0lIG6lM2xwKjBSzALxakmRxBAQpfS10JL9MY8tzilZM6T0
         /Ped9SxP3lZupeBprWChkqKyKOm0W8RJm8gMT4z4/MQXfz35kLjBZnHa6bE1CtTHH20+
         prTTbwba+wBkXN0ihKUt4fWL4JlB6HG7hMG6uzFKHxVqcgDvSmoei09hzLw9beLtao0U
         Gqk14+jcb4qkSF42Sc7LySN1zD529DtDTtmyBzKK6xJcXmmYIhXbiAXlvGkQt2Wa8SLW
         lZ0g==
X-Gm-Message-State: APjAAAVaCov9AwwvVXwK73o0GBghNfOYwLVH3iV0sjPz1xdp19WYNaPa
        KAwMisEEbDIxJndXLBoXCh0Ma0aRAwE=
X-Google-Smtp-Source: APXvYqzDc5qYX/cvw8jmRGIVJWG0PmK5upV3PKWK6REKJ01heXI/twVZ/Yp3xgo2wjOprdcgfyQF3w==
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr1029334wmh.164.1581978471558;
        Mon, 17 Feb 2020 14:27:51 -0800 (PST)
Received: from kwango.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g2sm2896120wrw.76.2020.02.17.14.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 14:27:50 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: [PATCH] vsprintf: don't obfuscate NULL and error pointers
Date:   Mon, 17 Feb 2020 23:28:03 +0100
Message-Id: <20200217222803.6723-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see what security concern is addressed by obfuscating NULL
and IS_ERR() error pointers, printed with %p/%pK.  Given the number
of sites where %p is used (over 10000) and the fact that NULL pointers
aren't uncommon, it probably wouldn't take long for an attacker to
find the hash that corresponds to 0.  Although harder, the same goes
for most common error values, such as -1, -2, -11, -14, etc.

The NULL part actually fixes a regression: NULL pointers weren't
obfuscated until commit 3e5903eb9cff ("vsprintf: Prevent crash when
dereferencing invalid pointers") which went into 5.2.  I'm tacking
the IS_ERR() part on here because error pointers won't leak kernel
addresses and printing them as pointers shouldn't be any different
from e.g. %d with PTR_ERR_OR_ZERO().  Obfuscating them just makes
debugging based on existing pr_debug and friends excruciating.

Note that the "always print 0's for %pK when kptr_restrict == 2"
behaviour which goes way back is left as is.

Example output with the patch applied:

                            ptr         error-ptr              NULL
%p:            0000000001f8cc5b  fffffffffffffff2  0000000000000000
%pK, kptr = 0: 0000000001f8cc5b  fffffffffffffff2  0000000000000000
%px:           ffff888048c04020  fffffffffffffff2  0000000000000000
%pK, kptr = 1: ffff888048c04020  fffffffffffffff2  0000000000000000
%pK, kptr = 2: 0000000000000000  0000000000000000  0000000000000000

Fixes: 3e5903eb9cff ("vsprintf: Prevent crash when dereferencing invalid pointers")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 lib/vsprintf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 7c488a1ce318..f0f0522cd5a7 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -794,6 +794,13 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
 	unsigned long hashval;
 	int ret;
 
+	/*
+	 * Print the real pointer value for NULL and error pointers,
+	 * as they are not actual addresses.
+	 */
+	if (IS_ERR_OR_NULL(ptr))
+		return pointer_string(buf, end, ptr, spec);
+
 	/* When debugging early boot use non-cryptographically secure hash. */
 	if (unlikely(debug_boot_weak_hash)) {
 		hashval = hash_long((unsigned long)ptr, 32);
-- 
2.19.2


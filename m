Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4350EC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F33A20736
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lD8zIVQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgEFRWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgEFRWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:22:14 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC33C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 10:22:12 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id h1so3596777qtu.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ns5wyg0cVDVk/wsS7IuEAG4E9K0ywHpqVyUHPZtDgoo=;
        b=lD8zIVQrDYNDHbqQniGarHiRp/7jkovViyyqRShGjw9CpIiJoJYRtoF8aIKEpdUQ4H
         nIQNldLWiyyEV4TOREBFdI7psqpQg870pL35Z9F4/ZXYDIHEtn/V00fUsBZi1EhZvTF4
         mqdas27rYVNtPWyCjYbm6xRdn+njQ3wrRW6+YgzOwB2DJaFheGpaL+C8bfPphYs7CXjx
         rSrPIOYwzhOQItBmAlmwBRfWagY2inbJhESaBWALFoq38uqQwlDcTJc+OmF6j6UbqHvV
         joz5z57fdbWVYzsTSnWgV4Q6fthh0JL/APrz9YYbuUmomFf+XyvOJPVtK5SedX0WXxb2
         SM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ns5wyg0cVDVk/wsS7IuEAG4E9K0ywHpqVyUHPZtDgoo=;
        b=GquSr8zJrcNzmWikPsqbxx9E+HyeC/gWy2A+/7uV98pFBb4F3wv/94ZccWSU9VPoDo
         NaR7F9cyqPs5jqj48fXRDeLJdRpXYTrZRVnnuzCx2Sm0lY0XkDdlBGC7mCxzeEDbclIz
         Ni+DPEc3toZAqnxkrygnfuDAJmZvyklXNQ0Py2L9D6vkjh7bvk5I+ITS+1HyofU35pqZ
         jnDkN82Vn97DEeSb1RI/fabSq5em3L4Xh4X6EQLRo5zcTCWZeR4dOM+tj/DM23E68XI/
         ftV+rWmf+bvqyA9wYgd9DBPDyPAB34Dojo8EsfKs27nPDHDCBMUMD9ngtw1u7L68eS9a
         L+Dw==
X-Gm-Message-State: AGi0PuZ2ZnM5CTwqrHmGRhEoJktvJFOkY6vOIE/mcw2/i0TsrWw7LYZs
        HeThbFQNDmYzCfwa43r6TgerCH17enD5
X-Google-Smtp-Source: APiQypIVYXz61krSfHTd7V4z7gh8F2h0wQZiceqNuEwVkeU7chmOYzYiQhfzMOE61tPVGBUSBVwriugRb7dH
X-Received: by 2002:a0c:8b48:: with SMTP id d8mr9461703qvc.195.1588785732019;
 Wed, 06 May 2020 10:22:12 -0700 (PDT)
Date:   Wed,  6 May 2020 10:21:58 -0700
Message-Id: <20200506172158.218366-1-bgeffon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH] userfaultfd: fix remap event with MREMAP_DONTUNMAP.
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Brian Geffon <bgeffon@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A user is not required to set a new address when using
MREMAP_DONTUNMAP as it can be used without MREMAP_FIXED.
When doing so the remap event will use new_addr which may not
have been set and we didn't propagate it back other then
in the return value of remap_to.

Because ret is always the new address it's probably more
correct to use it rather than new_addr on the remap_event_complete
call, and it resolves this bug.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 mm/mremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index c881abeba0bf..6aa6ea605068 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -794,7 +794,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	if (locked && new_len > old_len)
 		mm_populate(new_addr + old_len, new_len - old_len);
 	userfaultfd_unmap_complete(mm, &uf_unmap_early);
-	mremap_userfaultfd_complete(&uf, addr, new_addr, old_len);
+	mremap_userfaultfd_complete(&uf, addr, ret, old_len);
 	userfaultfd_unmap_complete(mm, &uf_unmap);
 	return ret;
 }
-- 
2.26.2.526.g744177e7f7-goog


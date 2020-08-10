Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEABC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33CB520734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpYwIQfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgHJSa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbgHJSa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:30:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B709C061756;
        Mon, 10 Aug 2020 11:30:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so411829pjb.4;
        Mon, 10 Aug 2020 11:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2OIsK5oRYNh3UgYHl5k4iCZ2BKaBevjiQpD2X1y9m8=;
        b=XpYwIQfPiyLKWe43oojfboSYoSVGOYhztjOAJhIFmI8yfxNr/f6cnS6nhKIKn+wapG
         rMB+mYS0ko4mki1JO/Ii2PNhAecJb7gyXaivKkq5Etra2O4m2VJGjBasYhUUx6oWlkW3
         A+35EgUWTSkvvqn1/vZDi+E2b48yQuZrs1VB1T4u02HPXv5ztWDl5usCP+rHmcAUlIzp
         7roAGRDTDwi7QHkuxFTp8MAiiaaOH0V0ktDNipiGX2XajJd4ieO96qBdCTnYLSUj/3zl
         8neQtilCbGvSQ/FgP1wqto5PHPTOp0RBqCBuw8XUx8lVWZXu9lHWwsxbXBzU7ew9R9g+
         GDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2OIsK5oRYNh3UgYHl5k4iCZ2BKaBevjiQpD2X1y9m8=;
        b=pYuLzqIRtWYkthzACr3GuU6A8c6zmiRFAom8qW7Gd/6TMYQdjUD1kIrYYjmvJ9XtXJ
         U7f/jrjpi0VrOfkOUUSg9LYKyi6it+wpd/y1FG44ibALDBTuTmXPW45KpX9oNdP9T3TA
         feGBZXjpZqBc4cBbSwvtG1ooUWBc0KtgzkClxlIbwJuMwLkBKa+6XVtkUz8pu4g6wUTI
         fkC8jVzCbQs+RDdHfeOFqe3kYM+wDUbuq1jzML6wpjMh4eSXa4Fe4x8pODzQr2ArKPMI
         Q55ISaFZMKQrcM/Ldf6IH7SvQj+/635FUAvUB3C8TUUOPP1J+vfkH2zoBhCbpEGwf1FH
         RH3A==
X-Gm-Message-State: AOAM533gw/KVRRYtb7BFMAveenC7qH2reIKsaZKyQSBAYTeo233JyoRp
        u5XghGhp3VkFik4RY9oDTmb2rGtSMYQ=
X-Google-Smtp-Source: ABdhPJy9+5d0bxXiVRrwvKe+9OAis/5X3NdYthP8+EI850W24qJtDry9Bu3XQyygQswKmKSGaPktjQ==
X-Received: by 2002:a17:90b:4b03:: with SMTP id lx3mr578360pjb.143.1597084227927;
        Mon, 10 Aug 2020 11:30:27 -0700 (PDT)
Received: from localhost.localdomain ([124.253.77.168])
        by smtp.googlemail.com with ESMTPSA id w3sm23876106pff.56.2020.08.10.11.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 11:30:27 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Core-api: Documentation: Replace deprecated :c:func: Usage
Date:   Tue, 11 Aug 2020 00:00:19 +0530
Message-Id: <20200810183019.22170-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace :c:func: with func() as the previous usage is deprecated.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 Documentation/core-api/idr.rst | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/core-api/idr.rst b/Documentation/core-api/idr.rst
index a2738050c4f0..2eb5afdb9931 100644
--- a/Documentation/core-api/idr.rst
+++ b/Documentation/core-api/idr.rst
@@ -20,48 +20,48 @@ only ID allocation, and as a result is much more memory-efficient.
 IDR usage
 =========
 
-Start by initialising an IDR, either with :c:func:`DEFINE_IDR`
-for statically allocated IDRs or :c:func:`idr_init` for dynamically
+Start by initialising an IDR, either with DEFINE_IDR()
+for statically allocated IDRs or idr_init() for dynamically
 allocated IDRs.
 
-You can call :c:func:`idr_alloc` to allocate an unused ID.  Look up
-the pointer you associated with the ID by calling :c:func:`idr_find`
-and free the ID by calling :c:func:`idr_remove`.
+You can call idr_alloc() to allocate an unused ID.  Look up
+the pointer you associated with the ID by calling idr_find()
+and free the ID by calling idr_remove().
 
 If you need to change the pointer associated with an ID, you can call
-:c:func:`idr_replace`.  One common reason to do this is to reserve an
+idr_replace().  One common reason to do this is to reserve an
 ID by passing a ``NULL`` pointer to the allocation function; initialise the
 object with the reserved ID and finally insert the initialised object
 into the IDR.
 
 Some users need to allocate IDs larger than ``INT_MAX``.  So far all of
 these users have been content with a ``UINT_MAX`` limit, and they use
-:c:func:`idr_alloc_u32`.  If you need IDs that will not fit in a u32,
+idr_alloc_u32().  If you need IDs that will not fit in a u32,
 we will work with you to address your needs.
 
 If you need to allocate IDs sequentially, you can use
-:c:func:`idr_alloc_cyclic`.  The IDR becomes less efficient when dealing
+idr_alloc_cyclic().  The IDR becomes less efficient when dealing
 with larger IDs, so using this function comes at a slight cost.
 
 To perform an action on all pointers used by the IDR, you can
-either use the callback-based :c:func:`idr_for_each` or the
-iterator-style :c:func:`idr_for_each_entry`.  You may need to use
-:c:func:`idr_for_each_entry_continue` to continue an iteration.  You can
-also use :c:func:`idr_get_next` if the iterator doesn't fit your needs.
+either use the callback-based idr_for_each() or the
+iterator-style idr_for_each_entry().  You may need to use
+idr_for_each_entry_continue() to continue an iteration.  You can
+also use idr_get_next() if the iterator doesn't fit your needs.
 
-When you have finished using an IDR, you can call :c:func:`idr_destroy`
+When you have finished using an IDR, you can call idr_destroy()
 to release the memory used by the IDR.  This will not free the objects
 pointed to from the IDR; if you want to do that, use one of the iterators
 to do it.
 
-You can use :c:func:`idr_is_empty` to find out whether there are any
+You can use idr_is_empty() to find out whether there are any
 IDs currently allocated.
 
 If you need to take a lock while allocating a new ID from the IDR,
 you may need to pass a restrictive set of GFP flags, which can lead
 to the IDR being unable to allocate memory.  To work around this,
-you can call :c:func:`idr_preload` before taking the lock, and then
-:c:func:`idr_preload_end` after the allocation.
+you can call idr_preload() before taking the lock, and then
+idr_preload_end() after the allocation.
 
 .. kernel-doc:: include/linux/idr.h
    :doc: idr sync
-- 
2.27.0


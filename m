Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A6AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432A120720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYmDnfr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgGFSIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbgGFSIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:08:09 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA49AC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 11:08:09 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j7so2285290plk.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lQCZlvushcOD69EcXhMHyrU/TPLV5UJPHlxcyr/r1Xg=;
        b=PYmDnfr2KReJ6L3ka/pFQ5TCVzJeDABsscKdIo2hVK+g6RynNJZXKJA8nKzjJjOnq0
         L2VdcsAO3SDozGKprBlSPKVlFyWx7ATEpTpHPmuQpqv+2Av+4+UtEMqP4nkiI/TBFFud
         YrT89cUVzUAujSFRvMPiwbghNFNc5iir/1aAB3zwSpXHvBizJQ+zLqhEevq9ZGMXUgDo
         /5JbKtwsVXV5OZ84G6tunl9EnJlXINSomZ+kuBkCV+2h8io0Gx75UW8PzdiOGLFGAV3E
         N4+IHa22YZq1UWZL12+aqy8rW4h9Ghp2VSD7l8bky+RMlBK5Ez4iWmccWaS138Ltdd4F
         J8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lQCZlvushcOD69EcXhMHyrU/TPLV5UJPHlxcyr/r1Xg=;
        b=OkpFreQGaaPlKDiuMeYD4FO1ZeR8LjpjwoIzaeJ083aRi9Ts28XUtByWZh+XpaapcW
         oUjYDZf+BNAYded0vcY5pKJCTKdj4vcoiDK+I2Se1nLng6nkJnFxRUGPo7Q3Rz5nGml+
         qO1YrF7Q3bOvG6KmdYomr0J0mF+PqQV8yUpXqUlwLIV83/94rYPfGj6vh6ZB0rtIrqSm
         rdszJE7IVORrQ3pwyZaCAe7mirHAEVTPMXieX7feLWgBAWPnH01iz10GwaPuKeDQvgeB
         dtQJ5laByP7R3UQySBdiuTW2mWGTY3zBIAFcdqr9AnnYiyN7X6zwj8TIEDKH7RrZGfTj
         7Ddw==
X-Gm-Message-State: AOAM532MXOOnxKkTF8w2wuv3CLD39tBfx8/R1G2chCezOTRgyBclT5er
        5HIF62R+PL9UvHqGbi86Pt8=
X-Google-Smtp-Source: ABdhPJxXyvj4hRWrdgEtWV/PcGf7R0fJvjrqlaQ3A42V+efb3QSuM3VXtxd7bpryewDUbBJN29AM8A==
X-Received: by 2002:a17:90a:ff92:: with SMTP id hf18mr461075pjb.10.1594058889231;
        Mon, 06 Jul 2020 11:08:09 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.43.125])
        by smtp.gmail.com with ESMTPSA id 199sm20425544pgc.79.2020.07.06.11.08.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2020 11:08:08 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
Subject: [PATCH v2 2/3] xen/privcmd: Mark pages as dirty
Date:   Mon,  6 Jul 2020 23:46:11 +0530
Message-Id: <1594059372-15563-3-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1594059372-15563-1-git-send-email-jrdr.linux@gmail.com>
References: <1594059372-15563-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pages need to be marked as dirty before unpinned it in
unlock_pages() which was oversight. This is fixed now.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Suggested-by: John Hubbard <jhubbard@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Paul Durrant <xadimgnik@gmail.com>
---
 drivers/xen/privcmd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 33677ea..f6c1543 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -612,8 +612,11 @@ static void unlock_pages(struct page *pages[], unsigned int nr_pages)
 {
 	unsigned int i;
 
-	for (i = 0; i < nr_pages; i++)
+	for (i = 0; i < nr_pages; i++) {
+		if (!PageDirty(pages[i]))
+			set_page_dirty_lock(pages[i]);
 		put_page(pages[i]);
+	}
 }
 
 static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
-- 
1.9.1


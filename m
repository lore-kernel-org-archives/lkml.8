Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0E0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA66E20774
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuHuT8bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgFHBso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 21:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbgFHBsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 21:48:40 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5B8C08C5C4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 18:48:39 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c12so15802084qkk.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 18:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WzFA+2ljHjJmjK+4s4N9XcJU7tBcFMQdcDUBF1suXBc=;
        b=LuHuT8biBmZ3iG5FzOfEwqe89ixDAa3ljS4YoyKsTSpfaKs7Nz1iZskUGIgk8ZZBRL
         eVf6UDo3ve8EyMR3rmCdre2xJjS9aXK02W8QKXjaDEVtmgQrhD06QiD56ip8R1kSdK6V
         ppdpqC0yTX39fq0Kn/Gyra1DxagaM7AyGJkucCLanO0nEccZPx6MHgWQNBm5P6DT6KEm
         w2dqhx0G851WILBvZ7WakMmeye0MmtwPyezjKzx2gLdcrmbFw26f7cZyuWWXnb63ohYM
         GHsb75UxcWiVk2uA2kjKehDqxZPQITk1q647OBALoFp7LOapY//aJ0N9vpvJZfuo98t2
         WGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WzFA+2ljHjJmjK+4s4N9XcJU7tBcFMQdcDUBF1suXBc=;
        b=iPdMFQa/GNEN/7rDHNylYukDAmBJnyvA0ZnWNxwQszo37B5Fmrf5utrMtLSWApSrAt
         5FFUJ5Yu8raDJbDlJSxy8Yx8E/nyyrVe6wl7mnDeIVQD/Oi6l7zBT0kTRqZR8eUS6G6x
         ZMGoYfvuV1cauLLRG/TRd6a3abpWGbyZwBU+gqiPzoOcZnOKkAzVIY0VrcwSzMnD2AZA
         wNIrJOyv6aS8gFDc3qCqlcwMRm2II/MxVNBQHNgCiB02M0sraapW7r7UaBjp9XK726wA
         OIY7tee2DKyvzfZO06LySRfQyPYq8WanxAX05u8CHGU3I+DoNHZhv3gMsiW4+VThU5ct
         2kAA==
X-Gm-Message-State: AOAM533iki8vU3Ppq7NqQ8VEtdl+czdw/NRBjw0klqaG0Xh9XDNr26/h
        8lL9qdXPzfvI+VpF+gWaJTBVxK5+gkaI
X-Google-Smtp-Source: ABdhPJx3hdua/aa7TR/ZJnRnAKntQFqVcj3eRPEZ4Ipe7HXaYik0Y5uDxWRLslnLSHdmngCE6J2YFA==
X-Received: by 2002:a37:9e10:: with SMTP id h16mr20497425qke.381.1591580918315;
        Sun, 07 Jun 2020 18:48:38 -0700 (PDT)
Received: from localhost.localdomain ([142.119.96.191])
        by smtp.googlemail.com with ESMTPSA id r77sm6160032qke.6.2020.06.07.18.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 18:48:37 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Cc:     iamkeyur96@gmail.com
Subject: [PATCH v3] fs: ocfs2: fix spelling mistake and grammar
Date:   Sun,  7 Jun 2020 21:48:18 -0400
Message-Id: <20200608014818.102358-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200607212115.99278-1-iamkeyur96@gmail.com>
References: <20200607212115.99278-1-iamkeyur96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./ocfs2/mmap.c:65: bebongs ==> belonging

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 fs/ocfs2/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
index 3a44e461828a..39a77e903fdf 100644
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -62,7 +62,7 @@ static vm_fault_t __ocfs2_page_mkwrite(struct file *file,
 	last_index = (size - 1) >> PAGE_SHIFT;
 
 	/*
-	 * There are cases that lead to the page no longer bebongs to the
+	 * There are cases that lead to the page no longer belonging to the
 	 * mapping.
 	 * 1) pagecache truncates locally due to memory pressure.
 	 * 2) pagecache truncates when another is taking EX lock against 
-- 
2.26.2


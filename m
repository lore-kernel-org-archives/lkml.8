Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5250C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 03:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A453020748
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 03:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4JjtjKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgGLDbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 23:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgGLDbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 23:31:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71285C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 20:31:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id i14so4458181pfu.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 20:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z3iLvmsALgpeKkdpuNL17/HM7clfrVNQ9KU9ARLG1y0=;
        b=V4JjtjKfiTieITrJU1+IsNVyCXTofXiYb1IBwVWUF0NhkJZwo2pn4KSii2ojXEDJUI
         66oIhsD0yr8miUbgs/hnkZguouIlQFh57D8QELabHjbdW1UxLxGLLNBkzNIsKUoO8gQJ
         hI8vluoROpyGtD3WEqXuxsbWXfeiLkK/6UD16CPnJbJHi0BlLgXvWM25njV3H3Hm/6s+
         NwUxqQK575Tft3dW74YgxV38tHrMXyq+M4eIrmalxNhNHumwd5n531ub6o9lXtqZWAhu
         qqUOfZZHNjqwmn+xR0U4aefx1Joq7fTfTsBq4TT7aT6Qe32Y3aocPzm27rqmGh1kc35U
         jGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z3iLvmsALgpeKkdpuNL17/HM7clfrVNQ9KU9ARLG1y0=;
        b=NElBbNrgw9LTdYDFGYyIvPGBfJsNaOL+A/ytTlI4JnFaybkB542dnEU7CGzBOw+q11
         2tEJ8ddm5ghkH08Nf8MC3W0hAcSx0VqMWRcb/ZUukjv+Rsg1w3GMNPPp6++eWR5PDcdX
         qAdkFOEnIttv3Jqr2LhAPCHzFE7WZIr6UQf7qv39xWrwu1kdHf1Keeo6s+IYufd6TQ/I
         uMqC1lwv7dQevajXy8+1D+H30XdS7icYItI2yISUFxIzJfvW/q/zL90NMIFpBdQo4Hb8
         1LoNDjZDBaP0++R8/ccrvHY5PN84QDzeEvUNXaYHERdxUD9U+cOXlRblHVZ14DXj6KN9
         rTqQ==
X-Gm-Message-State: AOAM533zGRKgG8KiM13pQhbPaV0IbMPfBZNituOVhPDeL5vN7TaNthSS
        oEv+vVPvQj/9Kmpw4lT/jdk=
X-Google-Smtp-Source: ABdhPJxXbi9KSZF/o0irOMdLPlhjV3pV92Mf5shXsy1/+Fp0VJiHmbskE4DYeA/T1f3pXWChiRQDSA==
X-Received: by 2002:a62:3583:: with SMTP id c125mr21856884pfa.158.1594524701949;
        Sat, 11 Jul 2020 20:31:41 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.167.224.89])
        by smtp.gmail.com with ESMTPSA id s89sm9750271pjj.28.2020.07.11.20.31.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Jul 2020 20:31:41 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
Subject: [PATCH v3 2/3] xen/privcmd: Mark pages as dirty
Date:   Sun, 12 Jul 2020 09:09:54 +0530
Message-Id: <1594525195-28345-3-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1594525195-28345-1-git-send-email-jrdr.linux@gmail.com>
References: <1594525195-28345-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pages need to be marked as dirty before unpinned it in
unlock_pages() which was oversight. This is fixed now.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Suggested-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Paul Durrant <xadimgnik@gmail.com>
---
 drivers/xen/privcmd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index b001673..079d35b 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -611,8 +611,11 @@ static void unlock_pages(struct page *pages[], unsigned int nr_pages)
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


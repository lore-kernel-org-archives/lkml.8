Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BC7C3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1BD24677
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pquNABTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbgBNUsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:48:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44510 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387607AbgBNUsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id m16so12435809wrx.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSZn5NdxipyK46DzNeA7V4/WUx7AG4S+aIA7f0L3pf4=;
        b=pquNABTbsXNyaQ+/83nJLxQ70MTTj+Ewj/CNGpjT6V7tfvLRAasRwqSCJCxKtiKqM+
         HaZYCtQxabHgj8vYaQY95EbRzY8d5cJjm3ZhIxeEgTdercVlU1F1qyOaY3L7CNLAgWtI
         TDPAnfTZpohKtMnzqv1Ru4XPswjCcLnChGIZW82GzFY5/m57E504kaWZ1CLGeF9Txyqy
         CipZTnKRVjrayd/ofaYAZQtro360dBR+sg1lwNahtOJ5ciKFxsHYxomydjOgDJ6RhLOd
         QgVcKurbgPZG9v7pvgGGSzNAgjWYFXJfo3teqMhWQSDz+eg5z0FSkegos220VsUqHxno
         6ghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSZn5NdxipyK46DzNeA7V4/WUx7AG4S+aIA7f0L3pf4=;
        b=Ob0igqZqG/ChTFAggfHPNzRYG9ykJnm9smpEx+drwJ9UwGJTn+NsvJJDGAKUmzYMGa
         8dmdTH8hf9vCK9A1SIs+ho3f2pYw8BMXokLJMwJob9RiKEjwHd2vTmhLFYP3QO7pJ51P
         9U/TLg67P4fO4XvM6N7TqK6YxAqo5DpmGFui20cecN9SWOt70FeqsjJlk2Wv3PBVG4I1
         yOxMmpVD0dIbM+puzxKUD25Ltbd/5niEsGljomrm9BcotfzGy9DGt1OzQErH7V+/DWPG
         fxOxDFakfy8ZDCogIkMGLum6b9WriCbGCoBHojs2Ir7gtQfH1zqwXeNwfz83o7eiBm28
         vbOQ==
X-Gm-Message-State: APjAAAXpTw97g4ssPLZRtkiIZhU5sFcHzZcnXpZk+98ReHEFP7E+E9fR
        XVnRLKMlQ14ySv6/YyAqfT/n9nFXi5Fc
X-Google-Smtp-Source: APXvYqyYwhiLYjP+UDg8dnRlQIYvx+qAOr7IIRC9ZKedxGpa9xxlI6O2cpLzc7jH7f6p1X+K23SI3Q==
X-Received: by 2002:a5d:5742:: with SMTP id q2mr1794014wrw.145.1581713319098;
        Fri, 14 Feb 2020 12:48:39 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:38 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:HUGETLB FILESYSTEM)
Subject: [PATCH 06/30] mm/hugetlb: Add missing annotation for gather_surplus_pages()
Date:   Fri, 14 Feb 2020 20:47:17 +0000
Message-Id: <20200214204741.94112-7-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at gather_surplus_pages()

warning: context imbalance in hugetlb_cow() - unexpected unlock

The root cause is the missing annotation at gather_surplus_pages()
Add the missing __must_hold(&hugetlb_lock)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/hugetlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dd8737a94bec..ff7dda27b33f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1695,6 +1695,7 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
  * of size 'delta'.
  */
 static int gather_surplus_pages(struct hstate *h, int delta)
+	__must_hold(&hugetlb_lock)
 {
 	struct list_head surplus_list;
 	struct page *page, *tmp;
-- 
2.24.1


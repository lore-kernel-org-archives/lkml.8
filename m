Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57B0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09DC206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2/aV2jK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgFVP25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgFVP25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:28:57 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40814C061573;
        Mon, 22 Jun 2020 08:28:57 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d8so7712235plo.12;
        Mon, 22 Jun 2020 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LLS3etLB14OeKtyvMjWxMdZgJDnPMAWgyEUJWqNI998=;
        b=B2/aV2jKgv1Q+HA6li/fBMTSMrKZMvcJCyytKK0bNTN05T121wcVArDtjtouT8zcG2
         MxOQ4d90n4mgPBKEB9gWRRbbnsKuHNyKlVdTD2GbxhfW1e4ntlMylecVzON812z3pP6Z
         KfpeJ+8uULZbz8B2MRaOfGfWV5rDPPtIN0Yeqrmr8jTcjWTYCqRhvbRLhoLzuyxRjvOg
         2H4bf03oGvmIjaFgcKksBaUUyQ6gRbPFoNR4M3mtXwG3lgVMWpsWWN0vpJwKzD49xyFZ
         hzHRaMaNZiCB9F+cQKMWslw5elsZiFU2NSNh1itTzpkrtjRyC8KcBxVcuqHpXPQiPJbz
         EfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LLS3etLB14OeKtyvMjWxMdZgJDnPMAWgyEUJWqNI998=;
        b=iSuykWEFXCXo/wRV895CiDBJDsn4y1JTdjP7p+infYwUHmlSeocCLBnyB9MtTa4IcV
         EAcvifX+NHjFPN4D2pRKhGU3PmtCS7h6uptIUiZJRCGKhqYdQcGcfnb9qb/x/Y5H5XfE
         pAsuLNnRGFQXdoGheBY9e9y4Ugf4YIgMXRIxRKIqWg+nWD8j5Y2lcBXWf0nUhL6cF7mT
         BwigKjUmuuRyU6wKc92KAj8EslBod5/srAMv8VvNSMYeFD/cfRS5j5VTKISq1XeA8lmF
         swQAis0XL/nJAc2u/iZ74Dy5r9kaqibwHdpSbU8I/gjFoAj4QvoZxbq4rJTlBLaVELcz
         UTiA==
X-Gm-Message-State: AOAM531tsNA8/zfMxNFlHNzEd1cbz7SsI+Ky1vkihq757iPnkasdoe/H
        nqvnhGqiSjnQLlkNU1vZsHc=
X-Google-Smtp-Source: ABdhPJw9+e7eQwNZg96asZj4l4SOBdBiobR2t58zuZfqYnGVP+1NXswQoqN3vb1KW4oG7MN7QL6+gg==
X-Received: by 2002:a17:90a:ea05:: with SMTP id w5mr19683315pjy.37.1592839736693;
        Mon, 22 Jun 2020 08:28:56 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id 137sm11585214pgg.72.2020.06.22.08.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 08:28:56 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 06370236035D; Tue, 23 Jun 2020 00:28:54 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        peterz@infradead.org, hch@lst.de, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] mm: Fix a warning while make xmldocs
Date:   Tue, 23 Jun 2020 00:28:50 +0900
Message-Id: <20200622152850.140871-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.27.0.112.g101b3204f376
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes following warning while "make xmldocs"

./mm/vmalloc.c:1877: warning: Excess function parameter
'prot' description in 'vm_map_ram'

This warning started since a patch was merged in 5.8-rc1.
Fixes: d4efd79a81ab ("mm: remove the prot argument from vm_map_ram")

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 mm/vmalloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3091c2ca60df..957a0be77270 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1862,7 +1862,6 @@ EXPORT_SYMBOL(vm_unmap_ram);
  * @pages: an array of pointers to the pages to be mapped
  * @count: number of pages
  * @node: prefer to allocate data structures on this node
- * @prot: memory protection to use. PAGE_KERNEL for regular RAM
  *
  * If you use this function for less than VMAP_MAX_ALLOC pages, it could be
  * faster than vmap so it's good.  But if you mix long-life and short-life
-- 
2.27.0.112.g101b3204f376


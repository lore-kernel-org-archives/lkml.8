Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFED0C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB44D2078A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586950911;
	bh=A3svjOj7D3H3IiGI9YKvWCaCdJBRHSi/l3T8j/muOJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zvKKloaOSgjNau+JU4Ug0MfglfgMic3l4stbRdAdx9DVIGnNuMtX/qPIDy9Of9pJF
	 JC7Vc0LE61W3YePL7IJfZpqXY7zeUAPaxn5taT+ZCFDyzYhaMvcEAdqvOfLBmlmglQ
	 C9QqddM8LpojZvPQDjalklRKK9HOQwTHQkdjTcsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897421AbgDOLlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897115AbgDOLgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:36:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 660FE20737;
        Wed, 15 Apr 2020 11:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950567;
        bh=A3svjOj7D3H3IiGI9YKvWCaCdJBRHSi/l3T8j/muOJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beraRJ2HMHyLEHTlbSp/wcR8jTX/cX2uxyo/k1BXc08CmtDICExDH0QMpHxIWpQbn
         /WRghQoLgjheVHCxx03ndaxBWBRvjJFGlbjHE/m3Rf9uPjSRlEvRWx5Y6rFD4poEfv
         Fuvt953RlEFtbRYr8pl0z7vz2TaAdcWbWyn9o3y4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        kbuild test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Baoquan He <bhe@redhat.com>,
        Nishanth Aravamudan <nacc@us.ibm.com>,
        Nick Piggin <npiggin@suse.de>, Adam Litke <agl@us.ibm.com>,
        Andi Kleen <ak@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 5.6 070/129] mm/hugetlb: fix build failure with HUGETLB_PAGE but not HUGEBTLBFS
Date:   Wed, 15 Apr 2020 07:33:45 -0400
Message-Id: <20200415113445.11881-70-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit bb297bb2de517e41199185021f043bbc5d75b377 ]

When CONFIG_HUGETLB_PAGE is set but not CONFIG_HUGETLBFS, the following
build failure is encoutered:

  In file included from arch/powerpc/mm/fault.c:33:0:
  include/linux/hugetlb.h: In function 'hstate_inode':
  include/linux/hugetlb.h:477:9: error: implicit declaration of function 'HUGETLBFS_SB' [-Werror=implicit-function-declaration]
    return HUGETLBFS_SB(i->i_sb)->hstate;
           ^
  include/linux/hugetlb.h:477:30: error: invalid type argument of '->' (have 'int')
    return HUGETLBFS_SB(i->i_sb)->hstate;
                                ^

Gate hstate_inode() with CONFIG_HUGETLBFS instead of CONFIG_HUGETLB_PAGE.

Fixes: a137e1cc6d6e ("hugetlbfs: per mount huge page sizes")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Nick Piggin <npiggin@suse.de>
Cc: Adam Litke <agl@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>
Link: http://lkml.kernel.org/r/7e8c3a3c9a587b9cd8a2f146df32a421b961f3a2.1584432148.git.christophe.leroy@c-s.fr
Link: https://patchwork.ozlabs.org/patch/1255548/#2386036
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hugetlb.h | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1e897e4168ac1..dafb3d70ff819 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -390,7 +390,10 @@ static inline bool is_file_hugepages(struct file *file)
 	return is_file_shm_hugepages(file);
 }
 
-
+static inline struct hstate *hstate_inode(struct inode *i)
+{
+	return HUGETLBFS_SB(i->i_sb)->hstate;
+}
 #else /* !CONFIG_HUGETLBFS */
 
 #define is_file_hugepages(file)			false
@@ -402,6 +405,10 @@ hugetlb_file_setup(const char *name, size_t size, vm_flags_t acctflag,
 	return ERR_PTR(-ENOSYS);
 }
 
+static inline struct hstate *hstate_inode(struct inode *i)
+{
+	return NULL;
+}
 #endif /* !CONFIG_HUGETLBFS */
 
 #ifdef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
@@ -472,11 +479,6 @@ extern unsigned int default_hstate_idx;
 
 #define default_hstate (hstates[default_hstate_idx])
 
-static inline struct hstate *hstate_inode(struct inode *i)
-{
-	return HUGETLBFS_SB(i->i_sb)->hstate;
-}
-
 static inline struct hstate *hstate_file(struct file *f)
 {
 	return hstate_inode(file_inode(f));
@@ -729,11 +731,6 @@ static inline struct hstate *hstate_vma(struct vm_area_struct *vma)
 	return NULL;
 }
 
-static inline struct hstate *hstate_inode(struct inode *i)
-{
-	return NULL;
-}
-
 static inline struct hstate *page_hstate(struct page *page)
 {
 	return NULL;
-- 
2.20.1


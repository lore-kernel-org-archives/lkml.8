Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93A3C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B870F20773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259925;
	bh=gT5151k0Ubtk/tBEyVBe8PhGWzMR8W2gtoTZ7OzRg98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=17d7dODTjtOUjUUgnuJKN/gbM35jzZr1q7HZbM4euJCvt03GI46sl6aBL1gL6n3JH
	 sj0iyJMWjovN0GHiAZW2VGoCIT11mjPk6F7eRSxsNrS6fXrudHiZySB1xLwJKODUE9
	 CoHQ3D5whH/jIvk1fdvYxmpCFujfZGZjsmFuhKSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgGTPpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730506AbgGTPpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:45:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 962202176B;
        Mon, 20 Jul 2020 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259919;
        bh=gT5151k0Ubtk/tBEyVBe8PhGWzMR8W2gtoTZ7OzRg98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rCOtXmm7csWjZA3mXh5gCv2w2GuqyhbQrg7Npl3kEMlw3U673ox6B50KwEa86DCLE
         3xqCaBMoMaRcwhZnkT1QPtePPpETGQH+fCZT7FDeWV7W2Ly9fc93VxJ5l3OCNeienS
         28FBoikojhYM9DJhRB9dyanopgx+b3xL6Sn3gKiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 4.14 040/125] s390/mm: fix huge pte soft dirty copying
Date:   Mon, 20 Jul 2020 17:36:19 +0200
Message-Id: <20200720152804.950738586@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janosch Frank <frankja@linux.ibm.com>

commit 528a9539348a0234375dfaa1ca5dbbb2f8f8e8d2 upstream.

If the pmd is soft dirty we must mark the pte as soft dirty (and not dirty).
This fixes some cases for guest migration with huge page backings.

Cc: <stable@vger.kernel.org> # 4.8
Fixes: bc29b7ac1d9f ("s390/mm: clean up pte/pmd encoding")
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/mm/hugetlbpage.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -117,7 +117,7 @@ static inline pte_t __rste_to_pte(unsign
 					     _PAGE_YOUNG);
 #ifdef CONFIG_MEM_SOFT_DIRTY
 		pte_val(pte) |= move_set_bit(rste, _SEGMENT_ENTRY_SOFT_DIRTY,
-					     _PAGE_DIRTY);
+					     _PAGE_SOFT_DIRTY);
 #endif
 		pte_val(pte) |= move_set_bit(rste, _SEGMENT_ENTRY_NOEXEC,
 					     _PAGE_NOEXEC);



Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB0BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3098720773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135203;
	bh=c+QW1mE2tGRPZcQtySA3Jab8B8UJPsk/3gFArtC+8zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ytXs60VifIPjPNMtWtTNhyoqGm0mIwNoFkifKyk+kuMFnI0kZY1ddCTi1xx0l2qwv
	 L4D+ZRtyEC6bv30h8P550HQdVBLUFUxP7FmWcRM+NRJPR2zdk90eu+rpXo1sfr12Mw
	 rh+2k4dUkxv4/OY8zURHiroKImt+5su4knzZuGLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgGGPUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:20:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729441AbgGGPT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:19:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F0B320771;
        Tue,  7 Jul 2020 15:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135196;
        bh=c+QW1mE2tGRPZcQtySA3Jab8B8UJPsk/3gFArtC+8zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3oBi7IwOdZdc10kaEUOX0l8/JVxrkxl8L3NruAEA68eZ+Zs0oJrm5SPxj/znlFzl
         Q/wHShsywCzGFLu3QneTEgn1xgNZN3qyeqonLu6zZgZmats/j1EyVRqL7jI0cmqRs3
         Zc1V6OLOSJej7XTpX5WLaBwOtGWPk2XSSOoZoPJA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 12/65] s390/debug: avoid kernel warning on too large number of pages
Date:   Tue,  7 Jul 2020 17:16:51 +0200
Message-Id: <20200707145753.046272955@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145752.417212219@linuxfoundation.org>
References: <20200707145752.417212219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

[ Upstream commit 827c4913923e0b441ba07ba4cc41e01181102303 ]

When specifying insanely large debug buffers a kernel warning is
printed. The debug code does handle the error gracefully, though.
Instead of duplicating the check let us silence the warning to
avoid crashes when panic_on_warn is used.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 6d321f5f101d6..7184d55d87aae 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -198,9 +198,10 @@ static debug_entry_t ***debug_areas_alloc(int pages_per_area, int nr_areas)
 	if (!areas)
 		goto fail_malloc_areas;
 	for (i = 0; i < nr_areas; i++) {
+		/* GFP_NOWARN to avoid user triggerable WARN, we handle fails */
 		areas[i] = kmalloc_array(pages_per_area,
 					 sizeof(debug_entry_t *),
-					 GFP_KERNEL);
+					 GFP_KERNEL | __GFP_NOWARN);
 		if (!areas[i])
 			goto fail_malloc_areas2;
 		for (j = 0; j < pages_per_area; j++) {
-- 
2.25.1




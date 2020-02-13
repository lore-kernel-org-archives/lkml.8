Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890E0C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567642073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609517;
	bh=ZlegwmCnAZOuLIiv3fdHyQ4anQ6XQtuPlcFIM1GgWJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WA1KnpYjdtGVxxTAEoEZa2YBGMx+6yDmw9jFw1pLsnrJ7ogXablGyEfu858ucZYch
	 SXYy4LHgNN2pmWHXPBW6aMr/K4hYdsVvtloqe/ubbVwY6VV5gBaCcRsrRT92oOhl4s
	 ttw3OiMzhJSdabWP3Chn2N3VhXLvaDTUtBGRgmQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgBMPZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:25:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbgBMPXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:38 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96957246B1;
        Thu, 13 Feb 2020 15:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607417;
        bh=ZlegwmCnAZOuLIiv3fdHyQ4anQ6XQtuPlcFIM1GgWJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=172NZIM3Y52nIXM+h7wMTcvsNxjYuSLHTEDQzzr8JNsR+UjM8criJn//mvVy/ZKGG
         onqC6GjjDJ+ZjOu6ktSPDtlhcbVK5jS/SCnTgLPS0WkLDfP1UXOp+7HlHKmwdWnK+J
         v2pHr0KtjKvUJ3f7ydmVy0ZwTyytb8sIF3zOIjQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 025/116] powerpc/pseries: Advance pfn if section is not present in lmb_is_removable()
Date:   Thu, 13 Feb 2020 07:19:29 -0800
Message-Id: <20200213151852.632372374@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pingfan Liu <kernelfans@gmail.com>

commit fbee6ba2dca30d302efe6bddb3a886f5e964a257 upstream.

In lmb_is_removable(), if a section is not present, it should continue
to test the rest of the sections in the block. But the current code
fails to do so.

Fixes: 51925fb3c5c9 ("powerpc/pseries: Implement memory hotplug remove in the kernel")
Cc: stable@vger.kernel.org # v4.1+
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/1578632042-12415-1-git-send-email-kernelfans@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/pseries/hotplug-memory.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -398,8 +398,10 @@ static bool lmb_is_removable(struct of_d
 
 	for (i = 0; i < scns_per_block; i++) {
 		pfn = PFN_DOWN(phys_addr);
-		if (!pfn_present(pfn))
+		if (!pfn_present(pfn)) {
+			phys_addr += MIN_MEMORY_BLOCK_SIZE;
 			continue;
+		}
 
 		rc &= is_mem_section_removable(pfn, PAGES_PER_SECTION);
 		phys_addr += MIN_MEMORY_BLOCK_SIZE;



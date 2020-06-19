Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A17C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9869320786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581019;
	bh=pl+gPSi2eCibttM7+mX+0j8F6Js2Zgowf5rgnz84zFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zy1rwvT0YMydUvjgfHHCxVs20XxJCJ8J/xD7ovf/Or75f0aWDopqMVEqgVAuMqlr9
	 2YjE+hUjLDGpnKo38qNLfd4Tv2achriTKLAZ74A27vGsxzZm1pmw12WGW33466Vrb0
	 JHY6CsfbszqfumtK6YOr3P8i3zc3dNfE3SP3O9Hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405112AbgFSPg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404463AbgFSPau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:30:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E20B520757;
        Fri, 19 Jun 2020 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580648;
        bh=pl+gPSi2eCibttM7+mX+0j8F6Js2Zgowf5rgnz84zFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fdv8isI6ye8BapLXgyTHD29m5J8jLwNgNgxY3JX3KAD51CC/kbNas9Cep0DCJ3Bks
         ASIicwg3y/f9IAcS10hMNKDZATNjrqeYspLKbmUL7jm8jQRnHokL6Gs+FE8jbfgi0p
         EyfAXm62ihakVtHRD46JFALKwqKTtEv3LVjAhv5E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.7 329/376] powerpc/fadump: Account for memory_limit while reserving memory
Date:   Fri, 19 Jun 2020 16:34:07 +0200
Message-Id: <20200619141725.906461903@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hari Bathini <hbathini@linux.ibm.com>

commit 9a2921e5baca1d25eb8d21f21d1e90581a6d0f68 upstream.

If the memory chunk found for reserving memory overshoots the memory
limit imposed, do not proceed with reserving memory. Default behavior
was this until commit 140777a3d8df ("powerpc/fadump: consider reserved
ranges while reserving memory") changed it unwittingly.

Fixes: 140777a3d8df ("powerpc/fadump: consider reserved ranges while reserving memory")
Cc: stable@vger.kernel.org
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/159057266320.22331.6571453892066907320.stgit@hbathini.in.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/fadump.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -603,7 +603,7 @@ int __init fadump_reserve_mem(void)
 		 */
 		base = fadump_locate_reserve_mem(base, size);
 
-		if (!base) {
+		if (!base || (base + size > mem_boundary)) {
 			pr_err("Failed to find memory chunk for reservation!\n");
 			goto error_out;
 		}



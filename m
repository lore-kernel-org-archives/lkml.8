Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B575C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E9D4208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943580;
	bh=QF5IDSTZsGg8+KtyRcK9yV+Y7rlVcpSFWAYA2ll7Ufo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BtlFttwIV2wP5IwwKTnz5u0/14WaOqU7nXctc0b0T1zGIAgRfCquwBScRm/dsr5tq
	 UETbf01K3zynygGXPOz6Pvx8+ZZ7zey4Nh95KtjHGcMDz3+Uhldj4/hTW4kV9J+HMo
	 jRIqsDndNHXP36SmRuB4BIqu+MXrtMOM1eIN93r8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgEHNM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbgEHMs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:48:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C168721473;
        Fri,  8 May 2020 12:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942106;
        bh=QF5IDSTZsGg8+KtyRcK9yV+Y7rlVcpSFWAYA2ll7Ufo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwfm3rqVREDPtCMoxnRxN9y/oFG8Y/NsDkRFJAwX2HO5l5r+fF3ztVD03Iyi2dfIv
         eFc4Mc29J4XLRYvxI/rJB6uuM6jgXiYXu5c/rHu3jOOIt0rv5+KOJzRMTVM5G4Da20
         NilZch0r6HFAPsJ9egsddKLLX6ZvSUKyCotkLooM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Ian Munsie <imunsie@au1.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 299/312] cxl: Fix DAR check & use REGION_ID instead of opencoding
Date:   Fri,  8 May 2020 14:34:50 +0200
Message-Id: <20200508123145.425312028@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

commit 3b1dbfa14f97188ec33fdfc7acb66bea59a3bb21 upstream.

The current code will set _PAGE_USER to the access flags for any
fault address, because the ~ operation will be true for all address we
take a fault on. But setting _PAGE_USER also means that the fault will
be handled only if the page table have _PAGE_USER set. Hence there is
no security hole with the current code.

Now if it is an user space access, then the change in this patch really
don't have an impact because we have (!ctx->kernel) set true
and we take the if condition true.

Now kernel context created fault on an address in the kernel range
will result in a fault loop because we will not insert the
hash pte due to access and pte permission mismatch. This patch fix
the above issue.

Fixes: f204e0b8cedd ("cxl: Driver code for powernv PCIe based cards for userspace access")
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/cxl/fault.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -152,7 +152,7 @@ static void cxl_handle_page_fault(struct
 	access = _PAGE_PRESENT;
 	if (dsisr & CXL_PSL_DSISR_An_S)
 		access |= _PAGE_RW;
-	if ((!ctx->kernel) || ~(dar & (1ULL << 63)))
+	if ((!ctx->kernel) || (REGION_ID(dar) == USER_REGION_ID))
 		access |= _PAGE_USER;
 
 	if (dsisr & DSISR_NOHPTE)



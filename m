Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11848C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E223A20739
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCSLP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 07:15:27 -0400
Received: from foss.arm.com ([217.140.110.172]:33512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgCSLP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 07:15:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAD5B1045;
        Thu, 19 Mar 2020 04:15:26 -0700 (PDT)
Received: from a075553-lin.blr.arm.com (unknown [10.162.16.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 96D6D3FA4D;
        Thu, 19 Mar 2020 00:39:36 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        James Morse <james.morse@arm.com>,
        Dave Anderson <anderson@redhat.com>
Subject: [PATCH 2/2] Documentation/vmcoreinfo: Add documentation for 'KERNELPACMASK'
Date:   Thu, 19 Mar 2020 13:09:11 +0530
Message-Id: <1584603551-23845-2-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584603551-23845-1-git-send-email-amit.kachhap@arm.com>
References: <1584603551-23845-1-git-send-email-amit.kachhap@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for KERNELPACMASK variable being added to vmcoreinfo.

It indicates the PAC bits mask information of signed kernel pointers if
ARMv8.3-A Pointer Authentication feature is present.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Dave Anderson <anderson@redhat.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 007a6b8..5cc3ee6 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -393,6 +393,12 @@ KERNELOFFSET
 The kernel randomization offset. Used to compute the page offset. If
 KASLR is disabled, this value is zero.
 
+KERNELPACMASK
+-------------
+
+Indicates the PAC bits mask information if Pointer Authentication is
+enabled and address authentication feature is present.
+
 arm
 ===
 
-- 
2.7.4


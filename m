Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79734C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E13920661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608919;
	bh=XfP0hxBw4XciKG4xJAy7w77XrwM1u8ge/WhhJ+ZEbpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NSxvw8DQKYPUgvdDwmFha/iI5Uh9aP3N1ZA2Gk/aiaUj9mVOgpXJ73V6VNRdljPuo
	 ftS3/Pjbk3nQF+We5JiyUO274+VZoT1yEW7TrY6eQ/6zMqpecMUjAkf4MF2JM58UPL
	 2U0rpOaugDYBNQ9cBaOxiPGi/cRh6xUckltvcRPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbgBMPsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:47522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729280AbgBMP0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:54 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D5302468E;
        Thu, 13 Feb 2020 15:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607614;
        bh=XfP0hxBw4XciKG4xJAy7w77XrwM1u8ge/WhhJ+ZEbpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=emmy3DNVYID9xyqKW1KiWADB8qglSW7r74efyMFElXxfqc3xdUl61EYCfnpqgXBS8
         iYrCQUUInxXSNj2dSWxZNiH7j1ehaxcS2wAwNmKuMgt94SmsJuWuIPtBpJeNRyGbCq
         JbOa8OMQ64DLa5IgJwtmHro15Rq+bMnSM7tK6YdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 4.19 31/52] iommu/arm-smmu-v3: Populate VMID field for CMDQ_OP_TLBI_NH_VA
Date:   Thu, 13 Feb 2020 07:21:12 -0800
Message-Id: <20200213151822.860424461@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151810.331796857@linuxfoundation.org>
References: <20200213151810.331796857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

commit 935d43ba272e0001f8ef446a3eff15d8175cb11b upstream.

CMDQ_OP_TLBI_NH_VA requires VMID and this was missing since
commit 1c27df1c0a82 ("iommu/arm-smmu: Use correct address mask
for CMD_TLBI_S2_IPA"). Add it back.

Fixes: 1c27df1c0a82 ("iommu/arm-smmu: Use correct address mask for CMD_TLBI_S2_IPA")
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/arm-smmu-v3.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -810,6 +810,7 @@ static int arm_smmu_cmdq_build_cmd(u64 *
 		cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
 		break;
 	case CMDQ_OP_TLBI_NH_VA:
+		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
 		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
 		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
 		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;



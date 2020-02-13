Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F3CC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2353206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607779;
	bh=+PDH+u5/lc2pdOv1vTKa6pFV3IVHNfHxaQ4d2TkRwVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FAgtggu9y+kFqyZjLYVfbD4pZrDCYGdsvQJOvq/AyWsTPVg+3FwMIA+Cp5iPom+YM
	 quMPYMa3gLq+DxWRBzwK+1GdqtY5qSRzRERc1FWSqCiadOmt+TNgckbG0fAD42xCbI
	 dpUFFgwvE3K+wWnbD+pLakrFf7v2SgRLx1wWwAEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgBMP3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:29:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729226AbgBMP0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:44 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B81112468A;
        Thu, 13 Feb 2020 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607602;
        bh=+PDH+u5/lc2pdOv1vTKa6pFV3IVHNfHxaQ4d2TkRwVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MC5zeT3PNOoMDlye5Oife1NRIKGYrTcKkUN3Bre72x0A6rSIdojoZ9NIfIcWlr90P
         usFd2TM+s+mF2cGZCkKN4/1/4yQDSCxJXid12Ihfo4jD0NwdqVimKKWFf2Xio1w1O9
         Hr94LKwM2wxvFZHvzNSYCIcUPr3wkzYxzvGXNIA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 4.19 32/52] KVM: arm/arm64: vgic-its: Fix restoration of unmapped collections
Date:   Thu, 13 Feb 2020 07:21:13 -0800
Message-Id: <20200213151823.353030659@linuxfoundation.org>
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

From: Eric Auger <eric.auger@redhat.com>

commit 8c58be34494b7f1b2adb446e2d8beeb90e5de65b upstream.

Saving/restoring an unmapped collection is a valid scenario. For
example this happens if a MAPTI command was sent, featuring an
unmapped collection. At the moment the CTE fails to be restored.
Only compare against the number of online vcpus if the rdist
base is set.

Fixes: ea1ad53e1e31a ("KVM: arm64: vgic-its: Collection table save/restore")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20191213094237.19627-1-eric.auger@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/vgic/vgic-its.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -2292,7 +2292,8 @@ static int vgic_its_restore_cte(struct v
 	target_addr = (u32)(val >> KVM_ITS_CTE_RDBASE_SHIFT);
 	coll_id = val & KVM_ITS_CTE_ICID_MASK;
 
-	if (target_addr >= atomic_read(&kvm->online_vcpus))
+	if (target_addr != COLLECTION_NOT_MAPPED &&
+	    target_addr >= atomic_read(&kvm->online_vcpus))
 		return -EINVAL;
 
 	collection = find_collection(its, coll_id);



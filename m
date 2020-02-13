Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D387C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63939222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608011;
	bh=F72EiyA+IiELPNaODgNRBv6WEF9RdIqrmfKes5y6Osw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WxY7Ptwi6kOSdWWszDnJ9v/bzDYmoaiicHX6jl+3GZiSa5KgAFvb270H+cAxyWF0z
	 G6Jb/L7c9nIYcqdS36peX8PG4SNUnNVxkutKpTUp+srpsb4jxZ7kjsCt3iDcA72GEE
	 BxyRDxqsXk2d2HaqMmubcQV2hn29LX48zZgFJD/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgBMPda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:33:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbgBMP3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:29:01 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E37D72168B;
        Thu, 13 Feb 2020 15:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607741;
        bh=F72EiyA+IiELPNaODgNRBv6WEF9RdIqrmfKes5y6Osw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IuhORwr3y1m6/mV+gL0+tq9KUvVTv3FJns8J82CKcFfsoTZT/8XtLPx3UkOMWnYDI
         j8Fro1EVKlX5cBI3X02e9dcs6XJdvr6UtEL/bIy5g0OJKHU2RAp8K4JxeagvlUhJ4s
         tgJNQVwE6aeDsvqJ5QYphq+bGM6EV9HPBkcSGxEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 5.5 077/120] KVM: arm/arm64: vgic-its: Fix restoration of unmapped collections
Date:   Thu, 13 Feb 2020 07:21:13 -0800
Message-Id: <20200213151927.406402983@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
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
@@ -2475,7 +2475,8 @@ static int vgic_its_restore_cte(struct v
 	target_addr = (u32)(val >> KVM_ITS_CTE_RDBASE_SHIFT);
 	coll_id = val & KVM_ITS_CTE_ICID_MASK;
 
-	if (target_addr >= atomic_read(&kvm->online_vcpus))
+	if (target_addr != COLLECTION_NOT_MAPPED &&
+	    target_addr >= atomic_read(&kvm->online_vcpus))
 		return -EINVAL;
 
 	collection = find_collection(its, coll_id);



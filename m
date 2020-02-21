Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2611DC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C9C24670
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273712;
	bh=dVCBeU47LpUoBpEaYThXBUKJX+NcHZty3tt/uZlIUyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qz8KPJ901Jqm7rruiwb/nzcWB2MOxsv1ReZN6DlPXYFr/1rj4othsGl8GZ4UqnLz5
	 mPpreabsYqv0lvMfZbbKFIvL8bDq0Ij9fJ60KGsSSJ/UR60o5nqhb2PTQBrDh038uJ
	 mpSsMtn8/oCJynufqJje9K3qsaxRENUSnTbYgFu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388848AbgBUI2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:28:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388122AbgBUIUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:20:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 821162468F;
        Fri, 21 Feb 2020 08:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273208;
        bh=dVCBeU47LpUoBpEaYThXBUKJX+NcHZty3tt/uZlIUyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWo7w3AeXb29SGbNSdHy6rtWfJMuu/xwmfWBtDHe/Vp7VxH2lr9Sxe7Yqv335gk5j
         e3BXdwKsBufV7alX9U3GDbz7VYYDlbs3Em5c0oz4ivT8L3t1s8V06VM2UKrOOZEfT6
         vHW3EqDjlKqYd+EB9NwipELiLQ2I0JVgp8NTOQz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 048/191] KVM: s390: ENOTSUPP -> EOPNOTSUPP fixups
Date:   Fri, 21 Feb 2020 08:40:21 +0100
Message-Id: <20200221072257.461312055@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

[ Upstream commit c611990844c28c61ca4b35ff69d3a2ae95ccd486 ]

There is no ENOTSUPP for userspace.

Reported-by: Julian Wiedmann <jwi@linux.ibm.com>
Fixes: 519783935451 ("KVM: s390: introduce ais mode modify function")
Fixes: 2c1a48f2e5ed ("KVM: S390: add new group for flic")
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/interrupt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 05ea466b9e403..3515f2b55eb9e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2109,7 +2109,7 @@ static int flic_ais_mode_get_all(struct kvm *kvm, struct kvm_device_attr *attr)
 		return -EINVAL;
 
 	if (!test_kvm_facility(kvm, 72))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&fi->ais_lock);
 	ais.simm = fi->simm;
@@ -2412,7 +2412,7 @@ static int modify_ais_mode(struct kvm *kvm, struct kvm_device_attr *attr)
 	int ret = 0;
 
 	if (!test_kvm_facility(kvm, 72))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (copy_from_user(&req, (void __user *)attr->addr, sizeof(req)))
 		return -EFAULT;
@@ -2492,7 +2492,7 @@ static int flic_ais_mode_set_all(struct kvm *kvm, struct kvm_device_attr *attr)
 	struct kvm_s390_ais_all ais;
 
 	if (!test_kvm_facility(kvm, 72))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (copy_from_user(&ais, (void __user *)attr->addr, sizeof(ais)))
 		return -EFAULT;
-- 
2.20.1




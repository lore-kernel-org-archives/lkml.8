Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA586C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751C1217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704188;
	bh=pnCToD4ejXqmCSEfYgdkO9vs0Zi7wt1AqjYvKxi4kFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bf4wyRqOarV5YYAJBl9NjajeRHvQKqGe5KIuUyRoOI7IRxboZ/x5dYF9PDoAZyTCF
	 2ORMI19oDsgsBtidc/u81rkHbUzdXkSzDrG279CJlD+viuy59P3TGYSddxgimNvivu
	 jjKinx87OydYQJNj+Agjh6hF4ep9I22EULhIX7dI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404933AbgBNSQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:16:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730802AbgBNPve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:51:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7EF224688;
        Fri, 14 Feb 2020 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695493;
        bh=pnCToD4ejXqmCSEfYgdkO9vs0Zi7wt1AqjYvKxi4kFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXpxqSZMVbriUiIPgs8WVrPNXwZYPyAOY1AO4c2gWdl0BM1fqs8/axoGLYRfrlm3C
         z0t1ty+yW+8cNnLRPlryxczwcuIy3sZLJeB2EhWs5PAOvclFb+BufgVTyUNL34vTF/
         kk7JN8lanfT4xjPU9617nh+uB/rqxsGvKoQ3+2r4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 122/542] KVM: s390: ENOTSUPP -> EOPNOTSUPP fixups
Date:   Fri, 14 Feb 2020 10:41:54 -0500
Message-Id: <20200214154854.6746-122-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 165dea4c7f193..c06c89d370a73 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2190,7 +2190,7 @@ static int flic_ais_mode_get_all(struct kvm *kvm, struct kvm_device_attr *attr)
 		return -EINVAL;
 
 	if (!test_kvm_facility(kvm, 72))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&fi->ais_lock);
 	ais.simm = fi->simm;
@@ -2499,7 +2499,7 @@ static int modify_ais_mode(struct kvm *kvm, struct kvm_device_attr *attr)
 	int ret = 0;
 
 	if (!test_kvm_facility(kvm, 72))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (copy_from_user(&req, (void __user *)attr->addr, sizeof(req)))
 		return -EFAULT;
@@ -2579,7 +2579,7 @@ static int flic_ais_mode_set_all(struct kvm *kvm, struct kvm_device_attr *attr)
 	struct kvm_s390_ais_all ais;
 
 	if (!test_kvm_facility(kvm, 72))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (copy_from_user(&ais, (void __user *)attr->addr, sizeof(ais)))
 		return -EFAULT;
-- 
2.20.1


Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860C5C38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534D9206D6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221623;
	bh=Z7KdvEPwnuQWnkjL+BM3WAvJLHQISfNthr7UMBLVDas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HbI8SO0F3x7uh0M4Fu3IpxiuBoSyF5k/FNvuPnrN2IugBSzBVrOi3hC3tF4c3h/HP
	 nfRH23gDw6sOKLD1X9G3dLOruFXP5P+acgbX3aKnIFd34gm8dSW09J81dHln4EHEZt
	 ught6II5pQkbH9SiR3bl6VcNkH1a42R6XRGqXZB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgDROxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbgDROl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:41:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B364321D82;
        Sat, 18 Apr 2020 14:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587220916;
        bh=Z7KdvEPwnuQWnkjL+BM3WAvJLHQISfNthr7UMBLVDas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rhJn0kgWvOGuMa0Y3i8mg2lj+N7vhFiskwT84YvqTvf8d87lrrqJAKIWY42yt0bp9
         OGb1blYhCze6nj9/uyo2OO8KTeSHGQrhgs+lvqCk1JQdthJXs+488Z1HyEK1VPSK6F
         wxIu7Qe4HU2q8q+0PhptOW4ygj8qQU+R7hQdyOC4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 55/78] KVM: s390: vsie: Fix delivery of addressing exceptions
Date:   Sat, 18 Apr 2020 10:40:24 -0400
Message-Id: <20200418144047.9013-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144047.9013-1-sashal@kernel.org>
References: <20200418144047.9013-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 4d4cee96fb7a3cc53702a9be8299bf525be4ee98 ]

Whenever we get an -EFAULT, we failed to read in guest 2 physical
address space. Such addressing exceptions are reported via a program
intercept to the nested hypervisor.

We faked the intercept, we have to return to guest 2. Instead, right
now we would be returning -EFAULT from the intercept handler, eventually
crashing the VM.
the correct thing to do is to return 1 as rc == 1 is the internal
representation of "we have to go back into g2".

Addressing exceptions can only happen if the g2->g3 page tables
reference invalid g2 addresses (say, either a table or the final page is
not accessible - so something that basically never happens in sane
environments.

Identified by manual code inspection.

Fixes: a3508fbe9dc6 ("KVM: s390: vsie: initial support for nested virtualization")
Cc: <stable@vger.kernel.org> # v4.8+
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20200403153050.20569-3-david@redhat.com
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
[borntraeger@de.ibm.com: fix patch description]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/vsie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 076090f9e666c..4f6c22d72072a 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1202,6 +1202,7 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		scb_s->iprcc = PGM_ADDRESSING;
 		scb_s->pgmilc = 4;
 		scb_s->gpsw.addr = __rewind_psw(scb_s->gpsw, 4);
+		rc = 1;
 	}
 	return rc;
 }
-- 
2.20.1


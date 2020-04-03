Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2F6C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B6E207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RePrLw3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404328AbgDCPbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:31:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43607 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404310AbgDCPbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585927871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Mna+DLBALS7Nv4a/6CqV2AmkqQOOKpm1xodEo/O7Gc=;
        b=RePrLw3olQO9DAYOkzn0anO7bZFu9GSXvOSxJeqocnHGiGZ8xzt1rQqN9F+LmE+9UGr+MT
        Z4QXKkA2Fya99I8fvEeWtQpNcR/IMHVOwWU6WrsuP+7GI9hGjBP1Q78lmIc0ebyrRH9/i/
        MBou1TA/BzSuR3cOUWERb2umMCo8I4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-3_BoqKm6MkSVwTpjGmDjAA-1; Fri, 03 Apr 2020 11:31:08 -0400
X-MC-Unique: 3_BoqKm6MkSVwTpjGmDjAA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BBD2800D50;
        Fri,  3 Apr 2020 15:31:06 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-213.ams2.redhat.com [10.36.112.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D8D626DD1;
        Fri,  3 Apr 2020 15:31:04 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 4/5] KVM: s390: vsie: Move conditional reschedule
Date:   Fri,  3 Apr 2020 17:30:49 +0200
Message-Id: <20200403153050.20569-5-david@redhat.com>
In-Reply-To: <20200403153050.20569-1-david@redhat.com>
References: <20200403153050.20569-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move it to the outer loop, in case we ever run again into long
loops, trying to map the prefix. While at it, convert it to cond_resched(=
).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/vsie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 4f6c22d72072..ef05b4e167fb 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1000,8 +1000,6 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struc=
t vsie_page *vsie_page)
=20
 	handle_last_fault(vcpu, vsie_page);
=20
-	if (need_resched())
-		schedule();
 	if (test_cpu_flag(CIF_MCCK_PENDING))
 		s390_handle_mcck();
=20
@@ -1185,6 +1183,7 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct v=
sie_page *vsie_page)
 		    kvm_s390_vcpu_has_irq(vcpu, 0) ||
 		    kvm_s390_vcpu_sie_inhibited(vcpu))
 			break;
+		cond_resched();
 	}
=20
 	if (rc =3D=3D -EFAULT) {
--=20
2.25.1


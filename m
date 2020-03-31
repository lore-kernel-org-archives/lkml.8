Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B011C2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72A62080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0z7FKtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgCaTpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:45:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24123 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727768AbgCaTpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585683938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mcpjr22EubvpvBv5U1Nr7UCjm49Gd0MVWUusU3L0BO0=;
        b=N0z7FKttUDHft1dUjZNZCHN/2iy6sAX4z9DByWHSPrMy2HSxXx8KbfAMZhxxtVxljvN2lr
        vZPkF5bCs6U9v/lmGNNlxH9AQzG0Bs49aBBbWmdXqo+OPxplsCsT2hYuh5NklAh5XvnQVb
        BKa2OwtBQjnzdo4iUIsUpUfQ7QLGrQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-mi-6gqLsPvy_dhd7NAlIvA-1; Tue, 31 Mar 2020 15:40:30 -0400
X-MC-Unique: mi-6gqLsPvy_dhd7NAlIvA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E35C11084426;
        Tue, 31 Mar 2020 19:40:28 +0000 (UTC)
Received: from horse.redhat.com (ovpn-118-184.phx2.redhat.com [10.3.118.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38C945C1BB;
        Tue, 31 Mar 2020 19:40:21 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6A6F42202D7; Tue, 31 Mar 2020 15:40:20 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, vgoyal@redhat.com, aarcange@redhat.com,
        dhildenb@redhat.com
Subject: [PATCH 3/4] kvm: Always get async page notifications
Date:   Tue, 31 Mar 2020 15:40:10 -0400
Message-Id: <20200331194011.24834-4-vgoyal@redhat.com>
In-Reply-To: <20200331194011.24834-1-vgoyal@redhat.com>
References: <20200331194011.24834-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, we seem to get async pf related notifications only if guest
is in user mode, or if it is in kernel mode and CONFIG_PREEMPTION is
enabled. I think idea is that if CONFIG_PREEMPTION is enabled then it
gives us opportunity to schedule something else if page is not ready.

If KVM_ASYNC_PF_SEND_ALWAYS is not set, then host will not send
notifications of PAGE_NOT_PRESENT/PAGE_READY. Instead once page
has been installed guest will run.

Now we are adding capability to report errors as part of async pf
protocol. That means we need async pf related notifications so that
we can make a task wait and when error is reported, we can either
send SIGBUS to user process or search through exception tables for
possible error handler.

Hence enable async pf notifications always. Not sure if this will
have noticieable performance implication though.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 arch/x86/kernel/kvm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 42d17e8c0135..97753a648133 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -336,9 +336,7 @@ static void kvm_guest_cpu_init(void)
 	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF) && kvmapf) {
 		u64 pa =3D slow_virt_to_phys(this_cpu_ptr(&apf_reason));
=20
-#ifdef CONFIG_PREEMPTION
 		pa |=3D KVM_ASYNC_PF_SEND_ALWAYS;
-#endif
 		pa |=3D KVM_ASYNC_PF_ENABLED;
=20
 		if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_VMEXIT))
--=20
2.25.1


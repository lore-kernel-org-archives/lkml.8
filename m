Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BC8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0F322BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNwmzVqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgH0Q1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbgH0Q1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598545655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nAUeeK2BuQYFsQta/IVHJijuZ4P+QQy9wWHlAAEXfrY=;
        b=WNwmzVqDBG4XUt9/SXeppzEF9ShT4v+oF1KmtqUqIgHV74ripI0RDUSmabSTl0PgbIP4G9
        ZjDmgjf0hXT4kzrNlSaGHy5UtVAZ/G4YPL75tDeZ9NNBBy7Lzsw4QWp4HZiFOLCUYNtVGu
        0qkk0/Y4q+HnnAwwNGPYXBCm2hixOnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-48E3qiZPMbekZUWy7CI_mA-1; Thu, 27 Aug 2020 12:27:31 -0400
X-MC-Unique: 48E3qiZPMbekZUWy7CI_mA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8CB718B9F14;
        Thu, 27 Aug 2020 16:27:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07B735C22E;
        Thu, 27 Aug 2020 16:27:21 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 0/3] Few nSVM bugfixes
Date:   Thu, 27 Aug 2020 19:27:17 +0300
Message-Id: <20200827162720.278690-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains few nested SVM fixes from=0D
testing I did this weekend.=0D
=0D
Patch #1 fixes issue where we were setting the GIF (global interrupt flag)=
=0D
on first nested VMexit, after migration thus making the nested guest crash=
=0D
from unexpected interrupts.=0D
=0D
Patch #2 is my observation that we never setup nesed msr bitmap on nested=0D
state load after migration.=0D
=0D
Patch #3 was 'migrated' ;-) from my other patch series to make it smaller,=
=0D
which is about more strict checks when we about to return to a nested guest=
,=0D
from SMM.=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (3):=0D
  SVM: nSVM: correctly restore GIF on vmexit from nesting after=0D
    migration=0D
  SVM: nSVM: setup nested msr permission bitmap on nested state load=0D
  KVM: nSVM: more strict SMM checks when returning to nested guest=0D
=0D
 arch/x86/kvm/svm/nested.c |  7 ++++++-=0D
 arch/x86/kvm/svm/svm.c    | 29 ++++++++++++++++++-----------=0D
 2 files changed, 24 insertions(+), 12 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D


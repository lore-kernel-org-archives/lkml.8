Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E85C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E63220775
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dT6p3ftt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgGQLe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:34:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39224 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726104AbgGQLe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594985667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ap+OTTNHSy5NfknFXFXO4vdY1KCy5ST6u153yyPpCug=;
        b=dT6p3ftt8LJJgkZnPcrHLGBpYr7gSC21EzqT05PuIbJcHsUCCVRNlW2xZ+r/IvjEDtshHc
        OZf6Z7LETRpLjPerOgzOwvD+KTL56VGIMv6yF+XCC5tlNaU9BiMntH2f4NiF1NQnHgOeYv
        KuTsWyircDeFeZeRUf7DjQAGtcv8zXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-vXZJzFuYPJuX1-pA46pgYQ-1; Fri, 17 Jul 2020 07:34:24 -0400
X-MC-Unique: vXZJzFuYPJuX1-pA46pgYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CF41100A8E7;
        Fri, 17 Jul 2020 11:34:23 +0000 (UTC)
Received: from virtlab710.virt.lab.eng.bos.redhat.com (virtlab710.virt.lab.eng.bos.redhat.com [10.19.152.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C09B19C58;
        Fri, 17 Jul 2020 11:34:22 +0000 (UTC)
From:   Cathy Avery <cavery@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com
Subject: [PATCH kvm-unit-tests v2 0/3] svm: INIT test and test_run on selected vcpu
Date:   Fri, 17 Jul 2020 07:34:19 -0400
Message-Id: <20200717113422.19575-1-cavery@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INIT intercept test and the ability to execute test_run
on a selected vcpu

Changes from v1:

1) Incorporated feedback:
	- DR6/DR7/CR2/DEBUGCTL should not be need.
	- HSAVE should be set to a different page for each vCPU
	- The on_cpu to set EFER should be in setup_svm
	- The on_cpu to set cr0/cr3/cr4 should be in setup_vm.

2) Execute tests on selected vcpu using on_cpu_async so the tests
may use the on_cpu functions without causing an ipi_lock deadlock.

3) Added additional test svm_init_startup_test which inits the vcpu and
restarts with sipi.

Cathy Avery (3):
  svm: Add ability to execute test via test_run on a vcpu other than
    vcpu 0
  svm: INIT and STARTUP ipi test
  svm: INIT intercept test

 lib/x86/vm.c    | 18 +++++++++
 lib/x86/vm.h    |  7 ++++
 x86/cstart64.S  |  1 +
 x86/svm.c       | 24 +++++++++++-
 x86/svm.h       |  2 +
 x86/svm_tests.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 148 insertions(+), 1 deletion(-)

-- 
2.20.1


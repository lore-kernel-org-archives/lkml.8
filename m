Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612EEC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C7020637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYbAITBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgCERZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:25:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33858 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725938AbgCERZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583429148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=LNaeYUuZ/I8N5sWDPpA8Jaa5r8899vfI3fz+QN5P+JQ=;
        b=IYbAITBpPGA9mko9U1WWd+yI5eq1lE4e4oPdV82mVJ21f9COss20jKa2hmDNUKgVt9IdSb
        zj81D+Y971N8ecGJBv8FKijv6Qa9gooEsaEz+vIinY0I+elRqXx6rzRYnAekfweHMsuaNU
        Gnqart5c8f+u1SYXcX+cxFifPdk4XOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-gvySo0gPN4e7waaKGzfUMA-1; Thu, 05 Mar 2020 12:25:47 -0500
X-MC-Unique: gvySo0gPN4e7waaKGzfUMA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1B9C1005509;
        Thu,  5 Mar 2020 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-124.gru2.redhat.com [10.97.116.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 704005C219;
        Thu,  5 Mar 2020 17:25:41 +0000 (UTC)
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     shuah@kernel.org, tglx@linutronix.de, thuth@redhat.com,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] kvm: selftests: Add TEST_FAIL macro
Date:   Thu,  5 Mar 2020 14:25:31 -0300
Message-Id: <20200305172532.9360-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch's commit message is self-explanatory about this proposal.

I adjusted to use TEST_FAIL only a few source files, in reality it will
need to change all the ones listed below. I will proceed with the
adjustments if this new macro idea is accepted.

$ find . -type f -name "*.c" -exec grep -l "TEST_ASSERT(false" {} \;
./lib/kvm_util.c
./lib/io.c
./lib/x86_64/processor.c
./lib/aarch64/ucall.c
./lib/aarch64/processor.c
./x86_64/vmx_dirty_log_test.c
./x86_64/state_test.c
./x86_64/vmx_tsc_adjust_test.c
./x86_64/svm_vmcall_test.c
./x86_64/evmcs_test.c
./x86_64/vmx_close_while_nested_test.c

Wainer dos Santos Moschetta (1):
  kvm: selftests: Add TEST_FAIL macro

 tools/testing/selftests/kvm/dirty_log_test.c             | 7 +++----
 tools/testing/selftests/kvm/include/test_util.h          | 3 +++
 tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c | 4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.17.2


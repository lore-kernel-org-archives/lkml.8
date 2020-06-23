Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A190C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2629A20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MORrLfMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbgFWAPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:15:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27033 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731000AbgFWAPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592871351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ouNy0Qiboh0qNzszrC6NPxtXqgwqYBcagFjKPktA1/g=;
        b=MORrLfMIBMNqcrOFDQbtPUG4WDf0VXc7mcmLfvn9wElFZdfM0EeXo+bWqEGsgv3klLV74W
        QjcUdr0rzQXtN3hPNDcLWCYkhNTThFFbXH8GAczIwTxdvqklgSyV9ZQ/iXFkyF9eRUaI4I
        MM8TmmMw38inBk+IjNXu3UCFESdyN4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-SvSTZNFCNfK0Fpevkp10PQ-1; Mon, 22 Jun 2020 20:15:49 -0400
X-MC-Unique: SvSTZNFCNfK0Fpevkp10PQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 859FF8005AD;
        Tue, 23 Jun 2020 00:15:48 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1756C60BEC;
        Tue, 23 Jun 2020 00:15:48 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/6] kselftest: fix TAP output for skipped test and ksft_set_plan misuse
Date:   Mon, 22 Jun 2020 20:15:41 -0400
Message-Id: <20200623001547.22255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 of the patch to fix TAP output for skipped tests.  I noticed
and fixed two other occurrences of "not ok ... # SKIP" which according
to the TAP specification should be marked as "ok ... # SKIP" instead.

Unfortunately, closer analysis showed ksft_exit_skip to be a badly
misused API.  It should be used when the remainder of the testcase
is being skipped, but TAP only supports this before the test plan
has been emitted (in which case you're supposed to print "1..0 # SKIP".

Therefore, in patch 1 I'm mostly trying to do something sensible,
printing "1..0 # SKIP" is possible or "ok ... # SKIP" if not (which is
no worse than what was doing before).  The remaining five patches
show what needs to be done in order to avoid ksft_exit_skip misuse;
while working on them I found other bugs that I've fixed at the same
time; see patch 2 for an example.

In the interest of full disclosure, I won't be able to do more cleanups
of ksft_exit_skip callers.  However, I have fixed all those that did
call ksft_set_plan() as those at least try to produce TAP output.

Paolo

Paolo Bonzini (6):
  kselftest: fix TAP output for skipped tests
  selftests: breakpoints: fix computation of test plan
  selftests: breakpoints: do not use ksft_exit_skip after ksft_set_plan
  selftests: pidfd: do not use ksft_exit_skip after ksft_set_plan
  selftests: sigaltstack: do not use ksft_exit_skip after ksft_set_plan
  selftests: sync_test: do not use ksft_exit_skip after ksft_set_plan

 .../breakpoints/step_after_suspend_test.c     | 53 +++++++++++--------
 tools/testing/selftests/kselftest.h           | 28 +++++++---
 tools/testing/selftests/kselftest/runner.sh   |  2 +-
 tools/testing/selftests/pidfd/pidfd_test.c    | 39 +++++++++++---
 tools/testing/selftests/sigaltstack/sas.c     |  4 +-
 tools/testing/selftests/sync/sync_test.c      |  2 +-
 6 files changed, 87 insertions(+), 41 deletions(-)

-- 
2.26.2


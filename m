Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472B3C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA65207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgCYOTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:19:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:42324 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbgCYOTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:19:10 -0400
IronPort-SDR: vCZkbwfm1OYWK4CBuTCsjI40i8ujIwCA4UpbwjtOfGh/9VcZ+wjjYtvCxGMr5otFDZucngBZdx
 tbxwnu59fqfw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 07:19:10 -0700
IronPort-SDR: 4j5oJBDaQj2KzJ63xjdYy/OcamE8di33XJj7oIvv1g7nyN7ulox6D2Kwj7ntvS4qQBbqzX6vbQ
 QM7tIkCXSlnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="270811071"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.39])
  by fmsmga004.fm.intel.com with ESMTP; 25 Mar 2020 07:19:08 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 0/6] Fix errors when try to build kvm selftests on specified output
Date:   Wed, 25 Mar 2020 22:01:27 +0800
Message-Id: <20200325140133.103236-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I attempted to build KVM selftests on a specified dir, unfortunately
neither	"make O=/path/to/mydir TARGETS=kvm" in tools/testing/selftests, nor
"make OUTPUT=/path/to/mydir" in tools/testing/selftests/kvm work.

This series aims to fix them.

Patch 1 fixes the issue that output directory is not exist.

Patch 2 and 3 are the preparation for kvm to get the right path of
installed linux headers.

Patch 4 and 6 prepare the INSTALL_HDR_PATH to tell sub TARGET where the
linux headers are installed.

Patch 5 fixes the issue that with OUTPUT specified, it still make the
linux tree dirty.

I only test the sub TARGET of kvm.
In theory, it won't break other TARGET of selftests.

Changes in v2:
 - fix the no directory issue in lib.mk
 - make kvm fixes seperate patch
 - Add the patch to fix linux src tree not clean issue

v1:
https://lore.kernel.org/kvm/20200315093425.33600-1-xiaoyao.li@intel.com/

Xiaoyao Li (6):
  selftests: Create directory when OUTPUT specified
  selftests: kvm: Include lib.mk earlier
  selftests: kvm: Use the default linux header path only when
    INSTALL_HDR_PATH not defined
  selftests: Create variable INSTALL_HDR_PATH if need to install linux
    headers to $(OUTPUT)/usr
  selftests: Generate build output of linux headers to
    $(OUTPUT)/linux-header-build
  selftests: export INSTALL_HDR_PATH if using "O" to specify output dir

 tools/testing/selftests/Makefile     |  6 +++++-
 tools/testing/selftests/kvm/Makefile |  9 +++++----
 tools/testing/selftests/lib.mk       | 19 ++++++++++++++++++-
 3 files changed, 28 insertions(+), 6 deletions(-)

-- 
2.20.1


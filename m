Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA64C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C03214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587051361;
	bh=I8PHgfdD0SDvIxDAZKoac40s1IpppyWu12/+HSUbMSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BEsxx7H1JNm2nUYsxV4noSToV0Glv6n2Wv2kUNZXSLj0BZtYvQtpB1Djhe91LPXXx
	 CT8ZaVXtsUC+VMqrP+OdB1aFOgIGY4MTaPE2wMPAV/YVLaNZa7T15qSgBLCDRP2oWr
	 CMoqM9cW7+5HyXTqYjccOyHRNi9QcII1pdmHL4SY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410417AbgDPPgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:36:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898207AbgDPNkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:40:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E60CD20732;
        Thu, 16 Apr 2020 13:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044449;
        bh=I8PHgfdD0SDvIxDAZKoac40s1IpppyWu12/+HSUbMSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kM9foNme47l7hTPkYOKs/vlTBdmHiRHOTJtvvsoUvnEFcX3gaV0WWlBQk+s7B0ZUM
         RWV3K9HGx4LQhaK8MWh7dEDpy2PMpVFsFdzpNcQfw4+0SHbjDDgi21bZO2BHqmKnDS
         ZeolAX+kRXO407by5WfxNEO+XZRIDq8gwLTCiQwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.5 205/257] selftests/powerpc: Fix try-run when source tree is not writable
Date:   Thu, 16 Apr 2020 15:24:16 +0200
Message-Id: <20200416131351.699219261@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit 9686813f6e9d5568bc045de0be853411e44958c8 upstream.

We added a usage of try-run to pmu/ebb/Makefile to detect if the
toolchain supported the -no-pie option.

This fails if we build out-of-tree and the source tree is not
writable, as try-run tries to write its temporary files to the current
directory. That leads to the -no-pie option being silently dropped,
which leads to broken executables with some toolchains.

If we remove the redirect to /dev/null in try-run, we see the error:

  make[3]: Entering directory '/linux/tools/testing/selftests/powerpc/pmu/ebb'
  /usr/bin/ld: cannot open output file .54.tmp: Read-only file system
  collect2: error: ld returned 1 exit status
  make[3]: Nothing to be done for 'all'.

And looking with strace we see it's trying to use a file that's in the
source tree:

  lstat("/linux/tools/testing/selftests/powerpc/pmu/ebb/.54.tmp", 0x7ffffc0f83c8)

We can fix it by setting TMPOUT to point to the $(OUTPUT) directory,
and we can verify with strace it's now trying to write to the output
directory:

  lstat("/output/kselftest/powerpc/pmu/ebb/.54.tmp", 0x7fffd1bf6bf8)

And also see that the -no-pie option is now correctly detected.

Fixes: 0695f8bca93e ("selftests/powerpc: Handle Makefile for unrecognized option")
Cc: stable@vger.kernel.org # v5.5+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200327095319.2347641-1-mpe@ellerman.id.au
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/powerpc/pmu/ebb/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/powerpc/pmu/ebb/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
@@ -7,6 +7,7 @@ noarg:
 # The EBB handler is 64-bit code and everything links against it
 CFLAGS += -m64
 
+TMPOUT = $(OUTPUT)/
 # Toolchains may build PIE by default which breaks the assembly
 no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
         $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)



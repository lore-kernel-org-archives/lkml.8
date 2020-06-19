Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B827AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2ED21973
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578453;
	bh=pCuZwKveT1WQk1wUP/h07aVdSsfF4vSo5HcypKbx6n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pXedvhJ7/HkdUxpYRVCJn7x9AwJapdf9OjzodwZG9AS47hJtnO2O58B3tbAAH59df
	 X/ldhrL/HftSjGompLEqCiGHOLJiEXn8Rp8jFCBS+mh2GtRfZVCSEtvjXpYX9fgFQZ
	 CL8oxhPKf55fszPYsmWsgLxb8H7i7PaZoEnuSGno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389403AbgFSOyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389800AbgFSOyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:54:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8867E217D8;
        Fri, 19 Jun 2020 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578440;
        bh=pCuZwKveT1WQk1wUP/h07aVdSsfF4vSo5HcypKbx6n0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o86Wt5Fd0doVyoZSJA9Zz9ZFb2Uw2QQwJKjDitAxSLj3wy+uoATfn/avw1KKfKGtZ
         OT7+TERtJW1gkvjBRPE9bCN3IDwUmlteZTCwRRcDezbT5B54lkAgiakuVJc9LDCc6u
         6xkOJGhftVS9mazpUb2PSRSehh/OBu8xAqULaZKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH 4.19 006/267] selftests: bpf: fix use of undeclared RET_IF macro
Date:   Fri, 19 Jun 2020 16:29:51 +0200
Message-Id: <20200619141649.161195522@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenz Bauer <lmb@cloudflare.com>

commit 634efb750435 ("selftests: bpf: Reset global state between
reuseport test runs") uses a macro RET_IF which doesn't exist in
the v4.19 tree. It is defined as follows:

        #define RET_IF(condition, tag, format...) ({
                if (CHECK_FAIL(condition)) {
                        printf(tag " " format);
                        return;
                }
        })

CHECK_FAIL in turn is defined as:

        #define CHECK_FAIL(condition) ({
                int __ret = !!(condition);
                int __save_errno = errno;
                if (__ret) {
                        test__fail();
                        fprintf(stdout, "%s:FAIL:%d\n", __func__, __LINE__);
                }
                errno = __save_errno;
                __ret;
        })

Replace occurences of RET_IF with CHECK. This will abort the test binary
if clearing the intermediate state fails.

Fixes: 634efb750435 ("selftests: bpf: Reset global state between reuseport test runs")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/bpf/test_select_reuseport.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/tools/testing/selftests/bpf/test_select_reuseport.c
+++ b/tools/testing/selftests/bpf/test_select_reuseport.c
@@ -616,13 +616,13 @@ static void cleanup_per_test(void)
 
 	for (i = 0; i < NR_RESULTS; i++) {
 		err = bpf_map_update_elem(result_map, &i, &zero, BPF_ANY);
-		RET_IF(err, "reset elem in result_map",
-		       "i:%u err:%d errno:%d\n", i, err, errno);
+		CHECK(err, "reset elem in result_map",
+		      "i:%u err:%d errno:%d\n", i, err, errno);
 	}
 
 	err = bpf_map_update_elem(linum_map, &zero, &zero, BPF_ANY);
-	RET_IF(err, "reset line number in linum_map", "err:%d errno:%d\n",
-	       err, errno);
+	CHECK(err, "reset line number in linum_map", "err:%d errno:%d\n",
+	      err, errno);
 
 	for (i = 0; i < REUSEPORT_ARRAY_SIZE; i++)
 		close(sk_fds[i]);



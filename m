Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AD1C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDAC205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738261;
	bh=OcNdbwEliGVpOYbXVJ9ALqYcB+eJC/IuXzLGPdaSWkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gVGszRyypxZcrl+VbAoYf4RDvaoR8EXBVjsS6A6yQAkjX0lssiLMVmPePWJrVzMrM
	 k2OipO9kFzn8/FDRvTl4qJmur9cA83eXwJW5vh/wfdDY2YfR6K8GlJV4SpyF52SIoT
	 ZhmrJNdqNIXWBaboZpYRY7j6orVBe8xnYpaG8TB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbgAKKYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:24:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbgAKKYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:24:16 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB422205F4;
        Sat, 11 Jan 2020 10:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738255;
        bh=OcNdbwEliGVpOYbXVJ9ALqYcB+eJC/IuXzLGPdaSWkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zdGZxuC2OjcxcnS4bBFlpWyCu9KEvbtWGT9B9fpm0sCwpDxups6LPWgLr1HJkOqW7
         mTChacN9DvfvoVx59vdIeL0S8rBYW275ek+S2l7DLIRSMvs4giNkLM5CB6dawbSoCx
         6fkq/GtqKriwAShZwgX+XrWwPWuoZSJqkMwMoSfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, SeongJae Park <sjpark@amazon.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 060/165] kselftest/runner: Print new line in print of timeout log
Date:   Sat, 11 Jan 2020 10:49:39 +0100
Message-Id: <20200111094926.204891138@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

[ Upstream commit d187801d1a46519d2a322f879f7c8f85c685372e ]

If a timeout failure occurs, kselftest kills the test process and prints
the timeout log.  If the test process has killed while printing a log
that ends with new line, the timeout log can be printed in middle of the
test process output so that it can be seems like a comment, as below:

    # test_process_log	not ok 3 selftests: timers: nsleep-lat # TIMEOUT

This commit avoids such problem by printing one more line before the
TIMEOUT failure log.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kselftest/runner.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 84de7bc74f2c..a8d20cbb711c 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -79,6 +79,7 @@ run_one()
 		if [ $rc -eq $skip_rc ]; then	\
 			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
 		elif [ $rc -eq $timeout_rc ]; then \
+			echo "#"
 			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
 		else
 			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
-- 
2.20.1




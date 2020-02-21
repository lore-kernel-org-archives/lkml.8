Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A174C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309E424670
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272276;
	bh=kwYS4IJqe/CCzOFwvS5e6qcl5rOhH6tgd+nA24huEr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=14UnBnoi532Zu9BwGRhMZGQHEeMt4aThH5mzJTWoDqJ5tn4bAhoMS/q6lqpnU26O5
	 6rp/TUQRjWgunn/S/mEBXhVwYC63WFSmLB/IMfkhTns4MdN4MxT4R82l6Q+hD/bvvP
	 4gFTTGETHANwmVmJ0ThXKGVlCxeTmf53CMYHGw1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbgBUIEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:04:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731649AbgBUIEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:04:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C714F24656;
        Fri, 21 Feb 2020 08:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272272;
        bh=kwYS4IJqe/CCzOFwvS5e6qcl5rOhH6tgd+nA24huEr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NC8+yWotBW0fGWnveJULYJKilA2Ei101N65v3K6AFQRs3MoR0Lns7+RYrrugQ0Ayb
         UXRhJkCKMYHijBakT3dpzingHvTGzmFvCxc9wK/M7TfG6bcyIlL+084Qb77dnJYXL4
         Tk8U/UX+aCWeCRLNPaa/Ia9yFQm5L1bT2ZZ/xfCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 081/344] selftests: settings: tests can be in subsubdirs
Date:   Fri, 21 Feb 2020 08:38:00 +0100
Message-Id: <20200221072356.324661870@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthieu Baerts <matthieu.baerts@tessares.net>

[ Upstream commit ac87813d4372f4c005264acbe3b7f00c1dee37c4 ]

Commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
timeout per test") adds support for a new per-test-directory "settings"
file. But this only works for tests not in a sub-subdirectories, e.g.

 - tools/testing/selftests/rtc (rtc) is OK,
 - tools/testing/selftests/net/mptcp (net/mptcp) is not.

We have to increase the timeout for net/mptcp tests which are not
upstreamed yet but this fix is valid for other tests if they need to add
a "settings" file, see the full list with:

  tools/testing/selftests/*/*/**/Makefile

Note that this patch changes the text header message printed at the end
of the execution but this text is modified only for the tests that are
in sub-subdirectories, e.g.

  ok 1 selftests: net/mptcp: mptcp_connect.sh

Before we had:

  ok 1 selftests: mptcp: mptcp_connect.sh

But showing the full target name is probably better, just in case a
subsubdir has the same name as another one in another subdirectory.

Fixes: 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second timeout per test)
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kselftest/runner.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index a8d20cbb711cf..e84d901f85672 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -91,7 +91,7 @@ run_one()
 run_many()
 {
 	echo "TAP version 13"
-	DIR=$(basename "$PWD")
+	DIR="${PWD#${BASE_DIR}/}"
 	test_num=0
 	total=$(echo "$@" | wc -w)
 	echo "1..$total"
-- 
2.20.1




Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA8BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8BF72075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590677556;
	bh=g+GA7748mcRVf5Dk5zP2FrQLRaz81ApMWGtcMSwYyJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Vg3mjWOuNZiiGgvkegrRLLBwyWRbnmPUtFnrbRbL8XQeGLEYSvxKYJiEDy41OWZq
	 9OScrfKAHi4Dtq9s3c8uW1b5/t0mGfq5v4xU3Fs028BF0si/LsjyUGsaOWIAdfJaEl
	 mI4c2Iw6dIGnoiBBFXu45AUZy8uZb8SBdkGUcp6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403806AbgE1Owg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403790AbgE1Owc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:52:32 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B812075F;
        Thu, 28 May 2020 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590677551;
        bh=g+GA7748mcRVf5Dk5zP2FrQLRaz81ApMWGtcMSwYyJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mbijsxQErF8YGGSl7V2+spkkU+8N071iLQceo/Fp1by2zKLCqZilbA4vkyS6fG5/L
         3cGjdWmje4FxT02kcA53Hqp6eDcIusULKX74Gre6qIOWqNhXu5Xr+mj35/msy9kuEJ
         KX4SFKN53lOAZsNt7I5juHJDKpjBrNn8DiElg7ys=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: [PATCH 3/4] selftests/sysctl: Fix to load test_sysctl module
Date:   Thu, 28 May 2020 23:52:26 +0900
Message-Id: <159067754657.229397.15961438722058766667.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159067751438.229397.6746886115540895104.stgit@devnote2>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to load test_sysctl.ko module correctly.

sysctl.sh checks whether the test module is embedded (or loaded
already) or not at first, and if not, it returns skip error
instead of trying modprobe. Thus, there is no chance to load the
test_sysctl test module.

Instead, this removes that module embedded check and returns
skip error only if it ensures that there is no embedded test
module *and* no loadable test module.

This also avoid referring config file since that is not
installed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/sysctl/sysctl.sh |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 6a970b127c9b..c3459f9f2429 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -40,16 +40,6 @@ ALL_TESTS="$ALL_TESTS 0004:1:1:uint_0001"
 ALL_TESTS="$ALL_TESTS 0005:3:1:int_0003"
 ALL_TESTS="$ALL_TESTS 0006:50:1:bitmap_0001"
 
-test_modprobe()
-{
-       if [ ! -d $DIR ]; then
-               echo "$0: $DIR not present" >&2
-               echo "You must have the following enabled in your kernel:" >&2
-               cat $TEST_DIR/config >&2
-               exit $ksft_skip
-       fi
-}
-
 function allow_user_defaults()
 {
 	if [ -z $DIR ]; then
@@ -125,10 +115,12 @@ function load_req_mod()
 	if [ ! -d $DIR ]; then
 		if ! modprobe -q -n $TEST_DRIVER; then
 			echo "$0: module $TEST_DRIVER not found [SKIP]"
+			echo "You must set CONFIG_TEST_SYSCTL=m in your kernel" >&2
 			exit $ksft_skip
 		fi
 		modprobe $TEST_DRIVER
 		if [ $? -ne 0 ]; then
+			echo "$0: modprobe $TEST_DRIVER failed."
 			exit
 		fi
 	fi
@@ -929,7 +921,6 @@ test_reqs
 allow_user_defaults
 check_production_sysctl_writes_strict
 load_req_mod
-test_modprobe
 
 trap "test_finish" EXIT
 


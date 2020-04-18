Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B30C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A663721D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221327;
	bh=yHNIDzVNvLCL4X8ZcRKD4Aum8vu9I5J85OgiF0T+xoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RS8Z7ILTZax2ElZ0aqRM7gBWuQyD06RWd43No5tmmrJxGRl99AXLH+IHuj/qvKMfa
	 g4rJecTCG4+9lenZxMYqlO+AQ8G3cvBVpfYjIrmbW4DNrXu8Z4zY7USMU8/LurrsnH
	 sZsKH+O5dY+FCkLJTVQvu1uf6CszocxlWOsgyNIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgDROsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:48:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728650AbgDROno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:43:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 904CD2072B;
        Sat, 18 Apr 2020 14:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587221024;
        bh=yHNIDzVNvLCL4X8ZcRKD4Aum8vu9I5J85OgiF0T+xoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Onl8QgSss864ThCOWyXtT04Y4rIIADdZC4eRbgXJdxAT1HJct1ePF7N8EfeCKF+6
         TkSh0bVRri/bBohVn/m+w0iQnMOUnbqPRUIueQy8DtRWJTrD+HinyXRUdRG5aM8Yo/
         uZS/B6Cln54BnuEh414Fqdiuy9qYWXH01wo7WnYQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Biggers <ebiggers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 12/28] selftests: kmod: fix handling test numbers above 9
Date:   Sat, 18 Apr 2020 10:43:12 -0400
Message-Id: <20200418144328.10265-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144328.10265-1-sashal@kernel.org>
References: <20200418144328.10265-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 6d573a07528308eb77ec072c010819c359bebf6e ]

get_test_count() and get_test_enabled() were broken for test numbers
above 9 due to awk interpreting a field specification like '$0010' as
octal rather than decimal.  Fix it by stripping the leading zeroes.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: NeilBrown <neilb@suse.com>
Link: http://lkml.kernel.org/r/20200318230515.171692-5-ebiggers@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kmod/kmod.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index 7956ea3be6675..eed5d5b81226b 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -502,18 +502,23 @@ function test_num()
 	fi
 }
 
-function get_test_count()
+function get_test_data()
 {
 	test_num $1
-	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$1'}')
+	local field_num=$(echo $1 | sed 's/^0*//')
+	echo $ALL_TESTS | awk '{print $'$field_num'}'
+}
+
+function get_test_count()
+{
+	TEST_DATA=$(get_test_data $1)
 	LAST_TWO=${TEST_DATA#*:*}
 	echo ${LAST_TWO%:*}
 }
 
 function get_test_enabled()
 {
-	test_num $1
-	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$1'}')
+	TEST_DATA=$(get_test_data $1)
 	echo ${TEST_DATA#*:*:}
 }
 
-- 
2.20.1


Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFECC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D4D206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588100477;
	bh=tJx2Pw8jARz8g4y2ONxmN/CJIrowA+R2SLrDY7KpChs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KsNL1yxJoEFsoIHauaEyPiE11DzAvrmUHZTTVfp9hcUuVxNS3vXvhCadhx6bXHV0E
	 xwBj6sF+CD2R1KhhkXAfwIdbhx9oguugGXJHVEWx5TfBcFd66yf1bWTUTAxXeFIsCz
	 e/s7K9GX4OUrOvNmUq+0JSabEo5dgtj79x9UD9dE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgD1S0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbgD1S0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:26:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B589C208E0;
        Tue, 28 Apr 2020 18:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098395;
        bh=tJx2Pw8jARz8g4y2ONxmN/CJIrowA+R2SLrDY7KpChs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVezjO2sA8zWK+vPGzJQP4trfj61PdRApDupbkv2R613s2PRnPUP8LuPfoq32L34M
         FnO5s4Q74NRp9O/JEmKBn2EVnpHhBAwDqPUZGw0fL2cCNJ0xD/YpFImjL9SvoJ4FBf
         MGC6+fdGOMSMRV5s3Jz/89eEOCVVnmcUisW0X4Q0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 022/167] selftests: kmod: fix handling test numbers above 9
Date:   Tue, 28 Apr 2020 20:23:18 +0200
Message-Id: <20200428182227.963762880@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 8b944cf042f6c..315a43111e046 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -505,18 +505,23 @@ function test_num()
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




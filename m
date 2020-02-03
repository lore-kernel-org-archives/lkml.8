Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FADC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0BC21775
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747653;
	bh=NS5ojRQwoa0VTd8vLTGmijdKyn6yx81L7neitWsZBow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PwdYeXreQGSxdRbMOL5fSJeJcTT93fF7seBXDWA6yV5cRjsKCmBDQ/3rMRLdkCR/W
	 8iLhgoTNmxzQsJwu0woYQ4wGmtlEkTBSsQeQuVolIxlbR0EEqrxnkXN+L3MrY49YtF
	 gpx3Wx2N9V5dwjmowGo2BuxHvD5Aic4mQJ0UmncI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbgBCQeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:34:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730729AbgBCQeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:34:07 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F7FD2087E;
        Mon,  3 Feb 2020 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747646;
        bh=NS5ojRQwoa0VTd8vLTGmijdKyn6yx81L7neitWsZBow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zXMyU4990rVdrUV03n4k/+miyZMGm3H9m5yXuGELpzPRVvtLoGNwcGqsAUZX33nTX
         +vITV2vHsEisVmgoM6J7dbRb3HKJqkssYX62OPsgBe+LEcC3gnzr3mzwHXRRWTyD9z
         yBQHDIPgL4IwDzV1O6yF10nsU7ihD5Aopm8bDXOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Dmitry Levin <ldv@altlinux.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        kbuild test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.4 11/90] tools lib: Fix builds when glibc contains strlcpy()
Date:   Mon,  3 Feb 2020 16:19:14 +0000
Message-Id: <20200203161919.110051704@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Chikunov <vt@altlinux.org>

commit 6c4798d3f08b81c2c52936b10e0fa872590c96ae upstream.

Disable a couple of compilation warnings (which are treated as errors)
on strlcpy() definition and declaration, allowing users to compile perf
and kernel (objtool) when:

1. glibc have strlcpy() (such as in ALT Linux since 2004) objtool and
   perf build fails with this (in gcc):

  In file included from exec-cmd.c:3:
  tools/include/linux/string.h:20:15: error: redundant redeclaration of ‘strlcpy’ [-Werror=redundant-decls]
     20 | extern size_t strlcpy(char *dest, const char *src, size_t size);

2. clang ignores `-Wredundant-decls', but produces another warning when
   building perf:

    CC       util/string.o
  ../lib/string.c:99:8: error: attribute declaration must precede definition [-Werror,-Wignored-attributes]
  size_t __weak strlcpy(char *dest, const char *src, size_t size)
  ../../tools/include/linux/compiler.h:66:34: note: expanded from macro '__weak'
  # define __weak                 __attribute__((weak))
  /usr/include/bits/string_fortified.h:151:8: note: previous definition is here
  __NTH (strlcpy (char *__restrict __dest, const char *__restrict __src,

Committer notes:

The

 #pragma GCC diagnostic

directive was introduced in gcc 4.6, so check for that as well.

Fixes: ce99091 ("perf tools: Move strlcpy() from perf to tools/lib/string.c")
Fixes: 0215d59 ("tools lib: Reinstate strlcpy() header guard with __UCLIBC__")
Resolves: https://bugzilla.kernel.org/show_bug.cgi?id=118481
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
Reviewed-by: Dmitry Levin <ldv@altlinux.org>
Cc: Dmitry Levin <ldv@altlinux.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: kbuild test robot <lkp@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Cc: Vineet Gupta <vineet.gupta1@synopsys.com>
Link: http://lore.kernel.org/lkml/20191224172029.19690-1-vt@altlinux.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/include/linux/string.h |    8 ++++++++
 tools/lib/string.c           |    7 +++++++
 2 files changed, 15 insertions(+)

--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -17,7 +17,15 @@ int strtobool(const char *s, bool *res);
  * However uClibc headers also define __GLIBC__ hence the hack below
  */
 #if defined(__GLIBC__) && !defined(__UCLIBC__)
+// pragma diagnostic was introduced in gcc 4.6
+#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wredundant-decls"
+#endif
 extern size_t strlcpy(char *dest, const char *src, size_t size);
+#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
+#pragma GCC diagnostic pop
+#endif
 #endif
 
 char *str_error_r(int errnum, char *buf, size_t buflen);
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -96,6 +96,10 @@ int strtobool(const char *s, bool *res)
  * If libc has strlcpy() then that version will override this
  * implementation:
  */
+#ifdef __clang__
+#pragma clang diagnostic push
+#pragma clang diagnostic ignored "-Wignored-attributes"
+#endif
 size_t __weak strlcpy(char *dest, const char *src, size_t size)
 {
 	size_t ret = strlen(src);
@@ -107,6 +111,9 @@ size_t __weak strlcpy(char *dest, const
 	}
 	return ret;
 }
+#ifdef __clang__
+#pragma clang diagnostic pop
+#endif
 
 /**
  * skip_spaces - Removes leading whitespace from @str.



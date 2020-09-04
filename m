Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C86BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36D82098B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599251175;
	bh=L1otYr9ZeSuuSzxTfilG3HB7h1F12CDCP/vsB46T2lA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=WYymHMtKQper+WewzgEqXUV/zX/qSmaTXn1I6oR/1IHWxkpw2tBOuQoMdDBifKtzE
	 iocpHRhWGpfQsHWONLm6k46oQsMm7hzFtNpEs2IL8fxInYCq+Zx/ccvefyITB08mqJ
	 yWxj6ZOAG7vQ2cGOS+G7SOMf8aKpnSxYN3S6nfnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgIDU0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgIDU0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:26:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1646F2084D;
        Fri,  4 Sep 2020 20:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599251173;
        bh=L1otYr9ZeSuuSzxTfilG3HB7h1F12CDCP/vsB46T2lA=;
        h=Date:From:To:Cc:Subject:From;
        b=Cd3J5d4nALeLfar9m7nBLo/1gM+TxTYxO/S47cRb6MJ7+kgtrizOW4ICSEjhxnmyB
         AmtCEtVT303Fwg1Q1Yk4CvggqPfKQy6hrLN7quxVxcCvip/dUdvrPHzZ0E7rAlBW3H
         SwdC6rEvdKz4epmP2gqx6XTad4ScR0qHeXdAhDZw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 32DB140D3D; Fri,  4 Sep 2020 17:26:11 -0300 (-03)
Date:   Fri, 4 Sep 2020 17:26:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] tools feature: Add missing -lzstd to the fast path feature
 detection
Message-ID: <20200904202611.GJ3753976@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were failing that due to GTK2+ and then for the ZSTD test, which made
test-all.c, the fast path feature detection file to fail and thus
trigger building all of the feature tests, slowing down the test.

Eventually the ZSTD test would be built and would succeed, since it had
the needed -lzstd, avoiding:

  $ cat /tmp/build/perf/feature/test-all.make.output
  /usr/bin/ld: /tmp/ccRRJQ4u.o: in function `main_test_libzstd':
  /home/acme/git/perf/tools/build/feature/test-libzstd.c:8: undefined reference to `ZSTD_createCStream'
  /usr/bin/ld: /home/acme/git/perf/tools/build/feature/test-libzstd.c:9: undefined reference to `ZSTD_freeCStream'
  collect2: error: ld returned 1 exit status
  $

Fix it by adding -lzstd to the test-all target.

Now I need an entry to 'perf test' to make sure that
/tmp/build/perf/feature/test-all.make.output is empty...

Fixes: 3b1c5d9659718263 ("tools build: Implement libzstd feature check, LIBZSTD_DIR and NO_LIBZSTD defines")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

---

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 977067e34dff064d..ec815ffc7777a02b 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -91,7 +91,7 @@ __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(
 ###############################
 
 $(OUTPUT)test-all.bin:
-	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -I/usr/include/slang -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma
+	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -I/usr/include/slang -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd
 
 $(OUTPUT)test-hello.bin:
 	$(BUILD)

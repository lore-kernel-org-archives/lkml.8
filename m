Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E4BC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01BF21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiGehpLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgBEQr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:47:26 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37077 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgBEQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:47:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so1104960plz.4;
        Wed, 05 Feb 2020 08:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=v1zp2c8Buz11rx8oDLZnUupN0a04RKKPFP1eZFfFaQM=;
        b=QiGehpLeRRoiud+tkPkpvNxlv7HMOBSUGcWDXdd80xlnQi3cihrQRONSCSX0ICRfCY
         Eh8KIM9rNA9sPxNSDt6Oc53WZaNCblOfoxXSeKUrBYAv/WFLkPZTUZPaT+J91Lx2fWK/
         GXF6I8iFZ4orv3EWpu3OFMRoFYl8NmckObA4eQvNOR5th2gKqBtaQtLWcRTTtJlUqszN
         YRirLyBnSPzlIzQOSpY0c0D2Jp2IZeFc3WGul4pvZua9CkGzo4z1MGjxyEo0WtDflm4l
         1ngF4Pn5g4JmAvXemtRxmTyiSNAx/hPYTU2D/R20V4eyw5rvGvpRfjNpaQyv0e5fwgLR
         TJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=v1zp2c8Buz11rx8oDLZnUupN0a04RKKPFP1eZFfFaQM=;
        b=TxH/Q9TGIJ1V8zmJgbggcTspyYhPxfy3eLGmKckNXZvXAdeU8r+gnZzassy/Z7ZIZU
         nhwVNUtYyTRbmci+MoaShMmA8t8bw1GChJDO2HwsAx7MYnMojajShvd773ncAOcvYwRo
         lLMguA35X5okceLChKcPgkiFjcniSfp/ICK31wgN2s8fPXsQGDoPX0WOWBGJrilGl88w
         VnTWr53f9qwD7mL6puYT5+vg0WTC+NCjl3untNRPUHrLpL1oNpDRCEMKUfapdQhKR02o
         bNzo8ftwT2XZhIddg0SdhZEFDoCJ4mdniUzCOhhJebO38q0dR5C0FAl19XNhNlitcsZ1
         cs6A==
X-Gm-Message-State: APjAAAXV6rA0qsQgwgow9zGw5NbZfZBRB2kn7wawjOaRbXQVXQkbiTH9
        y5UIlCjKKEvZ5SuZkccHgVI=
X-Google-Smtp-Source: APXvYqyQGgO2vcv53QCB+yjk7IsTa1MHki7VKtHtVc/aqzmOK+U7ZdKfc0x0N5acYGs/iH70d4ibzg==
X-Received: by 2002:a17:902:768a:: with SMTP id m10mr36188609pll.67.1580921245129;
        Wed, 05 Feb 2020 08:47:25 -0800 (PST)
Received: from localhost.localdomain ([211.47.96.9])
        by smtp.gmail.com with ESMTPSA id ev5sm340425pjb.4.2020.02.05.08.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 08:47:24 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     sj38.park@gmail.com, kbuild-all@lists.01.org,
        akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, dwmw@amazon.com, jolsa@redhat.com,
        kirill@shutemov.name, mark.rutland@arm.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, rdunlap@infradead.org, rostedt@goodmis.org,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v3 10/11] mm/damon: Add kunit tests
Date:   Wed,  5 Feb 2020 17:47:09 +0100
Message-Id: <20200205164709.19920-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <202002051834.cKoViGVl%lkp@intel.com> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2020 18:38:48 +0800 kbuild test robot <lkp@intel.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 24012 bytes --]
> 
> Hi,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.5]
> [cannot apply to next-20200205]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/sj38-park-gmail-com/Introduce-Data-Access-MONitor-DAMON/20200204-143127
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 322bf2d3446aabdaf5e8887775bd9ced80dbc0f0
> config: i386-allyesconfig (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/list.h:9:0,
>                     from include/linux/random.h:10,
>                     from include/linux/damon.h:13,
>                     from mm/damon.c:14:
>    mm/damon-test.h: In function 'damon_test_str_to_pids':
>    include/linux/kernel.h:835:29: warning: comparison of distinct pointer types lacks a cast
>       (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>                                 ^
> >> include/kunit/test.h:510:9: note: in expansion of macro '__typecheck'
>      ((void)__typecheck(__left, __right));           \
>             ^~~~~~~~~~~
> >> include/kunit/test.h:534:2: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
>      KUNIT_BASE_BINARY_ASSERTION(test,           \
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> include/kunit/test.h:623:2: note: in expansion of macro 'KUNIT_BASE_EQ_MSG_ASSERTION'
>      KUNIT_BASE_EQ_MSG_ASSERTION(test,           \
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> include/kunit/test.h:633:2: note: in expansion of macro 'KUNIT_BINARY_EQ_MSG_ASSERTION'
>      KUNIT_BINARY_EQ_MSG_ASSERTION(test,           \
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> include/kunit/test.h:996:2: note: in expansion of macro 'KUNIT_BINARY_EQ_ASSERTION'
>      KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
>      ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> mm/damon-test.h:26:2: note: in expansion of macro 'KUNIT_EXPECT_EQ'
>      KUNIT_EXPECT_EQ(test, 1l, nr_integers);
>      ^~~~~~~~~~~~~~~
[...]

Thank you for the reporting!  Fixed the warnings and an error for i386 build
with below changes.  If anything wrong, please let me know.


Thanks,
SeongJae Park


diff --git a/mm/damon-test.h b/mm/damon-test.h
index ad3ffd1c20e2..c7dc21325c77 100644
--- a/mm/damon-test.h
+++ b/mm/damon-test.h
@@ -23,51 +23,51 @@ static void damon_test_str_to_pids(struct kunit *test)

        question = "123";
        answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
-       KUNIT_EXPECT_EQ(test, 1l, nr_integers);
+       KUNIT_EXPECT_EQ(test, (ssize_t)1, nr_integers);
        KUNIT_EXPECT_EQ(test, 123ul, answers[0]);
        kfree(answers);

        question = "123abc";
        answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
-       KUNIT_EXPECT_EQ(test, 1l, nr_integers);
+       KUNIT_EXPECT_EQ(test, (ssize_t)1, nr_integers);
        KUNIT_EXPECT_EQ(test, 123ul, answers[0]);
        kfree(answers);

        question = "a123";
        answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
-       KUNIT_EXPECT_EQ(test, 0l, nr_integers);
+       KUNIT_EXPECT_EQ(test, (ssize_t)0, nr_integers);
        KUNIT_EXPECT_PTR_EQ(test, answers, (unsigned long *)NULL);

        question = "12 35";
        answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
-       KUNIT_EXPECT_EQ(test, 2l, nr_integers);
+       KUNIT_EXPECT_EQ(test, (ssize_t)2, nr_integers);
        for (i = 0; i < nr_integers; i++)
                KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
        kfree(answers);

        question = "12 35 46";
        answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
-       KUNIT_EXPECT_EQ(test, 3l, nr_integers);
+       KUNIT_EXPECT_EQ(test, (ssize_t)3, nr_integers);
        for (i = 0; i < nr_integers; i++)
                KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
        kfree(answers);

        question = "12 35 abc 46";
        answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
-       KUNIT_EXPECT_EQ(test, 2l, nr_integers);
+       KUNIT_EXPECT_EQ(test, (ssize_t)2, nr_integers);
        for (i = 0; i < 2; i++)
                KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
        kfree(answers);

        question = "";
        answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
-       KUNIT_EXPECT_EQ(test, 0l, nr_integers);
+       KUNIT_EXPECT_EQ(test, (ssize_t)0, nr_integers);
        KUNIT_EXPECT_PTR_EQ(test, (unsigned long *)NULL, answers);
        kfree(answers);

        question = "\n";
        answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
-       KUNIT_EXPECT_EQ(test, 0l, nr_integers);
+       KUNIT_EXPECT_EQ(test, (ssize_t)0, nr_integers);
        KUNIT_EXPECT_PTR_EQ(test, (unsigned long *)NULL, answers);
        kfree(answers);
 }
diff --git a/mm/damon.c b/mm/damon.c
index 108476b07555..c6c5b975f1f5 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -509,8 +509,8 @@ static bool damon_check_reset_time_interval(struct timespec64 *baseline,
        struct timespec64 now;

        ktime_get_coarse_ts64(&now);
-       if ((timespec64_to_ns(&now) - timespec64_to_ns(baseline)) / 1000 <
-                       interval)
+       if ((timespec64_to_ns(&now) - timespec64_to_ns(baseline)) <
+                       interval * 1000)
                return false;
        *baseline = now;
        return true;

> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> 
> [-- Attachment #2: .config.gz --]
> [-- Type: application/gzip, Size: 71233 bytes --]

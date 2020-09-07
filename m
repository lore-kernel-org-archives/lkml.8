Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E03C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D252137B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599450371;
	bh=axvJWXJTyuGwRDnXnaCEuHw8SCSyL10qFLm3YnbKnko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hisxBMg0dRvA4Q1/VuX5Uzanni9SWXcXnlwOswFrbc3bwKQbZiXF/wQRkYxaIrMhK
	 6kmcDL3x+UpVgoCY2cOd+9JZUDhCo1OQRsQsO3vx0C8dVksy5cjxe7/Rqx+/KkrL+T
	 gS0OzgXtDph35AXGFzZrLttDBHeOogUf+nHQyJkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgIGDqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgIGDpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:45:51 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06006C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 20:45:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id a8so3865316plm.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 20:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=27vCMqYtloZ9jlU8gp2knuFpHSbEXU/O9OXX/MacU2c=;
        b=VhLnqld4jXuMWmCdEDuy1ONq32aCpqXNEMr5ZoJ78Qks81hIDOnWGx4MOBQxra75tN
         BAYOxCf4m3krvQT1rryugiyi/Nax1ISKFG6z91BEqxz27Wv/y7ncJpTv5jMCQViRqjHD
         Xl37CCHhhW7dFC7Jxil/VUak3u1gniaHpURKNlAZyKOwdjJrOk5EP2qn9l1JQE5KLpEB
         xq+nqqzoPJMgHe/SWfVbsbS+kYwU+HPW+sXAPVhJItyziEuhGQYPKWpx6338yz0zfxIi
         Tc9WPWjtq3wpki8W1M+kq7IQAIqL06P+oVsAu9sotyLvPGNwPufwyMl5veiCwb/8fVA5
         KohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=27vCMqYtloZ9jlU8gp2knuFpHSbEXU/O9OXX/MacU2c=;
        b=UtIXm75WuMt3RY5zCVzZOM2b3Ixm/HmJR65ZJ9xBN104/bSdX19BnSRu/LK5LjyLb1
         Y0oTR8LxBR36irwHBVDTLwjaSQ83vWDmZcIj5WqLczjSBrLXD3DChOoQfbr75zTUpYbj
         p/kpqg9jypf0XMfTxuxilOvUWEC1AEac/rW3ef1ER97pWRftDC0meeXpPv01Yd/Oe5NZ
         GuCfRnICYu7dhBIOrHFxKiczaNUipNqunOmh0oPrifstlaVCr7O7kimKfW3WyOTZ/BLH
         CAsF09BtpejJJ45Obo+oDHP2RiFRrQIQgw6B6Q+P54IXZOMf6cenmi3odAUM2yaWfjdQ
         SIWg==
X-Gm-Message-State: AOAM532UfHHzfBkUOqUqhYQV+bxT9coJOtFYmllqf1aBp0zhBO37iUh+
        B5wD8+s7SaiXrJ+jb6S7zAqCdMJ8eNN0UA==
X-Google-Smtp-Source: ABdhPJyPaiDyFU7tG44Um7Jx3ufep8lkSmUZqj9UbbaTR1lXZxfbSmA4WBiG/WkdnfjfujqAQFHHEA==
X-Received: by 2002:a17:90a:6582:: with SMTP id k2mr9412813pjj.40.1599450350597;
        Sun, 06 Sep 2020 20:45:50 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id l123sm11099672pgl.24.2020.09.06.20.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 20:45:50 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 9/9] perf test: Free formats for perf pmu parse test
Date:   Mon,  7 Sep 2020 12:45:02 +0900
Message-Id: <20200907034502.753230-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200907034502.753230-1-namhyung@kernel.org>
References: <20200907034502.753230-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following leaks were detected by ASAN:

  Indirect leak of 360 byte(s) in 9 object(s) allocated from:
    #0 0x7fecc305180e in calloc (/lib/x86_64-linux-gnu/libasan.so.5+0x10780e)
    #1 0x560578f6dce5 in perf_pmu__new_format util/pmu.c:1333
    #2 0x560578f752fc in perf_pmu_parse util/pmu.y:59
    #3 0x560578f6a8b7 in perf_pmu__format_parse util/pmu.c:73
    #4 0x560578e07045 in test__pmu tests/pmu.c:155
    #5 0x560578de109b in run_test tests/builtin-test.c:410
    #6 0x560578de109b in test_and_print tests/builtin-test.c:440
    #7 0x560578de401a in __cmd_test tests/builtin-test.c:661
    #8 0x560578de401a in cmd_test tests/builtin-test.c:807
    #9 0x560578e49354 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
    #10 0x560578ce71a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
    #11 0x560578ce71a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
    #12 0x560578ce71a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
    #13 0x7fecc2b7acc9 in __libc_start_main ../csu/libc-start.c:308

Fixes: cff7f956ec4a1 ("perf tests: Move pmu tests into separate object")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/pmu.c |  1 +
 tools/perf/util/pmu.c  | 11 +++++++++++
 tools/perf/util/pmu.h  |  1 +
 3 files changed, 13 insertions(+)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 5c11fe2b3040..714e6830a758 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -173,6 +173,7 @@ int test__pmu(struct test *test __maybe_unused, int subtest __maybe_unused)
 		ret = 0;
 	} while (0);
 
+	perf_pmu__del_formats(&formats);
 	test_format_dir_put(format);
 	return ret;
 }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 555cb3524c25..d41caeb35cf6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1354,6 +1354,17 @@ void perf_pmu__set_format(unsigned long *bits, long from, long to)
 		set_bit(b, bits);
 }
 
+void perf_pmu__del_formats(struct list_head *formats)
+{
+	struct perf_pmu_format *fmt, *tmp;
+
+	list_for_each_entry_safe(fmt, tmp, formats, list) {
+		list_del(&fmt->list);
+		free(fmt->name);
+		free(fmt);
+	}
+}
+
 static int sub_non_neg(int a, int b)
 {
 	if (b > a)
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index b63c4c5e335e..a64e9c9ce731 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -94,6 +94,7 @@ int perf_pmu__new_format(struct list_head *list, char *name,
 			 int config, unsigned long *bits);
 void perf_pmu__set_format(unsigned long *bits, long from, long to);
 int perf_pmu__format_parse(char *dir, struct list_head *head);
+void perf_pmu__del_formats(struct list_head *formats);
 
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
-- 
2.28.0.526.ge36021eeef-goog


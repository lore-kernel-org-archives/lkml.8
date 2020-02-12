Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E40AC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFEC20724
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="STO8HDkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgBLOAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:00:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35952 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgBLOAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:00:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so2580912wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 06:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n3+13tIKTDO43P03qEQWz4Nr4xrTb2HjHzMbiw8Y1no=;
        b=STO8HDkTM/llblvCu5xNJ5PHGWn5qt5gn4AsCxw2m+xsQo7V4i5WVDv74Gyr1VBvdx
         oYgR8QHRfs2fscm8j2jjzApk7LiwG8raJ5cbqbvABIrcfcox39IX+0TLnzGHdC5ptLXu
         hgQyss3zQc0c72APgC8UrAhckZWc6aVwhnLcwSPpE80f7sxdwBcGEdV9bf7pQ0bTUMYi
         zsIySlxRpgaRfFn8fbENPbnTUuI/bQ4XuLfCrPjFr5aJwiiEL/O+CNtbDOH9/sZE957x
         9rXciZUl1GXD0P1y0dr4U77pV21uUTuFoJiNE6TR27dw16KaMaNI6goHbs9cu6oK7HhZ
         u1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n3+13tIKTDO43P03qEQWz4Nr4xrTb2HjHzMbiw8Y1no=;
        b=E50WSxI8V93irDiSOtG6hwQWbho3OgzJ30JNJgYPTs25acplkgGzlL917xcDa85jW+
         lu6Eg4M8fUdq4XXeMXCA3Yc8bUDIrchvGvwicvCnB4gbgJiFDRuu/Ao19ynHfSInR8Qv
         pCWcBXJS+Tov39dckiTGjnJsydbz2alJ/LqEghmPg3lPNapo/JoNouq7FR9/oE96ZheM
         gqmVmZd2wmBaLVS+0G9UXPNR4i1tNZS1fwQZb/ZEUs6/+6wYPmmuwiAAu0ZjfzR216t9
         1uxKTyQdGk+Yvz9zoXzO20+ZmMeV6uWhnsQSPwNIRfJV+u64JbDn/s61bZRRlhyxi1yv
         idIQ==
X-Gm-Message-State: APjAAAW9pwMYoYfaUug/TxRZYJbw3lWwBUjuVUhAhOhVKzRKB3Ld65Gw
        F7LxhiYu5Gv9egEMhZGjQlYv1g==
X-Google-Smtp-Source: APXvYqxm4ipUGduLevWwoiijnkjuyD6K6bNZolT+FtOLldoOcm0yjRD8ZM1F5mCUyCpm7yhgk6rmUg==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr12707947wma.31.1581516048180;
        Wed, 12 Feb 2020 06:00:48 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s23sm802694wra.15.2020.02.12.06.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 06:00:46 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, avagin@gmail.com,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>, Shuah Khan <skhan@kernel.org>
Subject: [PATCH] selftests: use LDLIBS for libraries instead of LDFLAGS
Date:   Wed, 12 Feb 2020 14:00:40 +0000
Message-Id: <20200212140040.126747-1-dima@arista.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While building selftests, the following errors were observed:
> tools/testing/selftests/timens'
> gcc -Wall -Werror -pthread  -lrt -ldl  timens.c  -o tools/testing/selftests/timens/timens
> /usr/bin/ld: /tmp/ccGy5CST.o: in function `check_config_posix_timers':
> timens.c:(.text+0x65a): undefined reference to `timer_create'
> collect2: error: ld returned 1 exit status

Quoting commit 870f193d48c2 ("selftests: net: use LDLIBS instead of
LDFLAGS"):

The default Makefile rule looks like:

$(CC) $(CFLAGS) $(LDFLAGS) $@ $^ $(LDLIBS)

When linking is done by gcc itself, no issue, but when it needs to be passed
to proper ld, only LDLIBS follows and then ld cannot know what libs to link
with.

More detail:
https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html

LDFLAGS
Extra flags to give to compilers when they are supposed to invoke the linker,
‘ld’, such as -L. Libraries (-lfoo) should be added to the LDLIBS variable
instead.

LDLIBS
Library flags or names given to compilers when they are supposed to invoke the
linker, ‘ld’. LOADLIBES is a deprecated (but still supported) alternative to
LDLIBS. Non-library linker flags, such as -L, should go in the LDFLAGS
variable.

While at here, correct other selftests, not only timens ones.

Reported-by: Shuah Khan <skhan@kernel.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 tools/testing/selftests/net/Makefile              | 4 ++--
 tools/testing/selftests/rtc/Makefile              | 2 +-
 tools/testing/selftests/timens/Makefile           | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 30996306cabc..23207829ec75 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../
 CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES)
-LDFLAGS := $(LDFLAGS) -pthread -lrt
+LDLIBS := -lpthread -lrt
 
 HEADERS := \
 	../include/futextest.h \
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b5694196430a..287ae916ec0b 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -27,5 +27,5 @@ KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
-$(OUTPUT)/tcp_mmap: LDFLAGS += -lpthread
-$(OUTPUT)/tcp_inq: LDFLAGS += -lpthread
+$(OUTPUT)/tcp_mmap: LDLIBS += -lpthread
+$(OUTPUT)/tcp_inq: LDLIBS += -lpthread
diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
index de9c8566672a..2d93d65723c9 100644
--- a/tools/testing/selftests/rtc/Makefile
+++ b/tools/testing/selftests/rtc/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -O3 -Wl,-no-as-needed -Wall
-LDFLAGS += -lrt -lpthread -lm
+LDLIBS += -lrt -lpthread -lm
 
 TEST_GEN_PROGS = rtctest
 
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index e9fb30bd8aeb..b4fd9a934654 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -2,6 +2,6 @@ TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec
 TEST_GEN_PROGS_EXTENDED := gettime_perf
 
 CFLAGS := -Wall -Werror -pthread
-LDFLAGS := -lrt -ldl
+LDLIBS := -lrt -ldl
 
 include ../lib.mk
-- 
2.25.0


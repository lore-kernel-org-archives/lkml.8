Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B42C3F2CE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464D2205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SY8v3/6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCQIdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:33:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:42498 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbgCQIc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584433977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LnTpb9OQdM3L6h0z4phaAe+x7LNhQqoqwFEnWzNKd4s=;
        b=SY8v3/6esEzzPCHR3LVYZeGztG/KOayjp+SjTmbGp/qZ4U56Zp89d+F7O/KaJKzyH9jsWp
        q3L5Y8PZfHE+tvBG7wexGYFBC3Tj4MRKFkb/Mygn3hZyWN1vz4PqtqpXSKg1YsMO2KZh7p
        Xrokahfk1gzwLEqVrYv2VrpPZDpOGzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-4CuMaePIOaah8csJytRpZw-1; Tue, 17 Mar 2020 04:32:56 -0400
X-MC-Unique: 4CuMaePIOaah8csJytRpZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 571A3100550D;
        Tue, 17 Mar 2020 08:32:54 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-112-179.ams2.redhat.com [10.36.112.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C932F60BF3;
        Tue, 17 Mar 2020 08:32:51 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4/4] selftests: add clone3() in time namespace test
Date:   Tue, 17 Mar 2020 09:30:44 +0100
Message-Id: <20200317083043.226593-5-areber@redhat.com>
In-Reply-To: <20200317083043.226593-1-areber@redhat.com>
References: <20200317083043.226593-1-areber@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a test to use clone3() with CLONE_NEWTIME. The test tries to
set CLOCK_BOOTTIME to 1 in the new process in the new time namespace and
CLOCK_MONOTONIC to +10000.

Signed-off-by: Adrian Reber <areber@redhat.com>
---
 tools/testing/selftests/timens/Makefile |   4 +-
 tools/testing/selftests/timens/clone3.c | 134 ++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/timens/clone3.c

diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/self=
tests/timens/Makefile
index b4fd9a934654..4a50c326bdab 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,7 +1,7 @@
-TEST_GEN_PROGS :=3D timens timerfd timer clock_nanosleep procfs exec
+TEST_GEN_PROGS :=3D timens timerfd timer clock_nanosleep procfs exec clo=
ne3
 TEST_GEN_PROGS_EXTENDED :=3D gettime_perf
=20
-CFLAGS :=3D -Wall -Werror -pthread
+CFLAGS :=3D -Wall -Werror -pthread -I../../../../usr/include/
 LDLIBS :=3D -lrt -ldl
=20
 include ../lib.mk
diff --git a/tools/testing/selftests/timens/clone3.c b/tools/testing/self=
tests/timens/clone3.c
new file mode 100644
index 000000000000..212b35d43fa5
--- /dev/null
+++ b/tools/testing/selftests/timens/clone3.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <sched.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "log.h"
+#include "timens.h"
+
+#define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
+
+struct set_timens_offset {
+	int clockid;
+	struct timespec val;
+};
+
+static void child_exit(int ret)
+{
+	fflush(stdout);
+	fflush(stderr);
+	_exit(ret);
+}
+
+static pid_t sys_clone3(struct clone_args *args, size_t size)
+{
+	fflush(stdout);
+	fflush(stderr);
+	return syscall(__NR_clone3, args, size);
+}
+
+int main(int argc, char *argv[])
+{
+	struct set_timens_offset timens_offset[2];
+	struct timespec monotonic;
+	struct timespec boottime;
+	pid_t pid =3D -1;
+	int ret =3D 0;
+	int status;
+
+	struct clone_args args =3D {
+		.flags =3D CLONE_NEWTIME,
+		.exit_signal =3D SIGCHLD,
+	};
+
+	nscheck();
+
+	ksft_set_plan(1);
+
+	ret =3D clock_gettime(CLOCK_MONOTONIC, &monotonic);
+	if (ret)
+		goto out;
+
+	ret =3D clock_gettime(CLOCK_BOOTTIME, &boottime);
+	if (ret)
+		goto out;
+
+	/* Set CLOCK_BOOTTIME to be 1 (sec). */
+	timens_offset[0].clockid =3D CLOCK_BOOTTIME;
+	timens_offset[0].val.tv_sec =3D -boottime.tv_sec + 1;
+	timens_offset[0].val.tv_nsec =3D 42;
+	/* Set CLOCK_MONOTONIC to be 10000 (sec) larger than current. */
+	timens_offset[1].clockid =3D CLOCK_MONOTONIC;
+	timens_offset[1].val.tv_sec =3D 10000;
+	timens_offset[1].val.tv_nsec =3D 37;
+
+	args.timens_offset_size =3D 2;
+	args.timens_offset =3D ptr_to_u64(timens_offset);
+
+	pid =3D sys_clone3(&args, sizeof(struct clone_args));
+	if (pid < 0) {
+		ksft_print_msg("%s - Failed to create new process\n",
+			       strerror(errno));
+		ret =3D -errno;
+		goto out;
+	}
+
+	if (pid =3D=3D 0) {
+		struct timespec monotonic_in_ns;
+		struct timespec boottime_in_ns;
+
+		ksft_print_msg("I am the child, my PID is %d\n", getpid());
+		if (clock_gettime(CLOCK_MONOTONIC, &monotonic_in_ns))
+			return -1;
+
+		if (clock_gettime(CLOCK_BOOTTIME, &boottime_in_ns))
+			return -1;
+
+		/*
+		 * CLOCK_BOOTTIME has been set to such an offset to
+		 * be 1 in the time namespace after clone3().
+		 */
+		if (boottime_in_ns.tv_sec > 5)
+			child_exit(EXIT_FAILURE);
+		ksft_print_msg("CLOCK_BOOTTIME %ld\n", boottime_in_ns.tv_sec);
+		if (monotonic_in_ns.tv_sec <=3D monotonic.tv_sec + 9998)
+			child_exit(EXIT_FAILURE);
+		ksft_print_msg("CLOCK_MONOTONIC %ld\n", monotonic_in_ns.tv_sec);
+		child_exit(EXIT_SUCCESS);
+	}
+
+	if (waitpid(pid, &status, 0) < 0) {
+		ksft_print_msg("Child returned %s\n", strerror(errno));
+		ret =3D -errno;
+		goto out;
+	}
+
+	if (!WIFEXITED(status)) {
+		ret =3D -1;
+		ksft_test_result_fail("Child clocks in time NS are wrong\n");
+		goto out;
+	}
+
+	if (WEXITSTATUS(status)) {
+		ret =3D -1;
+		ksft_test_result_fail("Child clocks in time NS are wrong\n");
+		goto out;
+	}
+
+	ret =3D 0;
+	ksft_test_result_pass("Clocks set successfully with clone3()\n");
+out:
+	if (ret)
+		ksft_exit_fail();
+
+	ksft_exit_pass();
+	return !!ret;
+}
--=20
2.24.1


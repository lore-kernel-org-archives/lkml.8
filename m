Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17660C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D3D207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594399938;
	bh=ywSwLeB8+9JlN7dFMnrx1nBTlfQXT0bNlfg5jfyoHR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GDppyKNmPut+lRn4ji0P6tLa+R1nA+rPTcLYDKgQJ4VKEndyVkMlfmt7O9lXHy1Oz
	 jxoAA6wKc8jHxX2zIcrQSekXHTk/1JHEj5198/fZmQg+GzhTbNFGX1YRmRzh253GLR
	 yWKzko+vO9GJybMI/BCig7iHKX0HlNVAt7NwN15Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgGJQwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgGJQwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:52:16 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 971D2207BB;
        Fri, 10 Jul 2020 16:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594399935;
        bh=ywSwLeB8+9JlN7dFMnrx1nBTlfQXT0bNlfg5jfyoHR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6+mvWAuHYBD9EQOfbrVCnBXyUKADom5uxLA0XAZj634c/JLz1rMQvYgsWgLq9Q8R
         eKal9rHQ4ZWI1MUEHU1vt7Bd0DBnir6bosbFJcZpKU2c4tYpRlLpzC96wK+KJvYkO/
         YAqMGiQwatY6vybt44z+KcEMoS+djRMpoZwc+DIg=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Joel Fernandes <joelaf@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Xiao Yang <ice_yangxiao@163.com>
Subject: [PATCH v3 01/19] tools: bpf: Use local copy of headers including uapi/linux/filter.h
Date:   Fri, 10 Jul 2020 17:51:45 +0100
Message-Id: <20200710165203.31284-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pulling header files directly out of the kernel sources for inclusion in
userspace programs is highly error prone, not least because it bypasses
the kbuild infrastructure entirely and so may end up referencing other
header files that have not been generated.

Subsequent patches will cause compiler.h to pull in the ungenerated
asm/rwonce.h file via filter.h, breaking the build for tools/bpf:

  | $ make -C tools/bpf
  | make: Entering directory '/linux/tools/bpf'
  |   CC       bpf_jit_disasm.o
  |   LINK     bpf_jit_disasm
  |   CC       bpf_dbg.o
  | In file included from /linux/include/uapi/linux/filter.h:9,
  |                  from /linux/tools/bpf/bpf_dbg.c:41:
  | /linux/include/linux/compiler.h:247:10: fatal error: asm/rwonce.h: No such file or directory
  |  #include <asm/rwonce.h>
  |           ^~~~~~~~~~~~~~
  | compilation terminated.
  | make: *** [Makefile:61: bpf_dbg.o] Error 1
  | make: Leaving directory '/linux/tools/bpf'

Take a copy of the installed version of linux/filter.h  (i.e. the one
created by the 'headers_install' target) into tools/include/uapi/linux/
and adjust the BPF tool Makefile to reference the local include
directories instead of those in the main source tree.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Reported-by: Xiao Yang <ice_yangxiao@163.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 tools/bpf/Makefile                |  3 +-
 tools/include/uapi/linux/filter.h | 90 +++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 tools/include/uapi/linux/filter.h

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index 6df1850f8353..8a69258fd8aa 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -9,7 +9,8 @@ MAKE = make
 INSTALL ?= install
 
 CFLAGS += -Wall -O2
-CFLAGS += -D__EXPORTED_HEADERS__ -I$(srctree)/include/uapi -I$(srctree)/include
+CFLAGS += -D__EXPORTED_HEADERS__ -I$(srctree)/tools/include/uapi \
+	  -I$(srctree)/tools/include
 
 # This will work when bpf is built in tools env. where srctree
 # isn't set and when invoked from selftests build, where srctree
diff --git a/tools/include/uapi/linux/filter.h b/tools/include/uapi/linux/filter.h
new file mode 100644
index 000000000000..eaef459e7bd4
--- /dev/null
+++ b/tools/include/uapi/linux/filter.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Linux Socket Filter Data Structures
+ */
+
+#ifndef __LINUX_FILTER_H__
+#define __LINUX_FILTER_H__
+
+
+#include <linux/types.h>
+#include <linux/bpf_common.h>
+
+/*
+ * Current version of the filter code architecture.
+ */
+#define BPF_MAJOR_VERSION 1
+#define BPF_MINOR_VERSION 1
+
+/*
+ *	Try and keep these values and structures similar to BSD, especially
+ *	the BPF code definitions which need to match so you can share filters
+ */
+ 
+struct sock_filter {	/* Filter block */
+	__u16	code;   /* Actual filter code */
+	__u8	jt;	/* Jump true */
+	__u8	jf;	/* Jump false */
+	__u32	k;      /* Generic multiuse field */
+};
+
+struct sock_fprog {	/* Required for SO_ATTACH_FILTER. */
+	unsigned short		len;	/* Number of filter blocks */
+	struct sock_filter *filter;
+};
+
+/* ret - BPF_K and BPF_X also apply */
+#define BPF_RVAL(code)  ((code) & 0x18)
+#define         BPF_A           0x10
+
+/* misc */
+#define BPF_MISCOP(code) ((code) & 0xf8)
+#define         BPF_TAX         0x00
+#define         BPF_TXA         0x80
+
+/*
+ * Macros for filter block array initializers.
+ */
+#ifndef BPF_STMT
+#define BPF_STMT(code, k) { (unsigned short)(code), 0, 0, k }
+#endif
+#ifndef BPF_JUMP
+#define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
+#endif
+
+/*
+ * Number of scratch memory words for: BPF_ST and BPF_STX
+ */
+#define BPF_MEMWORDS 16
+
+/* RATIONALE. Negative offsets are invalid in BPF.
+   We use them to reference ancillary data.
+   Unlike introduction new instructions, it does not break
+   existing compilers/optimizers.
+ */
+#define SKF_AD_OFF    (-0x1000)
+#define SKF_AD_PROTOCOL 0
+#define SKF_AD_PKTTYPE 	4
+#define SKF_AD_IFINDEX 	8
+#define SKF_AD_NLATTR	12
+#define SKF_AD_NLATTR_NEST	16
+#define SKF_AD_MARK 	20
+#define SKF_AD_QUEUE	24
+#define SKF_AD_HATYPE	28
+#define SKF_AD_RXHASH	32
+#define SKF_AD_CPU	36
+#define SKF_AD_ALU_XOR_X	40
+#define SKF_AD_VLAN_TAG	44
+#define SKF_AD_VLAN_TAG_PRESENT 48
+#define SKF_AD_PAY_OFFSET	52
+#define SKF_AD_RANDOM	56
+#define SKF_AD_VLAN_TPID	60
+#define SKF_AD_MAX	64
+
+#define SKF_NET_OFF	(-0x100000)
+#define SKF_LL_OFF	(-0x200000)
+
+#define BPF_NET_OFF	SKF_NET_OFF
+#define BPF_LL_OFF	SKF_LL_OFF
+
+#endif /* __LINUX_FILTER_H__ */
-- 
2.27.0.383.g050319c2ae-goog


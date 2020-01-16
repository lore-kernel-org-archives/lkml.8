Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172F1C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF79720661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXEU91qB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgAPNWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:22:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25510 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726994AbgAPNWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579180940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzqQE7mWfqS9gbpZpl6m88cnGx3MlkQu/XGO40kZXJg=;
        b=UXEU91qBsZH2Yae4zANsgldAmEGv1qjlKfmtl4HP3DXb+1RxwCn0uYBpiybS7hskg4RzW7
        n2Qw/LNyFeCIZ8zqjQ9HG4GUkIMYKomYgltlvrHH1fkUII5gs+4yVbxzeRMTFw0uVYTly0
        aHMw/1M6ZpyZo1Aqr+ZbTiUeCuwzXMQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-jy2sBboYP1Wsn-3jN7-amg-1; Thu, 16 Jan 2020 08:22:17 -0500
X-MC-Unique: jy2sBboYP1Wsn-3jN7-amg-1
Received: by mail-lj1-f199.google.com with SMTP id f19so5149884ljm.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 05:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gzqQE7mWfqS9gbpZpl6m88cnGx3MlkQu/XGO40kZXJg=;
        b=JhhS7TRJSHaw7V7C8uNvN0wvt0/Qax9tJkL6g37aIhbEZqjlEoun6P5cFCEblwsTI5
         DsbWsQ7Gb+Mzn/l9xA452q+JgDNzQukG9ft2iY9//yQxHN1eAYfAuF+esbCCqm5sRI6V
         lVjf/zJpUI4+tL7Vkdm7u+LvBykaxE3yhPTupfIbfDKFIG5X/Fq2DiY3FXjPPE8DvgXm
         ONKTRsAWN86fXauq+ZVFmiC+q0s3MOkvT+xFl+Fq/q39l6TYaL/FAbUi3m3Sno6LDdEf
         lNiLc4ucx9uzHDKAnb2GgRMatpU4VE6V47pCSqE0/0mN7aGEKdLzn9Trjxb1hbdJurII
         zccA==
X-Gm-Message-State: APjAAAUOHrFDAEsUvscOjpTi/p0uRSVN7LZrFT2tz4JryAYc+aViqLtR
        VxrRXXpRhcgS5D/e7oq8zIrBD8pQMH/H69CZMIoV2NQk8cc4khOwQhUKQfsUWnxi6UKEKqdn/gP
        8Hf5HoyBRW8JUqh5lKQVeYsNj
X-Received: by 2002:a2e:2c16:: with SMTP id s22mr2305739ljs.248.1579180936040;
        Thu, 16 Jan 2020 05:22:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFm8TdvoRQDWtY2lKrbQQl1O6xAPqlYnDABHlUDuyNgLz95SjjEtdQljJ8ty7d3yotxnb3Rg==
X-Received: by 2002:a2e:2c16:: with SMTP id s22mr2305732ljs.248.1579180935891;
        Thu, 16 Jan 2020 05:22:15 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id n3sm10612990lfk.61.2020.01.16.05.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:22:15 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 03CC51804D8; Thu, 16 Jan 2020 14:22:14 +0100 (CET)
Subject: [PATCH bpf-next v3 02/11] tools/bpf/runqslower: Fix override option
 for VMLINUX_BTF
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Thu, 16 Jan 2020 14:22:13 +0100
Message-ID: <157918093389.1357254.10041649215380772130.stgit@toke.dk>
In-Reply-To: <157918093154.1357254.7616059374996162336.stgit@toke.dk>
References: <157918093154.1357254.7616059374996162336.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

The runqslower tool refuses to build without a file to read vmlinux BTF
from. The build fails with an error message to override the location by
setting the VMLINUX_BTF variable if autodetection fails. However, the
Makefile doesn't actually work with that override - the error message is
still emitted.

Fix this by including the value of VMLINUX_BTF in the expansion, and only
emitting the error message if the *result* is empty. Also permit running
'make clean' even though no VMLINUX_BTF is set.

Fixes: 9c01546d26d2 ("tools/bpf: Add runqslower tool to tools/bpf")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/runqslower/Makefile |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index cff2fbcd29a8..89fb7cd30f1a 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -10,12 +10,14 @@ CFLAGS := -g -Wall
 
 # Try to detect best kernel BTF source
 KERNEL_REL := $(shell uname -r)
-ifneq ("$(wildcard /sys/kernel/btf/vmlinux)","")
-VMLINUX_BTF := /sys/kernel/btf/vmlinux
-else ifneq ("$(wildcard /boot/vmlinux-$(KERNEL_REL))","")
-VMLINUX_BTF := /boot/vmlinux-$(KERNEL_REL)
-else
-$(error "Can't detect kernel BTF, use VMLINUX_BTF to specify it explicitly")
+VMLINUX_BTF_PATHS := $(VMLINUX_BTF) /sys/kernel/btf/vmlinux /boot/vmlinux-$(KERNEL_REL)
+VMLINUX_BTF_PATH := $(firstword $(wildcard $(VMLINUX_BTF_PATHS)))
+
+ifeq ("$(VMLINUX_BTF_PATH)","")
+ifneq ($(MAKECMDGOALS),clean)
+$(error Could not find kernel BTF file (tried: $(VMLINUX_BTF_PATHS)). \
+	Try setting $$VMLINUX_BTF)
+endif
 endif
 
 abs_out := $(abspath $(OUTPUT))
@@ -67,9 +69,9 @@ $(OUTPUT):
 	$(call msg,MKDIR,$@)
 	$(Q)mkdir -p $(OUTPUT)
 
-$(OUTPUT)/vmlinux.h: $(VMLINUX_BTF) | $(OUTPUT) $(BPFTOOL)
+$(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BPFTOOL)
 	$(call msg,GEN,$@)
-	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
 
 $(OUTPUT)/libbpf.a: | $(OUTPUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \


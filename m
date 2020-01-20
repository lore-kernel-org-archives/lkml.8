Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D5AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B75622314
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4wtEJaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgATNN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:13:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51710 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727740AbgATNN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579526005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nX6gCvToHh/M+ufmuZNkVcVbY/LiP2p5Z5znXTQZT8=;
        b=P4wtEJawlku4ISmhdMp/g/gAQSkarssDjVlc1V5LD4kyzRliEOmLc5QrSecem6CG/bpJWK
        mDsnICKX10miuF+UV3mOCDyYQgQETGjCLG7Cv8r5o49+Mb1Hs8EMeiWCSuZ9yq7T9tHxau
        Tjw6oQLXlp2jrAUaRvIAus5oyC58o84=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-5jpL76AaNhaH3DLGvS9_IQ-1; Mon, 20 Jan 2020 08:13:24 -0500
X-MC-Unique: 5jpL76AaNhaH3DLGvS9_IQ-1
Received: by mail-ed1-f72.google.com with SMTP id n18so21821859edo.17
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 05:13:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7nX6gCvToHh/M+ufmuZNkVcVbY/LiP2p5Z5znXTQZT8=;
        b=rmHPCPYvAMFTFj78qKDhgxU6WZOMIDz1BG9q+u+IfM9DB4P9RBEwEn5ekRETuV27/7
         hYuqvtC5Kodpf5B2P5xQMcNkIymlPQUoe8MRDkZpjO6ZaXnCc7CW5OMQSD+YheeDQa9P
         JoLpcAEqYwfyFd5jcHN108bNWFHQh5H6PcNdQGNwmikxWPDU3BELdRkXkY9cov086C/Y
         BEfpWn23Z5yHS5tu+k5E58Yb8BEr26VsyMAmMqEDXQULMVHZfRo0gUSlv6tE4Z3e5QhH
         4IQh6IJcqj25XiiXLOfq2n8oAc+42a1Z63YwS81dTPtZtLpkePax020FF3GH0y54rBR8
         KbQQ==
X-Gm-Message-State: APjAAAW46+70zNydz3kqTtRiblUtk+Ua+M75EsstT3taMcdKb3UmNsjQ
        9hZsFXIDAyzqQteRqiVbYWHqLrTLpUi/3U6jqloY/2oMCmrZ6cF35kQwGAOlbE4MMAKjoXc4VDw
        s6wOTXrBRSnaL1nQOA2hyfDVY
X-Received: by 2002:a17:906:7c5a:: with SMTP id g26mr19565117ejp.249.1579525999573;
        Mon, 20 Jan 2020 05:13:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqx0QP6IDZi2QN6qajrJveTlJj75I05ZuYUObj5tdnbOi4mrACFD11iCcZbt/l4zWfp+Ir1i2Q==
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr13842833ljq.109.1579525998002;
        Mon, 20 Jan 2020 05:13:18 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id z3sm16867876ljh.83.2020.01.20.05.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 05:13:16 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 709ED1804D6; Mon, 20 Jan 2020 14:06:51 +0100 (CET)
Subject: [PATCH bpf-next v5 10/11] runsqslower: Support user-specified libbpf
 include and object paths
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
Date:   Mon, 20 Jan 2020 14:06:51 +0100
Message-ID: <157952561135.1683545.5660339645093141381.stgit@toke.dk>
In-Reply-To: <157952560001.1683545.16757917515390545122.stgit@toke.dk>
References: <157952560001.1683545.16757917515390545122.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This adds support for specifying the libbpf include and object paths as
arguments to the runqslower Makefile, to support reusing the libbpf version
built as part of the selftests.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/runqslower/Makefile |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index b90044caf270..faf5418609ea 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -6,7 +6,9 @@ LLVM_STRIP := llvm-strip
 DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 LIBBPF_SRC := $(abspath ../../lib/bpf)
-INCLUDES := -I$(OUTPUT) -I$(abspath ../../lib)
+BPFOBJ := $(OUTPUT)/libbpf.a
+BPF_INCLUDE := $(OUTPUT)
+INCLUDES := -I$(BPF_INCLUDE) -I$(OUTPUT) -I$(abspath ../../lib)
 CFLAGS := -g -Wall
 
 # Try to detect best kernel BTF source
@@ -37,7 +39,7 @@ clean:
 	$(call msg,CLEAN)
 	$(Q)rm -rf $(OUTPUT) runqslower
 
-$(OUTPUT)/runqslower: $(OUTPUT)/runqslower.o $(OUTPUT)/libbpf.a
+$(OUTPUT)/runqslower: $(OUTPUT)/runqslower.o $(BPFOBJ)
 	$(call msg,BINARY,$@)
 	$(Q)$(CC) $(CFLAGS) -lelf -lz $^ -o $@
 
@@ -50,7 +52,7 @@ $(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
 	$(call msg,GEN-SKEL,$@)
 	$(Q)$(BPFTOOL) gen skeleton $< > $@
 
-$(OUTPUT)/%.bpf.o: %.bpf.c $(OUTPUT)/libbpf.a | $(OUTPUT)
+$(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BPF,$@)
 	$(Q)$(CLANG) -g -O2 -target bpf $(INCLUDES)			      \
 		 -c $(filter %.c,$^) -o $@ &&				      \
@@ -73,9 +75,9 @@ $(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BPFTOOL)
 	fi
 	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
 
-$(OUTPUT)/libbpf.a: | $(OUTPUT)
+$(BPFOBJ): | $(OUTPUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \
-		    OUTPUT=$(abs_out)/ $(abs_out)/libbpf.a
+		    OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
 
 $(DEFAULT_BPFTOOL):
 	$(Q)$(MAKE) $(submake_extras) -C ../bpftool			      \


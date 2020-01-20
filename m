Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7A5C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A296521D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6N1aw1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgATNGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:06:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27315 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728665AbgATNGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579525608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MkLSYm3mzAZXDQgD2SVlnhnv45Ao3CBk7NzaRvQfH7U=;
        b=h6N1aw1ubvrOW7G/ysDHROfT28oEufwwPWGsJlAh84H+szBE/QZp2vaYy3MgJtFDPzapAx
        p26sOUz2hIzznXG3QbFzfehKKEFkYg74WSn4Gw2v/+tPy4Y4h6+yWLbTRdjZ2bad+cD8/Y
        Yd65urD5zM7fvSl8FoxX0bPVQIrKBOo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-eYeP2XdAOZa7b_d0BbWgDg-1; Mon, 20 Jan 2020 08:06:47 -0500
X-MC-Unique: eYeP2XdAOZa7b_d0BbWgDg-1
Received: by mail-lf1-f70.google.com with SMTP id y4so6234441lfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 05:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MkLSYm3mzAZXDQgD2SVlnhnv45Ao3CBk7NzaRvQfH7U=;
        b=B0PsjlaMrl6w3ntOKT4e/guu/1l94rlMv02Ifmuunp7HFvUz1ZTEmE5XckZhVRQn6x
         f3Jb8GD2acl0f9vJBvjw18zl1saJAJtjRxpDh2x93wMl+G5Hcn381DwQ+uwmZTsHhUHe
         A/rvukq7MjQYVIEdEzvBZ4HWWFftjZ1Uwg0eX4A+pK807ShAEpAvg3Hj+5SaSCpEJkFm
         leIblsEpgryMrxQgxHsPa8+fLytxG0L4J2GSwC+mOSfXjvKJeUxkI4Kf/dKN45pe+zMV
         C5iZm2c7GW/8ef1Ltoe0di88yfvQSaKDM18EGjMh1YmLdGmnhsSjL4lez0q13Z8aJ96e
         z4BQ==
X-Gm-Message-State: APjAAAV/WbqizOvuOqhZofv5vVp8OdDZk3f44igxQ0nRTdB74uQ7OVWI
        4F0SjFKP32mdiczxFe8HVSL3NRFLqdkFGCUEDpN3Q03td58xgPQbZPrA879yTYwb3IeL/8N7tM9
        RVkviidDef7EpcAvkMkqO7JEX
X-Received: by 2002:ac2:5e2e:: with SMTP id o14mr7404716lfg.198.1579525605660;
        Mon, 20 Jan 2020 05:06:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxFiThs7woU8NNE+Z3Xi+dI52IZDR8cAEXZMjePibrZkF51mtKKwxYoZzZkPgd0sMDCRYfMg==
X-Received: by 2002:ac2:5e2e:: with SMTP id o14mr7404688lfg.198.1579525605362;
        Mon, 20 Jan 2020 05:06:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id b22sm20503583lji.99.2020.01.20.05.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 05:06:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 89C7B1804D7; Mon, 20 Jan 2020 14:06:43 +0100 (CET)
Subject: [PATCH bpf-next v5 03/11] selftests: Pass VMLINUX_BTF to runqslower
 Makefile
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
Date:   Mon, 20 Jan 2020 14:06:43 +0100
Message-ID: <157952560344.1683545.2723631988771664417.stgit@toke.dk>
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

Add a VMLINUX_BTF variable with the locally-built path when calling the
runqslower Makefile from selftests. This makes sure a simple 'make'
invocation in the selftests dir works even when there is no BTF information
for the running kernel. Do a wildcard expansion and include the same paths
for BTF for the running kernel as in the runqslower Makefile, to make it
possible to build selftests without having a vmlinux in the local tree.

Also fix the make invocation to use $(OUTPUT)/tools as the destination
directory instead of $(CURDIR)/tools.

Fixes: 3a0d3092a4ed ("selftests/bpf: Build runqslower from selftests")
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/Makefile |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 246d09ffb296..8240282aef7f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -124,10 +124,14 @@ $(OUTPUT)/test_stub.o: test_stub.c
 	$(call msg,CC,,$@)
 	$(CC) -c $(CFLAGS) -o $@ $<
 
+VMLINUX_BTF_PATHS := $(abspath ../../../../vmlinux)			\
+			       /sys/kernel/btf/vmlinux			\
+			       /boot/vmlinux-$(shell uname -r)
+VMLINUX_BTF:= $(firstword $(wildcard $(VMLINUX_BTF_PATHS)))
 .PHONY: $(OUTPUT)/runqslower
 $(OUTPUT)/runqslower: force
-	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	      \
-		    OUTPUT=$(CURDIR)/tools/
+	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	\
+		    OUTPUT=$(OUTPUT)/tools/ VMLINUX_BTF=$(VMLINUX_BTF)
 
 BPFOBJ := $(OUTPUT)/libbpf.a
 


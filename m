Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0F6C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFD524656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L01R6wDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgAOOM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:12:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55930 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729263AbgAOOM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579097576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B9j+W7gDIaDJz39H0dsQUAJSNrjtTec2FhMoAkHknrs=;
        b=L01R6wDjrJUa2jsqeMymFoujfwEFMGcv9qQD0H3KFU3ZBpCxuBrSTef7zY9XiRw2hL7OX7
        fbZL+nUOEGQj1nWQp81zBw4FFvOa+pniDb6OFZ6hKkNuxe13LXYIytZCR2m870tNhoEWzu
        whb/qzEcw2+7eXuF7GvT9iyx3DJkUTo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-Rkw1x_04OL2BIOXEs4TVwg-1; Wed, 15 Jan 2020 09:12:55 -0500
X-MC-Unique: Rkw1x_04OL2BIOXEs4TVwg-1
Received: by mail-lf1-f71.google.com with SMTP id t8so3246490lfc.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:12:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=B9j+W7gDIaDJz39H0dsQUAJSNrjtTec2FhMoAkHknrs=;
        b=iAyTM0Tdurq9cPiLjKRcRqRwMOH4sSEMsKWzlgUsnh9oEizWwJJ1kCSqAs/YNz0XMg
         gS8NgCT9Ld3dwj5+6nPYG+ouKJrLZHFefS4scoDhw4sVRDJEY5VjMRPMPYiiWAqgMEpY
         3Dt3LKG+3UZesGDVCvtPxkyPggjBSQR6R3dm8+YOYFaigZNwCLI3aeFbyhO6kPTExqju
         ANskpi5KD0YFensWlEi8Zo3qXnOsRdUvbRaenirLJDdpsdF4Q5Bumc19Fu9MU968muO0
         PSY0NAspnk3JgMnO20RAoFlHuRtZB3IeYG/b7wjHzAW5U1S3/PKR4OdIZgHSlsDicQvY
         AWmg==
X-Gm-Message-State: APjAAAV+ig5VsFVwcTqTEnlT8AyOeAcOnUbx/Y4bbyrZCizL0qzwxGK3
        HaqIl3W3XgPfqMMVoR8pzRNtr1YuDmZMVO3ien5qZG5xXi1Ul/pevD6P/cD9G4CUz4azYQfGlP/
        EAv9KmrwSn2Tf5rBRTyHDbX5x
X-Received: by 2002:a2e:a37c:: with SMTP id i28mr1772083ljn.118.1579097574010;
        Wed, 15 Jan 2020 06:12:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUW0Ep6uEXtLij//fHtTp+5adTa9pXL0f4oBHP8qleNZhf8ZN29IWsfrnAs2scQN/yNWVb2Q==
X-Received: by 2002:a2e:a37c:: with SMTP id i28mr1772066ljn.118.1579097573864;
        Wed, 15 Jan 2020 06:12:53 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p136sm9082048lfa.8.2020.01.15.06.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:12:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EE0AE1804D8; Wed, 15 Jan 2020 15:12:50 +0100 (CET)
Subject: [PATCH bpf-next v2 02/10] tools/bpf/runqslower: Fix override option
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
        Jakub Kicinski <jakub.kicinski@netronome.com>,
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
Date:   Wed, 15 Jan 2020 15:12:50 +0100
Message-ID: <157909757089.1192265.9038866294345740126.stgit@toke.dk>
In-Reply-To: <157909756858.1192265.6657542187065456112.stgit@toke.dk>
References: <157909756858.1192265.6657542187065456112.stgit@toke.dk>
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

Fix this by only doing auto-detection if no override is set. And while
we're at it, also look for a vmlinux file in the current kernel build dir
if none if found on the running kernel.

Fixes: 9c01546d26d2 ("tools/bpf: Add runqslower tool to tools/bpf")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/runqslower/Makefile |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index cff2fbcd29a8..fb93ce2bf2fe 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -10,12 +10,16 @@ CFLAGS := -g -Wall
 
 # Try to detect best kernel BTF source
 KERNEL_REL := $(shell uname -r)
-ifneq ("$(wildcard /sys/kernel/btf/vmlinux)","")
-VMLINUX_BTF := /sys/kernel/btf/vmlinux
-else ifneq ("$(wildcard /boot/vmlinux-$(KERNEL_REL))","")
-VMLINUX_BTF := /boot/vmlinux-$(KERNEL_REL)
-else
-$(error "Can't detect kernel BTF, use VMLINUX_BTF to specify it explicitly")
+ifeq ("$(VMLINUX_BTF)","")
+  ifneq ("$(wildcard /sys/kernel/btf/vmlinux)","")
+  VMLINUX_BTF := /sys/kernel/btf/vmlinux
+  else ifneq ("$(wildcard /boot/vmlinux-$(KERNEL_REL))","")
+  VMLINUX_BTF := /boot/vmlinux-$(KERNEL_REL)
+  else ifneq ("$(wildcard $(abspath ../../../vmlinux))","")
+  VMLINUX_BTF := $(abspath ../../../vmlinux)
+  else
+  $(error "Can't detect kernel BTF, use VMLINUX_BTF to specify it explicitly")
+  endif
 endif
 
 abs_out := $(abspath $(OUTPUT))


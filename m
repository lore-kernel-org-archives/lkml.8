Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4631C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F772467F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ET3oZ2P+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgA0Tf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:35:58 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:34045 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgA0Tf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:35:58 -0500
Received: by mail-pf1-f202.google.com with SMTP id q5so7070802pfh.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 11:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mpxskphRBvOL/qa3RNJEpkYJ77oom+hiyFZV6y60D5o=;
        b=ET3oZ2P+OposxBTl7gtdA6Ne/VXHBUyrqwzl0jGDJzwmMyX0YHWDh6L2Z/PjUFR+pA
         tpZ8asqoBERAcAX22VeGHr5NrLNIMcfpZy73ggI6GTAVcwket9PhWceGNwvpoxvzksWJ
         umz0SX/haxVNn9obja6wK0h0z1m7nwNVevw7hATItKgbeK2TsUNdaaeWnQgOkRpzZw4r
         D1dFvWpJrfizbMzfoDw6dyPMg0knyjjQwxa+MIjqq9juhhkGd1PEbFINGsBNQSGGS73P
         6g5+h/9UjUSXtnl1YivGXjehcSP1su39J3O875BLeSHjwgybSCXMjTgyrKmbVLpVzkY8
         RerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mpxskphRBvOL/qa3RNJEpkYJ77oom+hiyFZV6y60D5o=;
        b=I0KnANuFz2iTlXO6eYkaiFJy4egjyY0Edc/TlKHagNRZRx8JiHUSqnb6Dy4hL3OKJ3
         wvt4KWMOOoa3NZk08/Iop8ZFjc6XhQ+qP/Vc68geTsYsjQt/BKrQGQjrNX28dGkIxC41
         ZhsKIT7lzEHQFuukAGnYwuCZf8dVTQ4vAXtBO7VVkSlIFa1GebT+YdiAVRTqfzPt+T0I
         6J/eMBSqEZ4WV75ap4ctNF3zt9wKzmoVUOjn8zxU3ud7KA8ZlLgcNf/fJ9ugFltB1q6H
         EcaNLK3safXw/XvdaI1Wh5/Tcxo0rw4+JE0rAUaUsfXIgKvJGxSgd2cCLM45/x1KehL1
         7YAw==
X-Gm-Message-State: APjAAAVe87JxOfVzuN9h3gASTnqnG/Ph63Vw81m23lf9qj+YXJWd17/N
        o5sGuyB5+RBcLsKIms7LhI/Nim4g6JE/t2IJaDDiUQ==
X-Google-Smtp-Source: APXvYqwxbM0yx3aGLGJCvz0uurqo4GX5uxVBjWuqLdFaQGyTTcSVvraOd/hViBN5gxGGBSLQVqJdDtNEkYW1pHjmMZB2jg==
X-Received: by 2002:a63:4d4c:: with SMTP id n12mr21651459pgl.212.1580153757576;
 Mon, 27 Jan 2020 11:35:57 -0800 (PST)
Date:   Mon, 27 Jan 2020 11:35:47 -0800
Message-Id: <20200127193549.187419-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [RFC v1 0/2] arch: um: turn BTF_TYPEINFO support off
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        akpm@linux-foundation.org, changbin.du@intel.com,
        yamada.masahiro@socionext.com, rdunlap@infradead.org,
        keescook@chromium.org, andriy.shevchenko@linux.intel.com
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, heidifahim@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a part of my quest to get allyesconfig working on UML, I found a new
build error, with CONFIG_DEBUG_INFO_BTF=y:

scripts/link-vmlinux.sh: line 106: 17463 Segmentation fault      LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
objcopy: --change-section-vma .BTF=0x0000000000000000 never used
objcopy: --change-section-lma .BTF=0x0000000000000000 never used
objcopy: error: the input file '.btf.vmlinux.bin' is empty
Failed to generate BTF for vmlinux
Try to disable CONFIG_DEBUG_INFO_BTF
make: *** [Makefile:1078: vmlinux] Error 1

The most interesting bit seems to be the:

objcopy: error: the input file '.btf.vmlinux.bin' is empty

Thinking about it, I am not sure if it makes sense for UML to produce
BTF type information, so I proposed a fix here that:

 1. Adds the ability for architectures to turn BTF support off.
 2. Turns BTF support off for UML.

I am also totally fine with just saying that DEBUG_INFO_BTF
depends on !UML, but I figured people would prefer this approach more.

Brendan Higgins (2):
  kbuild: add arch specific dependency for BTF support
  arch: um: turn BTF_TYPEINFO support off

 arch/um/Kconfig   | 1 +
 lib/Kconfig.debug | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.25.0.341.g760bfbb309-goog


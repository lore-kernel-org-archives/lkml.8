Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09124C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D203220774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CE/JXgEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgC0P27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:28:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56645 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbgC0P26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585322936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LrVbKy832yQOEnKJUht0bMjtEexZGq0QyNpHi1sAYOs=;
        b=CE/JXgEoaYMiLYPkCSXHqcW6n1b0FHAco8l8RwJ8zuagRC5xjf9oURD8Y+Z4m7fDJyo60M
        v+QR5yG13lls2mbldtgQLe1uPyRDtYnb9a3XMgJ3XRaLoxiUXKSE1+Z+2iRIADicPQUYCD
        3HanJC94gbp1kSrYy7l+WG858cFOwzc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-Ts07-gpkOVSLxGIWapvoBw-1; Fri, 27 Mar 2020 11:28:52 -0400
X-MC-Unique: Ts07-gpkOVSLxGIWapvoBw-1
Received: by mail-wr1-f69.google.com with SMTP id i18so4681261wrx.17
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 08:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LrVbKy832yQOEnKJUht0bMjtEexZGq0QyNpHi1sAYOs=;
        b=S7TrlyiLqdpJixTcQC2uZF4Na+2+vhfEQSQRrp8JqrmjcDk0DEbD5cXapx68Xmin8z
         3BG3ObWm2NFaZSQpG8uVp4foOoT/O2FzfHIko6X92wsy8QJv9v6n1GPg53YiAbrlRNi8
         B1xv7V8WQJ3EgwRpeEfvnYzxvESrz19tU9ZNzIX2zST5LXQ38rJCikrDXy0mdX4aulsr
         tABrrnhnnw4RhDL6k79dqcjJ6Z1p3g6UH7U4+sV3ZeuQWTq0tSsC3v2CGBz09++zi+3n
         R6H53ezG5psmmypP+jcm2l2IewJraB9LxyhNbyFNFsm02yoNJLXO5AA34Au9pkmuzBVY
         s3wA==
X-Gm-Message-State: ANhLgQ2EF8Y8scbnlhsLlus6Ji8BIqaXzZMTEtCRoQhXI6UXjVBTN0PI
        6RuuG7aqh5x1F0WyC+5kToioSTL/w8imQS8Zo9R6162cl86G2CzKdeUapnvQaJCOGxXOHE4FVkd
        SIL6gegLvBCDiiM5r9dfPjB0Y
X-Received: by 2002:adf:e650:: with SMTP id b16mr14914712wrn.328.1585322930876;
        Fri, 27 Mar 2020 08:28:50 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuuhVU6uZvYqzAHNpesAwkUn6yyADQcW6XSpPmlOfhMg5xdFnKij9JHYD1KAG4ja84uht3Ecg==
X-Received: by 2002:adf:e650:: with SMTP id b16mr14914701wrn.328.1585322930693;
        Fri, 27 Mar 2020 08:28:50 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id i8sm8906856wrb.41.2020.03.27.08.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:28:49 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 00/10] Objtool updates for easier portability
Date:   Fri, 27 Mar 2020 15:28:37 +0000
Message-Id: <20200327152847.15294-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset includes some of the least controversial changes that
were needed as part of the arm64 port [1].

I'm resending these rebase on top of linux-tip/core/objtool, following
the addition of Peter's patches [2]

It consist mostly of small fixes or lifting some limitations to make it
easier to support a new architecture in objtool. Of course, these will
not be the only required changes, but these are the ones I hope make
enough sense to be merged separately from the rest of arm64 port series.

Changes since v1[3]:
- Really just rebased things

[1] https://lkml.org/lkml/2020/1/9/643
[2] https://lkml.org/lkml/2020/3/25/807
[3] https://www.spinics.net/lists/kernel/msg3453718.html

Thanks,

Julien

-->

Julien Thierry (9):
  objtool: Move header sync-check ealier in build
  objtool: check: Remove redundant checks on operand type
  objtool: check: Clean instruction state before each function
    validation
  objtool: check: Ignore empty alternative groups
  objtool: check: Remove check preventing branches within alternative
  objtool: check: Use arch specific values in restore_reg()
  objtool: check: Allow save/restore hint in non standard function
    symbols
  objtool: Split generic and arch specific CFI definitions
  objtool: Support multiple stack_op per instruction

Raphael Gault (1):
  objtool: Add abstraction for computation of symbols offsets

 tools/objtool/Makefile                    |   5 +-
 tools/objtool/arch.h                      |  10 +-
 tools/objtool/arch/x86/decode.c           |  24 +++-
 tools/objtool/arch/x86/include/cfi_regs.h |  25 ++++
 tools/objtool/cfi.h                       |  21 +--
 tools/objtool/check.c                     | 152 +++++++++++++---------
 tools/objtool/check.h                     |   3 +-
 7 files changed, 154 insertions(+), 86 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/cfi_regs.h

--
2.21.1


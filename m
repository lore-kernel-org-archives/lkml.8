Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE90C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 02:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140FC21744
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 02:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXMcgP3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgHACLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 22:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgHACLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 22:11:11 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A290C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 19:11:11 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k18so24469961qtm.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 19:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IIe2V6KflGKZOn7QS908wW8BYLPFtbcpWHZAEz1hDgk=;
        b=mXMcgP3DvievUcucf9BrqQ22yf8OdRUoL1AQd4ThWeT+18r9T0fzV+eqSJtsgLgCBB
         Ni77ATuwQ2LnJZSdptYkPj79QukVZzQZn3+B6xuWUj8ko/cBtJMkKYV/FDf0EZ0qrpBf
         wiajaeLLGDf9egGDsjA+qx1bd+Gl/D3w78ylBNma2xH+XRarnNCdezW/VqNJhWJhyksx
         E83K84l4gyWp5ps0Lgmkjz6hSVxDeDHpK06O00ZYwcep4zgeKCrOwaZMdr65l4RKxfqc
         gC/ADU4V0/2ZQQGNk+0VD1VoQ2NsMeTP+voulYaYnZZHTjUIUzU8AWF9OEE46KFHowHu
         LHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IIe2V6KflGKZOn7QS908wW8BYLPFtbcpWHZAEz1hDgk=;
        b=iNPmUBJX0/If3JpLySjh9ydyjD4i9dHrJgJZcR/UldJ9G2+mJz6n1TLTxWlWAJGQRd
         QeVrO4MOCvX5jMqFTrC+3AELr7NXSUNKMAUlr/yZAZM7MXkA88OOlMj/v7PK+GM2t6vB
         ZVnfqNFdav8impfSyRhsg1qqzFnXyyTAb6s2t0/3BRAH2jPwyGc3m1DW9+bleU+f3RLg
         ujncOdRkNQhbX8q8CV87b5drsQE3j1sdLzon++wWbGCkD//tiY+IzeNxVgoYDe9Iitab
         ahHQPCfxXVwiYVayTiAI+qio1QBvfQJ78lsHQAO3kAiCSLNzc1U/gSZ3A8mQgyhiTMy+
         sQGA==
X-Gm-Message-State: AOAM532idRRNXFItObTRt3Iduw32rta64oxldpI2ByHxrhUJzm/IXddV
        uRQaMG/ufkihECT+8nLmuQ==
X-Google-Smtp-Source: ABdhPJydwIv8QJlCp4ZKsqgnbMvVuKUYEfD9Rdd//kTJdWgOkb13Fj6frDPsYMF7imm96R5yvQFUKg==
X-Received: by 2002:ac8:4652:: with SMTP id f18mr6468424qto.142.1596247870562;
        Fri, 31 Jul 2020 19:11:10 -0700 (PDT)
Received: from localhost.localdomain (146-115-88-66.s3894.c3-0.sbo-ubr1.sbo.ma.cable.rcncustomer.com. [146.115.88.66])
        by smtp.gmail.com with ESMTPSA id u37sm12278160qtj.47.2020.07.31.19.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 19:11:10 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH v2] ptrace: Prevent kernel-infoleak in ptrace_get_syscall_info()
Date:   Fri, 31 Jul 2020 22:08:41 -0400
Message-Id: <20200801020841.227522-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727213644.328662-1-yepeilin.cs@gmail.com>
References: <20200727213644.328662-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace_get_syscall_info() is potentially copying uninitialized stack
memory to userspace, since the compiler may leave a 3-byte hole near the
beginning of `info`. Fix it by adding a padding field to `struct
ptrace_syscall_info`.

Cc: stable@vger.kernel.org
Fixes: 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
Change in v2:
    - Add a padding field to `struct ptrace_syscall_info`, instead of
      doing memset() on `info`. (Suggested by Dmitry V. Levin
      <ldv@altlinux.org>)

Reference: https://lwn.net/Articles/417989/

$ # before:
$ pahole -C "ptrace_syscall_info" kernel/ptrace.o
struct ptrace_syscall_info {
	__u8                       op;                   /*     0     1 */

	/* XXX 3 bytes hole, try to pack */

	__u32                      arch __attribute__((__aligned__(4))); /*     4     4 */
	__u64                      instruction_pointer;  /*     8     8 */
	__u64                      stack_pointer;        /*    16     8 */
	union {
		struct {
			__u64      nr;                   /*    24     8 */
			__u64      args[6];              /*    32    48 */
		} entry;                                 /*    24    56 */
		struct {
			__s64      rval;                 /*    24     8 */
			__u8       is_error;             /*    32     1 */
		} exit;                                  /*    24    16 */
		struct {
			__u64      nr;                   /*    24     8 */
			__u64      args[6];              /*    32    48 */
			/* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
			__u32      ret_data;             /*    80     4 */
		} seccomp;                               /*    24    64 */
	};                                               /*    24    64 */

	/* size: 88, cachelines: 2, members: 5 */
	/* sum members: 85, holes: 1, sum holes: 3 */
	/* forced alignments: 1, forced holes: 1, sum forced holes: 3 */
	/* last cacheline: 24 bytes */
} __attribute__((__aligned__(8)));
$
$ # after:
$ pahole -C "ptrace_syscall_info" kernel/ptrace.o
struct ptrace_syscall_info {
	__u8                       op;                   /*     0     1 */
	__u8                       pad[3];               /*     1     3 */
	__u32                      arch __attribute__((__aligned__(4))); /*     4     4 */
	__u64                      instruction_pointer;  /*     8     8 */
	__u64                      stack_pointer;        /*    16     8 */
	union {
		struct {
			__u64      nr;                   /*    24     8 */
			__u64      args[6];              /*    32    48 */
		} entry;                                 /*    24    56 */
		struct {
			__s64      rval;                 /*    24     8 */
			__u8       is_error;             /*    32     1 */
		} exit;                                  /*    24    16 */
		struct {
			__u64      nr;                   /*    24     8 */
			__u64      args[6];              /*    32    48 */
			/* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
			__u32      ret_data;             /*    80     4 */
		} seccomp;                               /*    24    64 */
	};                                               /*    24    64 */

	/* size: 88, cachelines: 2, members: 6 */
	/* forced alignments: 1 */
	/* last cacheline: 24 bytes */
} __attribute__((__aligned__(8)));
$ _

 include/uapi/linux/ptrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index a71b6e3b03eb..a518ba514bac 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -81,6 +81,7 @@ struct seccomp_metadata {
 
 struct ptrace_syscall_info {
 	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
+	__u8 pad[3];
 	__u32 arch __attribute__((__aligned__(sizeof(__u32))));
 	__u64 instruction_pointer;
 	__u64 stack_pointer;
-- 
2.25.1


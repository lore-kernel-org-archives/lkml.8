Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FE0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 15:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A4542076B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 15:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+CQ6tFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHAPWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 11:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgHAPWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 11:22:55 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F05C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 08:22:55 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b14so29881750qkn.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i9HjdunNdeDb6el2KFiKvzDJLets7DjcfYSJtReQ90A=;
        b=a+CQ6tFXEKoQnwBiEU7118Tp/SPyORFALhwIwQIB+HWrVUhhYoozvHpKP1TKZu5Sly
         GPgx/3KNprl7UzHNQGLceoVwFuTlAh5xcG/RhRunG5U15hStEkZaXnCjkdUlgeBLb3Go
         eUT6RnSA1UH9JvpHt5UXTFGHj8c3adU/YsRih//N8DIeUGJR+VN34Sayvu/rsHw/JL69
         MlMTaMsynn9HBHKDZgasVkzIKkRAe4HOAusD7hzeaWJIO9ewRNH8bp+YKGlgHhF3lLh8
         gateEnSLgsZM5K3Vrl6Volcs++mwpA2v8tIjMzN0aG2ZlhQRLBk3iiM2UE/Spizb8EHs
         Uf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9HjdunNdeDb6el2KFiKvzDJLets7DjcfYSJtReQ90A=;
        b=dzsXsC73tTiWPAKPm1ZYJbCyn2bCYZMF1RQ7im0pnkCi6QgQ9kryd5smEvyW1fuKcS
         bJR1qQrEJrhI60ufr2MOCrBlLlzocsrcpZjet4NuuhyNbWz0GM+8fnO5Y5womB4xvb/5
         ec9pK0kjWn5j2vj/OSBrP9lyQwgO454WdzErMR5Wy3qJSbyjIvSa63rYY6ZUiKH8mwvF
         MBsXo4q5+LQP6B0dfCQ6rmGRrJGTR4w2bzOuvCkdTF/su6w5TQzZbXnp1pMtwQhacgAW
         l270qaWR9eC7sT7o5pVU+Y9YjkSTe9nbxOVdKQ2gfHS/9gFypvz3NtbkbtueaDukeEKi
         Ohdw==
X-Gm-Message-State: AOAM531SfCvCK5/oBUB48VpQJEciy71Wytbu1dKaJBURohWMn961YrJd
        OBrg3GCxj3bBUj4cYC632w==
X-Google-Smtp-Source: ABdhPJy0C9eilLWU1/8pYjkI3JKMpRagOOguZHCnkboWiW5HffgJkT/y75nzcg8XScViImkt3uhx0Q==
X-Received: by 2002:a05:620a:13c9:: with SMTP id g9mr1484449qkl.436.1596295374348;
        Sat, 01 Aug 2020 08:22:54 -0700 (PDT)
Received: from localhost.localdomain (146-115-88-66.s3894.c3-0.sbo-ubr1.sbo.ma.cable.rcncustomer.com. [146.115.88.66])
        by smtp.gmail.com with ESMTPSA id n184sm12951144qkn.49.2020.08.01.08.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 08:22:53 -0700 (PDT)
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
Subject: [Linux-kernel-mentees] [PATCH v3] ptrace: Prevent kernel-infoleak in ptrace_get_syscall_info()
Date:   Sat,  1 Aug 2020 11:20:44 -0400
Message-Id: <20200801152044.230416-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200801020841.227522-1-yepeilin.cs@gmail.com>
References: <20200801020841.227522-1-yepeilin.cs@gmail.com>
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
Change in v3:
    - Remove unnecessary `__aligned__` attribute. (Suggested by
      Dmitry V. Levin <ldv@altlinux.org>)

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
	__u32                      arch;                 /*     4     4 */
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
	/* last cacheline: 24 bytes */
};
$ _

 include/uapi/linux/ptrace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index a71b6e3b03eb..83ee45fa634b 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -81,7 +81,8 @@ struct seccomp_metadata {
 
 struct ptrace_syscall_info {
 	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
-	__u32 arch __attribute__((__aligned__(sizeof(__u32))));
+	__u8 pad[3];
+	__u32 arch;
 	__u64 instruction_pointer;
 	__u64 stack_pointer;
 	union {
-- 
2.25.1


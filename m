Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CC3C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6390C21775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuXfBDuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgBGUVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:21:47 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:60285 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgBGUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:21:47 -0500
Received: by mail-pj1-f73.google.com with SMTP id e4so1859623pjj.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+f6B99g77KURDLWF0jG9B7rc7+G1Jyxo/PtYXlo3EKQ=;
        b=MuXfBDuK2Hk/EkqAJ60zYjzf93z6CNxNm426qL5FrmxphPUaEXf3WYROatjGu68r7h
         3gLxrmQy6VA/5ic+x8IxrqdeA49iaGfjoUnnlUi6/wT5wD4phJJro1exeBmzl3owxblv
         UeAVVtMr37MjTKtVPmsuqhhcdcmxbmKh6qRQ+mdY5+xe4ZOgcr+/u9JlYrxI9u+/fwBN
         7FxFAuKSIiNqr003zrEVB2NGpscq1G8j3xFIuoN2Ju0IVw1nXSq3hEDeL2ccndKrwFne
         uRq8M54rH+um4uGbNf4PG2YdaOxN10HKYCQt+zmHJt6HjbZATbMy73ojTOl3ZeQbrIEp
         DKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+f6B99g77KURDLWF0jG9B7rc7+G1Jyxo/PtYXlo3EKQ=;
        b=mtY6EQ+hneEYNIkugkFcehwurtiiKAflnZeCP0X5L7Yc0EoJAR92tlQrM/HH6kkH4j
         Ki4QT+CQi1JOAOmkmTK3dIqTWuw5PcjTDYeEcyuIJuWR7foymeukV/b2/0irvApDHI13
         gsiKw5JgLVBx1ecgHZXp7tjmOOvXJgWbv0pPPHXjlDrpdrxY6HZ1PX/XHs5301adZv+3
         gnrlQrNSmGRLYvbomIM8ctOZnVZE0qcvo/EVyfC+XqiPSWSK4DxeY1fteFaKFWhID96L
         JScYFXziILFx/fWmqQ3t1FqOoBbR7dhLFiiDnBAb7ew8qkEDrVC7OZ8g7+ZkdOIlOTK+
         DklQ==
X-Gm-Message-State: APjAAAWW1NlKcM71+Ivk8EYEAZucTSwCb+9DTnnE45g8e8oEJmMmRBA1
        GNEJirm6rlZQBsNJgqUGICtjkBNwrc8f
X-Google-Smtp-Source: APXvYqx1U2Lrq+cO2dZtr2CupCBM/sOTbHK7qy0c5byUyPUEajDLI08oKejCN9iIGiyA6zxnyX6Dy2p1x4hj
X-Received: by 2002:a65:641a:: with SMTP id a26mr918780pgv.425.1581106906604;
 Fri, 07 Feb 2020 12:21:46 -0800 (PST)
Date:   Fri,  7 Feb 2020 12:21:24 -0800
In-Reply-To: <20200207201856.46070-1-bgeffon@google.com>
Message-Id: <20200207202124.68949-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20200207201856.46070-1-bgeffon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] mremap.2: Add information for MREMAP_DONTUNMAP.
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Brian Geffon <bgeffon@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 man2/mremap.2 | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/man2/mremap.2 b/man2/mremap.2
index d73fb64fa..c660a45be 100644
--- a/man2/mremap.2
+++ b/man2/mremap.2
@@ -26,7 +26,8 @@
 .\" 1996-04-12 Tom Bjorkholm <tomb@mydata.se>
 .\"            Update for Linux 1.3.87 and later
 .\" 2005-10-11 mtk: Added NOTES for MREMAP_FIXED; revised EINVAL text.
-.\"
+.\" 2020-02-05 Brian Geffon <bgeffon@google.com>
+.\"            Update for MREMAP_DONTUNMAP.
 .TH MREMAP 2 2019-03-06 "Linux" "Linux Programmer's Manual"
 .SH NAME
 mremap \- remap a virtual memory address
@@ -129,6 +130,13 @@ If
 is specified, then
 .B MREMAP_MAYMOVE
 must also be specified.
+.TP
+.BR MREMAP_DONTUNMAP " (since Linux ?.?)"
+This flag which must be used in conjuction with
+.B MREMAP_MAYMOVE
+remaps a mapping to a new address and it does not unmap the mapping at \fIold_address\fP. This flag can only be used with private anonymous mappings. Any access to the range specified at \fIold_address\fP after completion will result in a page fault. If a
+.BR userfaultfd (2)
+was registered on the mapping specified by \fIold_address\fP it will continue to watch that mapping for faults.
 .PP
 If the memory segment specified by
 .I old_address
@@ -176,6 +184,8 @@ a value other than
 .B MREMAP_MAYMOVE
 or
 .B MREMAP_FIXED
+or
+.B MREMAP_DONTUNMAP
 was specified in
 .IR flags ;
 .IP *
@@ -197,9 +207,14 @@ and
 .IR old_size ;
 .IP *
 .B MREMAP_FIXED
+or
+.B MREMAP_DONTUNMAP
 was specified without also specifying
 .BR MREMAP_MAYMOVE ;
 .IP *
+.B MREMAP_DONTUNMAP
+was specified with an \fIold_address\fP that was not private anonymous;
+.IP *
 \fIold_size\fP was zero and \fIold_address\fP does not refer to a
 shareable mapping (but see BUGS);
 .IP *
@@ -209,10 +224,20 @@ flag was not specified.
 .RE
 .TP
 .B ENOMEM
+Not enough memory was available to complete the operation.
+Possible causes are:
+.RS
+.IP * 3
 The memory area cannot be expanded at the current virtual address, and the
 .B MREMAP_MAYMOVE
 flag is not set in \fIflags\fP.
 Or, there is not enough (virtual) memory available.
+.IP *
+.B MREMAP_DONTUNMAP
+was used without
+.B MREMAP_FIXED
+causing a new mapping to be created that would exceed the virtual memory available or it would exceed the maximum number of allowed mappings.
+.RE
 .SH CONFORMING TO
 This call is Linux-specific, and should not be used in programs
 intended to be portable.
-- 
2.25.0.341.g760bfbb309-goog


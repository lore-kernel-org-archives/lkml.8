Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B293C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9782137B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758009;
	bh=8V1Zt96sEf5UaGvEGvUpGOTOnIj7KwL1yfKO8xcMVsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L4lG4z9XGrVXLCebCLZQCRVLqf37/57E6L7xFGyr5ktrBr00SFCyZvzy/VrpXMHnS
	 Axmb7kBkdW64vqansHser6mhLURCTo3KmZ3MEhw/ZhLbuydsJeFzfeoudt4GcoesHv
	 lC6doth7VzL2DMgIxi5jJsDqG3IQC9qpQrmgXySA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbgDAQUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732582AbgDAQUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:20:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A531C20857;
        Wed,  1 Apr 2020 16:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758004;
        bh=8V1Zt96sEf5UaGvEGvUpGOTOnIj7KwL1yfKO8xcMVsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pH6sQdMRRvpiZ26IL6b3FwalTZpqze4jyK3NzAX9/uJKVi7uT73n3GVwc/lRVhnd/
         5J6pfl4lu/lxsCv6tYU6IN78SlvCplkyT4y4D7e3hOeYyZvCGtDkbOXYskfODdxh7B
         4ZMcHFX1pyoP+/3+KmAu+oYOIk3ZSPwy5FVjDhew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Alistair Delva <adelva@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH 5.5 12/30] bpf: Explicitly memset the bpf_attr structure
Date:   Wed,  1 Apr 2020 18:17:16 +0200
Message-Id: <20200401161425.424426025@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161414.345528747@linuxfoundation.org>
References: <20200401161414.345528747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 8096f229421f7b22433775e928d506f0342e5907 upstream.

For the bpf syscall, we are relying on the compiler to properly zero out
the bpf_attr union that we copy userspace data into. Unfortunately that
doesn't always work properly, padding and other oddities might not be
correctly zeroed, and in some tests odd things have been found when the
stack is pre-initialized to other values.

Fix this by explicitly memsetting the structure to 0 before using it.

Reported-by: Maciej Żenczykowski <maze@google.com>
Reported-by: John Stultz <john.stultz@linaro.org>
Reported-by: Alexander Potapenko <glider@google.com>
Reported-by: Alistair Delva <adelva@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://android-review.googlesource.com/c/kernel/common/+/1235490
Link: https://lore.kernel.org/bpf/20200320094813.GA421650@kroah.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/syscall.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2988,7 +2988,7 @@ out:
 
 SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size)
 {
-	union bpf_attr attr = {};
+	union bpf_attr attr;
 	int err;
 
 	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
@@ -3000,6 +3000,7 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf
 	size = min_t(u32, size, sizeof(attr));
 
 	/* copy attributes from user space, may be less than sizeof(bpf_attr) */
+	memset(&attr, 0, sizeof(attr));
 	if (copy_from_user(&attr, uattr, size) != 0)
 		return -EFAULT;
 



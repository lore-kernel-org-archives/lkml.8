Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EB9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18683206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593465095;
	bh=t9zzV/CyhZ4bPii2Izp8Lv2PwTTnEZksXP9gnh6vTMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gjHjp8bYKUurT0Fdkk9RUkaY0zXEzwJxQz+RJoXDcgHF0DHSA5GgzMdxDZwnT6neo
	 3C3w85oHPjdogi7PRxX/kPsqVCpfuMvO5GtOU/JUjIEi2yC+CLYJV6THiuk14Trd1V
	 ygBRDFZz4jfJfAusQq7QfKml5stz0izc0uzNTWMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390382AbgF2VL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730303AbgF2TAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:00:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D8802550B;
        Mon, 29 Jun 2020 15:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446068;
        bh=t9zzV/CyhZ4bPii2Izp8Lv2PwTTnEZksXP9gnh6vTMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pj3AF0bqTdglDtGaY+9rLbkvZi0bbfxfoY43roUTUYGwxsTDUrMN4zFvQZK8aKrJ3
         lYvtwZaUK0Vnn4dZfxgmemfo0aEsKzICmHwFmPJ3wVHS0n/nTPrr8rYFtCgttis6uQ
         1gU+7kOr2y54IKGCfBlsfHIGSUJO9gTDlresDmSc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, stable@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 067/135] sparc64: fix misuses of access_process_vm() in genregs32_[sg]et()
Date:   Mon, 29 Jun 2020 11:52:01 -0400
Message-Id: <20200629155309.2495516-68-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 142cd25293f6a7ecbdff4fb0af17de6438d46433 ]

We do need access_process_vm() to access the target's reg_window.
However, access to caller's memory (storing the result in
genregs32_get(), fetching the new values in case of genregs32_set())
should be done by normal uaccess primitives.

Fixes: ad4f95764040 ([SPARC64]: Fix user accesses in regset code.)
Cc: stable@kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/kernel/ptrace_64.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index c1566170964f3..829592d5efe0b 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -534,13 +534,8 @@ static int genregs32_get(struct task_struct *target,
 						      &reg, sizeof(reg), 0)
 				    != sizeof(reg))
 					return -EFAULT;
-				if (access_process_vm(target,
-						      (unsigned long) u,
-						      &reg, sizeof(reg), 1)
-				    != sizeof(reg))
+				if (put_user(reg, u++))
 					return -EFAULT;
-				pos++;
-				u++;
 			}
 		}
 	}
@@ -639,11 +634,7 @@ static int genregs32_set(struct task_struct *target,
 			}
 		} else {
 			for (; count > 0 && pos < 32; count--) {
-				if (access_process_vm(target,
-						      (unsigned long)
-						      u,
-						      &reg, sizeof(reg), 0)
-				    != sizeof(reg))
+				if (get_user(reg, u++))
 					return -EFAULT;
 				if (access_process_vm(target,
 						      (unsigned long)
-- 
2.25.1


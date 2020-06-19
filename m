Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485AEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207B0217A0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583302;
	bh=+OZj2jAXCncu9wYrjju7ertIwwrHjJKhK6GfzfHwLvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=irV3VFCnO2257DVIJhz3wTtOT3rJO3Y4uRjex/SMTAXFutVTrAtnrWn0VBQqG3y7m
	 BqAihQasds7VdCw0Qw9e5CEbwK5yGKGeKfoyOxCZYNmg1it3uAL8UB27m0y0E8ml5a
	 iZuQtFHtjHHH/poM8EkQ7pea5hWbLoPbjmJnEYrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394460AbgFSQO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390626AbgFSPDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:03:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B8D206DB;
        Fri, 19 Jun 2020 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579028;
        bh=+OZj2jAXCncu9wYrjju7ertIwwrHjJKhK6GfzfHwLvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RiILUdiBhmXk1ZIRh3zsri77LztcDkBpEKlug4G8TFxtF941BvzQHLYhnnnqV/VEu
         uL3A8DtygclUQpsjUvgdiUVdWEFmgj1raBHvjwAUhBrbV3hJnQOiNAY0up/ygSwfWH
         oLB57uTOKZiVUinP/Bnjfg1opOYwCQLio7f0HFNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.19 247/267] sparc64: fix misuses of access_process_vm() in genregs32_[sg]et()
Date:   Fri, 19 Jun 2020 16:33:52 +0200
Message-Id: <20200619141700.550399559@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

commit 142cd25293f6a7ecbdff4fb0af17de6438d46433 upstream.

We do need access_process_vm() to access the target's reg_window.
However, access to caller's memory (storing the result in
genregs32_get(), fetching the new values in case of genregs32_set())
should be done by normal uaccess primitives.

Fixes: ad4f95764040 ([SPARC64]: Fix user accesses in regset code.)
Cc: stable@kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/sparc/kernel/ptrace_64.c |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -571,19 +571,13 @@ static int genregs32_get(struct task_str
 			for (; count > 0 && pos < 32; count--) {
 				if (access_process_vm(target,
 						      (unsigned long)
-						      &reg_window[pos],
+						      &reg_window[pos++],
 						      &reg, sizeof(reg),
 						      FOLL_FORCE)
 				    != sizeof(reg))
 					return -EFAULT;
-				if (access_process_vm(target,
-						      (unsigned long) u,
-						      &reg, sizeof(reg),
-						      FOLL_FORCE | FOLL_WRITE)
-				    != sizeof(reg))
+				if (put_user(reg, u++))
 					return -EFAULT;
-				pos++;
-				u++;
 			}
 		}
 	}
@@ -683,12 +677,7 @@ static int genregs32_set(struct task_str
 			}
 		} else {
 			for (; count > 0 && pos < 32; count--) {
-				if (access_process_vm(target,
-						      (unsigned long)
-						      u,
-						      &reg, sizeof(reg),
-						      FOLL_FORCE)
-				    != sizeof(reg))
+				if (get_user(reg, u++))
 					return -EFAULT;
 				if (access_process_vm(target,
 						      (unsigned long)



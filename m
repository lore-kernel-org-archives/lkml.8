Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C5AC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5988E20735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443527;
	bh=OBlJkf5LEBooOxz/pRfGnBAjEMUlZH/6MyYD1wLrYug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sV88DKqwd+u5ha8X743pIE2iSc3rjZ4VByVKKvNyCytxr7LP4z86+MVFtl7bc9s7B
	 4ZG4i+nAKT/6htnE14Vmleo18n2AOuKCE8lVej6BEG74k+0LxLvV518kRQI9LUXF1X
	 XA2EfFj8dttLiJm2mngo4FLI/LjplQRMjTCvbs7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgCQLMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgCQLMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:12:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A5C12071C;
        Tue, 17 Mar 2020 11:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443520;
        bh=OBlJkf5LEBooOxz/pRfGnBAjEMUlZH/6MyYD1wLrYug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQUbnzGXU8oOrfP24p8wzmk7UD35Osk+OP65LOLGk8NnJKVzvX5c++QL1q3Z5IJeF
         KL54XeERSzo0Hq4gMQCkFLP7JH1DZ90L7dX2pv+96qmHjkkQ87BiLFN6sCq2RKXEgi
         67G6bBPtsO4C5u1YqOT9Qp4K+VV2yC8/Jvkl4Wzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Adrian Reber <areber@redhat.com>
Subject: [PATCH 5.5 110/151] pid: Fix error return value in some cases
Date:   Tue, 17 Mar 2020 11:55:20 +0100
Message-Id: <20200317103334.271538396@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

commit b26ebfe12f34f372cf041c6f801fa49c3fb382c5 upstream.

Recent changes to alloc_pid() allow the pid number to be specified on
the command line.  If set_tid_size is set, then the code scanning the
levels will hard-set retval to -EPERM, overriding it's previous -ENOMEM
value.

After the code scanning the levels, there are error returns that do not
set retval, assuming it is still set to -ENOMEM.

So set retval back to -ENOMEM after scanning the levels.

Fixes: 49cb2fc42ce4 ("fork: extend clone3() to support setting a PID")
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Adrian Reber <areber@redhat.com>
Cc: <stable@vger.kernel.org> # 5.5
Link: https://lore.kernel.org/r/20200306172314.12232-1-minyard@acm.org
[christian.brauner@ubuntu.com: fixup commit message]
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/pid.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -247,6 +247,8 @@ struct pid *alloc_pid(struct pid_namespa
 		tmp = tmp->parent;
 	}
 
+	retval = -ENOMEM;
+
 	if (unlikely(is_child_reaper(pid))) {
 		if (pid_ns_prepare_proc(ns))
 			goto out_free;



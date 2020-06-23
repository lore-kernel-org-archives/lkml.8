Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD11C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0A321883
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945019;
	bh=GRIRu4oi7R4HZL1Sk3KbRk/UGrE+bA7YOQThrJgVD64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ar1gZjS8uN/JAbytxK+1yjdd6eoYgBv5Nc5ty1z3S8m6GiXJB7qM0wz3NaeT3Rfkw
	 B23RhijFLUq0cIwE1WGSadDjcIyN1Fw+QXANLelVwd18hb3NFtHP3B5sDEO5+WOYBs
	 XFgVm5I8xOIHr0wgAXvkYb9Cm8EHU9Twi6N4blKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392539AbgFWUng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390295AbgFWUne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:43:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9272B2053B;
        Tue, 23 Jun 2020 20:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945014;
        bh=GRIRu4oi7R4HZL1Sk3KbRk/UGrE+bA7YOQThrJgVD64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJs/9CBmtRp3GssVkb5dx0CD074pzSha7Qz/MSpEQwmiVU98AkMT1jqFw1VjFk2Gn
         8cV0QYDZmbUYEBsOHoVZ/paG0HXsu0SKPjncglasuHz6bgUnYUvfwW9BPmeYHJ0xO1
         Q85n7acUhMpeddJJ1mmfJjWdXXbzv3yj3DCGEmMI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Ingo Molnar <mingo@elte.hu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ziqian SUN <zsun@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 200/206] kprobes: Fix to protect kick_kprobe_optimizer() by kprobe_mutex
Date:   Tue, 23 Jun 2020 21:58:48 +0200
Message-Id: <20200623195326.880422767@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 1a0aa991a6274161c95a844c58cfb801d681eb59 upstream.

In kprobe_optimizer() kick_kprobe_optimizer() is called
without kprobe_mutex, but this can race with other caller
which is protected by kprobe_mutex.

To fix that, expand kprobe_mutex protected area to protect
kick_kprobe_optimizer() call.

Link: http://lkml.kernel.org/r/158927057586.27680.5036330063955940456.stgit@devnote2

Fixes: cd7ebe2298ff ("kprobes: Use text_poke_smp_batch for optimizing")
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: David Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ziqian SUN <zsun@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/kprobes.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -599,11 +599,12 @@ static void kprobe_optimizer(struct work
 	mutex_unlock(&module_mutex);
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
-	mutex_unlock(&kprobe_mutex);
 
 	/* Step 5: Kick optimizer again if needed */
 	if (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list))
 		kick_kprobe_optimizer();
+
+	mutex_unlock(&kprobe_mutex);
 }
 
 /* Wait for completing optimization and unoptimization */



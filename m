Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E484C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052D22465D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341268;
	bh=ubRE2SZEaEGCR094AMb1RNGp86l3lXPp5PS9AdISMv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1gDfPttiaqKiLMuKk3ajHsPspbFIGSWINUuJxt1Gyh74nT5C8J/U+aMUYXYC4uqGb
	 U+oOmSJs2npHtnXbHpdZPTK2EetvKwY2s0G6m+wdJbJFcprxM7v3hD5JtfeJN23xRN
	 ZZq9V2kZBCtJ/kCm6pfkCOqY8C/1EHBciGkz7ADs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbgBJN1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:27:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728406AbgBJMgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:32 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB5F2085B;
        Mon, 10 Feb 2020 12:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338191;
        bh=ubRE2SZEaEGCR094AMb1RNGp86l3lXPp5PS9AdISMv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWZRCfHUsAbfm3id9EeZpaulpRVznxIUIzdhpJIKQPQEJ4yb/co2en2JTy7GFjMqd
         G1mY4XDiyRp4UjIuwAu7WeYbSsMcCxiHYTiA+avF6KqWgmzWPeDkO14JJVyXltDyfq
         0cAPbGnQmN4FAu7auIYKqC5E9DoNKSfUugwkHmy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.19 194/195] perf/core: Fix mlock accounting in perf_mmap()
Date:   Mon, 10 Feb 2020 04:34:12 -0800
Message-Id: <20200210122324.124825345@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

commit 003461559ef7a9bd0239bae35a22ad8924d6e9ad upstream.

Decreasing sysctl_perf_event_mlock between two consecutive perf_mmap()s of
a perf ring buffer may lead to an integer underflow in locked memory
accounting. This may lead to the undesired behaviors, such as failures in
BPF map creation.

Address this by adjusting the accounting logic to take into account the
possibility that the amount of already locked memory may exceed the
current limit.

Fixes: c4b75479741c ("perf/core: Make the mlock accounting simple again")
Suggested-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Link: https://lkml.kernel.org/r/20200123181146.2238074-1-songliubraving@fb.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/core.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5709,7 +5709,15 @@ accounting:
 	 */
 	user_lock_limit *= num_online_cpus();
 
-	user_locked = atomic_long_read(&user->locked_vm) + user_extra;
+	user_locked = atomic_long_read(&user->locked_vm);
+
+	/*
+	 * sysctl_perf_event_mlock may have changed, so that
+	 *     user->locked_vm > user_lock_limit
+	 */
+	if (user_locked > user_lock_limit)
+		user_locked = user_lock_limit;
+	user_locked += user_extra;
 
 	if (user_locked > user_lock_limit)
 		extra = user_locked - user_lock_limit;



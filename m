Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4471EC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1823220838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748263;
	bh=T/LbyhOpANalFGth4QIQR7yQjVB/DcC7Wez3GWw4MgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dP46TnjskSijE5W5i4EpABKL0fr29ZPgDVm/hbWyfGmXc6J86G3wW6MPevSZBAcis
	 jV3a+1bzsT1W/EXjo512BizC6+ThyO3O7+4oXMCqilHgpQkk/3QDuPKfVcbeoAdEEw
	 1X8lZD8yQ6hWCuYuJnuRF/WStckxLNVRFf+NzkJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbgBCQbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:31:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730233AbgBCQbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:31:39 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 049322082E;
        Mon,  3 Feb 2020 16:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747499;
        bh=T/LbyhOpANalFGth4QIQR7yQjVB/DcC7Wez3GWw4MgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxDfaqXYjbXwuB+A+7AUSxTNwoX2BzGPhkajvSiR2zz04z8It4cJFNmoTkH39pC5O
         6IWRUhepIfDKdvKjjWWOXFfCBjWD0mgoXaqGbASU1DcWWDDbcMV8ONpwMoe/L0WxqY
         aobhNW+/76wbKZV2c/h2TSfDMhXNqe+UQ5kCjgHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot <syzbot+efea72d4a0a1d03596cd@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 4.19 20/70] tomoyo: Use atomic_t for statistics counter
Date:   Mon,  3 Feb 2020 16:19:32 +0000
Message-Id: <20200203161915.573229417@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
References: <20200203161912.158976871@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit a8772fad0172aeae339144598b809fd8d4823331 upstream.

syzbot is reporting that there is a race at tomoyo_stat_update() [1].
Although it is acceptable to fail to track exact number of times policy
was updated, convert to atomic_t because this is not a hot path.

[1] https://syzkaller.appspot.com/bug?id=a4d7b973972eeed410596e6604580e0133b0fc04

Reported-by: syzbot <syzbot+efea72d4a0a1d03596cd@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/tomoyo/common.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2254,9 +2254,9 @@ static const char * const tomoyo_memory_
 	[TOMOYO_MEMORY_QUERY]  = "query message:",
 };
 
-/* Timestamp counter for last updated. */
-static unsigned int tomoyo_stat_updated[TOMOYO_MAX_POLICY_STAT];
 /* Counter for number of updates. */
+static atomic_t tomoyo_stat_updated[TOMOYO_MAX_POLICY_STAT];
+/* Timestamp counter for last updated. */
 static time64_t tomoyo_stat_modified[TOMOYO_MAX_POLICY_STAT];
 
 /**
@@ -2268,10 +2268,7 @@ static time64_t tomoyo_stat_modified[TOM
  */
 void tomoyo_update_stat(const u8 index)
 {
-	/*
-	 * I don't use atomic operations because race condition is not fatal.
-	 */
-	tomoyo_stat_updated[index]++;
+	atomic_inc(&tomoyo_stat_updated[index]);
 	tomoyo_stat_modified[index] = ktime_get_real_seconds();
 }
 
@@ -2291,7 +2288,7 @@ static void tomoyo_read_stat(struct tomo
 	for (i = 0; i < TOMOYO_MAX_POLICY_STAT; i++) {
 		tomoyo_io_printf(head, "Policy %-30s %10u",
 				 tomoyo_policy_headers[i],
-				 tomoyo_stat_updated[i]);
+				 atomic_read(&tomoyo_stat_updated[i]));
 		if (tomoyo_stat_modified[i]) {
 			struct tomoyo_time stamp;
 			tomoyo_convert_time(tomoyo_stat_modified[i], &stamp);



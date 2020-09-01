Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A67AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A03C2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975169;
	bh=qQYC96ys55bOwFktWPSHo6ffF8BCXRT989q4ofQBy+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qiE4oZ8hx+1jzjX6JUhgxAef2wFSk0Ybf/xe0c7o4A5NkPSYZccKk3XR1ElQO3x12
	 GUZ7QjNU9quVojJ0+ykseESaVJDc3gyEeyQzUViawxnbSFwSZEWy32vu0ix6UAPJAc
	 U9Xx+SM48sRFmMMFp30loMmur8mUk8+nQIdWNthQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbgIAPqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731652AbgIAPnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:43:14 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DB12206EB;
        Tue,  1 Sep 2020 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974994;
        bh=qQYC96ys55bOwFktWPSHo6ffF8BCXRT989q4ofQBy+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/BtNddI6gHUTVsK6JT8Eu+lOkQeJ7vVCT6NzVsPgQVxiZmxlOtk2301ls5VLpO4u
         k4RkPcghx8x7aAkkQiFiJzDmK//qkfXB7wx6gwhtErISuxUEyzIrD0hjoFHAI5IYt7
         Mkazo6wQxw4gSoBEwTHlmC/4/Cu3W15WgicyfHhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Deal <eric.deal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.8 168/255] block: fix get_max_io_size()
Date:   Tue,  1 Sep 2020 17:10:24 +0200
Message-Id: <20200901151008.744593322@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

commit e4b469c66f3cbb81c2e94d31123d7bcdf3c1dabd upstream.

A previous commit aligning splits to physical block sizes inadvertently
modified one return case such that that it now returns 0 length splits
when the number of sectors doesn't exceed the physical offset. This
later hits a BUG in bio_split(). Restore the previous working behavior.

Fixes: 9cc5169cd478b ("block: Improve physical block alignment of split bios")
Reported-by: Eric Deal <eric.deal@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-merge.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -154,7 +154,7 @@ static inline unsigned get_max_io_size(s
 	if (max_sectors > start_offset)
 		return max_sectors - start_offset;
 
-	return sectors & (lbs - 1);
+	return sectors & ~(lbs - 1);
 }
 
 static inline unsigned get_max_segment_size(const struct request_queue *q,



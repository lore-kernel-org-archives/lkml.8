Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7B5C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B626C20842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338256;
	bh=QU5hlEcn8A5qyauh+f5DdOPlzw74Il9ZLeMFavcEx8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=go4D2sOjIdNnOZQkLYywybB+XPUB8W9DePqSOCVt+3kp84StZRmrmpHwtnkrcSHTR
	 nP6azBPfWf6YGgacFDaFz5JLsPDKsCW+1VIOFXxwjRu4s15m+zZKWxgqGDFGt+Xfz/
	 QIDa+wfBhR/0rQYM3B9yFVx0OHQREYr1w2Gz1ZMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgBJMhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:37:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbgBJMgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:16 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 938712467C;
        Mon, 10 Feb 2020 12:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338175;
        bh=QU5hlEcn8A5qyauh+f5DdOPlzw74Il9ZLeMFavcEx8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ByUJrZP9RI/3t6ZyNa79DEvwexV1+K2dGZYMxfXgSuGYmLBktZ+zosbFgaSKf6btv
         9HNnB3uyclxsWz/Qq/I9vY4yfWL5qnXmNBnqtTPbjz1qi5ZvKtyXKxg5HFTWnNKaYl
         Lc1t2rmyQ/uo/bCwbAK78ZDwrnTYopDKNlfqmnzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.19 162/195] ubi: fastmap: Fix inverted logic in seen selfcheck
Date:   Mon, 10 Feb 2020 04:33:40 -0800
Message-Id: <20200210122321.103434498@linuxfoundation.org>
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

From: Sascha Hauer <s.hauer@pengutronix.de>

commit ef5aafb6e4e9942a28cd300bdcda21ce6cbaf045 upstream.

set_seen() sets the bit corresponding to the PEB number in the bitmap,
so when self_check_seen() wants to find PEBs that haven't been seen we
have to print the PEBs that have their bit cleared, not the ones which
have it set.

Fixes: 5d71afb00840 ("ubi: Use bitmaps in Fastmap self-check code")
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/fastmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -73,7 +73,7 @@ static int self_check_seen(struct ubi_de
 		return 0;
 
 	for (pnum = 0; pnum < ubi->peb_count; pnum++) {
-		if (test_bit(pnum, seen) && ubi->lookuptbl[pnum]) {
+		if (!test_bit(pnum, seen) && ubi->lookuptbl[pnum]) {
 			ubi_err(ubi, "self-check failed for PEB %d, fastmap didn't see it", pnum);
 			ret = -EINVAL;
 		}



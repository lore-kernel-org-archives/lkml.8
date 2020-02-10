Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8AAC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADC82070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340498;
	bh=dKRv21hzhlljzKrr9urpXkc/E1WsZUzsIYdAS3QiIJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0C+G+/8Svc9gWcrQzvh2EajsEp5guYDD+hRb0/vk+gXr4Lvccj4nUX1OAg7qrTYcX
	 cPk/4zmYrhTyrnKbQkOM6bsZbedbqIW3xQFMm97DshJk8QyjS1X+oO0HLk39cn01Fk
	 3u46yqRfKWDd6lavwSN858iuwbAPgqifeI+bzhxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgBJNO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:14:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729141AbgBJMi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:27 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DF162085B;
        Mon, 10 Feb 2020 12:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338307;
        bh=dKRv21hzhlljzKrr9urpXkc/E1WsZUzsIYdAS3QiIJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wYw/XVWj4oyU4Q3RcEV782dzy7WZGpiDIZMZBTarcuzahZzATvYimFnmmbOSz/ZI3
         x+uGo2bcRlmXFVTFYtkBmxWD8OMBNa9wylzpvhiigUhXNHnpzxEqaifmR6rHSgkdjD
         aruSUguAd5hhWS9FEAv8ALWmoeAO7uefKgFaK98E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abhi Das <adas@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 5.4 183/309] gfs2: fix gfs2_find_jhead that returns uninitialized jhead with seq 0
Date:   Mon, 10 Feb 2020 04:32:19 -0800
Message-Id: <20200210122424.133471738@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhi Das <adas@redhat.com>

commit 7582026f6f3588ecebd281965c8a71aff6fb6158 upstream.

When the first log header in a journal happens to have a sequence
number of 0, a bug in gfs2_find_jhead() causes it to prematurely exit,
and return an uninitialized jhead with seq 0. This can cause failures
in the caller. For instance, a mount fails in one test case.

The correct behavior is for it to continue searching through the journal
to find the correct journal head with the highest sequence number.

Fixes: f4686c26ecc3 ("gfs2: read journal in large chunks")
Cc: stable@vger.kernel.org # v5.2+
Signed-off-by: Abhi Das <adas@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/lops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -421,7 +421,7 @@ static bool gfs2_jhead_pg_srch(struct gf
 
 	for (offset = 0; offset < PAGE_SIZE; offset += sdp->sd_sb.sb_bsize) {
 		if (!__get_log_header(sdp, kaddr + offset, 0, &lh)) {
-			if (lh.lh_sequence > head->lh_sequence)
+			if (lh.lh_sequence >= head->lh_sequence)
 				*head = lh;
 			else {
 				ret = true;



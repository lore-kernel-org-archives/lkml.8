Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F57AC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88B020838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339361;
	bh=8YWEqfZzJiB2wQyBg/KeYsZbbnwq/3ktB7xKinpWvGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dOqSdT+PLlWe/7tK2G/pzb0g9LC2IyAzBDuyiyxvFm+ZlUqXssVBrho6GuJ64kwjo
	 Zxy9eGDe5CrAb5J2SbWGwhz/Qkzs2nzrT24zYA6kBkPb6nRdFArMpIivN1DCjxW91n
	 TGgi0eDf8hbOy28I82ztFlpRgK/QmzynHu0IkVdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgBJMz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:55:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730059AbgBJMlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:44 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28AEE24688;
        Mon, 10 Feb 2020 12:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338504;
        bh=8YWEqfZzJiB2wQyBg/KeYsZbbnwq/3ktB7xKinpWvGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXyW91XM653WiN7+7CAveiJnHHv294CDOHdwUo6o/UZnxM7CFE6iorKsB0JoWxqUl
         d6KeP33qCZWP6cdDoLIBLw5VjCJSfjVbfPUt7jITW3iE9cVs2213uQN/9ImzEtvfXZ
         quJ7pbTz9SEzl3bRyXWlka/XRCGe7UJa+tMdZpfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 5.5 303/367] ubi: fastmap: Fix inverted logic in seen selfcheck
Date:   Mon, 10 Feb 2020 04:33:36 -0800
Message-Id: <20200210122451.475025673@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
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
@@ -64,7 +64,7 @@ static int self_check_seen(struct ubi_de
 		return 0;
 
 	for (pnum = 0; pnum < ubi->peb_count; pnum++) {
-		if (test_bit(pnum, seen) && ubi->lookuptbl[pnum]) {
+		if (!test_bit(pnum, seen) && ubi->lookuptbl[pnum]) {
 			ubi_err(ubi, "self-check failed for PEB %d, fastmap didn't see it", pnum);
 			ret = -EINVAL;
 		}



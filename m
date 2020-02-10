Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935B9C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6360020714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340388;
	bh=8YWEqfZzJiB2wQyBg/KeYsZbbnwq/3ktB7xKinpWvGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nVl9L4XKZ0gSGweyXLn/N5UbgpLuWOFxSXsIPLVlEzoFeiGRLi9zSvMIo7kE5jdIr
	 fNyp0dUWzpV4kKBBwnwDhkRc+vKIDEf39chc4w5sbPGpW5i1ZxZyIcDpTuETAEoRat
	 gADY+aoHkcp2PGCAsP+aE4RnxPFN/Qdp4lPQPIJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgBJNNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:13:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbgBJMio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:44 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AD36208C4;
        Mon, 10 Feb 2020 12:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338324;
        bh=8YWEqfZzJiB2wQyBg/KeYsZbbnwq/3ktB7xKinpWvGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zAHotUTi+5oVZmiy7Y/hZmCnHTtIW/tmEQvke3ACxScl37fYyTiMZf+je8bMhEBLx
         DpcRkcz35ZztWphYW98PuyriVQZ0yhsiRb3aSaX7SX9WhVJ16R57a1Z/TZNNb62glF
         9BiNcY+jYhoBK97Q5GfExIP2XZptHBt0Qtbk3xIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 5.4 258/309] ubi: fastmap: Fix inverted logic in seen selfcheck
Date:   Mon, 10 Feb 2020 04:33:34 -0800
Message-Id: <20200210122431.368145943@linuxfoundation.org>
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



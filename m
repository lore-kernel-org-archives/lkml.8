Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2D9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA57206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859548;
	bh=dZTUZ43rZtLVx6WjxbjKYrBOrk1kquAKKQ3mzcwZK8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CN9buzJnoLgckU4Nznhgy/13X2eqiNiSg5ndDlgwy0ikFrtE9O4kZoGeZbceaOZwl
	 ZAJkdEYcIUHDDp0tC/3zFkbZnSLasIRGkfWBdn+3t2c0NnNwH9WFoF6p4OhYdgBl/C
	 GlRHrZw2y3iftS/RNml6+23kw5b2gEuxfixDOjGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbgAXJw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:52:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388130AbgAXJwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:52:20 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9E00206D5;
        Fri, 24 Jan 2020 09:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859539;
        bh=dZTUZ43rZtLVx6WjxbjKYrBOrk1kquAKKQ3mzcwZK8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OiUWJZYWNv1EpsVJk+8FW6IBldwXnyf4ZqcbPpTUldkg6khgqLofHa1mBZvL2OdiQ
         btrjxanN0/W7enYDzIXSoM6Yq42WVN4mBwWPG58pcc2xW4mMWZFjIJ9jklMfb9HIT/
         mo6JdutiX23rNyA1dxW3J8phmcqYVs9j3lZXVGbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alexandre.bounine@idt.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 140/343] drivers/rapidio/rio_cm.c: fix potential oops in riocm_ch_listen()
Date:   Fri, 24 Jan 2020 10:29:18 +0100
Message-Id: <20200124092938.415701897@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 5ac188b12e7cbdd92dee60877d1fac913fc1d074 ]

If riocm_get_channel() fails, then we should just return -EINVAL.
Calling riocm_put_channel() will trigger a NULL dereference and
generally we should call put() if the get() didn't succeed.

Link: http://lkml.kernel.org/r/20190110130230.GB27017@kadam
Fixes: b6e8d4aa1110 ("rapidio: add RapidIO channelized messaging driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rapidio/rio_cm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index ef989a15aefc4..b29fc258eeba4 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -1215,7 +1215,9 @@ static int riocm_ch_listen(u16 ch_id)
 	riocm_debug(CHOP, "(ch_%d)", ch_id);
 
 	ch = riocm_get_channel(ch_id);
-	if (!ch || !riocm_cmp_exch(ch, RIO_CM_CHAN_BOUND, RIO_CM_LISTEN))
+	if (!ch)
+		return -EINVAL;
+	if (!riocm_cmp_exch(ch, RIO_CM_CHAN_BOUND, RIO_CM_LISTEN))
 		ret = -EINVAL;
 	riocm_put_channel(ch);
 	return ret;
-- 
2.20.1




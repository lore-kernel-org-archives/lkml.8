Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFC0C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7BE20759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595877675;
	bh=33bOnRxQYcLjfqzs2eI3Oh4V4hno6AGLyCBS3BV+qEI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=qedYKT008sfimRy+acigTnXvHnZbktrD3wlhAle9191swhFnXzyVS8nvSBS1SynAj
	 fixpH4V60x8FenyTgcW02FrhHWBJc+DIyBzex9/YA9jP7fk6/ROVWIcyVB4l3Wh58D
	 mC4fQNTYzUKkNYlUkWKKmkVq4mzEC5MAVqVwQLUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgG0TVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgG0TVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:21:13 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E08F20738;
        Mon, 27 Jul 2020 19:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595877673;
        bh=33bOnRxQYcLjfqzs2eI3Oh4V4hno6AGLyCBS3BV+qEI=;
        h=Date:From:To:Cc:Subject:From;
        b=ZJIhaNPRUtDouDC2U8eKUF57o48dYvbfveBFRu6iUdzQrQCowwPbY8rWw6P0Ubha5
         Mb7tOaHuYYZxv4WSEjKKoGbwzcs1A/70WzrBYtjdc7ov6KGz933Ln0lnGE+Cz6CKgF
         HT1XRQ9/ZwQMJ3Rri8JKqDRFwQMXpAY0fh7Q0OA8=
Date:   Mon, 27 Jul 2020 14:27:05 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Zwane Mwaikambo <zwanem@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] watchdog: sc1200wdt: Use fallthrough pseudo-keyword
Message-ID: <20200727192705.GA31097@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/watchdog/sc1200wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sc1200wdt.c b/drivers/watchdog/sc1200wdt.c
index 9673eb12dacd..f22ebe89fe13 100644
--- a/drivers/watchdog/sc1200wdt.c
+++ b/drivers/watchdog/sc1200wdt.c
@@ -234,7 +234,7 @@ static long sc1200wdt_ioctl(struct file *file, unsigned int cmd,
 			return -EINVAL;
 		timeout = new_timeout;
 		sc1200wdt_write_data(WDTO, timeout);
-		/* fall through - and return the new timeout */
+		fallthrough;	/* and return the new timeout */
 
 	case WDIOC_GETTIMEOUT:
 		return put_user(timeout * 60, p);
-- 
2.27.0


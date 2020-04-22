Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A741C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7105E2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587553299;
	bh=RvU73F7tLB9ZFjTmEy3uFpOJCsNs03yV0YlJ8KnNps0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ICjQHIVqmBD4HNz98DDm28Xu8giNkogYN/syZ920sfxytD3Ko26AkaeVUyoH8P+7K
	 nPpr0Bdaej8p9PvaeF0Ku7IwxxiUiXccDpqAXwxbmKTOKx+NXLOCCj9jF1RVYazD11
	 DPYqjKTByp6fJlA8RcxLXRYWgbe82lCgoCpLaj9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgDVKBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgDVKBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:01:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F35720774;
        Wed, 22 Apr 2020 10:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549662;
        bh=RvU73F7tLB9ZFjTmEy3uFpOJCsNs03yV0YlJ8KnNps0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oduSSCQBbLQITntmz2gyhvovhDD0B5B8HVaE5V0m9FmyZG/ZxOK6mRRsvE5E75vUl
         3CGAC60iS9d8hbNfsWX9YbKJ6ehPWyHyxc2YEIhf/igQVgDAT4QKExvaE+/ey3/O5C
         ogWVmuEaDzzFkWPTlQiUcsK+kYMmnhu+wvuC4z0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 054/100] misc: echo: Remove unnecessary parentheses and simplify check for zero
Date:   Wed, 22 Apr 2020 11:56:24 +0200
Message-Id: <20200422095032.803893481@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 85dc2c65e6c975baaf36ea30f2ccc0a36a8c8add ]

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

drivers/misc/echo/echo.c:384:27: warning: equality comparison with
extraneous parentheses [-Wparentheses-equality]
        if ((ec->nonupdate_dwell == 0)) {
             ~~~~~~~~~~~~~~~~~~~~^~~~
drivers/misc/echo/echo.c:384:27: note: remove extraneous parentheses
around the comparison to silence this warning
        if ((ec->nonupdate_dwell == 0)) {
            ~                    ^   ~
drivers/misc/echo/echo.c:384:27: note: use '=' to turn this equality
comparison into an assignment
        if ((ec->nonupdate_dwell == 0)) {
                                 ^~
                                 =
1 warning generated.

Remove them and while we're at it, simplify the zero check as '!var' is
used more than 'var == 0'.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/echo/echo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/echo/echo.c b/drivers/misc/echo/echo.c
index 9597e9523cac4..fff13176f9b8b 100644
--- a/drivers/misc/echo/echo.c
+++ b/drivers/misc/echo/echo.c
@@ -454,7 +454,7 @@ int16_t oslec_update(struct oslec_state *ec, int16_t tx, int16_t rx)
 	 */
 	ec->factor = 0;
 	ec->shift = 0;
-	if ((ec->nonupdate_dwell == 0)) {
+	if (!ec->nonupdate_dwell) {
 		int p, logp, shift;
 
 		/* Determine:
-- 
2.20.1




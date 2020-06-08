Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D876C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A6120870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658232;
	bh=laFJJFYyv4B1e4mrKe19o3ReXIflnahoOiDPh8QGyZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YCxc5vvvQS1/hjuT1x9Fa5c4jAOu7mYxXrFwJIHM9TgB+21BxCj3Ke4037XQHleIH
	 5UWLUsYgRYhzh5RJ1L9XCi5nW2Lq6OpdCeAsPn/IEkx0NdANyNJVQUd8nycGL8YFso
	 WTbPxSMP7om5fsJg60EbaFJsjNfbb7zY2fQK/uWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgFHXRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbgFHXN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:13:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D51D0212CC;
        Mon,  8 Jun 2020 23:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658039;
        bh=laFJJFYyv4B1e4mrKe19o3ReXIflnahoOiDPh8QGyZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGRxUixesW2uS95Uj6emrvxSuwqRLDlkZoqsq5jt8q4Ri68zqkYzc5UaBcm5J0trs
         ka4/wdOHnhu2NFuPDI1keFJsGh5Rr4OjrJQKznig5vA+fOK4Sa2advOcgNFX9tjbbQ
         jWpebJk7oMWknOQrOPzbi7xQO+0U/DJjS7gcuDzY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, stable@kernel.org,
        Thiago Macieira <thiago.macieira@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 089/606] fix multiplication overflow in copy_fdtable()
Date:   Mon,  8 Jun 2020 19:03:34 -0400
Message-Id: <20200608231211.3363633-89-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 4e89b7210403fa4a8acafe7c602b6212b7af6c3b ]

cpy and set really should be size_t; we won't get an overflow on that,
since sysctl_nr_open can't be set above ~(size_t)0 / sizeof(void *),
so nr that would've managed to overflow size_t on that multiplication
won't get anywhere near copy_fdtable() - we'll fail with EMFILE
before that.

Cc: stable@kernel.org # v2.6.25+
Fixes: 9cfe015aa424 (get rid of NR_OPEN and introduce a sysctl_nr_open)
Reported-by: Thiago Macieira <thiago.macieira@intel.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index c8a4e4c86e55..abb8b7081d7a 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -70,7 +70,7 @@ static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
  */
 static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
 {
-	unsigned int cpy, set;
+	size_t cpy, set;
 
 	BUG_ON(nfdt->max_fds < ofdt->max_fds);
 
-- 
2.25.1


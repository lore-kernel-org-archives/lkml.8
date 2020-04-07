Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C169CC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB06206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgDGIem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:34:42 -0400
Received: from mx04.melco.co.jp ([192.218.140.144]:53709 "EHLO
        mx04.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgDGIem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 04:34:42 -0400
Received: from mr04.melco.co.jp (mr04 [133.141.98.166])
        by mx04.melco.co.jp (Postfix) with ESMTP id 38F083A402C;
        Tue,  7 Apr 2020 17:34:37 +0900 (JST)
Received: from mr04.melco.co.jp (unknown [127.0.0.1])
        by mr04.imss (Postfix) with ESMTP id 48xLLP0pchzRkCl;
        Tue,  7 Apr 2020 17:34:37 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr04.melco.co.jp (Postfix) with ESMTP id 48xLLP0nP9zRkC5;
        Tue,  7 Apr 2020 17:34:37 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 48xLLP0yMjzRkDG;
        Tue,  7 Apr 2020 17:34:37 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf03.melco.co.jp (Postfix) with ESMTP id 48xLLP0WKjzRjKC;
        Tue,  7 Apr 2020 17:34:37 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 0378YauP028023;
        Tue, 7 Apr 2020 17:34:36 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id CF93017E07A;
        Tue,  7 Apr 2020 17:34:36 +0900 (JST)
Received: from tux554.tad.melco.co.jp (tux100.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id B96D617E079;
        Tue,  7 Apr 2020 17:34:36 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 0378Yass018807;
        Tue, 7 Apr 2020 17:34:36 +0900
From:   Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] exfat: remove 'bps' mount-option
Date:   Tue,  7 Apr 2020 17:34:10 +0900
Message-Id: <20200407083410.79154-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remount fails because exfat_show_options() returns unsupported option 'bps'.
> # mount -o ro,remount
> exfat: Unknown parameter 'bps'

To fix the problem, just remove 'bps' option from exfat_show_options().

Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
---
 fs/exfat/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 2dd62543a4..1b7d2eb034 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -151,7 +151,6 @@ static int exfat_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",iocharset=utf8");
 	else if (sbi->nls_io)
 		seq_printf(m, ",iocharset=%s", sbi->nls_io->charset);
-	seq_printf(m, ",bps=%ld", sb->s_blocksize);
 	if (opts->errors == EXFAT_ERRORS_CONT)
 		seq_puts(m, ",errors=continue");
 	else if (opts->errors == EXFAT_ERRORS_PANIC)
-- 
2.25.0


Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7483CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4713F20732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WzR+R+R3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbgDMQOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:14:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbgDMQOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3Ns4lMw5YQR9EKErAPG8tmaa2b+isBUf0B4fwtlYwFU=; b=WzR+R+R3s/LUj2oSupUIwJbMRz
        8HCzqLqjtoRhaAM9TwuTR3+GdHmHgekZWUIhThRoPtbfvhdjEx6WIbKomtZ1otM5n3FFI5XMXb7Vu
        Ar6fWdHCYaHutNF6BTLLJTdfbHxJcxLi4l/+S31TttnAOt2i6hLcHPI1ER6ruJ14vnXYN42NdfIvj
        J/AhW4IUkl/ufZ2Bqks+z5XqnmmBQph2QdkB3QlkH7zDERLp+4XsWZO99jQ3Zowf/KLrSo87PElVZ
        lyIbS1ed0np2kYohpHkpjzDPBYApgJmuqf2zOy1fReccIM5QFDGqeoHrBtSIGChw7STmnqs+W5VNC
        Rn6495dw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jO1jL-00029B-Fr; Mon, 13 Apr 2020 16:14:39 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH TRIVIAL] printk: fix a typo
Message-ID: <15022308-a15d-7843-4d5b-d72a58efe99c@infradead.org>
Date:   Mon, 13 Apr 2020 09:14:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix typo/spello.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <trivial@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/printk/printk_safe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200413.orig/kernel/printk/printk_safe.c
+++ linux-next-20200413/kernel/printk/printk_safe.c
@@ -20,7 +20,7 @@
  * is later flushed into the main ring buffer via IRQ work.
  *
  * The alternative implementation is chosen transparently
- * by examinig current printk() context mask stored in @printk_context
+ * by examining current printk() context mask stored in @printk_context
  * per-CPU variable.
  *
  * The implementation allows to flush the strings also from another CPU.


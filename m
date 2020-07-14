Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFD9C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF8C229CA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753208;
	bh=G15zM31QICDMV7rJs5RJeHhuMGQu1mL+XeWYE7wr6vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jH01xLh6uvEh+bHbsHDe9m38Jk9s/oyjUpGK1tVa1NG0ijfrSgcSW21U/zUTmH8Ga
	 oFxjapZbJ2IA5oNrNEaD2RCshqE3wxJtWOKPGXmW7o6So4ZcD16CNSLsAu7aDTPh4K
	 BWcJwk12xjhI/p4Cxn3Oy0qPMlOFd0nYZZDI5fgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbgGNTAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731015AbgGNS74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:59:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F001122507;
        Tue, 14 Jul 2020 18:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753196;
        bh=G15zM31QICDMV7rJs5RJeHhuMGQu1mL+XeWYE7wr6vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IeXNbBv/gM4hj/iXPkxL6uUZ6LH/FW2CJ0sABNX4yDoNT9nVkyYU/rjw+Z/KBe1fW
         jJvjokIe/A3zzmVGWVzr9bRVJVr33mSwSkqOSrFr7hSQ8q1I11xb9HigPt3co1Ky6I
         Rbo27OrLmbVZbpnFoQInA5rZUmDugro3nljZZqLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.7 126/166] io_uring: fix memleak in io_sqe_files_register()
Date:   Tue, 14 Jul 2020 20:44:51 +0200
Message-Id: <20200714184121.866656714@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

commit 667e57da358f61b6966e12e925a69e42d912e8bb upstream.

I got a memleak report when doing some fuzz test:

BUG: memory leak
unreferenced object 0x607eeac06e78 (size 8):
  comm "test", pid 295, jiffies 4294735835 (age 31.745s)
  hex dump (first 8 bytes):
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<00000000932632e6>] percpu_ref_init+0x2a/0x1b0
    [<0000000092ddb796>] __io_uring_register+0x111d/0x22a0
    [<00000000eadd6c77>] __x64_sys_io_uring_register+0x17b/0x480
    [<00000000591b89a6>] do_syscall_64+0x56/0xa0
    [<00000000864a281d>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Call percpu_ref_exit() on error path to avoid
refcount memleak.

Fixes: 05f3fb3c5397 ("io_uring: avoid ring quiesce for fixed file set unregister and update")
Cc: stable@vger.kernel.org
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -6751,6 +6751,7 @@ static int io_sqe_files_register(struct
 		for (i = 0; i < nr_tables; i++)
 			kfree(ctx->file_data->table[i].files);
 
+		percpu_ref_exit(&ctx->file_data->refs);
 		kfree(ctx->file_data->table);
 		kfree(ctx->file_data);
 		ctx->file_data = NULL;



Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEAEC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735542468F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844903;
	bh=iBM1w65UJFTOJRont15HkGQodYMg2ICLaa+vsjpa610=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pQOXE8wbVM4z9ZJ7zb70nqOOtsGfQjUBKuWjBj06T0HrZTvM6cIyFQTPYqKLm2CuF
	 JF6vXiMpbHdFbkXcK64QcLn/yUtK60kwO8bbpeL5a6hmwDI5TSvZPkHCnP/PWjosvh
	 9Z6YxBLdsTGEDj4ijYRXJntdClyRFazdh/NTrPS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgCJMzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbgCJMy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:54:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A06782253D;
        Tue, 10 Mar 2020 12:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844898;
        bh=iBM1w65UJFTOJRont15HkGQodYMg2ICLaa+vsjpa610=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sxIcJYFk933ouFXANOq8iLuCzGKnU766UdVPQHPTxeYga4cAGiDh6VqlB/oXe7L3c
         l9WSaGKTmUUKXzd+HDoIxr6vuhOhK1D+9pGaykpYRRddrf7eXO0U7PSFRBR0k5r/+b
         HJ0W0FAgBuQTATvGGMhQSVjvMu4fRZ5s9GuU/qfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+b2098bc44728a4efb3e9@syzkaller.appspotmail.com,
        Greg Hackmann <ghackmann@google.com>,
        Chenbo Feng <fengc@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 5.4 160/168] dma-buf: free dmabuf->name in dma_buf_release()
Date:   Tue, 10 Mar 2020 13:40:06 +0100
Message-Id: <20200310123651.733901630@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

commit d1f37226431f5d9657aa144a40f2383adbcf27e1 upstream.

dma-buf name can be set via DMA_BUF_SET_NAME ioctl, but once set
it never gets freed.

Free it in dma_buf_release().

Fixes: bb2bb9030425 ("dma-buf: add DMA_BUF_SET_NAME ioctls")
Reported-by: syzbot+b2098bc44728a4efb3e9@syzkaller.appspotmail.com
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Chenbo Feng <fengc@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Chenbo Feng <fengc@google.com>
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20191227063204.5813-1-xiyou.wangcong@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma-buf/dma-buf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -108,6 +108,7 @@ static int dma_buf_release(struct inode
 		dma_resv_fini(dmabuf->resv);
 
 	module_put(dmabuf->owner);
+	kfree(dmabuf->name);
 	kfree(dmabuf);
 	return 0;
 }



Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC51EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60CE20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825400;
	bh=O+15IHTHinbKwCpP8DrhT0xXUmz7VokApZ3tUFMr470=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qeHbVdVb3X4ufq5yvFH3DwjytnFHYMk3uwN6QN06NHF65/QdWM+6vv37oL2lkHXnC
	 cJQGSGPYt3Sj4bKcTDHoDhfd52lCkdKVkCiXqg7KVhf4xm9LGh+yhe6HIQ/SaqCUj0
	 2hg4JbmP44Gt1xKzVw43kSTl+6lhlYJjZra30YHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbgERSJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733123AbgERSGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:06:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1AD62087D;
        Mon, 18 May 2020 18:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825170;
        bh=O+15IHTHinbKwCpP8DrhT0xXUmz7VokApZ3tUFMr470=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzIqi1UH/vVNLHFP557F6epjaLuBBvACf6ZGjgSFLit2rsYeDpzYMUrn8znJP7JIQ
         8T7N1xUzkgmZpjj7FMx8Itv7lYe20kIcjGsC5hL/whkif1r96q3PRPx8UT6irzuRmh
         DAVqFJSwikS0QuuJCl//i1yJ+9YgTWsEbqseMJKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam McCoy <adam@forsedomani.com>,
        Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 5.6 156/194] cifs: fix leaked reference on requeued write
Date:   Mon, 18 May 2020 19:37:26 +0200
Message-Id: <20200518173544.207122094@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam McCoy <adam@forsedomani.com>

commit a48137996063d22ffba77e077425f49873856ca5 upstream.

Failed async writes that are requeued may not clean up a refcount
on the file, which can result in a leaked open. This scenario arises
very reliably when using persistent handles and a reconnect occurs
while writing.

cifs_writev_requeue only releases the reference if the write fails
(rc != 0). The server->ops->async_writev operation will take its own
reference, so the initial reference can always be released.

Signed-off-by: Adam McCoy <adam@forsedomani.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifssmb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -2138,8 +2138,8 @@ cifs_writev_requeue(struct cifs_writedat
 			}
 		}
 
+		kref_put(&wdata2->refcount, cifs_writedata_release);
 		if (rc) {
-			kref_put(&wdata2->refcount, cifs_writedata_release);
 			if (is_retryable_error(rc))
 				continue;
 			i += nr_pages;



Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95876C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6010824690
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221781;
	bh=bwUcbKsiuk1GFcZnsPPhemtK+4GzzRGmIVt+Y1sHx1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yRf2xfWzWfOWUhzqvkZsoYk94FXfFufP294GweJv17kBgHvPAU4zJY/MTkEq42CHu
	 xUsQ9O2tYumiG9xGdVyMo6n8l2MRDW4cQtK4xiCXxZNe7RJiR/hPj2qJuj7rkyopBk
	 MssWP4n/I49v6ky0cgH78jgOyAL9LKy2KAwKCXqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387532AbgA1O3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:29:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729239AbgA1O3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:29:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B54324690;
        Tue, 28 Jan 2020 14:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221775;
        bh=bwUcbKsiuk1GFcZnsPPhemtK+4GzzRGmIVt+Y1sHx1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdVYyVKvJaFnr9xbfaQxD88VHyMqDaejAaFJ02jERp2PPxg4Ui4GdBkylUlnrlx+4
         NDZBxCpBg616vrUaed/gkA/phyZ4XkxhpCF523WNdmQMKp/PZ8ebFb/XfCFZGa7Q8L
         SKNXHlueDFOh3ZaE2M4H+6tcGcSnLcl4rOLnNB2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 4.19 76/92] mm, memory_hotplug: update a comment in unregister_memory()
Date:   Tue, 28 Jan 2020 15:08:44 +0100
Message-Id: <20200128135819.174078183@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135809.344954797@linuxfoundation.org>
References: <20200128135809.344954797@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 16df1456aa858a86f398dbc7d27649eb6662b0cc upstream.

The remove_memory_block() function was renamed to in commit
cc292b0b4302 ("drivers/base/memory.c: rename remove_memory_block() to
remove_memory_section()").

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -743,7 +743,7 @@ unregister_memory(struct memory_block *m
 {
 	BUG_ON(memory->dev.bus != &memory_subsys);
 
-	/* drop the ref. we got in remove_memory_block() */
+	/* drop the ref. we got in remove_memory_section() */
 	put_device(&memory->dev);
 	device_unregister(&memory->dev);
 }



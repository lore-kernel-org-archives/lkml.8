Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4C8C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D63920842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340817;
	bh=9sL3KvbCb2vGm3OP5jNO94CpgQ5x9Mz8ykRB6AKRlLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=froGIQAVy3JhEY5orLtOXiJSa9XtCMNOPWiKwhj9/6M0B27f9cPKjIUewb3KVCosq
	 SP7ilOv9P3RkKi/A+WyT1trSQrUbC3pH7P00SNMSfGEwRVypesCPzQcVOrVXoYsEac
	 6hXuddtG+Fjr5fi4rMGeN/00n1lp0x43rxSmL9TU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgBJNUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbgBJMhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:37:42 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAFA62168B;
        Mon, 10 Feb 2020 12:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338261;
        bh=9sL3KvbCb2vGm3OP5jNO94CpgQ5x9Mz8ykRB6AKRlLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AiWhbYHQXD+Adb8dnzGA0KKdOUOATlBIgZtQN9iqOCaPJ1NsxiU19fe0xL/HhJ5CD
         xPxDAq31EaHtZeNHWlh/UWNz8atLaP0ngiQ/ORjN8qSRPIXDOVooLHMpZwsJcPFkCi
         EH5SGSsj9p024iYCm3sco6LjYq50kytyhgarV8MQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 5.4 093/309] ubifs: Fix wrong memory allocation
Date:   Mon, 10 Feb 2020 04:30:49 -0800
Message-Id: <20200210122415.004118599@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

commit edec51374bce779f37fc209a228139c55d90ec8d upstream.

In create_default_filesystem() when we allocate the idx node we must use
the idx_node_size we calculated just one line before, not tmp, which
contains completely other data.

Fixes: c4de6d7e4319 ("ubifs: Refactor create_default_filesystem()")
Cc: stable@vger.kernel.org # v4.20+
Reported-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
Tested-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ubifs/sb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -161,7 +161,7 @@ static int create_default_filesystem(str
 	sup = kzalloc(ALIGN(UBIFS_SB_NODE_SZ, c->min_io_size), GFP_KERNEL);
 	mst = kzalloc(c->mst_node_alsz, GFP_KERNEL);
 	idx_node_size = ubifs_idx_node_sz(c, 1);
-	idx = kzalloc(ALIGN(tmp, c->min_io_size), GFP_KERNEL);
+	idx = kzalloc(ALIGN(idx_node_size, c->min_io_size), GFP_KERNEL);
 	ino = kzalloc(ALIGN(UBIFS_INO_NODE_SZ, c->min_io_size), GFP_KERNEL);
 	cs = kzalloc(ALIGN(UBIFS_CS_NODE_SZ, c->min_io_size), GFP_KERNEL);
 



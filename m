Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48412C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220F42080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340945;
	bh=XLsH/og7nds9+7JWjxVwvyiIrHhkqGnfk/0z9Ma8ezE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P8LmfHHVVyiQMZEuZg99bQiNlpX6q0rATM34cOlZzydOrlg6NZqW4yGQfQ3JgeyT7
	 AgavmFC7qYWaQA+M9H5idjj8l62H2LLYbplabwckUbRH6oLRqUz07Gqhe+oINrbGds
	 F8FsnBfVi/QVRNj0LRo0QsAaWTfi3dN0V08RDmhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgBJNWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:22:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:58894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbgBJMh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:37:26 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C1E120661;
        Mon, 10 Feb 2020 12:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338244;
        bh=XLsH/og7nds9+7JWjxVwvyiIrHhkqGnfk/0z9Ma8ezE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvodtmlXBLZhzK23FUReDMLxZDpbxTU5u6DaELGpGgKDxWwUVxta+Suy/3tnCodWQ
         ypkxGDUOtPklyhGUo+OiKlDjxXFt9f4+KowqzT/m3XXR2bdoOJft/3ZRG5T2YKvB3V
         J/gg52abHdKvi5vUMClOmIkrXHrsXYNftFZ4Hhsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.4 102/309] crypto: ccree - fix backlog memory leak
Date:   Mon, 10 Feb 2020 04:30:58 -0800
Message-Id: <20200210122416.041864509@linuxfoundation.org>
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

From: Gilad Ben-Yossef <gilad@benyossef.com>

commit 4df2ef25b3b3618fd708ab484fe6239abd130fec upstream.

Fix brown paper bag bug of not releasing backlog list item buffer
when backlog was consumed causing a memory leak when backlog is
used.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_request_mgr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/crypto/ccree/cc_request_mgr.c
+++ b/drivers/crypto/ccree/cc_request_mgr.c
@@ -404,6 +404,7 @@ static void cc_proc_backlog(struct cc_dr
 		spin_lock(&mgr->bl_lock);
 		list_del(&bli->list);
 		--mgr->bl_len;
+		kfree(bli);
 	}
 
 	spin_unlock(&mgr->bl_lock);



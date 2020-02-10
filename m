Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80183C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC27208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338152;
	bh=GtwvLBE9l4uu758OTym52pW0P4sLJS2rZ4a7w/zsbv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rfn0zB4vRA/05IqyQ3jxyMx78hz4C2qsuVpg2RMaHA1qMcujmnFnZ0KQu7EbXf2Cx
	 xAra67FpbMHXQnTlUqCRk18A+rEYwpsy09y3RvfqdXpH0/rf4jGR8oIcb52hORbhdU
	 gnkLpcRRaBsLeaCFbOit2j7okUtklx9ofX7Vcu1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgBJMfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:35:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbgBJMfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:31 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B73472467D;
        Mon, 10 Feb 2020 12:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338130;
        bh=GtwvLBE9l4uu758OTym52pW0P4sLJS2rZ4a7w/zsbv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QiJ16h2RpIPi0xahPQiYwwv4g3UDayUa50dZWk/oXoCgH259ZwIIDRWfiHxpGfD2e
         ASjFFxN9fCS8pvePpJwVGPolnpSbc0nZ4PKHv5mUglolUm0CeCGAaHZvG6lqjj2zp5
         mJOwy/hUErojm+pMtDorzTGjBRgQXjqb+pPBVnTQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 074/195] crypto: ccree - fix backlog memory leak
Date:   Mon, 10 Feb 2020 04:32:12 -0800
Message-Id: <20200210122312.986325330@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
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
@@ -403,6 +403,7 @@ static void cc_proc_backlog(struct cc_dr
 		spin_lock(&mgr->bl_lock);
 		list_del(&bli->list);
 		--mgr->bl_len;
+		kfree(bli);
 	}
 
 	spin_unlock(&mgr->bl_lock);



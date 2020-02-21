Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF5CC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C3824682
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273009;
	bh=Xj9uPktyd8h+TZiCVSTuf3BHXFC+ByLgoE3KHYSHwf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IWlgmGBZtXfNJcfyQ5VyH/0jsMDIncFIOmno2oNErRVcSMB+RP+fNg8Ya/x87nD2Q
	 nejvwg1qwAAD/pvqjfiHrdG/nIHRxfLCuWhPdF8yEmMUevdm1428/YlrRjSba/DBLk
	 W8Wx3ZtCSd+GafJ1sVJBNeW4B7TgSQtrBieniefE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbgBUIQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:16:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387566AbgBUIQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:16:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E45E2467B;
        Fri, 21 Feb 2020 08:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273004;
        bh=Xj9uPktyd8h+TZiCVSTuf3BHXFC+ByLgoE3KHYSHwf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gedwdtq6OSh5BupJWC2fdQaneo4MRZJ/MTgngS+57p/ZEDy8BsF4pJnZvMzc9B2Y9
         wF8wG1N6TYMLVedH2aiwaoMIXVeUfqw2Jmhst88iUVVCg6EWRxyUNqt96k4j4SXZRd
         5NxYCCm0qBdeR5KotceYUxjUqFAexyQ2pj/PKhyY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Per Forlin <perfn@axis.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 004/191] net: dsa: tag_qca: Make sure there is headroom for tag
Date:   Fri, 21 Feb 2020 08:39:37 +0100
Message-Id: <20200221072251.310188750@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Per Forlin <per.forlin@axis.com>

[ Upstream commit 04fb91243a853dbde216d829c79d9632e52aa8d9 ]

Passing tag size to skb_cow_head will make sure
there is enough headroom for the tag data.
This change does not introduce any overhead in case there
is already available headroom for tag.

Signed-off-by: Per Forlin <perfn@axis.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/tag_qca.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/dsa/tag_qca.c
+++ b/net/dsa/tag_qca.c
@@ -41,7 +41,7 @@ static struct sk_buff *qca_tag_xmit(stru
 	struct dsa_port *dp = dsa_slave_to_port(dev);
 	u16 *phdr, hdr;
 
-	if (skb_cow_head(skb, 0) < 0)
+	if (skb_cow_head(skb, QCA_HDR_LEN) < 0)
 		return NULL;
 
 	skb_push(skb, QCA_HDR_LEN);



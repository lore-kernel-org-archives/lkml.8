Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15CEC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6BC206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099768;
	bh=OB5cdMgX0DfmvgcahTQN1oU2ujswn+ZP+iedL5rqzVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sTXYF150n4XqfnVHJviJkc7+XuykflsIEQmOjpAhhB7VJ9vF/DaTd6y3Pnujni7R1
	 Xj/0TmHsz/U7VZd62Bbk/hHSkmocTKyn0YNk6DBL7Wisb93plS49BE3/3KBFU0IyyE
	 Re+hFCxoEOaZKpV31LkJySz1jI0BUsDm6amjHPeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbgD1StW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730905AbgD1SkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:40:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2FEF20575;
        Tue, 28 Apr 2020 18:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099217;
        bh=OB5cdMgX0DfmvgcahTQN1oU2ujswn+ZP+iedL5rqzVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcMbnfAhjUHMoxUqfE9OwGk5WqMH+Z147wwYazEVNmYOjJBDumSAQ07mq3GoXOMoa
         zIePQoPByM6aGKCCMVQrLYLemso9l3uH9PKQnEwiIWOlgWHDkDkjBW//hT8t/Fpz9K
         csBASrKNZqHZ1msI5M492R/SE2QZHzg7X33dDxeg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 075/168] net: dsa: b53: Fix valid setting for MDB entries
Date:   Tue, 28 Apr 2020 20:24:09 +0200
Message-Id: <20200428182241.590684350@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit eab167f4851a19c514469dfa81147f77e17b5b20 ]

When support for the MDB entries was added, the valid bit was correctly
changed to be assigned depending on the remaining port bitmask, that is,
if there were no more ports added to the entry's port bitmask, the entry
now becomes invalid. There was another assignment a few lines below that
would override this which would invalidate entries even when there were
still multiple ports left in the MDB entry.

Fixes: 5d65b64a3d97 ("net: dsa: b53: Add support for MDB")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/b53/b53_common.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1515,7 +1515,6 @@ static int b53_arl_op(struct b53_device
 
 	memset(&ent, 0, sizeof(ent));
 	ent.port = port;
-	ent.is_valid = is_valid;
 	ent.vid = vid;
 	ent.is_static = true;
 	memcpy(ent.mac, addr, ETH_ALEN);



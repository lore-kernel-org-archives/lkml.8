Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58973C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3033F20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823526;
	bh=aFUTyjB84LtmFYdF74WD3KpQt5EZkYCI96cgLucpqz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0+OLNDLHbOVB6m85KVwNHhiiQTt5v+MuQlx26twWejZ8mo9dFbDtMitRSzwPSp5YE
	 963rdoQO1XuASAI4vvTwBpHwytXnBDl9zngVE8GCtoBKQCZtSq9DPNRwIRriXa+Qqj
	 KgI8HSIMRCYd7fxyYXQstlWV22Wsb0hB+3C92TaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgERRio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:32904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbgERRim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:38:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08D9D20835;
        Mon, 18 May 2020 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823521;
        bh=aFUTyjB84LtmFYdF74WD3KpQt5EZkYCI96cgLucpqz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+EQbk4YslU+Rxgv/ij5vJ6h1owPaAoqRZxbLhAEhPiGODlIycDJmZfvQMjGovw11
         r05TbIIA1SqL/UmOxRXesWC18tYNX4oQxN5Lvst6zFsrord1w7qE37ZcfpEwK3g0mZ
         BcHBtiJ+cvW2F6Z7cIXzAigHa6md5LZnNj85RH9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Govindarajulu Varadarajan <gvaradar@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 08/86] enic: do not overwrite error code
Date:   Mon, 18 May 2020 19:35:39 +0200
Message-Id: <20200518173452.013849689@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.254571947@linuxfoundation.org>
References: <20200518173450.254571947@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Govindarajulu Varadarajan <gvaradar@cisco.com>

commit 56f772279a762984f6e9ebbf24a7c829faba5712 upstream.

In failure path, we overwrite err to what vnic_rq_disable() returns. In
case it returns 0, enic_open() returns success in case of error.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Fixes: e8588e268509 ("enic: enable rq before updating rq descriptors")
Signed-off-by: Govindarajulu Varadarajan <gvaradar@cisco.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/cisco/enic/enic_main.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1708,7 +1708,7 @@ static int enic_open(struct net_device *
 {
 	struct enic *enic = netdev_priv(netdev);
 	unsigned int i;
-	int err;
+	int err, ret;
 
 	err = enic_request_intr(enic);
 	if (err) {
@@ -1766,10 +1766,9 @@ static int enic_open(struct net_device *
 
 err_out_free_rq:
 	for (i = 0; i < enic->rq_count; i++) {
-		err = vnic_rq_disable(&enic->rq[i]);
-		if (err)
-			return err;
-		vnic_rq_clean(&enic->rq[i], enic_free_rq_buf);
+		ret = vnic_rq_disable(&enic->rq[i]);
+		if (!ret)
+			vnic_rq_clean(&enic->rq[i], enic_free_rq_buf);
 	}
 	enic_dev_notify_unset(enic);
 err_out_free_intr:



Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ADEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4DE24685
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220124;
	bh=GblreWZ+JRtAI9Ywunt0o62CX5WRB6D8ta66N+lyYlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cw31FiQEgLjV0SjCbtwWVO1z1CiCu5NfvVt2+XVMwSUjeSMXDf78Lhn1VyzNwtFXS
	 /g6PVaDONut0hVFFd56zihFHNNjwPqBwumwGbPUpOqvKGYPivnQT+rQ9RRD2Z5Agur
	 bchx44qL+UWux/lXZi3Qb79Pp8ZqegVggYtv4pTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgA1OCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:02:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgA1OB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:01:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6252624685;
        Tue, 28 Jan 2020 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220116;
        bh=GblreWZ+JRtAI9Ywunt0o62CX5WRB6D8ta66N+lyYlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+3Fxzq+ra9s2sFdiIK8qNHJEyo7x3IxkB8uVj1eO0BfvZnex2aXIEA/0NUnJEjlp
         k3QNdc4pdPjuL49r0cbOiOWWwx9FpAd7s/zDfvsNU5mmJYW6rV4IXGfUC3ULQf9ZLK
         nVEFXvo0Lz4BWcas9rV3l6KLa5bP8eXYx0buPrME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 006/104] net: cxgb3_main: Add CAP_NET_ADMIN check to CHELSIO_GET_MEM
Date:   Tue, 28 Jan 2020 14:59:27 +0100
Message-Id: <20200128135818.138777535@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135817.238524998@linuxfoundation.org>
References: <20200128135817.238524998@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 3546d8f1bbe992488ed91592cf6bf76e7114791a =

The cxgb3 driver for "Chelsio T3-based gigabit and 10Gb Ethernet
adapters" implements a custom ioctl as SIOCCHIOCTL/SIOCDEVPRIVATE in
cxgb_extension_ioctl().

One of the subcommands of the ioctl is CHELSIO_GET_MEM, which appears
to read memory directly out of the adapter and return it to userspace.
It's not entirely clear what the contents of the adapter memory
contains, but the assumption is that it shouldn't be accessible to all
users.

So add a CAP_NET_ADMIN check to the CHELSIO_GET_MEM case. Put it after
the is_offload() check, which matches two of the other subcommands in
the same function which also check for is_offload() and CAP_NET_ADMIN.

Found by Ilja by code inspection, not tested as I don't have the
required hardware.

Reported-by: Ilja Van Sprundel <ivansprundel@ioactive.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -2448,6 +2448,8 @@ static int cxgb_extension_ioctl(struct n
 
 		if (!is_offload(adapter))
 			return -EOPNOTSUPP;
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
 		if (!(adapter->flags & FULL_INIT_DONE))
 			return -EIO;	/* need the memory controllers */
 		if (copy_from_user(&t, useraddr, sizeof(t)))



Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953BBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786772086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823554;
	bh=R3OFtDSNSKo9Y6kM7usTYKgPt88aIPs/IFl0nxhwCEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zYhBbOPwjjstnSJKxZKGlZQUkN/iC6ime8GxNgvZuRT1Z40Oc0MGBi5Po0PPcfIII
	 iGt2vuyu9Mf6b1krq771VXOBoThWaVYFw3SU+MwQFvmT2/R/xmurXGrWxDtLYIr5+Q
	 aP34BhxNpndomkKBv864n+KDdv1IA5yeV5zKA3BA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgERRjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728710AbgERRjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:39:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 922C220873;
        Mon, 18 May 2020 17:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823551;
        bh=R3OFtDSNSKo9Y6kM7usTYKgPt88aIPs/IFl0nxhwCEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GoIBiYuYW1rDUMO8xrgZbUvS9UK34R4m0+eZlPrU+ZsDzRbMos3DIwb5UYYGNagSB
         dg5D1syWOOukArRnggoGUk1SP632thuh0evyUuoDizWmFvyAiA2nplonuCgV6mYiw1
         elYWgSkQu/JG2aXcfB0aYO/A+n3g1JV9ijdSqt2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 28/86] ptp: do not explicitly set drvdata in ptp_clock_register()
Date:   Mon, 18 May 2020 19:35:59 +0200
Message-Id: <20200518173456.193877073@linuxfoundation.org>
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

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 882f312dc0751c973db26478f07f082c584d16aa upstream.

We do not need explicitly call dev_set_drvdata(), as it is done for us by
device_create().

Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ptp/ptp_clock.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -220,8 +220,6 @@ struct ptp_clock *ptp_clock_register(str
 	if (IS_ERR(ptp->dev))
 		goto no_device;
 
-	dev_set_drvdata(ptp->dev, ptp);
-
 	err = ptp_populate_sysfs(ptp);
 	if (err)
 		goto no_sysfs;



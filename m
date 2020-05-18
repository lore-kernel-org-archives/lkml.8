Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F088DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91912065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826487;
	bh=18kelMiuxmlsuUdBZVM0nsM6j/squYz1UglbO0FLr6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SJlYvjHosFlnwhBfynDYGsMoeYsVAO3HDJCWCcQjcaq6kt20wmqZpac3BV4Aw6l7y
	 QI0e/vIcNzZ3NwHH6lRnt3CrZp+GYIzqt7ieho0oGlxVj+kUq1dI+x+lweolZ1p5GS
	 62V7+A7R8AHuAQbr43+58pYzR7VObzrXcirgQT8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbgERS2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbgERRnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:43:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7345B20715;
        Mon, 18 May 2020 17:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823795;
        bh=18kelMiuxmlsuUdBZVM0nsM6j/squYz1UglbO0FLr6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SZNrCwoniH1mkkalcbT6RdWXNMp2Z1N7xprmweDKQVsb8J3npBS85jC2h5VagUFI0
         RjxS12fHA+hV/d15DXbKKKNPWtOYTus58W8+YoNDMDorHq/qKIumsi/xb5WkH04Uzk
         TVv4me1Fy54CeD8BsDc0PTOlK+N7oddiQSvHnxKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Antti Laakso <antti.laakso@intel.com>,
        Vladis Dronov <vdronov@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 40/90] ptp: free ptp device pin descriptors properly
Date:   Mon, 18 May 2020 19:36:18 +0200
Message-Id: <20200518173459.303551655@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladis Dronov <vdronov@redhat.com>

commit 75718584cb3c64e6269109d4d54f888ac5a5fd15 upstream.

There is a bug in ptp_clock_unregister(), where ptp_cleanup_pin_groups()
first frees ptp->pin_{,dev_}attr, but then posix_clock_unregister() needs
them to destroy a related sysfs device.

These functions can not be just swapped, as posix_clock_unregister() frees
ptp which is needed in the ptp_cleanup_pin_groups(). Fix this by calling
ptp_cleanup_pin_groups() in ptp_clock_release(), right before ptp is freed.

This makes this patch fix an UAF bug in a patch which fixes an UAF bug.

Reported-by: Antti Laakso <antti.laakso@intel.com>
Fixes: a33121e5487b ("ptp: fix the race between the release of ptp_clock and cdev")
Link: https://lore.kernel.org/netdev/3d2bd09735dbdaf003585ca376b7c1e5b69a19bd.camel@intel.com/
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ptp/ptp_clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 2c1ae324da182..bf1536f1c90bb 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -175,6 +175,7 @@ static void ptp_clock_release(struct device *dev)
 {
 	struct ptp_clock *ptp = container_of(dev, struct ptp_clock, dev);
 
+	ptp_cleanup_pin_groups(ptp);
 	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	ida_simple_remove(&ptp_clocks_map, ptp->index);
@@ -276,9 +277,8 @@ int ptp_clock_unregister(struct ptp_clock *ptp)
 	if (ptp->pps_source)
 		pps_unregister_source(ptp->pps_source);
 
-	ptp_cleanup_pin_groups(ptp);
-
 	posix_clock_unregister(&ptp->clock);
+
 	return 0;
 }
 EXPORT_SYMBOL(ptp_clock_unregister);
-- 
2.20.1




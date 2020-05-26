Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188CAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8036208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519925;
	bh=4M5deWG5jIa6iI19py38thQWtE2UPrGfLPREoxU3En4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rpSXYHCKhNXdlUF6yfkNIy1uf1ja8klJg3xn3uUa78qD+sIZ0Mp6pTHeR2Z3PrlD+
	 /niq/n5epkmXY9/EhuReWI1VpteTqqv3X5KG6noHO6PXPQIIC5C/YTdOq8nWePbjgb
	 +Ou3Od4PDZhdqEYo0j6OBqXB73XiOacIQ24R4ZgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390626AbgEZTFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391486AbgEZTFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:05:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DBBB20873;
        Tue, 26 May 2020 19:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519918;
        bh=4M5deWG5jIa6iI19py38thQWtE2UPrGfLPREoxU3En4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifZgnEfj8Ng08qNNqkyTkbFUEKrO2oefqwDdj6pPTQy734kneEzJTJmif4Okr9Zgv
         h4z57bcfovPv97rpc9ECjyY1DISGZN6upBbyXNLorV4aNi7+fjG8AJb1iAAwRWeZR4
         lES2XbKT0ko5NDe8H4ccFudo7+0cHbBUoZTQ0TAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Klaus Doth <kdlnx@doth.eu>
Subject: [PATCH 4.19 69/81] misc: rtsx: Add short delay after exit from ASPM
Date:   Tue, 26 May 2020 20:53:44 +0200
Message-Id: <20200526183934.709077655@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Klaus Doth <kdlnx@doth.eu>

commit 7a839dbab1be59f5ed3b3b046de29e166784c9b4 upstream.

DMA transfers to and from the SD card stall for 10 seconds and run into
timeout on RTS5260 card readers after ASPM was enabled.

Adding a short msleep after disabling ASPM fixes the issue on several
Dell Precision 7530/7540 systems I tested.

This function is only called when waking up after the chip went into
power-save after not transferring data for a few seconds. The added
msleep does therefore not change anything in data transfer speed or
induce any excessive waiting while data transfers are running, or the
chip is sleeping. Only the transition from sleep to active is affected.

Signed-off-by: Klaus Doth <kdlnx@doth.eu>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/4434eaa7-2ee3-a560-faee-6cee63ebd6d4@doth.eu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/cardreader/rtsx_pcr.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -155,6 +155,9 @@ static void rtsx_comm_pm_full_on(struct
 
 	rtsx_disable_aspm(pcr);
 
+	/* Fixes DMA transfer timout issue after disabling ASPM on RTS5260 */
+	msleep(1);
+
 	if (option->ltr_enabled)
 		rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
 



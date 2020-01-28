Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8017DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5378D207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221707;
	bh=jxyCRKHd0fDIu343tBn5ZNUxn+VXjYVhvW/u9UIssOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K9SAWiSu7vdy+rXVp2IsHYkKrUza92B3RjpHXRfultXIjFXRNe/SbuPhHploW9ReY
	 IgOiiksL6QNssgLih940b7BH11JXoe4vgNah+ew7HO4pJwa0S/mdTwTr5lASYOXU35
	 WK+8PFgKbP2LYLD/mwnWD2lsoDFbklRaiI5tru28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733152AbgA1O20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:28:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730602AbgA1O2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:28:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D794321739;
        Tue, 28 Jan 2020 14:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221703;
        bh=jxyCRKHd0fDIu343tBn5ZNUxn+VXjYVhvW/u9UIssOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OZjKhcuNiPR3CWGHQR3RjOOienaFsLLOgUZ1HGTxL1ALjjKQzL/yg60I9/vAzuHG7
         HWQyxmIi7LtqnGuAZWFZxdkLioxOP4+Qo4+JjG5/fUb8vqo7VCQgG0udBF7a6gQLT1
         CquKS5ch8Q20zsQWpgQEI+eISjFl2JLJQLsQcUTo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilles Buloz <gilles.buloz@kontron.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.19 40/92] hwmon: (nct7802) Fix voltage limits to wrong registers
Date:   Tue, 28 Jan 2020 15:08:08 +0100
Message-Id: <20200128135814.213073529@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135809.344954797@linuxfoundation.org>
References: <20200128135809.344954797@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gilles Buloz <gilles.buloz@kontron.com>

commit 7713e62c8623c54dac88d1fa724aa487a38c3efb upstream.

in0 thresholds are written to the in2 thresholds registers
in2 thresholds to in3 thresholds
in3 thresholds to in4 thresholds
in4 thresholds to in0 thresholds

Signed-off-by: Gilles Buloz <gilles.buloz@kontron.com>
Link: https://lore.kernel.org/r/5de0f509.rc0oEvPOMjbfPW1w%gilles.buloz@kontron.com
Fixes: 3434f3783580 ("hwmon: Driver for Nuvoton NCT7802Y")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/nct7802.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -32,8 +32,8 @@
 static const u8 REG_VOLTAGE[5] = { 0x09, 0x0a, 0x0c, 0x0d, 0x0e };
 
 static const u8 REG_VOLTAGE_LIMIT_LSB[2][5] = {
-	{ 0x40, 0x00, 0x42, 0x44, 0x46 },
-	{ 0x3f, 0x00, 0x41, 0x43, 0x45 },
+	{ 0x46, 0x00, 0x40, 0x42, 0x44 },
+	{ 0x45, 0x00, 0x3f, 0x41, 0x43 },
 };
 
 static const u8 REG_VOLTAGE_LIMIT_MSB[5] = { 0x48, 0x00, 0x47, 0x47, 0x48 };



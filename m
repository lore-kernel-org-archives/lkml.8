Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6970CC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3565420678
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699133;
	bh=i5LGxRby5DJsvcfekIq4ozkKD+9xhtVq6Jkdof7oRi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vveJTmXEBUPbZljAhDk1SjR9Cxc72SloBjpg6//WwqdO4UE2elu8VwIjlKPPFahw/
	 8GQYuiTCYeK8X5vHof7MwaxwGIIHV60zbrnDwQuPFKPTN3Jx6z0g19voDE+7HUrBoY
	 KbVwfDjKKPkOC6IO0Zp5ms4Mqsdb5/L1m4vpH6Uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgAVNSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:18:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729424AbgAVNSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:18:46 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B32520678;
        Wed, 22 Jan 2020 13:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699126;
        bh=i5LGxRby5DJsvcfekIq4ozkKD+9xhtVq6Jkdof7oRi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHtCm11guWWda6zZN/p5IdtdoaYWPCpsoKqImdSgC5ZTTXa45PsclgZFQ8L8qWUXt
         srS4tOLA3HTIzttH2AGPc62M8BlsuWSjB/zRrualXusTa2ATL9oxEkcMJpgAyrgAFm
         Q+MRtSL33VaN+n/XrFFQoHFThuhFrItykBbV1Rk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 049/222] USB: serial: io_edgeport: handle unbound ports on URB completion
Date:   Wed, 22 Jan 2020 10:27:15 +0100
Message-Id: <20200122092837.111988670@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit e37d1aeda737a20b1846a91a3da3f8b0f00cf690 upstream.

Check for NULL port data in the shared interrupt and bulk completion
callbacks to avoid dereferencing a NULL pointer in case a device sends
data for a port device which isn't bound to a driver (e.g. due to a
malicious device having unexpected endpoints or after an allocation
failure on port probe).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/io_edgeport.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -716,7 +716,7 @@ static void edge_interrupt_callback(stru
 			if (txCredits) {
 				port = edge_serial->serial->port[portNumber];
 				edge_port = usb_get_serial_port_data(port);
-				if (edge_port->open) {
+				if (edge_port && edge_port->open) {
 					spin_lock_irqsave(&edge_port->ep_lock,
 							  flags);
 					edge_port->txCredits += txCredits;
@@ -1825,7 +1825,7 @@ static void process_rcvd_data(struct edg
 				port = edge_serial->serial->port[
 							edge_serial->rxPort];
 				edge_port = usb_get_serial_port_data(port);
-				if (edge_port->open) {
+				if (edge_port && edge_port->open) {
 					dev_dbg(dev, "%s - Sending %d bytes to TTY for port %d\n",
 						__func__, rxLen,
 						edge_serial->rxPort);



Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77AFC54FCA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDA324656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813625;
	bh=kUKSzHdRRHXlQaZVmuHIoD/S65nhOWHRv5mf2gtz24U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gquwPUUctbQd3A5EC6vHDkyd8oJb4tg3rBn/xNYeaICoKtLZLYSSrIuLycZvxwvuZ
	 V4qwQlxm68FH4UXS1zy4HxfzyyPDLJgV3JwbKFlnc5EefX10TPnEIKlGquAN5axR94
	 PKXA1n+B3NFEeNrRy99PVJ9Y2VpDvsWB9IdfCVQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbgB0OJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:09:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:47064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388311AbgB0OJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:09:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8192E24656;
        Thu, 27 Feb 2020 14:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812549;
        bh=kUKSzHdRRHXlQaZVmuHIoD/S65nhOWHRv5mf2gtz24U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYGnjdSdEDs+yfquiP/T7IL7Lc0ZQyZLcNtmufrTms4+e4x9FAOduO367FpUrPq/H
         t0PKm4/RRlbJFVh5LU14S4YVr7/8WfjNmga0NqzKQudjhBZXA8m4YK4v8iRLvbPXjW
         0qlcg7X+kdxdX7qkYGYmi9ZNYqCJde8VEGx/xeLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 059/135] serdev: ttyport: restore client ops on deregistration
Date:   Thu, 27 Feb 2020 14:36:39 +0100
Message-Id: <20200227132237.907077913@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132228.710492098@linuxfoundation.org>
References: <20200227132228.710492098@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 0c5aae59270fb1f827acce182786094c9ccf598e upstream.

The serdev tty-port controller driver should reset the tty-port client
operations also on deregistration to avoid a NULL-pointer dereference in
case the port is later re-registered as a normal tty device.

Note that this can only happen with tty drivers such as 8250 which have
statically allocated port structures that can end up being reused and
where a later registration would not register a serdev controller (e.g.
due to registration errors or if the devicetree has been changed in
between).

Specifically, this can be an issue for any statically defined ports that
would be registered by 8250 core when an 8250 driver is being unbound.

Fixes: bed35c6dfa6a ("serdev: add a tty port controller driver")
Cc: stable <stable@vger.kernel.org>     # 4.11
Reported-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20200210145730.22762-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serdev/serdev-ttyport.c |    6 ++----
 drivers/tty/tty_port.c              |    5 +++--
 include/linux/tty.h                 |    2 ++
 3 files changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -265,7 +265,6 @@ struct device *serdev_tty_port_register(
 					struct device *parent,
 					struct tty_driver *drv, int idx)
 {
-	const struct tty_port_client_operations *old_ops;
 	struct serdev_controller *ctrl;
 	struct serport *serport;
 	int ret;
@@ -284,7 +283,6 @@ struct device *serdev_tty_port_register(
 
 	ctrl->ops = &ctrl_ops;
 
-	old_ops = port->client_ops;
 	port->client_ops = &client_ops;
 	port->client_data = ctrl;
 
@@ -297,7 +295,7 @@ struct device *serdev_tty_port_register(
 
 err_reset_data:
 	port->client_data = NULL;
-	port->client_ops = old_ops;
+	port->client_ops = &tty_port_default_client_ops;
 	serdev_controller_put(ctrl);
 
 	return ERR_PTR(ret);
@@ -312,8 +310,8 @@ int serdev_tty_port_unregister(struct tt
 		return -ENODEV;
 
 	serdev_controller_remove(ctrl);
-	port->client_ops = NULL;
 	port->client_data = NULL;
+	port->client_ops = &tty_port_default_client_ops;
 	serdev_controller_put(ctrl);
 
 	return 0;
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -52,10 +52,11 @@ static void tty_port_default_wakeup(stru
 	}
 }
 
-static const struct tty_port_client_operations default_client_ops = {
+const struct tty_port_client_operations tty_port_default_client_ops = {
 	.receive_buf = tty_port_default_receive_buf,
 	.write_wakeup = tty_port_default_wakeup,
 };
+EXPORT_SYMBOL_GPL(tty_port_default_client_ops);
 
 void tty_port_init(struct tty_port *port)
 {
@@ -68,7 +69,7 @@ void tty_port_init(struct tty_port *port
 	spin_lock_init(&port->lock);
 	port->close_delay = (50 * HZ) / 100;
 	port->closing_wait = (3000 * HZ) / 100;
-	port->client_ops = &default_client_ops;
+	port->client_ops = &tty_port_default_client_ops;
 	kref_init(&port->kref);
 }
 EXPORT_SYMBOL(tty_port_init);
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -225,6 +225,8 @@ struct tty_port_client_operations {
 	void (*write_wakeup)(struct tty_port *port);
 };
 
+extern const struct tty_port_client_operations tty_port_default_client_ops;
+
 struct tty_port {
 	struct tty_bufhead	buf;		/* Locked internally */
 	struct tty_struct	*tty;		/* Back pointer */



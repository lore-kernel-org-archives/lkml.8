Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A460C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7502085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338122;
	bh=iJIScaKcBBiAXvtWaUrzFmJW9LfZUpxI49wQF0wdBig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rrwKXcdDt1jvMHgE6hsoDS1XN2PGg1jVHCdKRVQZRlvjZuB1Ey7xal3VdtccrjyqN
	 qvVErYE++5UVvTICrOrzytYeWvEv1SWnLC3g+9Zg/n0FfRAtjb7mPQajJC4m69zr96
	 05dno64FTZgyH2bsX3AeiGqaVq/iGm0/00XfXPO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgBJMfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:35:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:51662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbgBJMfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:09 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32FB52168B;
        Mon, 10 Feb 2020 12:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338109;
        bh=iJIScaKcBBiAXvtWaUrzFmJW9LfZUpxI49wQF0wdBig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rpfzdyBBlx9tduUOA3S6+qhl1Jbhw97+h6t8YK0r3wCWIOifqclxh7YykReZFrcy1
         1GUJdlBzVS5wb79msFKCb6Toxpuz5z4NFDvXaark9HAeUSYkZyGz0QFn236aStoXNZ
         KRwk84PmxHOSLj0CoJ0+0vedDm5uSfu9Y8sJyg0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Jun <jun.li@nxp.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.19 032/195] usb: typec: tcpci: mask event interrupts when remove driver
Date:   Mon, 10 Feb 2020 04:31:30 -0800
Message-Id: <20200210122309.639639914@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jun Li <jun.li@nxp.com>

commit 3ba76256fc4e2a0d7fb26cc95459041ea0e88972 upstream.

This is to prevent any possible events generated while unregister
tpcm port.

Fixes: 74e656d6b055 ("staging: typec: Type-C Port Controller Interface driver (tcpci)")
Signed-off-by: Li Jun <jun.li@nxp.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/1579502333-4145-1-git-send-email-jun.li@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/tcpci.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/typec/tcpci.c
+++ b/drivers/usb/typec/tcpci.c
@@ -581,6 +581,12 @@ static int tcpci_probe(struct i2c_client
 static int tcpci_remove(struct i2c_client *client)
 {
 	struct tcpci_chip *chip = i2c_get_clientdata(client);
+	int err;
+
+	/* Disable chip interrupts before unregistering port */
+	err = tcpci_write16(chip->tcpci, TCPC_ALERT_MASK, 0);
+	if (err < 0)
+		return err;
 
 	tcpci_unregister_port(chip->tcpci);
 



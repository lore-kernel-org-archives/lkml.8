Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6E6C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8491F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845887;
	bh=F+0TqD+X8sIsI6owgc1H/U6SPBKg/yevNWDS2WQHKNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T/iKIEA6DKEhwpV4mJsVSCekY8CyCODHYSCkuB4eI8/Nh6EYGmv3qaKqbLvYN/x63
	 5RfJr46sYpKHfGUz7WuqgrBw5jQhHJaGGR8Jk914exDrEle9wiCi1s3Xyes3tptkSY
	 j1uz17Q/MlcFHsY/+sICLESlNJvbFSk61jcqPwnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgCJNL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbgCJNLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:11:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1EF6208E4;
        Tue, 10 Mar 2020 13:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845878;
        bh=F+0TqD+X8sIsI6owgc1H/U6SPBKg/yevNWDS2WQHKNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fr+6V9u+20cFzZOxvSoH+AQGb/Utc8ze+2vC+paHgadEXbqQJSJINE7UrTcW1zHLS
         EmFsyOy8/Z2WDEIUk7VBjq73z1p4VxoF6BGaFfQ2iquW9qHvoN1BeJkFcwZpCyJDDK
         DtFt0FzhASlQBd59mF/RiwKvK1gpzLkFh3kB8ZMI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, tangbin <tangbin@cmss.chinamobile.com>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4.14 101/126] tty:serial:mvebu-uart:fix a wrong return
Date:   Tue, 10 Mar 2020 13:42:02 +0100
Message-Id: <20200310124210.125553802@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
References: <20200310124203.704193207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tangbin <tangbin@cmss.chinamobile.com>

commit 4a3e208474204e879d22a310b244cb2f39e5b1f8 upstream.

in this place, the function should return a
negative value and the PTR_ERR already returns
a negative,so return -PTR_ERR() is wrong.

Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Jiri Slaby <jslaby@suse.cz>
Link: https://lore.kernel.org/r/20200305013823.20976-1-tangbin@cmss.chinamobile.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/mvebu-uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -581,7 +581,7 @@ static int mvebu_uart_probe(struct platf
 
 	port->membase = devm_ioremap_resource(&pdev->dev, reg);
 	if (IS_ERR(port->membase))
-		return -PTR_ERR(port->membase);
+		return PTR_ERR(port->membase);
 
 	data = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_uart_data),
 			    GFP_KERNEL);



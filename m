Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03D7C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9872072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218248;
	bh=+WiKHkloAlLpAzCZp4UZ8FL8lS55nC7i7zkYhXgF1Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=flaiIRZ2WHUxKWM3ZzSQNmaxVPRzhWh05djYNlF+jSmboLZaxQL3imIcpB2JPUK5L
	 E/hPJMRrCIQEhmSeXz+LgcINrkmoJXIH42SAfsXB+V7GNCRoSMsyOqYxo2kEWLag5T
	 hkJ0geUA+F7xkKgpopnp6b2CDsTxOr2OPYIixdAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbgAPXYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:24:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733295AbgAPXYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:24:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D5DD2075B;
        Thu, 16 Jan 2020 23:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217059;
        bh=+WiKHkloAlLpAzCZp4UZ8FL8lS55nC7i7zkYhXgF1Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E6I7baYOxq1ZZQRzf/HSvm14CcSLuVGAmF+0vzQLjqT8+SeW63bq9K1VXmxcK6Im9
         eo8intES3qn8IW26piXa0AJQpmLS+93KQjFrndATsBLDUPBnnE8d0pGNMOPCKZuyq+
         GCAzH/yvRyljJhcxQoJmSXRTaldmYvqU6Vs06/9g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.4 131/203] compat_ioctl: handle SIOCOUTQNSD
Date:   Fri, 17 Jan 2020 00:17:28 +0100
Message-Id: <20200116231756.593290101@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 9d7bf41fafa5b5ddd4c13eb39446b0045f0a8167 upstream.

Unlike the normal SIOCOUTQ, SIOCOUTQNSD was never handled in compat
mode. Add it to the common socket compat handler along with similar
ones.

Fixes: 2f4e1b397097 ("tcp: ioctl type SIOCOUTQNSD returns amount of data not sent")
Cc: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/socket.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/socket.c
+++ b/net/socket.c
@@ -3532,6 +3532,7 @@ static int compat_sock_ioctl_trans(struc
 	case SIOCSARP:
 	case SIOCGARP:
 	case SIOCDARP:
+	case SIOCOUTQNSD:
 	case SIOCATMARK:
 		return sock_do_ioctl(net, sock, cmd, arg);
 	}



Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C788C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CF024685
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685675;
	bh=QShch5yP5fgS7GnlmpBmfX8k+hfvh+epfN/4DjWZQQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qqL0tjaWUPwpKcEWAWpLHc9JDRz5QudnVddP3ql076klIOiVynUCxkuP6IGGlNEJ5
	 FMq3Dm1OFp6u2DWEqhyHkiEcLJ96v7X7QgZkjIwDFx8Zvs5xoN13lZaYCkMWFV/x7v
	 Jyn5fK7AmCB335b+Z/JMf1yINRgxtCMHUfZVGnXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbgAVJee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729970AbgAVJeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:34:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E66B824673;
        Wed, 22 Jan 2020 09:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685670;
        bh=QShch5yP5fgS7GnlmpBmfX8k+hfvh+epfN/4DjWZQQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MgUd55xZE2PduXiqHEp4A3YBobTrW/SRVZ9dK1vCIhuUNFND/8p5Oh+B33UNY3EgC
         oWZhGf+W3ntxAq5cMEOTCrWb6WShmbUUSiPEW7fvHf0jScOAaFErLdilivu7ckgqub
         yToLeD3PU98OJHaOtFBEmTFgx2eQYF6QS5fxbGtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 32/97] compat_ioctl: handle SIOCOUTQNSD
Date:   Wed, 22 Jan 2020 10:28:36 +0100
Message-Id: <20200122092801.626804167@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
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
@@ -3160,6 +3160,7 @@ static int compat_sock_ioctl_trans(struc
 	case SIOCSARP:
 	case SIOCGARP:
 	case SIOCDARP:
+	case SIOCOUTQNSD:
 	case SIOCATMARK:
 		return sock_do_ioctl(net, sock, cmd, arg);
 	}



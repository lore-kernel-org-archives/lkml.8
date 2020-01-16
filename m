Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB2DC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E902073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217373;
	bh=Tv5X94cUn6Cb0NxK31Lnn8p5Qz5H+ux/LUAcJ4MC3k4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xW47ivfmAD15pitTnsHl7cWK/PVJF2hWNqLW7Bzp1mxKAlYPjcuPURQwjCRGCcMFW
	 HJhQ7KahfIbEoC53o1hx8rvAoQZBMC7u8iAOyAizB2vHzKZbTYd1bTxC2r3g5PpK0y
	 fSBLUhcLSdWZvk/HPw2YyA86tUHLUWhN6PULiXS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391296AbgAPX3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:29:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391266AbgAPX31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:29:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 295EB2073A;
        Thu, 16 Jan 2020 23:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217366;
        bh=Tv5X94cUn6Cb0NxK31Lnn8p5Qz5H+ux/LUAcJ4MC3k4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qd1MX5PWQY9GEi++gSGQLVIvGNFHtZ2JpR220nzjN5aInpW/sF7yTQatH6ip8JN7d
         xABkIqqbZa+yCnU6+3WSaeuukjDcQZgnFRrdiZvk6lDb7oPobjZkyCynfLUs2UVRdg
         ZXym3ZtT72/JGWSnKGkbsqByqAIER82+CULM+IRg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.19 53/84] compat_ioctl: handle SIOCOUTQNSD
Date:   Fri, 17 Jan 2020 00:18:27 +0100
Message-Id: <20200116231720.052194053@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231713.087649517@linuxfoundation.org>
References: <20200116231713.087649517@linuxfoundation.org>
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
@@ -3240,6 +3240,7 @@ static int compat_sock_ioctl_trans(struc
 	case SIOCSARP:
 	case SIOCGARP:
 	case SIOCDARP:
+	case SIOCOUTQNSD:
 	case SIOCATMARK:
 		return sock_do_ioctl(net, sock, cmd, arg);
 	}



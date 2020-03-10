Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16582C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1F820409
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846347;
	bh=hP7QB49/EqfVLxCeySXGAPy+WtwNAdFQlnAJKdDcWTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MuuORDiXQ1Pgz2ICToKAk6Pa8tUi2vWkNVPGKySChV8cz5TQ3yTAO7x4LA+8cmajd
	 qplUX5y17RKpTZ0Wy1SIuvdAzDQzi2gZq/pK24QzuTgg5h0gTG0sbQvrFfJkiM1eoy
	 Gp9pyRYQpEJB4/kp+VxzFeUcOeorQ3nKKAzOSN9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbgCJNJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731256AbgCJNJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:09:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B5EF20873;
        Tue, 10 Mar 2020 13:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845781;
        bh=hP7QB49/EqfVLxCeySXGAPy+WtwNAdFQlnAJKdDcWTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ndRsMaqII4iENyzZEGPxppW/sjOCBfjZ+GfDOUkAN+teFfsW2qjiDexlnI+rXwl4l
         Unxx//BXyMa7DFl3iRujDgGX4wr/r6iETPo90CyTWpHJiBHH1UwUTYwYeCNieLzI34
         Bw+nVGOgTiscoGTXcnkqhdm2q/X1LoeTylunZxoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Eric Dumazet <edumazet@google.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 059/126] tuntap: correctly set SOCKWQ_ASYNC_NOSPACE
Date:   Tue, 10 Mar 2020 13:41:20 +0100
Message-Id: <20200310124207.925139999@linuxfoundation.org>
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

From: Jason Wang <jasowang@redhat.com>

commit 2f3ab6221e4c87960347d65c7cab9bd917d1f637 upstream.

When link is down, writes to the device might fail with
-EIO. Userspace needs an indication when the status is resolved.  As a
fix, tun_net_open() attempts to wake up writers - but that is only
effective if SOCKWQ_ASYNC_NOSPACE has been set in the past. This is
not the case of vhost_net which only poll for EPOLLOUT after it meets
errors during sendmsg().

This patch fixes this by making sure SOCKWQ_ASYNC_NOSPACE is set when
socket is not writable or device is down to guarantee EPOLLOUT will be
raised in either tun_chr_poll() or tun_sock_write_space() after device
is up.

Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
Cc: Eric Dumazet <edumazet@google.com>
Fixes: 1bd4978a88ac2 ("tun: honor IFF_UP in tun_get_user()")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>

---
 drivers/net/tun.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1134,6 +1134,13 @@ static void tun_net_init(struct net_devi
 	dev->max_mtu = MAX_MTU - dev->hard_header_len;
 }
 
+static bool tun_sock_writeable(struct tun_struct *tun, struct tun_file *tfile)
+{
+	struct sock *sk = tfile->socket.sk;
+
+	return (tun->dev->flags & IFF_UP) && sock_writeable(sk);
+}
+
 /* Character device part */
 
 /* Poll */
@@ -1156,10 +1163,14 @@ static unsigned int tun_chr_poll(struct
 	if (!skb_array_empty(&tfile->tx_array))
 		mask |= POLLIN | POLLRDNORM;
 
-	if (tun->dev->flags & IFF_UP &&
-	    (sock_writeable(sk) ||
-	     (!test_and_set_bit(SOCKWQ_ASYNC_NOSPACE, &sk->sk_socket->flags) &&
-	      sock_writeable(sk))))
+	/* Make sure SOCKWQ_ASYNC_NOSPACE is set if not writable to
+	 * guarantee EPOLLOUT to be raised by either here or
+	 * tun_sock_write_space(). Then process could get notification
+	 * after it writes to a down device and meets -EIO.
+	 */
+	if (tun_sock_writeable(tun, tfile) ||
+	    (!test_and_set_bit(SOCKWQ_ASYNC_NOSPACE, &sk->sk_socket->flags) &&
+	     tun_sock_writeable(tun, tfile)))
 		mask |= POLLOUT | POLLWRNORM;
 
 	if (tun->dev->reg_state != NETREG_REGISTERED)



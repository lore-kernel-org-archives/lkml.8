Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE40C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2D420671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825776;
	bh=saodYP1hUrtdt/XP2aY9Q7Kgi/0dLuPVWPN8hT5B1LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CP8U9R+ZWFLwfTXeyLw8BsNNhAqTF6P7+IBRQmMw64+i9COL1n5B8mzkuz/oWDJ8H
	 aOVi4nb8ggQ1FXY6L8ur3D45RJm5m96Nmd0K08TcnJmrMWc78EUTFeXSCx08Bdnwem
	 PKhh2ive9cKf7HyO9B/bXGGCgINm6ZaOlfmtHAH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbgERSQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731922AbgERR6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:58:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87631207C4;
        Mon, 18 May 2020 17:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824725;
        bh=saodYP1hUrtdt/XP2aY9Q7Kgi/0dLuPVWPN8hT5B1LA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9lsihbNbvLRaqem4uStAKIC1SQUz+4j5g/gxywt5ggydvb5OmWCEeUEaJiQmWTY1
         LCdUctP+rHzO8kLCDfPLmJubDtNCPY739PuwHRM71rcXwr4NPNsue6MQTJD8+j7tw7
         xH7a0AvevAz/D+pqGGhqQvpeFcrc8tlfC1vXvI5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 5.4 127/147] usb: gadget: net2272: Fix a memory leak in an error handling path in net2272_plat_probe()
Date:   Mon, 18 May 2020 19:37:30 +0200
Message-Id: <20200518173528.763611029@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
References: <20200518173513.009514388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit ccaef7e6e354fb65758eaddd3eae8065a8b3e295 upstream.

'dev' is allocated in 'net2272_probe_init()'. It must be freed in the error
handling path, as already done in the remove function (i.e.
'net2272_plat_remove()')

Fixes: 90fccb529d24 ("usb: gadget: Gadget directory cleanup - group UDC drivers")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/net2272.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2647,6 +2647,8 @@ net2272_plat_probe(struct platform_devic
  err_req:
 	release_mem_region(base, len);
  err:
+	kfree(dev);
+
 	return ret;
 }
 



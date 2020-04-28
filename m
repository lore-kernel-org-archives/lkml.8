Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FA2C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0193F20730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099721;
	bh=xUBrIa9s6qjyrUqQUlPyqQ8PfAecf3yiWxZwq//pzhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fan5wn9ZCq2soij8j+eMAqtOnumbxGLkhLZOPOudUJ6n+HYMvWSvt3ex0bZxLULSw
	 oadMpvqmSuBdxZwyqP+ZkI3EQIdjmMbHOSwCcl8U69352jmvc0RIXhh6BoXK/uni4x
	 qU6ifyiOClCmb3FSAfgWSDN33kH8W+hiMXU9uo18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgD1Sku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbgD1Skr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:40:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59A3720B80;
        Tue, 28 Apr 2020 18:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099246;
        bh=xUBrIa9s6qjyrUqQUlPyqQ8PfAecf3yiWxZwq//pzhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJLWK+Czl2+vlFg6n76mvHU3oInqwQObsCGF7+tRWbe7j3Rt80u/t8Q/SthJy4Ry7
         ozWvPh5rS81HUxo3tzyJAzJy/6hSWhUSaj5WtnZSOZ3vokg7kAdbAm8ZIvrl7CTti7
         x1oOPgYsUbkg99FF4SYMi5CosAnHrA5qE13x6vtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 4.19 121/131] staging: vt6656: Power save stop wake_up_count wrap around.
Date:   Tue, 28 Apr 2020 20:25:33 +0200
Message-Id: <20200428182240.413244161@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Malcolm Priestley <tvboxspy@gmail.com>

commit ea81c3486442f4643fc9825a2bb1b430b829bccd upstream.

conf.listen_interval can sometimes be zero causing wake_up_count
to wrap around up to many beacons too late causing
CTRL-EVENT-BEACON-LOSS as in.

wpa_supplicant[795]: message repeated 45 times: [..CTRL-EVENT-BEACON-LOSS ]

Fixes: 43c93d9bf5e2 ("staging: vt6656: implement power saving code.")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
Link: https://lore.kernel.org/r/fce47bb5-7ca6-7671-5094-5c6107302f2b@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vt6656/int.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/staging/vt6656/int.c
+++ b/drivers/staging/vt6656/int.c
@@ -143,7 +143,8 @@ void vnt_int_process_data(struct vnt_pri
 				priv->wake_up_count =
 					priv->hw->conf.listen_interval;
 
-			--priv->wake_up_count;
+			if (priv->wake_up_count)
+				--priv->wake_up_count;
 
 			/* Turn on wake up to listen next beacon */
 			if (priv->wake_up_count == 1)



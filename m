Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715E1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC55206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyZdQ+Wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgHTIwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgHTIur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:50:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDFEC061757;
        Thu, 20 Aug 2020 01:50:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mw10so687909pjb.2;
        Thu, 20 Aug 2020 01:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xwd8nOeSb0YumtAMd904xAyU3bfTBgRBas9x5F4YwCU=;
        b=pyZdQ+WycGAAsR6ciDdWCZbdA3betN8OJ1+4K5MqjQUilxaKdYWeb5xjr8Y6fxZrV+
         XPMoH+1lvlgrhDkSI9rpVwHnSGWDKSNnIX0DO8YW3ZRzFP2mqH+lxKVVdo3Axk0VDsZG
         Q+DbuJ4e5Z/u7Rx8zm2M4juVhU3wWDeA6Cb8p4TGOnty9BXGy0EvCNRuNWC4l6WZ6c1P
         W3NdxxD2N5GShe57Mgv2ctJCeQD1b2DQpcb+vl32Y4furb1BEbwP7Ui0mst8ZKvyk3ZI
         qf7SaDki5SjnwSCU8YowwLIREmwMXdzjaFCF9Bvr56ze8sTr02R6+Mkq6kdr5Ey/24wc
         Jtng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xwd8nOeSb0YumtAMd904xAyU3bfTBgRBas9x5F4YwCU=;
        b=VaG+DiXNz2AsTeBJA3mQynvvcQZATXTylGfAxFp/zTGWVWWPD9iOMTXgoJv5u4Bdj0
         pGdwVxdU/reJAXcifCKwnLvb2myVG25SCizhcXLHTkttEzA2Q4EIP5dtdUtAgVRh342Q
         mNjP2FH8O2hEnoaFKIxFFT65lQR+S+UNNbCNqN4X40m3dKfP4mr5sAr/sL/+JaCvfDWw
         KgNlqtMAw4r+CqNIUIQc/ezLEDX51n/aeurRXbRJJXcVL1epis+EBX4KejCewE3uzzJd
         W8JW6/vK7Oe4xoGnuUltUHyc6XyR+f3xLg775blkW/ajpAOXjTbluP0EhIvPt9XDno9o
         febw==
X-Gm-Message-State: AOAM530a58yRZcOhzEs1zu3WfsSvA6dJNoDFRneZ5cs97bs8GYfHpvGb
        NusS8QrGAe8UiMJf/aPeHUo=
X-Google-Smtp-Source: ABdhPJxu7QsiBFdAy9B2xEBnvtCHJcAdiOoyfB4PTnGuT/Z3ZavblpMFV434HG45UwgjHJrRvpao2g==
X-Received: by 2002:a17:902:8601:: with SMTP id f1mr1779259plo.272.1597913447264;
        Thu, 20 Aug 2020 01:50:47 -0700 (PDT)
Received: from blackclown ([103.88.82.201])
        by smtp.gmail.com with ESMTPSA id gl9sm1442254pjb.41.2020.08.20.01.50.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Aug 2020 01:50:46 -0700 (PDT)
Date:   Thu, 20 Aug 2020 14:20:35 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 3/6] staging: wfx/data_rx.c: Fix spelling mistake
 "negociation" => "negotiation"
Message-ID: <7e0dab9eb4d976605371f1ba814ce32d62366dd4.1597913333.git.usuraj35@gmail.com>
References: <834139101223e627665c939388cd7c542920c531.1597913333.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <834139101223e627665c939388cd7c542920c531.1597913333.git.usuraj35@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/staging/wfx/data_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/data_rx.c b/drivers/staging/wfx/data_rx.c
index 6fb078880742..7fcbbfc53416 100644
--- a/drivers/staging/wfx/data_rx.c
+++ b/drivers/staging/wfx/data_rx.c
@@ -73,7 +73,7 @@ void wfx_rx_cb(struct wfx_vif *wvif,
 	if (arg->rx_flags.encryp)
 		hdr->flag |= RX_FLAG_DECRYPTED;
 
-	// Block ack negociation is offloaded by the firmware. However,
+	// Block ack negotiation is offloaded by the firmware. However,
 	// re-ordering must be done by the mac80211.
 	if (ieee80211_is_action(frame->frame_control) &&
 	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
-- 
2.17.1


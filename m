Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80139C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF6B2051A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341524;
	bh=GGWQ67jdRD0wSmMauQa4FV3WSwv4RIz4968TpQMGWfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X85qkMyf1rjBqbzUWftlNThBbsesRUgy5YPGuskCNUJ0S1M/e8AyqgAFEGzqeeVdd
	 6X5Ubpy/dy2gbe34DPSb1XO8ZU6KcIawL4/k3+/XTD3p31SYuXLpa0wGb3bYjX6FsA
	 C+DbWw9byXW5tjevHbxKsnBGSXHtb6QxTVVCOWfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgEAN6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729880AbgEANaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:30:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45BC2208DB;
        Fri,  1 May 2020 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339807;
        bh=GGWQ67jdRD0wSmMauQa4FV3WSwv4RIz4968TpQMGWfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=crYn1M2bqoD/YU7gzHMGhfyG2iLHhfZGpcdDPUt5M2JA09qjVR4+nVtG84nJ3AmBq
         CD4C+1cjwrBbHoPTMYIS4TrOCyAq7AoDYYoNhQeH9jYiQPxwjHFGLLru2U1gOdnpyZ
         9W7XBCpjhofRIiItBZBBwv2PPXW2NiQhZcFFWxI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 4.9 55/80] staging: vt6656: Power save stop wake_up_count wrap around.
Date:   Fri,  1 May 2020 15:21:49 +0200
Message-Id: <20200501131530.323188055@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.810761598@linuxfoundation.org>
References: <20200501131513.810761598@linuxfoundation.org>
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
@@ -153,7 +153,8 @@ void vnt_int_process_data(struct vnt_pri
 				priv->wake_up_count =
 					priv->hw->conf.listen_interval;
 
-			--priv->wake_up_count;
+			if (priv->wake_up_count)
+				--priv->wake_up_count;
 
 			/* Turn on wake up to listen next beacon */
 			if (priv->wake_up_count == 1)



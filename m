Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F653C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C0020776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520477;
	bh=FNwJtqw0co+L2BKi0lDKL+YKNyPzCvSShNaJsFMku0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cdk6bQwdFHS6IgcSP5sI77+Utr6nHyvUJQ0JKTb94m7P6uJB7eqv0tIl0Uq85EN8x
	 A33FH0hO74rnO4+H8db8G0ExHkELjA6Mu44lreoEIB8PmB7zHyTg6vSp9tMqnItvw0
	 3QfD1FoXrqhrKwknC2Vlu+x+4ECq8t9DxREfHrpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404381AbgEZTOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392143AbgEZTO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:14:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA5620776;
        Tue, 26 May 2020 19:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520467;
        bh=FNwJtqw0co+L2BKi0lDKL+YKNyPzCvSShNaJsFMku0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkaUDZKFduebYkm4CGUJhuJJJH0D65FQ5Lkx8uwk+2SrCBxTLczrNpTclsbVgOovx
         LlK9ASo5L2IAPbVamciFu6WFJ6uIl1xudVPKGTmmCB7xJybBEGVvPDffvEetuIEQJw
         As08skcmUot+Eq4CiLQokIE2SMyK9YyDak871WGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH 5.6 091/126] staging: wfx: unlock on error path
Date:   Tue, 26 May 2020 20:53:48 +0200
Message-Id: <20200526183945.571669993@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit f0b9d875faa4499afe3381404c3795e9da84bc00 upstream.

We need to release the tx_lock on the error path before returning.

Fixes: d1c015b4ef6f ("staging: wfx: rewrite wfx_hw_scan()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Link: https://lore.kernel.org/r/20200512083656.GA251760@mwanda
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/wfx/scan.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/staging/wfx/scan.c
+++ b/drivers/staging/wfx/scan.c
@@ -57,8 +57,10 @@ static int send_scan_req(struct wfx_vif
 	wvif->scan_abort = false;
 	reinit_completion(&wvif->scan_complete);
 	timeout = hif_scan(wvif, req, start_idx, i - start_idx);
-	if (timeout < 0)
+	if (timeout < 0) {
+		wfx_tx_unlock(wvif->wdev);
 		return timeout;
+	}
 	ret = wait_for_completion_timeout(&wvif->scan_complete, timeout);
 	if (req->channels[start_idx]->max_power != wvif->vif->bss_conf.txpower)
 		hif_set_output_power(wvif, wvif->vif->bss_conf.txpower);



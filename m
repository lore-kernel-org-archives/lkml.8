Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C03C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F45216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341139;
	bh=XukTGRUrtvKB6T6Dx7YJG9irS2u0oNYCp9zrre1bP/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zkcaeSbc3Uk8VAbhihnNQBeSrDH+IBG7kVIuxk4R/eGObpSjFOAW8gszZP4TK4/lG
	 WLbQBQikQHluMM8quGw41vZfUFJgmllvtVIMufFA40HUcFCi5ga6YuU7DSjOnjIe54
	 H3yRRIP/ZcCjjsmhW1pZ2qCc+sHRYNYo/3AZeDn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbgEANwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:52:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbgEANhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:37:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F30BA24956;
        Fri,  1 May 2020 13:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340267;
        bh=XukTGRUrtvKB6T6Dx7YJG9irS2u0oNYCp9zrre1bP/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=abNaf4Br8ZxLrXqKp+Prb/PkktfHrL6At8xL3j0MRu7lJPMuTfvQXip1RBl60DlRP
         ktrB1FG3Ffb0xOkr9Q0Tjsq+H3l4mfgZVZyTK26ORg5jaVEIE2nZwea50VzioHei1E
         905vOBfGHh9JLjz4bnavyvXcnDu3iAh58Q1Nk7io=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Clement Leger <cleger@kalray.eu>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH 5.4 01/83] remoteproc: Fix wrong rvring index computation
Date:   Fri,  1 May 2020 15:22:40 +0200
Message-Id: <20200501131524.384742556@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131524.004332640@linuxfoundation.org>
References: <20200501131524.004332640@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clement Leger <cleger@kalray.eu>

commit 00a0eec59ddbb1ce966b19097d8a8d2f777e726a upstream.

Index of rvring is computed using pointer arithmetic. However, since
rvring->rvdev->vring is the base of the vring array, computation
of rvring idx should be reversed. It previously lead to writing at negative
indices in the resource table.

Signed-off-by: Clement Leger <cleger@kalray.eu>
Link: https://lore.kernel.org/r/20191004073736.8327-1-cleger@kalray.eu
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/remoteproc/remoteproc_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -400,7 +400,7 @@ rproc_parse_vring(struct rproc_vdev *rvd
 void rproc_free_vring(struct rproc_vring *rvring)
 {
 	struct rproc *rproc = rvring->rvdev->rproc;
-	int idx = rvring->rvdev->vring - rvring;
+	int idx = rvring - rvring->rvdev->vring;
 	struct fw_rsc_vdev *rsc;
 
 	idr_remove(&rproc->notifyids, rvring->notifyid);



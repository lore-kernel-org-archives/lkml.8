Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50BCC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9232073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217856;
	bh=rnofVM1r06/zCpQPxV0g+/0PybA7btznnK8eSOOv9tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lvF+pdLgsZe4+CGt/ZiLK/gsCwJW0V8k5FNZbwlMzZv1zi9+T6b0nYujZmjZ9CpcT
	 ySyB6v33BUjC/1vVEC/udiR6xW0XFo6V4DF71KHaIWQvBKY2YQvYrvp8R4txP69oka
	 Op4rWCfpZhVfztgxFRmgg6Lu1Pj1GBZJkYtxN5fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404536AbgAPXhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:37:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390085AbgAPXaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:30:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F882073A;
        Thu, 16 Jan 2020 23:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217451;
        bh=rnofVM1r06/zCpQPxV0g+/0PybA7btznnK8eSOOv9tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JETvV7mtCLlw9CIshlICCAf0usq8jQj1l75pMlfXVkNYnJxNkF+wN8XE/4I6N1XvA
         9Utv+S8f/c/vmucG2TxgZb3XVa4tHD6WKkIcJflQHMVAMb6xgxbTNN0I22yRm8SNiX
         AjkdQKXUuTjV/nXvFY3kUjOWtZP/2rEqkDZPGE5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 63/84] media: v4l: cadence: Fix how unsued lanes are handled in csi2rx_start()
Date:   Fri, 17 Jan 2020 00:18:37 +0100
Message-Id: <20200116231721.075335811@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 2eca8e4c1df4864b937752c3aa2f7925114f4806 upstream.

The 2nd parameter of 'find_first_zero_bit()' is a number of bits, not of
bytes. So use 'csi2rx->max_lanes' instead of 'sizeof(lanes_used)'.

Fixes: 1fc3b37f34f6 ("media: v4l: cadence: Add Cadence MIPI-CSI2 RX driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/cadence/cdns-csi2rx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -129,7 +129,7 @@ static int csi2rx_start(struct csi2rx_pr
 	 */
 	for (i = csi2rx->num_lanes; i < csi2rx->max_lanes; i++) {
 		unsigned int idx = find_first_zero_bit(&lanes_used,
-						       sizeof(lanes_used));
+						       csi2rx->max_lanes);
 		set_bit(idx, &lanes_used);
 		reg |= CSI2RX_STATIC_CFG_DLANE_MAP(i, i + 1);
 	}



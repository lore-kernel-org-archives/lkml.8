Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52AFC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722B324677
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996542;
	bh=IAWoV7sLHY7VarPJfk6cJJN8sA4BpJYPO9/iJ9t548g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WpeQF+1Qgpkc7S5ZmRLjYj86nnCAwq1ptoqaXSEZirqCFWeAKXSO70rj4CqcEpuOy
	 ZE3ivmKbTTQxW1GXmUCwrf08V/gBeA8q/qHBXc0Cp28CLxAup4paVl8nztNwdE1FQO
	 lWcu52Gg3NDeEsq9KD16OD2dj1mDrMtAYsKs9nA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbgANKJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:09:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731176AbgANKI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:08:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9622124679;
        Tue, 14 Jan 2020 10:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996539;
        bh=IAWoV7sLHY7VarPJfk6cJJN8sA4BpJYPO9/iJ9t548g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zi9t3OEnrUgRZwzkf6NpJkQ6RsSL/guWjQHwRE+KCtvANxpux+GtSdkF7NBpVg65k
         ad7LxaRjcQyHDhrosuim0BF9slVXIP304GGMmK3kGF1sZ28hwYTX1yceRv5P/cLXqP
         zGEcfSzt4RP/eVGbroU39Wna0+pBjKBlGidjKmBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.19 39/46] ath10k: fix memory leak
Date:   Tue, 14 Jan 2020 11:01:56 +0100
Message-Id: <20200114094347.933299495@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
References: <20200114094339.608068818@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit b8d17e7d93d2beb89e4f34c59996376b8b544792 upstream.

In ath10k_usb_hif_tx_sg the allocated urb should be released if
usb_submit_urb fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath10k/usb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/ath/ath10k/usb.c
+++ b/drivers/net/wireless/ath/ath10k/usb.c
@@ -454,6 +454,7 @@ static int ath10k_usb_hif_tx_sg(struct a
 			ath10k_dbg(ar, ATH10K_DBG_USB_BULK,
 				   "usb bulk transmit failed: %d\n", ret);
 			usb_unanchor_urb(urb);
+			usb_free_urb(urb);
 			ret = -EINVAL;
 			goto err_free_urb_to_pipe;
 		}



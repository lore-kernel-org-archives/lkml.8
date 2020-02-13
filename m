Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1590C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7986720656
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581610292;
	bh=SeUInoUZKF668T+Lg79mvKlNvrUROy3LHdp63jNvHxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VqfpDz8M8otDlYmf8Z9CksONE1SbFNhx3W8CmRFE26u6S2UfbILKxr3uuYOlrsuuq
	 5kwy4mFZqkzsi4r1Cfvi4aeij/JOAIDuyoNGNsLAuZF9u+XQi1VmdBIo74FHIsgrut
	 dqWeld2wQ7Icu6PQ2le0OhUzWkJUarvoikiJXKuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgBMPWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:22:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbgBMPWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:20 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F109246C3;
        Thu, 13 Feb 2020 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607338;
        bh=SeUInoUZKF668T+Lg79mvKlNvrUROy3LHdp63jNvHxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDeb4EIjQwqmDKHAcAdI3rBMjSHInpsdPxHvcrbteXwR0ZrcI5WgObIsSYwQ2nYQG
         vx+rRj/pO0L9MFk0FLbFOplVKabLr/QE/RQl4RxJSYkgWUVYxLSZJ3JwX2BZKRUJ4A
         chn6J5T2f2IrmTo5bqRKvSVYRXoCPlzHxO9XSe4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.4 12/91] brcmfmac: Fix memory leak in brcmf_usbdev_qinit
Date:   Thu, 13 Feb 2020 07:19:29 -0800
Message-Id: <20200213151826.385949633@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit 4282dc057d750c6a7dd92953564b15c26b54c22c upstream.

In the implementation of brcmf_usbdev_qinit() the allocated memory for
reqs is leaking if usb_alloc_urb() fails. Release reqs in the error
handling path.

Fixes: 71bb244ba2fd ("brcm80211: fmac: add USB support for bcm43235/6/8 chipsets")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/brcm80211/brcmfmac/usb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/usb.c
@@ -426,6 +426,7 @@ fail:
 			usb_free_urb(req->urb);
 		list_del(q->next);
 	}
+	kfree(reqs);
 	return NULL;
 
 }



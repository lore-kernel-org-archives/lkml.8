Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3CCC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9590220675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609486;
	bh=YOR8bPRZxfWKnP2r5ckgg8MHlfxHiP9z0YI5Tv3PFOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ATYjdxj4fUyqwqmOCiuuztdLKerikHYS7o6DSgmKNTiOavvPMLKreuVsRVNnSqPlZ
	 +r4fIhVHYe375bQ1hN7jG3x8ebGsq1iB/KHUcbJdtwcyy+mZy8+qmLIti53GrdqCt2
	 rSbeX4Ec2YqUloyqXBBcTR9byxa1dbZB0TosS6dE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgBMPZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:25:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbgBMPXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:39 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2FEB246C0;
        Thu, 13 Feb 2020 15:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607418;
        bh=YOR8bPRZxfWKnP2r5ckgg8MHlfxHiP9z0YI5Tv3PFOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0mp+oa1DZlZeUM4HV38Kqnc3GOFh9fstQVP8orLiKKQsi2zQrrB+A1cM+jZXxaCi
         3NoZbPGIsdcIPz202Jxo1cap9djMwyAcIIyHaxowhS0GN087r+YZyjWBDET89dHNof
         XpBTocRjH10uPKk7rjNSgxvYoq0qLw0AMxIux/3w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 017/116] brcmfmac: Fix memory leak in brcmf_usbdev_qinit
Date:   Thu, 13 Feb 2020 07:19:21 -0800
Message-Id: <20200213151849.671772663@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
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
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -438,6 +438,7 @@ fail:
 			usb_free_urb(req->urb);
 		list_del(q->next);
 	}
+	kfree(reqs);
 	return NULL;
 
 }



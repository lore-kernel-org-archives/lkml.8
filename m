Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1552AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1BA206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591038028;
	bh=lmk8LyOLdJPxSVoQ8onp72CpMj+B/OZETC0PxqrDAMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UI+DfNQTNmNK+Ra2BfQMsHTm+N/+sTLBERvAB1duFw73/xjnnu/+QvhOC2ky10D9r
	 hy9y2QLdJqL0b6T+dyGy2kMhvGKqefUbJFlStcdBFAKswJsfDv7ZH1P7pCEoAZrwUG
	 /rEDSzq9tbRb0B1/bXpuBc/7S/3l+r0qPxr+2mqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgFATA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgFAR4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:56:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2058720776;
        Mon,  1 Jun 2020 17:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034191;
        bh=lmk8LyOLdJPxSVoQ8onp72CpMj+B/OZETC0PxqrDAMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YydB63dbsb/0fZVwUdolBLz01HutxmyhAFQppWSpha/iYyupFjVSWiefTOkb28qcW
         +uiKLvMrRV/SNekI/qHH0yxLS7cxO7g1sArCbS18VU1PXE6M4zVOhC9jp4obKEXorG
         kGLZIQf8DQHm/oArm/4XYc6V9ir2wirAVpGJnh/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 05/48] net: sun: fix missing release regions in cas_init_one().
Date:   Mon,  1 Jun 2020 19:53:15 +0200
Message-Id: <20200601173953.582846061@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601173952.175939894@linuxfoundation.org>
References: <20200601173952.175939894@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

commit 5a730153984dd13f82ffae93d7170d76eba204e9 upstream.

In cas_init_one(), "pdev" is requested by "pci_request_regions", but it
was not released after a call of the function “pci_write_config_byte”
failed. Thus replace the jump target “err_write_cacheline” by
"err_out_free_res".

Fixes: 1f26dac32057 ("[NET]: Add Sun Cassini driver.")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/sun/cassini.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -4980,7 +4980,7 @@ static int cas_init_one(struct pci_dev *
 					  cas_cacheline_size)) {
 			dev_err(&pdev->dev, "Could not set PCI cache "
 			       "line size\n");
-			goto err_write_cacheline;
+			goto err_out_free_res;
 		}
 	}
 #endif
@@ -5151,7 +5151,6 @@ err_out_iounmap:
 err_out_free_res:
 	pci_release_regions(pdev);
 
-err_write_cacheline:
 	/* Try to restore it in case the error occurred after we
 	 * set it.
 	 */



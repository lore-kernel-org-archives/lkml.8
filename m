Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B6FC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F36320684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217742;
	bh=2WNeRsDryRBzpXQN44EbufOyKvzcVAspZ6zfgL6yVVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kgf0USPLi24mp9fiDqOLXNbZW1Ca4JIPWINd4Y46tQRmMlPtjinIIXb+aCxt4j9Mr
	 W+7VhcB14nPhHMPeuzC3UNcT/9OQEr+++Dho8D9EAvcdR84lZ+FAea5skBRvLdLEKH
	 CSPLjHRTg+02FxwwYWUbJYMeprkc9lTZdR9m6MF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404481AbgAPXfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:35:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404188AbgAPXcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:32:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B15472077C;
        Thu, 16 Jan 2020 23:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217524;
        bh=2WNeRsDryRBzpXQN44EbufOyKvzcVAspZ6zfgL6yVVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ShMSfBE/g4JfKIShNvTicIqVUn5Hc3MUm+0eLIw215p7dCq3FoD/I3OmZ+FoFYALZ
         T4zynwZ1Xf0TfhiHzxtjTZOMHNCgquNGk50sOWgnwQq3LkV+VKjenSLXRDoswgk1uf
         qDL7Zb2B9vv8JO8GJgsbqnVFQwbbHGR3hUMkRZjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 34/71] scsi: enclosure: Fix stale device oops with hot replug
Date:   Fri, 17 Jan 2020 00:18:32 +0100
Message-Id: <20200116231714.528012331@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231709.377772748@linuxfoundation.org>
References: <20200116231709.377772748@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Bottomley <James.Bottomley@HansenPartnership.com>

commit 529244bd1afc102ab164429d338d310d5d65e60d upstream.

Doing an add/remove/add on a SCSI device in an enclosure leads to an oops
caused by poisoned values in the enclosure device list pointers.  The
reason is because we are keeping the enclosure device across the enclosed
device add/remove/add but the current code is doing a
device_add/device_del/device_add on it.  This is the wrong thing to do in
sysfs, so fix it by not doing a device_del on the enclosure device simply
because of a hot remove of the drive in the slot.

[mkp: added missing email addresses]

Fixes: 43d8eb9cfd0a ("[SCSI] ses: add support for enclosure component hot removal")
Link: https://lore.kernel.org/r/1578532892.3852.10.camel@HansenPartnership.com
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reported-by: Luo Jiaxing <luojiaxing@huawei.com>
Tested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/enclosure.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -419,10 +419,9 @@ int enclosure_remove_device(struct enclo
 		cdev = &edev->component[i];
 		if (cdev->dev == dev) {
 			enclosure_remove_links(cdev);
-			device_del(&cdev->cdev);
 			put_device(dev);
 			cdev->dev = NULL;
-			return device_add(&cdev->cdev);
+			return 0;
 		}
 	}
 	return -ENODEV;



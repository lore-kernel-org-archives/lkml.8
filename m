Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C6CC35E1D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C49420578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812874;
	bh=BSZfzcC3rom+TwcE0ATPv7pVKjZ/+GbA95PHOYnmggU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oB69gLsaonYaBdVOUWBfv7nV9h70Ytjt4oD9alDBPgiLoFZr0g9GcuccZPC4wKqTK
	 AuKlV2dLeDJjGHh5/kFMLPqnbHv9meK0xsqvb28E0GBJjvx8bBiozg4a5Hg/0lPanu
	 TB+MNSxpcNjjYkXl7hdrUY6I2/TFa4DjrkO28V+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbgB0OOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:14:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389127AbgB0OO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:14:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD0BF24690;
        Thu, 27 Feb 2020 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812867;
        bh=BSZfzcC3rom+TwcE0ATPv7pVKjZ/+GbA95PHOYnmggU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoBt9vuz6qsky1AKtsTmiXF1dysjxX59zckYg657rJNgjxIyeBDJfivMW+wrRy9Di
         MuEdE6K6nmLojgk9Rptah5d+qRnzMISqeYFE1G7kvmTGEEhPl8scmkChceJecNzI9p
         6xUKjV3RiDFCNSjR2iBZmFmpAy1rzibSV8bqTw9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pietro Oliva <pietroliva@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 5.5 046/150] staging: rtl8188eu: Fix potential overuse of kernel memory
Date:   Thu, 27 Feb 2020 14:36:23 +0100
Message-Id: <20200227132239.805446322@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 4ddf8ab8d15ddbc52eefb44eb64e38466ce1f70f upstream.

In routine wpa_supplicant_ioctl(), the user-controlled p->length is
checked to be at least the size of struct ieee_param size, but the code
does not detect the case where p->length is greater than the size
of the struct, thus a malicious user could be wasting kernel memory.
Fixes commit a2c60d42d97c ("Add files for new driver - part 16").

Reported by: Pietro Oliva <pietroliva@gmail.com>
Cc: Pietro Oliva <pietroliva@gmail.com>
Cc: Stable <stable@vger.kernel.org>
Fixes commit a2c60d42d97c ("Add files for new driver - part 16").
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Link: https://lore.kernel.org/r/20200210180235.21691-4-Larry.Finger@lwfinger.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -2011,7 +2011,7 @@ static int wpa_supplicant_ioctl(struct n
 	struct ieee_param *param;
 	uint ret = 0;
 
-	if (p->length < sizeof(struct ieee_param) || !p->pointer) {
+	if (!p->pointer || p->length != sizeof(struct ieee_param)) {
 		ret = -EINVAL;
 		goto out;
 	}



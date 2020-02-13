Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4DBC3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3C820661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609066;
	bh=papIyfFj1qzrURl+Pra2xbV58csYt+VzN7lpJCfdmHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ubwqp0ZVPS9GxMf2nmgqBQfNgd+pylcUS1mVuyiMQzWwkWYUdO0gEunxbN1q9a4Ya
	 JhNotIrrzP/PLS6gb1LSbK2bBR+Kio2FwhCYCxuvezWtD0lxNurMBNrXPOJrWlSK1+
	 4zl9Wl3AotOqEdgakbd/wf2dYr3FGCWW4H1xMV90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387537AbgBMP0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:26:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbgBMPY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:28 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 250F12469A;
        Thu, 13 Feb 2020 15:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607467;
        bh=papIyfFj1qzrURl+Pra2xbV58csYt+VzN7lpJCfdmHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MdivBarOCDdGCe/DyQQPPHxYAn69lhD8///CWSX1GiY4JSxxFU+e7l9N5bVLWM8IO
         Nc2y/3Ky46W1o1x9Uylmq10mSqdO5AKxL6xzPtTK5/8eKfEqQnD4cNa/BDzgPkk2KA
         mht0yxeXiU82IHCCabEpyigTpc2jidOW873w3bHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.9 103/116] rtc: hym8563: Return -EINVAL if the time is known to be invalid
Date:   Thu, 13 Feb 2020 07:20:47 -0800
Message-Id: <20200213151922.404079033@linuxfoundation.org>
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

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

commit f236a2a2ebabad0848ad0995af7ad1dc7029e895 upstream.

The current code returns -EPERM when the voltage loss bit is set.
Since the bit indicates that the time value is not valid, return
-EINVAL instead, which is the appropriate error code for this
situation.

Fixes: dcaf03849352 ("rtc: add hym8563 rtc-driver")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Link: https://lore.kernel.org/r/20191212153111.966923-1-paul.kocialkowski@bootlin.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/rtc-hym8563.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -105,7 +105,7 @@ static int hym8563_rtc_read_time(struct
 
 	if (!hym8563->valid) {
 		dev_warn(&client->dev, "no valid clock/calendar values available\n");
-		return -EPERM;
+		return -EINVAL;
 	}
 
 	ret = i2c_smbus_read_i2c_block_data(client, HYM8563_SEC, 7, buf);



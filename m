Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12840C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4F92051A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748500;
	bh=8jjE9uv8uvJk6VowYOBj062JvcWcLL7+3in/HzO46K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2IHO7zVtgbpPXzcn7aAWzOpi4MVzECieWPKPLxLNV/dig7gLaw6GRNXRUHaEwkIsy
	 Fl3t+L89ql6y5wCYGA8JJWcCLv1kLveKpri3youxJYuDNB2j9VMoUnUUmVLoVRTs3t
	 ExJtjxAzluiE8DuWkIPNHolFwVJIqdU1u4uWQb4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgBCQsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:48:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728876AbgBCQ0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:26:14 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9291B2051A;
        Mon,  3 Feb 2020 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747174;
        bh=8jjE9uv8uvJk6VowYOBj062JvcWcLL7+3in/HzO46K0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsdHbGRMej31yK1uO7k4P7ge1CHzwttJopKh2pVW41h1bxtM7/F58DxXyebhxqmNk
         +dzXLuJWPIPQXuAcr6IecrPsM0L2THf1c5eedSlwVzFz9vjoiBFyBX2rJt17eMjNUq
         coMGui8SQ2RUi4brQABAytczSgGWqNVRnEbDXZ2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.9 41/68] media: si470x-i2c: Move free() past last use of radio
Date:   Mon,  3 Feb 2020 16:19:37 +0000
Message-Id: <20200203161911.742850167@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161904.705434837@linuxfoundation.org>
References: <20200203161904.705434837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

A pointer to 'struct si470x_device' is currently used after free:

  drivers/media/radio/si470x/radio-si470x-i2c.c:462:25-30: ERROR: reference
    preceded by free on line 460

Shift the call to free() down past its final use.

NB: Not sending to Mainline, since the problem does not exist there, it was
caused by the backport of 2df200ab234a ("media: si470x-i2c: add missed
operations in remove") to the stable trees.

Cc: <stable@vger.kernel.org> # v3.18+
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/radio/si470x/radio-si470x-i2c.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/radio/si470x/radio-si470x-i2c.c
+++ b/drivers/media/radio/si470x/radio-si470x-i2c.c
@@ -458,10 +458,10 @@ static int si470x_i2c_remove(struct i2c_
 
 	free_irq(client->irq, radio);
 	video_unregister_device(&radio->videodev);
-	kfree(radio);
 
 	v4l2_ctrl_handler_free(&radio->hdl);
 	v4l2_device_unregister(&radio->v4l2_dev);
+	kfree(radio);
 	return 0;
 }
 



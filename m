Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A87C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D4D206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979595;
	bh=osaqLSDYDiEltLUL8Oj0TTqrbLKvTWs1GkbpqezWH7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0p/JwHErhnil6Z+Ri+znyxTbMtJb6Y1RZ5t9J9nCigJzqW/JnvJNxxhIe+vHhvukO
	 f9zXRE3ff+ZiyKlN7nrnm885So4ZrebTcMgJuManm6qhqnRsh+7kH5wRRieh1n6Aij
	 zVAtUL0VauaLhpTDwG+XWfwv70vYTf5F89x3ei6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbgIAQ7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:59:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729670AbgIAPVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:21:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 353F3207D3;
        Tue,  1 Sep 2020 15:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973689;
        bh=osaqLSDYDiEltLUL8Oj0TTqrbLKvTWs1GkbpqezWH7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QobbtARL8lvk0T0wWmXCR7ozJp0wBe3no2lnlgspS/GlJmi/J7HXeU9A7GnNLvN1j
         zC7kXjX28pymAsTMl/LMvtJYI3RFabePfsgSJbuKg9JOehEUSZzhoDi3Npipdbc1+m
         fcjT1zs0gmyJEHlyRdt7xdD4JpEl5bpZ6G0vMVhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evgeny Novikov <novikov@ispras.ru>
Subject: [PATCH 4.14 61/91] USB: lvtest: return proper error code in probe
Date:   Tue,  1 Sep 2020 17:10:35 +0200
Message-Id: <20200901150931.166023426@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150928.096174795@linuxfoundation.org>
References: <20200901150928.096174795@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeny Novikov <novikov@ispras.ru>

commit 531412492ce93ea29b9ca3b4eb5e3ed771f851dd upstream.

lvs_rh_probe() can return some nonnegative value from usb_control_msg()
when it is less than "USB_DT_HUB_NONVAR_SIZE + 2" that is considered as
a failure. Make lvs_rh_probe() return -EINVAL in this case.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200805090643.3432-1-novikov@ispras.ru
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/lvstest.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/misc/lvstest.c
+++ b/drivers/usb/misc/lvstest.c
@@ -432,7 +432,7 @@ static int lvs_rh_probe(struct usb_inter
 			USB_DT_SS_HUB_SIZE, USB_CTRL_GET_TIMEOUT);
 	if (ret < (USB_DT_HUB_NONVAR_SIZE + 2)) {
 		dev_err(&hdev->dev, "wrong root hub descriptor read %d\n", ret);
-		return ret;
+		return ret < 0 ? ret : -EINVAL;
 	}
 
 	/* submit urb to poll interrupt endpoint */



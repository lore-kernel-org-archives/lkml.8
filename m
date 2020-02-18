Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38987C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0463924655
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582055944;
	bh=6Q7UhUc1xzaaYT1fnjAKTkB/6wFgVIW/ZTQsvvAYn3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NQKnR+SENsJgIvRTrIwy2L+ZzxU/GiwCeDfgfPiG/8y1FbhBLNyAzX8+jVpf6VbPI
	 lkbOXEc0Jn9T0VBmcv+z4ivyzVozUHRNSPOh/E4P3NBB6JW3Fx++jzLfHKbsAZswWm
	 dF0I53q3sdK7CCsodx0LcmKfumLsrPGSIxuhj5yA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgBRT7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:59:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgBRT66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:58:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C281C2465A;
        Tue, 18 Feb 2020 19:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582055938;
        bh=6Q7UhUc1xzaaYT1fnjAKTkB/6wFgVIW/ZTQsvvAYn3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i1rUlh1q5Jw4sWqS74CfkAwjGbJMSzn7998rr8VnP+A0Vee61TyQUTOThynlrJxwl
         eddb7NgsxgdVMDmjy8IVBaSXyjWFMQdmWz25Oyk1IBDHDUeA2hENowa0INLPUJQqTx
         mzLF9cV7u7cGztji8CQf+KTv0UvEsoL+iYdijuhw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Asmaa Mnebhi <asmaa@mellanox.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 5.4 38/66] drivers: ipmi: fix off-by-one bounds check that leads to a out-of-bounds write
Date:   Tue, 18 Feb 2020 20:55:05 +0100
Message-Id: <20200218190431.553464416@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190428.035153861@linuxfoundation.org>
References: <20200218190428.035153861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit e0354d147e5889b5faa12e64fa38187aed39aad4 upstream.

The end of buffer check is off-by-one since the check is against
an index that is pre-incremented before a store to buf[]. Fix this
adjusting the bounds check appropriately.

Addresses-Coverity: ("Out-of-bounds write")
Fixes: 51bd6f291583 ("Add support for IPMB driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Message-Id: <20200114144031.358003-1-colin.king@canonical.com>
Reviewed-by: Asmaa Mnebhi <asmaa@mellanox.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmb_dev_int.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -265,7 +265,7 @@ static int ipmb_slave_cb(struct i2c_clie
 		break;
 
 	case I2C_SLAVE_WRITE_RECEIVED:
-		if (ipmb_dev->msg_idx >= sizeof(struct ipmb_msg))
+		if (ipmb_dev->msg_idx >= sizeof(struct ipmb_msg) - 1)
 			break;
 
 		buf[++ipmb_dev->msg_idx] = *val;



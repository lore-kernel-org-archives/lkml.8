Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B28BC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0422624649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846085;
	bh=gQWh7sVvH+z0XgXF4BmUO0G1rkaaDUhYsderlOQ/u0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uZEE8cdG3PlNnMPIFUeeAQLDid8rWwWPwuPCM0hko/UDJgUlkmiVsHDJsT8VtLP9/
	 XUzGEMIGyURSaZuO5DHSQo+ll3Z/X2vd9Wga1xPlccCFInMeffCk+tx6eOx7ZTXdkF
	 GHfPnGHXZMsaKONiPglrj5a07Shn50zcLAAh86H8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbgCJNOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731356AbgCJNOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:14:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 038A7208E4;
        Tue, 10 Mar 2020 13:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583846079;
        bh=gQWh7sVvH+z0XgXF4BmUO0G1rkaaDUhYsderlOQ/u0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0pvjs39PnB0ZTngrkFb2kWMJ8wznKk+AO8bbsKS75DXK2DCaac6Ws4DyzeMBUJv1V
         9X4cR82QYd1OYVd+6/6RUISLXg+v8vBE7UqyWhy2kRWkbdDTxGz7sMhTm6lUiZdxtj
         Ik1LvhvIhFmKa9uh9u4y+OFa+eReSpz0AgELRzw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.19 80/86] hwmon: (adt7462) Fix an error return in ADT7462_REG_VOLT()
Date:   Tue, 10 Mar 2020 13:45:44 +0100
Message-Id: <20200310124535.075179011@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124530.808338541@linuxfoundation.org>
References: <20200310124530.808338541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 44f2f882909fedfc3a56e4b90026910456019743 upstream.

This is only called from adt7462_update_device().  The caller expects it
to return zero on error.  I fixed a similar issue earlier in commit
a4bf06d58f21 ("hwmon: (adt7462) ADT7462_REG_VOLT_MAX() should return 0")
but I missed this one.

Fixes: c0b4e3ab0c76 ("adt7462: new hwmon driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Link: https://lore.kernel.org/r/20200303101608.kqjwfcazu2ylhi2a@kili.mountain
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/adt7462.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -426,7 +426,7 @@ static int ADT7462_REG_VOLT(struct adt74
 			return 0x95;
 		break;
 	}
-	return -ENODEV;
+	return 0;
 }
 
 /* Provide labels for sysfs */



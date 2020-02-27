Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA6BC728F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580C924656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813415;
	bh=Gh0r9CNz1XQi1o5EC9F2wUWx/cfLvl0SucLWOQzEXXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p4BHbhP9Bdph5/sHipInekmTuIvLuo5VulkYSzkBfjNLcx8GsO3QdMqsoB9GM2C3v
	 S0G24Yj35GRQt2QHV1BxhwvGGdp3NxMfolABPwEWjg5CPDCpSj5Bolvr9OItT/4VGL
	 OwNlExJI/MK5RAYOA77cD2Tui88LZmACLLkh/l4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389527AbgB0OXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:23:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389135AbgB0OOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:14:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FB7624690;
        Thu, 27 Feb 2020 14:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812869;
        bh=Gh0r9CNz1XQi1o5EC9F2wUWx/cfLvl0SucLWOQzEXXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUoNryZbzFEfgxEssWcS+ZkhtBLj+bsKlqGYwXVu2CkzqKHNjSpti/dv+JS8/0qYI
         ekDgW9syY2+4yyrAnHuekT8WuM2GktCc8vPzcioOvEgA1j3U2FpW3EI+uX3JuB3m4g
         VwPPGF8MLpbQi7sF0wuGG1ZYlBAQf2vGbyPpPEko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pietro Oliva <pietroliva@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 5.5 047/150] staging: rtl8723bs: Fix potential security hole
Date:   Thu, 27 Feb 2020 14:36:24 +0100
Message-Id: <20200227132239.962277163@linuxfoundation.org>
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

commit ac33597c0c0d1d819dccfe001bcd0acef7107e7c upstream.

In routine rtw_hostapd_ioctl(), the user-controlled p->length is assumed
to be at least the size of struct ieee_param size, but this assumption is
never checked. This could result in out-of-bounds read/write on kernel
heap in case a p->length less than the size of struct ieee_param is
specified by the user. If p->length is allowed to be greater than the size
of the struct, then a malicious user could be wasting kernel memory.
Fixes commit 554c0a3abf216 ("0taging: Add rtl8723bs sdio wifi driver").

Reported by: Pietro Oliva <pietroliva@gmail.com>
Cc: Pietro Oliva <pietroliva@gmail.com>
Cc: Stable <stable@vger.kernel.org>
Fixes 554c0a3abf216 ("0taging: Add rtl8723bs sdio wifi driver").
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Link: https://lore.kernel.org/r/20200210180235.21691-3-Larry.Finger@lwfinger.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -4207,7 +4207,7 @@ static int rtw_hostapd_ioctl(struct net_
 
 
 	/* if (p->length < sizeof(struct ieee_param) || !p->pointer) { */
-	if (!p->pointer) {
+	if (!p->pointer || p->length != sizeof(*param)) {
 		ret = -EINVAL;
 		goto out;
 	}



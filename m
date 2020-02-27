Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8F6C52D4C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5DA20578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812494;
	bh=Ck4RiXd9LtXXu/LTSaJIPrI7nme6mxSXS0dsiQUxxuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vFBEuRpzR4gHfHYugDmxPqQwwfU1bp9Lk7+MkNzvEqc8UUsjRZgQhz+9TdwQ5MtJQ
	 8lnJZ/e8Xf8uTLrt3MegDp0fjEUc9DGR+KQSn09p86LQeFZyhDwtgilppsT/5zFUVL
	 /RUS2a9TCROlhs97LnKXxgT8q8uAPcgxILt64m3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733131AbgB0OIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:08:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388210AbgB0OIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:08:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 163EB20578;
        Thu, 27 Feb 2020 14:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812489;
        bh=Ck4RiXd9LtXXu/LTSaJIPrI7nme6mxSXS0dsiQUxxuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gr1PogZdABjtiZe9vBn0mAiE0oPPUtpG8KsFxJ72M0j656fXHW9Qz/x+oxqSCM6aT
         TWAQ4DFLF0//HWpgJHs8Exh4TZbNqJleNYJ76TsRXtTgu8SaaT9nc/Pj6/TYZK0Tfv
         Ev4tuir8pe761Vp7BcsVmW+nYH+i14YZe0rY8dy8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pietro Oliva <pietroliva@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 5.4 038/135] staging: rtl8188eu: Fix potential security hole
Date:   Thu, 27 Feb 2020 14:36:18 +0100
Message-Id: <20200227132234.650810669@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132228.710492098@linuxfoundation.org>
References: <20200227132228.710492098@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 499c405b2b80bb3a04425ba3541d20305e014d3e upstream.

In routine rtw_hostapd_ioctl(), the user-controlled p->length is assumed
to be at least the size of struct ieee_param size, but this assumption is
never checked. This could result in out-of-bounds read/write on kernel
heap in case a p->length less than the size of struct ieee_param is
specified by the user. If p->length is allowed to be greater than the size
of the struct, then a malicious user could be wasting kernel memory.
Fixes commit a2c60d42d97c ("Add files for new driver - part 16").

Reported by: Pietro Oliva <pietroliva@gmail.com>
Cc: Pietro Oliva <pietroliva@gmail.com>
Cc: Stable <stable@vger.kernel.org>
Fixes: a2c60d42d97c ("staging: r8188eu: Add files for new driver - part 16")
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Link: https://lore.kernel.org/r/20200210180235.21691-2-Larry.Finger@lwfinger.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -2812,7 +2812,7 @@ static int rtw_hostapd_ioctl(struct net_
 		goto out;
 	}
 
-	if (!p->pointer) {
+	if (!p->pointer || p->length != sizeof(struct ieee_param)) {
 		ret = -EINVAL;
 		goto out;
 	}



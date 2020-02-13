Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFF5C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DB420656
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581610255;
	bh=AfbUs+nud2va6Aa5pGROgC4szYilv6TYCfS4lF1pL+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hMz+ibqXimxFo6BJE/8Taxt2tPCHKzHxY2qy0+VRHjC+zKlTiy4FiV0Ym0fwqr56p
	 viIfC2Hx6airDbX6V7GXaradCUthfsfpLaYAvg+6Gq/kFYm0cYMNQ0D9IFBmUYaEpN
	 N+85xbZcTZQ3sgnhJ0V+1tjS3N2XuZ0kPeJesz38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgBMQKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:10:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbgBMPWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:33 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDAD1246A3;
        Thu, 13 Feb 2020 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607352;
        bh=AfbUs+nud2va6Aa5pGROgC4szYilv6TYCfS4lF1pL+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jicbUgSIKv3hTcagI5sIfYJLEjo0YbVn7JQGf7RwANOi3CxO+LhpbYUiwxMxQq0ic
         5PQq0kx/LqaVia4LLDRu/VpsFYg5RBCp4TtR8YCbT+GZqyIwESe6dH5gbRfR0sWtD6
         RI+17OV9CPGT6P8Eh3ooey+6qcWJyPiMC1Oz/Mf8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, huangwen <huangwenabc@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.4 33/91] mwifiex: fix unbalanced locking in mwifiex_process_country_ie()
Date:   Thu, 13 Feb 2020 07:19:50 -0800
Message-Id: <20200213151834.516337372@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Norris <briannorris@chromium.org>

commit 65b1aae0d9d5962faccc06bdb8e91a2a0b09451c upstream.

We called rcu_read_lock(), so we need to call rcu_read_unlock() before
we return.

Fixes: 3d94a4a8373b ("mwifiex: fix possible heap overflow in mwifiex_process_country_ie()")
Cc: stable@vger.kernel.org
Cc: huangwen <huangwenabc@gmail.com>
Cc: Ganapathi Bhat <ganapathi.bhat@nxp.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mwifiex/sta_ioctl.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/mwifiex/sta_ioctl.c
@@ -232,6 +232,7 @@ static int mwifiex_process_country_ie(st
 
 	if (country_ie_len >
 	    (IEEE80211_COUNTRY_STRING_LEN + MWIFIEX_MAX_TRIPLET_802_11D)) {
+		rcu_read_unlock();
 		mwifiex_dbg(priv->adapter, ERROR,
 			    "11D: country_ie_len overflow!, deauth AP\n");
 		return -EINVAL;



Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2921C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38502467C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338189;
	bh=L4r5YMKdPeOtPohxU0GhCvCY682DwqDYJCwck78rRGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HzibSVm9IkyXu7jZGXr9Lz6Auh60m0JaxmsRAGshiOIJ1B3FmITDct2JFrJNrYt3D
	 WBvPYglbgUPySRB10B9MOd7GbR+o2T6dYFVyH+/Kkd8De1AgIQbTIg7sgYXoMJx9Zk
	 iSmwmsN2svAAuq+LaeQ/ooXGSOga4FAkCiyJVFI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgBJMg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:36:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbgBJMft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:49 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33966208C4;
        Mon, 10 Feb 2020 12:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338149;
        bh=L4r5YMKdPeOtPohxU0GhCvCY682DwqDYJCwck78rRGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWf5ZkGNyH2Na0x0+8dY/8eTH3/mXTLaBlcniHV5YlPGvhG2oMgxlVPNs06JWBFyR
         QyV905L0XLY0wkbr7JJNfqS5rM2lrww4KAUXfwGyIXcfEhJRjGHXe392P8a6ph3bCf
         ZUCU8fY9avuWvoBBwQN6bZT8yPxodI9SU1fXA48k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, huangwen <huangwenabc@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.19 111/195] mwifiex: fix unbalanced locking in mwifiex_process_country_ie()
Date:   Mon, 10 Feb 2020 04:32:49 -0800
Message-Id: <20200210122316.365129776@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
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
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -232,6 +232,7 @@ static int mwifiex_process_country_ie(st
 
 	if (country_ie_len >
 	    (IEEE80211_COUNTRY_STRING_LEN + MWIFIEX_MAX_TRIPLET_802_11D)) {
+		rcu_read_unlock();
 		mwifiex_dbg(priv->adapter, ERROR,
 			    "11D: country_ie_len overflow!, deauth AP\n");
 		return -EINVAL;



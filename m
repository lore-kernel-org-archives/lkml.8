Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8878C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738DC20658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759192;
	bh=DahiHw5H4HO3q92hreQmS6hEroRFGFzccqXJwM9Tv3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zH6NdmEwvrD7CJWf4eWsOT+XSUuvIEucgCOK433sjPSlMDL51uxsVgu2Rm3NxaNlO
	 ezZzxrQavlNZub4NjU/KmY0SR59AAUS6FvlxE7AdPsEpuoSXENum+fWb0z53xAMs7t
	 /f/lJmnf+kT8Euc+AB7qWjPwhPZZov3eGMitA2Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbgDAQju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389243AbgDAQjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:39:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B28D2063A;
        Wed,  1 Apr 2020 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759188;
        bh=DahiHw5H4HO3q92hreQmS6hEroRFGFzccqXJwM9Tv3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=haBkFEXMYV/UQ0N4+yDp6AQL25QKukc11bN8hZ4F4aJK3zpccN2DakBMajd+8b5W7
         ppYBigLfftWqXci1PkM0KfByTW83XOaCGHvS2DaqLFxiJ61xM4IjWEDUSKX1gcN3eA
         XOvR80mr7sLT/tgZsDTd5EeL63wO/Jnpu8EMslX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>,
        syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com
Subject: [PATCH 4.9 084/102] staging: wlan-ng: fix use-after-free Read in hfa384x_usbin_callback
Date:   Wed,  1 Apr 2020 18:18:27 +0200
Message-Id: <20200401161546.521375881@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

commit 1165dd73e811a07d947aee218510571f516081f6 upstream.

We can't handle the case length > WLAN_DATA_MAXLEN.
Because the size of rxfrm->data is WLAN_DATA_MAXLEN(2312), and we can't
read more than that.

Thanks-to: Hillf Danton <hdanton@sina.com>
Reported-and-tested-by: syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200326131850.17711-1-hqjagain@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/wlan-ng/hfa384x_usb.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -3443,6 +3443,8 @@ static void hfa384x_int_rxmonitor(struct
 	     WLAN_HDR_A4_LEN + WLAN_DATA_MAXLEN + WLAN_CRC_LEN)) {
 		pr_debug("overlen frm: len=%zd\n",
 			 skblen - sizeof(struct p80211_caphdr));
+
+		return;
 	}
 
 	skb = dev_alloc_skb(skblen);



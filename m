Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0FCC2BA12
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962B9206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759987;
	bh=Zd/Q8QkGFlwvhHJ5G34qfoMML/W9hxKmGVYK4fHfKc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=juEH4fiXW1FSqOSY51lOnvjRWPbK6cc00mbzUnUu5W65mVKbDqlwR5XBuw1QG02zn
	 dGFI3e5mBzxviTBxKvRzcx70w0Jdz3Novpe/fqbgszzfiYjnafNeWrrwoH967Rynwt
	 W5rX/ZnBvSgF8BaCK2KN7qWrUFBDMRFOHTZGZtL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbgDAQdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387890AbgDAQdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:33:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEBF520658;
        Wed,  1 Apr 2020 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758788;
        bh=Zd/Q8QkGFlwvhHJ5G34qfoMML/W9hxKmGVYK4fHfKc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IGGbdqVtnGYLpNTjNm3MODhsLNhSlxwP2kZrJyjaVBpAqnENtqkmCt+oQlz0uKxmE
         0D5HpRWQ/D38A5C6S+Py4vcWVFyreeXh4Hwr66YGh2JqPqDImlFCmCaN1brYnC+f4K
         aMHFovboudx5zeKb5HAWBzDjdEvXOexabcrRNfLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>,
        syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com
Subject: [PATCH 4.4 76/91] staging: wlan-ng: fix use-after-free Read in hfa384x_usbin_callback
Date:   Wed,  1 Apr 2020 18:18:12 +0200
Message-Id: <20200401161537.807508407@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
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
@@ -3574,6 +3574,8 @@ static void hfa384x_int_rxmonitor(wlande
 	     WLAN_HDR_A4_LEN + WLAN_DATA_MAXLEN + WLAN_CRC_LEN)) {
 		pr_debug("overlen frm: len=%zd\n",
 			 skblen - sizeof(struct p80211_caphdr));
+
+		return;
 	}
 
 	skb = dev_alloc_skb(skblen);



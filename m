Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12250C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AC1208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645825;
	bh=ho35sVTquqF+nMCh8sjY2bccs/JY5rCm7rSUWaXHH/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aGI5F5HHreCzM6X3YMYxnHZhDjGAG7zmRw7Bf9N6QZHyhsxJQXIjjDnk40l7yf/jr
	 OJsnCUl+UrS0IAtjUIkiqvrZVbcadz8ovmnE4EqdMvmMziZz/CNUzWge+atKuOr7fM
	 9HO156wdsGIWvh+WvEn83ElxjlROBL2rR+yv1N/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbgCaJKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731584AbgCaJKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:10:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1835D20772;
        Tue, 31 Mar 2020 09:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645821;
        bh=ho35sVTquqF+nMCh8sjY2bccs/JY5rCm7rSUWaXHH/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xB/tvSXcmwEGjC4xmu771qDWt+s8H1xY6W7Xps9USG0a6C1ZnXNBcS1Z0MSGNJLQQ
         oiG/JhpyN3Ix2T8iwMY3mZZ3sVq04r8LzGN0sa2fmlfwiNxsFuYa6z4m4Ih15SP7eB
         hF7lWrcZBj/byeHir5uphPbGhGn2te36c4G5XpAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>,
        syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com
Subject: [PATCH 5.5 160/170] staging: wlan-ng: fix use-after-free Read in hfa384x_usbin_callback
Date:   Tue, 31 Mar 2020 10:59:34 +0200
Message-Id: <20200331085439.854944686@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
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
@@ -3372,6 +3372,8 @@ static void hfa384x_int_rxmonitor(struct
 	     WLAN_HDR_A4_LEN + WLAN_DATA_MAXLEN + WLAN_CRC_LEN)) {
 		pr_debug("overlen frm: len=%zd\n",
 			 skblen - sizeof(struct p80211_caphdr));
+
+		return;
 	}
 
 	skb = dev_alloc_skb(skblen);



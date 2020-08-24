Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C2DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C002072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598259660;
	bh=G5jUKukagXKkOLJ4BybzKWHms8rDfx8sUQRQ+hdxnbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t4dtPrrMX6hSz/5ozJHEzayn+nyBY7plZa9Tdyh0ytfACEmV56NkuSVr4JaojKYO5
	 AgylNZIWZBS/3BWybDUX7wsiTGJVMWw30KLztyYCGscpOZze3myt/eaI7gEQya1vrI
	 V0N/HDtSMOuXJhFdAZ4YNsB873CJNTNdfQOsVGds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgHXJA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730641AbgHXI5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:57:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB0352072D;
        Mon, 24 Aug 2020 08:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259429;
        bh=G5jUKukagXKkOLJ4BybzKWHms8rDfx8sUQRQ+hdxnbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JsPpGv6WgfIvuTe1F0zlcaELFTn1h+Q+UFv5dbwmawNjyqUrgJRN4k3hg//U5Pd/O
         cWVewum0cWb+NCKMbihzwJTMNi4IIsxdhF48lgcxGC4TtvD74NdiczSNyxGEY5IDFO
         fTqa7HotMB+2VlohCPEIuHeRyL91zPsYLlzqaRDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 26/71] Input: psmouse - add a newline when printing proto by sysfs
Date:   Mon, 24 Aug 2020 10:31:17 +0200
Message-Id: <20200824082357.197272472@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082355.848475917@linuxfoundation.org>
References: <20200824082355.848475917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongfeng Wang <wangxiongfeng2@huawei.com>

[ Upstream commit 4aec14de3a15cf9789a0e19c847f164776f49473 ]

When I cat parameter 'proto' by sysfs, it displays as follows. It's
better to add a newline for easy reading.

root@syzkaller:~# cat /sys/module/psmouse/parameters/proto
autoroot@syzkaller:~#

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Link: https://lore.kernel.org/r/20200720073846.120724-1-wangxiongfeng2@huawei.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/psmouse-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index d3ff1fc09af71..a9040c0fb4c3f 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -2044,7 +2044,7 @@ static int psmouse_get_maxproto(char *buffer, const struct kernel_param *kp)
 {
 	int type = *((unsigned int *)kp->arg);
 
-	return sprintf(buffer, "%s", psmouse_protocol_by_type(type)->name);
+	return sprintf(buffer, "%s\n", psmouse_protocol_by_type(type)->name);
 }
 
 static int __init psmouse_init(void)
-- 
2.25.1




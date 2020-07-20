Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55242C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27243206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260206;
	bh=Bm7+99BRfMvFgVSaw2xFBlAHy03AWaWgm5xDQDxC/f8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tnr11SSguqZOSkCcmTBZ0XnWTxTZK7yO7LHiit3LoO3u9ZR1Ym7RZAT31DaGtuDRE
	 tDRRv0F7N4oPITM/AU6xiKg0mPtY1CiJHAE4TfRBTuTN1qoZrqz+CzwdLoW56Xk+4s
	 uc52yjICf1YOcZdM2qAYYnXDw3w+MlIB0jWImo54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgGTPuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731059AbgGTPuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:50:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 279EE2064B;
        Mon, 20 Jul 2020 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260200;
        bh=Bm7+99BRfMvFgVSaw2xFBlAHy03AWaWgm5xDQDxC/f8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfqsmatGIkTBQcJ+KestgN7Z2ccDc6+9RZYVXMuPb0413daNrTw4Nx7DIXxHg923r
         mQMq3QQQ9UokxngbmKCBmtBnMLf1CMhm+PurRTEY32ez4dHWtg8m7Xli6V10DxaYFW
         sHEjZ/fnji7TcS2+oOYTCWgMnZfkQucjUfIJ6gY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 017/133] cgroup: Fix sock_cgroup_data on big-endian.
Date:   Mon, 20 Jul 2020 17:36:04 +0200
Message-Id: <20200720152804.555945669@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 14b032b8f8fce03a546dcf365454bec8c4a58d7d ]

In order for no_refcnt and is_data to be the lowest order two
bits in the 'val' we have to pad out the bitfield of the u8.

Fixes: ad0f75e5f57c ("cgroup: fix cgroup_sk_alloc() for sk_clone_lock()")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/cgroup-defs.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -757,6 +757,7 @@ struct sock_cgroup_data {
 		struct {
 			u8	is_data : 1;
 			u8	no_refcnt : 1;
+			u8	unused : 6;
 			u8	padding;
 			u16	prioidx;
 			u32	classid;
@@ -766,6 +767,7 @@ struct sock_cgroup_data {
 			u32	classid;
 			u16	prioidx;
 			u8	padding;
+			u8	unused : 6;
 			u8	no_refcnt : 1;
 			u8	is_data : 1;
 		} __packed;



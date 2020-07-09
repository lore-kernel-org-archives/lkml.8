Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B868C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C6D62077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGxW0Cle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgGIPy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:54:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20645 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGIPyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594310064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V4dMBJlPQ8H2akrS9eA8GsIyxk9Bt5w1khnbdCVC110=;
        b=YGxW0ClekbJQNYEB146dDxZyyyy2Goixd9ug7SZx70XDPJi5PJdIhw1xrJ4+TGrZO+6x2R
        +C5lAte+MZryAoJhZnDHemMCR12/gO02lyUCVTrRSJ4Ot04Xy6gJCl+lutiAR+YYhjcSw2
        /6jE4NKUmM1Bu5mmmdctlcjZ7kvj+6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-ymG3nr9bOkeFYd_TdDJiRw-1; Thu, 09 Jul 2020 11:54:22 -0400
X-MC-Unique: ymG3nr9bOkeFYd_TdDJiRw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 404BF1DE2;
        Thu,  9 Jul 2020 15:54:21 +0000 (UTC)
Received: from localhost (ovpn-116-137.gru2.redhat.com [10.97.116.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C93331A913;
        Thu,  9 Jul 2020 15:54:17 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        torvalds@linux-foundation.org, Jason@zx2c4.com,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH] doc:kmsg: explictly state the return value in case of SEEK_CUR
Date:   Thu,  9 Jul 2020 12:54:15 -0300
Message-Id: <20200709155415.41207-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 625d3449788f ("Revert "kernel/printk: add kmsg SEEK_CUR
handling"") reverted a change done to the return value in case a SEEK_CUR
operation was performed for kmsg buffer based on the fact that different
userspace apps were handling the new return value (-ESPIPE) in different
ways, breaking them.

At the same time -ESPIPE was the wrong decision because kmsg /does support/
seek() but doesn't follow the "normal" behavior userspace is used to.
Because of that and also considering the time -EINVAL has been used, it was
decided to keep this way to avoid more userspace breakage.

This patch adds an official statement to the kmsg documentation pointing to
the current return value for SEEK_CUR, -EINVAL, thus userspace libraries and
apps can refer to it for a definitive guide on what to expected.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 Documentation/ABI/testing/dev-kmsg | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/ABI/testing/dev-kmsg b/Documentation/ABI/testing/dev-kmsg
index f307506eb54c..9bc854faaa79 100644
--- a/Documentation/ABI/testing/dev-kmsg
+++ b/Documentation/ABI/testing/dev-kmsg
@@ -56,6 +56,11 @@ Description:	The /dev/kmsg character device node provides userspace access
 		  seek after the last record available at the time
 		  the last SYSLOG_ACTION_CLEAR was issued.
 
+		Considering that the seek operation is supported but has 
+		special meaning to the device, any attempt to seek specific
+		positions on the buffer (i.e.  using SEEK_CUR) results in an
+		-EINVAL error returned to userspace.
+		
 		The output format consists of a prefix carrying the syslog
 		prefix including priority and facility, the 64 bit message
 		sequence number and the monotonic timestamp in microseconds,
-- 
2.26.2


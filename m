Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59547C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CFC4208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340159;
	bh=n8YYs1p3ceLhF6R4fuOHz/FdxWvu9UvVizPhy2zajHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OPmyqcX4Ion/3TiPeU3bQP5q6nDDGyYZWEJ1OvlAPNX7xCsu60sevbefMmiLdHirp
	 1ItU60nvaJS3JeQ+jgJzQ5wkcRDN0Z4EUKnuzsQtl+IBJ6tzjnVbJQmEEy/ZQwMG8r
	 cPT8bqOcbjjdOd5X3L4ETOO+ypQbDOCtvPEEBs3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbgEANf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729721AbgEANfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:35:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FA6824953;
        Fri,  1 May 2020 13:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340153;
        bh=n8YYs1p3ceLhF6R4fuOHz/FdxWvu9UvVizPhy2zajHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzU0J43WNStRIb9GrtuRPQUA18z3/i/a6n83aeihS14A2tS+0AJ3Ws0efY5UdOodR
         0Dmgy+tJAGrLbrRaVTL+QKyT/lw25AVzP+i6hRyNXJPH8RwQpwPEFlztMxbS5PDVyO
         u2Lwz633rmm1mB+fEpdzry/HrMn64P5JGVmYfwU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yi Huaijie <yihuaijie@huawei.com>,
        Liu Jian <liujian56@huawei.com>,
        Tokunori Ikegami <ikegami_to@yahoo.co.jp>,
        Richard Weinberger <richard@nod.at>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.19 02/46] mtd: cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
Date:   Fri,  1 May 2020 15:22:27 +0200
Message-Id: <20200501131459.421311442@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131457.023036302@linuxfoundation.org>
References: <20200501131457.023036302@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Jian <liujian56@huawei.com>

commit d9b8a67b3b95a5c5aae6422b8113adc1c2485f2b upstream.

In function do_write_buffer(), in the for loop, there is a case
chip_ready() returns 1 while chip_good() returns 0, so it never
break the loop.
To fix this, chip_good() is enough and it should timeout if it stay
bad for a while.

Fixes: dfeae1073583("mtd: cfi_cmdset_0002: Change write buffer to check correct value")
Signed-off-by: Yi Huaijie <yihuaijie@huawei.com>
Signed-off-by: Liu Jian <liujian56@huawei.com>
Reviewed-by: Tokunori Ikegami <ikegami_to@yahoo.co.jp>
Signed-off-by: Richard Weinberger <richard@nod.at>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/chips/cfi_cmdset_0002.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -1882,7 +1882,11 @@ static int __xipram do_write_buffer(stru
 			continue;
 		}
 
-		if (time_after(jiffies, timeo) && !chip_ready(map, adr))
+		/*
+		 * We check "time_after" and "!chip_good" before checking "chip_good" to avoid
+		 * the failure due to scheduling.
+		 */
+		if (time_after(jiffies, timeo) && !chip_good(map, adr, datum))
 			break;
 
 		if (chip_good(map, adr, datum)) {



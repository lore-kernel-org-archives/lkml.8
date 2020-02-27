Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A658C5ED40
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490CE2468F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813222;
	bh=bDVVnOPiBJFbAwok1eeBcXQx8jGyj50nZqeS8zCYhbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mbSCczSxAipVom1HBpwD9AXERqYyYd1jdVNAimY6344k+Kl70xc935vzVsqafFTzi
	 2osXhlF4j2MHNoK7espEDVSHP4Trk3GFLsSQn8H6jxTArVoqci0oZ0PMnxHUjgT1dB
	 905bApYYviNb33ECJ6zm8kQun+kyzbVzURON9h7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389545AbgB0OSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:18:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389803AbgB0OSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:18:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70CAF20801;
        Thu, 27 Feb 2020 14:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582813079;
        bh=bDVVnOPiBJFbAwok1eeBcXQx8jGyj50nZqeS8zCYhbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=02E2ojJl2cxMsEVQAWqknldqPTFTUWnb/YWaPMR8H4psSoIjm3uCbHYzb2eVNBbL6
         yrf0dAUN1ubHhBf2kZ/hl+waPuRu7n1/eaGX+hkm+0B6bqGt75Ir5Qgq8qfP3TjdC5
         UGY1rz7rq4pzJbGNtbm69cZlv4DET9Qz5IHHChQc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Pascal van Leeuwen <pvanleeuwen@rambus.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 5.5 129/150] crypto: rename sm3-256 to sm3 in hash_algo_name
Date:   Thu, 27 Feb 2020 14:37:46 +0100
Message-Id: <20200227132251.624312135@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

commit 6a30e1b1dcad0ba94fae757f797812d7d8dcb72c upstream.

The name sm3-256 is defined in hash_algo_name in hash_info, but the
algorithm name implemented in sm3_generic.c is sm3, which will cause
the sm3-256 algorithm to be not found in some application scenarios of
the hash algorithm, and an ENOENT error will occur. For example,
IMA, keys, and other subsystems that reference hash_algo_name all use
the hash algorithm of sm3.

Fixes: 5ca4c20cfd37 ("keys, trusted: select hash algorithm for TPM2 chips")
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Reviewed-by: Pascal van Leeuwen <pvanleeuwen@rambus.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/hash_info.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/hash_info.c
+++ b/crypto/hash_info.c
@@ -26,7 +26,7 @@ const char *const hash_algo_name[HASH_AL
 	[HASH_ALGO_TGR_128]	= "tgr128",
 	[HASH_ALGO_TGR_160]	= "tgr160",
 	[HASH_ALGO_TGR_192]	= "tgr192",
-	[HASH_ALGO_SM3_256]	= "sm3-256",
+	[HASH_ALGO_SM3_256]	= "sm3",
 	[HASH_ALGO_STREEBOG_256] = "streebog256",
 	[HASH_ALGO_STREEBOG_512] = "streebog512",
 };



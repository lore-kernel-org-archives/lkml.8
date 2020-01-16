Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED06C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FB120684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579216918;
	bh=61VitoPadF4A60mPrF3DScQka7MkLp7FTs3+jQ0LYX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uFQ/9mcIrv1M7950Gd2ScMDlt/0RLqyDXvI9jDgxSk0HeKkWzp6z0jeTGwtxRX4Rc
	 EV8M7HvQLinpV9CDaBOzHDLxaQC2jAwVXvJ5O9Lkz6GohnS8Vc0X19r0fnEZbXMw8G
	 sOVlaSX5c+bIuDoKYNwtS4hYQ3Cvl7KU4VffWp9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390879AbgAPXV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:21:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390871AbgAPXVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:21:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 404B920684;
        Thu, 16 Jan 2020 23:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216910;
        bh=61VitoPadF4A60mPrF3DScQka7MkLp7FTs3+jQ0LYX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRvAp5ZhVJRiAPDClkvIqlixu+gaVPq41PI1pOAxeI3jtGsDkBxa+FW/V/YVw3aC/
         FJOyaVZFeRWAbL7D5etv+UC3L1MOHDqe4ScMfTdcbWHLMoSTTCbIa1UkAxSqzlmlMk
         p4V/RuMdj0Js+0+IM7kZ+ig3Smn9aSyDCSh4RzCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 054/203] netfilter: nft_meta: use 64-bit time arithmetic
Date:   Fri, 17 Jan 2020 00:16:11 +0100
Message-Id: <20200116231748.691052760@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 6408c40c39d8eee5caaf97f5219b7dd4e041cc59 upstream.

On 32-bit architectures, get_seconds() returns an unsigned 32-bit
time value, which also matches the type used in the nft_meta
code. This will not overflow in year 2038 as a time_t would, but
it still suffers from the overflow problem later on in year 2106.

Change this instance to use the time64_t type consistently
and avoid the deprecated get_seconds().

The nft_meta_weekday() calculation potentially gets a little slower
on 32-bit architectures, but now it has the same behavior as on
64-bit architectures and does not overflow.

Fixes: 63d10e12b00d ("netfilter: nft_meta: support for time matching")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nft_meta.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -33,19 +33,19 @@
 
 static DEFINE_PER_CPU(struct rnd_state, nft_prandom_state);
 
-static u8 nft_meta_weekday(unsigned long secs)
+static u8 nft_meta_weekday(time64_t secs)
 {
 	unsigned int dse;
 	u8 wday;
 
 	secs -= NFT_META_SECS_PER_MINUTE * sys_tz.tz_minuteswest;
-	dse = secs / NFT_META_SECS_PER_DAY;
+	dse = div_u64(secs, NFT_META_SECS_PER_DAY);
 	wday = (4 + dse) % NFT_META_DAYS_PER_WEEK;
 
 	return wday;
 }
 
-static u32 nft_meta_hour(unsigned long secs)
+static u32 nft_meta_hour(time64_t secs)
 {
 	struct tm tm;
 
@@ -250,10 +250,10 @@ void nft_meta_get_eval(const struct nft_
 		nft_reg_store64(dest, ktime_get_real_ns());
 		break;
 	case NFT_META_TIME_DAY:
-		nft_reg_store8(dest, nft_meta_weekday(get_seconds()));
+		nft_reg_store8(dest, nft_meta_weekday(ktime_get_real_seconds()));
 		break;
 	case NFT_META_TIME_HOUR:
-		*dest = nft_meta_hour(get_seconds());
+		*dest = nft_meta_hour(ktime_get_real_seconds());
 		break;
 	default:
 		WARN_ON(1);



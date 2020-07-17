Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55867C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D4320717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SSLFeMPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgGQXhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgGQXhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:37:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7221BC0619D2;
        Fri, 17 Jul 2020 16:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=6hb59juUwhJN5OlmnQheYWguHLNKByYyI7mgQ5nQg+Y=; b=SSLFeMPKGK450Pmhbriq5L7Qps
        oz/NxonOAfjYuiqzyJyemzr1kiOHOPaF67l75ZHraT+QHhe1M1TzeBgKrdVxWMwXJRYCjb6FApt7Q
        65yKw8WrDPaAhR61/I2nDMgfdlpEaV6TNeQHfh2bsdmBZf31Pw1Ute8JZgVBXKrkOdUuCKWcFaP4k
        SzwO1LHykznbYNdgqQAtENeq1djbC3vAtfPVhTaIDAybWpg+SgSUbUlYENZKoJYmXCKpQgHemriCB
        Gws4cDEPMXSI0lc+oeyeWby93Uxum/hTvvq0CjCDHT1dkhSHAshnHRdzRKHXc89wYaIbzxa0bSN+6
        APfGPc7A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwZun-0006Zp-DQ; Fri, 17 Jul 2020 23:37:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] raid: md_p.h: drop duplicated word in a comment
To:     LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org
Message-ID: <d01bc32e-3b17-bd4d-faf6-29b4b931c9f6@infradead.org>
Date:   Fri, 17 Jul 2020 16:37:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org
---
 include/uapi/linux/raid/md_p.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/uapi/linux/raid/md_p.h
+++ linux-next-20200714/include/uapi/linux/raid/md_p.h
@@ -123,7 +123,7 @@ typedef struct mdp_device_descriptor_s {
 
 /*
  * Notes:
- * - if an array is being reshaped (restriped) in order to change the
+ * - if an array is being reshaped (restriped) in order to change
  *   the number of active devices in the array, 'raid_disks' will be
  *   the larger of the old and new numbers.  'delta_disks' will
  *   be the "new - old".  So if +ve, raid_disks is the new value, and


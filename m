Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DB1C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D3992074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZeT+Ia8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgGQXgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGQXgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:36:10 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216D1C0619D2;
        Fri, 17 Jul 2020 16:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=oFnXs36gqGq0pZQLBb8MfbqARQI1dqt1SGIAH76sp6s=; b=ZeT+Ia8e/5lUsCLHaLFg0mHF7u
        iqcM8CUk50IODVTpHYSLdfElRQMvJ/VK0L5IPHzWVLBH2jbpP+CmZJSp6OON6gdjv7SMM8r61Wt1r
        0E1A2BoYtP5HVBO0b5j6idiHKPzL2CeTUSJwrA+ibdt5GD6nW7BZejrdr39q+8U/EdjLnXEa/a+1j
        QX2P2IC9HNZfmr6PiGmh+JSUOwJaR7V9ihuMacuXxjtd49L85c1RwpoRzlkIIQoYP4JUOXtpYgKiw
        WQs4Zod+WHvH57mwhWDwi1VpJSwXHCPmnqofF5ptUT7wsOraVmqPN4xpq75XEEtmJAIrGoDI+wxku
        Op4zMygw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwZtf-0006Ub-PH; Fri, 17 Jul 2020 23:36:08 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ceph: ceph_features.h: drop duplicated word in a comment
To:     LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Message-ID: <37c50064-e4ee-d79f-5a9f-2824479b01ca@infradead.org>
Date:   Fri, 17 Jul 2020 16:36:04 -0700
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
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org
---
 include/linux/ceph/ceph_features.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/ceph/ceph_features.h
+++ linux-next-20200714/include/linux/ceph/ceph_features.h
@@ -58,7 +58,7 @@
  *    because 10.2.z (jewel) did not care if its peers advertised this
  *    feature bit.
  *
- *  - In the second phase we stop advertising the the bit and call it
+ *  - In the second phase we stop advertising the bit and call it
  *    RETIRED.  This can normally be done in the *next* major release
  *    following the one in which we marked the feature DEPRECATED.  In
  *    the above example, for 12.0.z (luminous) we can say:


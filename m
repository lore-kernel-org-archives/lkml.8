Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5524EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 23:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24BFD20782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 23:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XjRTDvAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGCX4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 19:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgGCXz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 19:55:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40451C061794;
        Fri,  3 Jul 2020 16:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+B8eRXDkq3Qv185n5eewAmeo/WP2l1p7ZXSs2yu2sT4=; b=XjRTDvAEWH+yOxZw2Bh+S+76Kb
        FUJQhjlcwfR55AXz5L31dcj708KMvoArh2KFl3kG+3+BMsRLo4rDn9c92eURug8hsajtnNGmGm8Sq
        fPJJsYemF0D6XwBTNXEcjPhHsNyK/9o/BN4Bna9MQbTJLL/qvk44ORIot7nya0bHdxx6lkrYkSNIY
        GAQCL1IToDTpr3UEVDyurd1Kej4spBeORAET9zSbas4MMMFIJSsAfkfFI4Mg/+cRiEepiVOCE4POn
        T1AvV1X2lhBDbrq2JG9P+6z74axOLF6ZBjyCBFc//YsMnc/BbCed5zYwXsvn2LQDPoymuHkNzFlDz
        P2A6mAfg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrVX9-0005uW-VM; Fri, 03 Jul 2020 23:55:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH 06/11] Documentation: userspace-api/media: dvb/video: drop doubled word
Date:   Fri,  3 Jul 2020 16:55:31 -0700
Message-Id: <20200703235536.30416-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703235536.30416-1-rdunlap@infradead.org>
References: <20200703235536.30416-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "and".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 Documentation/userspace-api/media/dvb/video.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/userspace-api/media/dvb/video.rst
+++ linux-next-20200701/Documentation/userspace-api/media/dvb/video.rst
@@ -15,7 +15,7 @@ Digital TV Video Device
 
 The Digital TV video device controls the MPEG2 video decoder of the Digital
 TV hardware. It can be accessed through **/dev/dvb/adapter0/video0**. Data
-types and and ioctl definitions can be accessed by including
+types and ioctl definitions can be accessed by including
 **linux/dvb/video.h** in your application.
 
 Note that the Digital TV video device only controls decoding of the MPEG video

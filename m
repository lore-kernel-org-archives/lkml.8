Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2327C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 23:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7681720723
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 23:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="movRGH7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGCX4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 19:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgGCX4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 19:56:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD03C08C5DE;
        Fri,  3 Jul 2020 16:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iYcfohdcQaMVHkTS973VAf/FM4Dd7O/UCacHZXK/Ejc=; b=movRGH7b/rpSk+d1+omy2x8Kmb
        ZPsF2AKkuFPD53BhQwLQYy4cZOYjZJUiEqhZGLiKukMEKZogIkJ9VAZRuB3dxzvFGPMFzEJ9g8b55
        Q4SwbLOxJe/D2Sz+EH79awBAmDs5SOatROroMhWsNk7zlbePJODpki6UZ9RT0INfOs3hvxswj0Hem
        badIvqesu1//HahMs96JCEokZhbCHNU6+X20wXDrEI1p/YqnVKGa8IxYFjy9s0M/Yw9LFfmrGgxA6
        4sJgOYRdeAOSwUKkf1b/hrSoueWtwZ8xghGG561xy/4L8Tp4Tja/7ulLotllDMy9WYnGTxbGB7PUO
        UFFES1Tw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrVXJ-0005uW-RV; Fri, 03 Jul 2020 23:56:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH 10/11] Documentation: userspace-api/media: v4l/vidioc-g-output: drop doubled word
Date:   Fri,  3 Jul 2020 16:55:35 -0700
Message-Id: <20200703235536.30416-11-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703235536.30416-1-rdunlap@infradead.org>
References: <20200703235536.30416-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "standard.".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 Documentation/userspace-api/media/v4l/vidioc-g-output.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/userspace-api/media/v4l/vidioc-g-output.rst
+++ linux-next-20200701/Documentation/userspace-api/media/v4l/vidioc-g-output.rst
@@ -53,7 +53,7 @@ To select a video output applications st
 output in an integer and call the :ref:`VIDIOC_S_OUTPUT <VIDIOC_G_OUTPUT>` ioctl with a
 pointer to this integer. Side effects are possible. For example outputs
 may support different video standards, so the driver may implicitly
-switch the current standard. standard. Because of these possible side
+switch the current standard. Because of these possible side
 effects applications must select an output before querying or
 negotiating any other parameters.
 

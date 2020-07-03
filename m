Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D883C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 23:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622F920723
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 23:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iKqAKL67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgGCX4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 19:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGCX4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 19:56:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA53C061794;
        Fri,  3 Jul 2020 16:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nQSDna65/F6utxsuttQ4q5VqwGUF94Xy/+2V2kqBuUk=; b=iKqAKL671qlez7keSNcVrLuT9S
        JutMBbor+l6SMQQedXi2UqiauFm/oF4IUapfGAH66K7yghDtx3CvBZBDLf2qobZX8IOKXc2uPPP/9
        chabhN4ziacLpvlUyvnXwSiUDfOm4dy7FEcc5A3r3D22ZwNSKN8n/pn++Cdfg1t5BNAvxwIwN7Cc9
        lMT0JmrzImvCdRpHUdkywHEiudAdt8zuZyIWB20yaqyO+LBCiMZjoWDfzIL6W5tqWb13XLwOi4oMh
        hpU6JNBG4aq40HxgEtimqlZl3MBSmaPoWSgJxjjEW8K9sCOybJAB4WzVVf36vXOFGbdVRZl6Oy1z6
        +hUwLBeQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrVXE-0005uW-TM; Fri, 03 Jul 2020 23:56:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH 08/11] Documentation: userspace-api/media: v4l/selection-api-config: drop doubled word
Date:   Fri,  3 Jul 2020 16:55:33 -0700
Message-Id: <20200703235536.30416-9-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703235536.30416-1-rdunlap@infradead.org>
References: <20200703235536.30416-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "in".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 Documentation/userspace-api/media/v4l/selection-api-configuration.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/userspace-api/media/v4l/selection-api-configuration.rst
+++ linux-next-20200701/Documentation/userspace-api/media/v4l/selection-api-configuration.rst
@@ -101,7 +101,7 @@ specified using :ref:`VIDIOC_S_FMT <VIDI
 
 The top left corner, width and height of the source rectangle, that is
 the area from which image date are processed by the hardware, is given
-by the ``V4L2_SEL_TGT_CROP``. Its coordinates are expressed in in the
+by the ``V4L2_SEL_TGT_CROP``. Its coordinates are expressed in the
 same coordinate system as the bounds rectangle. The active cropping area
 must lie completely inside the crop boundaries and the driver may
 further adjust the requested size and/or position according to hardware

Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DC1C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735BA20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584444036;
	bh=vNR8UdTpnd+MdKXM3RRc5qpDJLFIBrFnvSXpXWI3GSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PjFUrjFk06m3//ppOzqiM5FMbBJ1T7w76NK5SrzWzgRldek77L6CEN+mC0HlwyUrg
	 EWRvZ0bWJgP5q6fKKpi5ZldGfqx4PzJ0yoUJzPTq5hjw/mOzVr1GgSBzd26BWoUJns
	 ljR3jvDPoM5L/loSB2xOmX939mp1L61RTJtoPYNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgCQLAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbgCQLAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:00:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FA8920719;
        Tue, 17 Mar 2020 11:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442816;
        bh=vNR8UdTpnd+MdKXM3RRc5qpDJLFIBrFnvSXpXWI3GSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYkj1VU/ZvdZUDiSayLCwd3w49cLl/9khTxIryx9tL6eDfk2rg7qdeBGo+0+fOdrH
         +OhfTlPfUionjBpzgCTxAXFjeT+vSM3tXWVNb/Zvez4u5va079RpDku0dYu/2e8QhU
         aqXR5YDihGkpG7NYNtQ9/IEG5g37FnSaBWXSbt6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.19 72/89] pinctrl: core: Remove extra kref_get which blocks hogs being freed
Date:   Tue, 17 Mar 2020 11:55:21 +0100
Message-Id: <20200317103308.238331165@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

commit aafd56fc79041bf36f97712d4b35208cbe07db90 upstream.

kref_init starts with the reference count at 1, which will be balanced
by the pinctrl_put in pinctrl_unregister. The additional kref_get in
pinctrl_claim_hogs will increase this count to 2 and cause the hogs to
not get freed when pinctrl_unregister is called.

Fixes: 6118714275f0 ("pinctrl: core: Fix pinctrl_register_and_init() with pinctrl_enable()")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20200228154142.13860-1-ckeepax@opensource.cirrus.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/core.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -2008,7 +2008,6 @@ static int pinctrl_claim_hogs(struct pin
 		return PTR_ERR(pctldev->p);
 	}
 
-	kref_get(&pctldev->p->users);
 	pctldev->hog_default =
 		pinctrl_lookup_state(pctldev->p, PINCTRL_STATE_DEFAULT);
 	if (IS_ERR(pctldev->hog_default)) {



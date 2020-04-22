Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E260C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AAE020775
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552991;
	bh=in12tsT4gXL1ga0bTUIzcTFDR64Uyu8m1TorXuPbdVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XAB1wjlfIHsXrDCIvcjPOhnL6pzE5lFTucWYG18vEyYID8rS4imtz3Gx1M1GsQBcZ
	 V3/7ahaE/gmTFcAs9OE2cX9XEXV6egGWeadHL5xj+uqb4Ywwj5knV0t81ym3aRBT6g
	 ytHjAYnbI08etQs/djzRfmire04yCp5TdEDMNLHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbgDVK4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgDVKG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:06:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A673F20575;
        Wed, 22 Apr 2020 10:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549989;
        bh=in12tsT4gXL1ga0bTUIzcTFDR64Uyu8m1TorXuPbdVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T6ov6k4fhwB5Td2OAuPCofCz5wbfDDYDwSLSebMX12mB1CEqFWEtubMo7QXDoyH1r
         gVuBmpZBe2oo37qB10A08JbhVBDd/74pin9hyIsa9hy/0H0e2FA3Kg5rUK4922xdva
         +0vdUi8lCO26plXIGGeB+5H5lEPb9zC1x/oZfnZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Erhard F." <erhard_f@mailbox.org>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.9 088/125] of: unittest: kmemleak on changeset destroy
Date:   Wed, 22 Apr 2020 11:56:45 +0200
Message-Id: <20200422095047.225506345@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

commit b3fb36ed694b05738d45218ea72cf7feb10ce2b1 upstream.

kmemleak reports several memory leaks from devicetree unittest.
This is the fix for problem 1 of 5.

of_unittest_changeset() reaches deeply into the dynamic devicetree
functions.  Several nodes were left with an elevated reference
count and thus were not properly cleaned up.  Fix the reference
counts so that the memory will be freed.

Fixes: 201c910bd689 ("of: Transactional DT support.")
Reported-by: Erhard F. <erhard_f@mailbox.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/unittest.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -539,6 +539,10 @@ static void __init of_unittest_changeset
 	unittest(!of_changeset_revert(&chgset), "revert failed\n");
 
 	of_changeset_destroy(&chgset);
+
+	of_node_put(n1);
+	of_node_put(n2);
+	of_node_put(n21);
 #endif
 }
 



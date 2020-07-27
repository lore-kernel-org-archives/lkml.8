Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24559C433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1C432078E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595875017;
	bh=0qi4Bh72MnTOjHIKJDOCzq3CI7AB00MKUbRkPWQ0UjI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=e+3unKUUuzbfNjsGY9hPpvrICAQXwYB3HSDyo757ByEpQlsSo8YI5vNdRU9HTtFis
	 PCMvDhx93KsTaUMWLBb5FqhV8hQUgd1Dlk6wKoYjAoCylNZrt4bElxHZM8XZL8zaKX
	 im2djQmy92EKteYp/S6gw2Q3qzNcDeXTXIAUd5Go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgG0Sgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:36:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbgG0Sgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:36:55 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50EC620729;
        Mon, 27 Jul 2020 18:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595875015;
        bh=0qi4Bh72MnTOjHIKJDOCzq3CI7AB00MKUbRkPWQ0UjI=;
        h=Date:From:To:Cc:Subject:From;
        b=GsrL9hzNE5X0b/+DyDLS7oSOIT3Zm7Keq2SQhp9bvOWyvE9T3MmO4BbtviLMS+CiF
         wJSWusFKgJ6BespsQQxGR/kPpgdK33PYWneRnE/J/apIxa4Up4S7/7YXugMWRm0tbx
         q+XYkM/T1h41grdaSYpG7wiM/BJR7Fne3UABoDh8=
Date:   Mon, 27 Jul 2020 13:42:47 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] staging: comedi: s526: Use fallthrough pseudo-keyword
Message-ID: <20200727184247.GA29207@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/comedi/drivers/s526.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/s526.c b/drivers/staging/comedi/drivers/s526.c
index ba485f106c1e..085cf5b449e5 100644
--- a/drivers/staging/comedi/drivers/s526.c
+++ b/drivers/staging/comedi/drivers/s526.c
@@ -400,7 +400,7 @@ static int s526_gpct_winsn(struct comedi_device *dev,
 		if ((data[1] <= data[0]) || !data[0])
 			return -EINVAL;
 		/* to write the PULSE_WIDTH */
-		/* fall through */
+		fallthrough;
 	case INSN_CONFIG_GPCT_QUADRATURE_ENCODER:
 	case INSN_CONFIG_GPCT_SINGLE_PULSE_GENERATOR:
 		s526_gpct_write(dev, chan, data[0]);
-- 
2.27.0


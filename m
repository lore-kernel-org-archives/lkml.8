Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813EBC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EA3214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607230;
	bh=GiJkc1e1xfErwk3IjOfHmnD535a/btlVEWZipOJPnWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uCB3sE1GwIvrxh1EpmTmOJXlQ/6n4WY1foTlNICY3Jc7YfEUhuLBJa0CdCkLa108X
	 CwYIk3ypaxxUdib4ECpNUuoLl30nZhe/v8lQPCeWv4KCfFS6kO4VeTdGQP73X/tLMN
	 EIYJeT+uaVuk86cKMiJ8lX2fr3FALJA6MQiFrO+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDKMNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgDKMNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:13:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B23C21D7B;
        Sat, 11 Apr 2020 12:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607221;
        bh=GiJkc1e1xfErwk3IjOfHmnD535a/btlVEWZipOJPnWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jIx1hLOJZGBgo7jOP6iUJVERr0xrQyWVNS4t2Z/S/jGAwF06IkD8wk/RndCcdhvu2
         YvzGDJGidMgYlxfSLwC1HyMiSqekBM9gKj5BwsIvShAZnyd+kderOvHLnIxEpxL/O8
         tqxe3BD4HWCvoayZxNA7yGuZLhOXK7FX3u9TkshQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 23/38] hwrng: imx-rngc - fix an error path
Date:   Sat, 11 Apr 2020 14:09:07 +0200
Message-Id: <20200411115440.319425435@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115437.795556138@linuxfoundation.org>
References: <20200411115437.795556138@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kaiser <martin@kaiser.cx>

commit 47a1f8e8b3637ff5f7806587883d7d94068d9ee8 upstream.

Make sure that the rngc interrupt is masked if the rngc self test fails.
Self test failure means that probe fails as well. Interrupts should be
masked in this case, regardless of the error.

Cc: stable@vger.kernel.org
Fixes: 1d5449445bd0 ("hwrng: mx-rngc - add a driver for Freescale RNGC")
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/hw_random/imx-rngc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -110,8 +110,10 @@ static int imx_rngc_self_test(struct imx
 		return -ETIMEDOUT;
 	}
 
-	if (rngc->err_reg != 0)
+	if (rngc->err_reg != 0) {
+		imx_rngc_irq_mask_clear(rngc);
 		return -EIO;
+	}
 
 	return 0;
 }



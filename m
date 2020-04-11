Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41C5C2BBFD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B8E20787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607805;
	bh=cxaqw+gj13L48qPCR+g9Lk8enKGNLTboZwEzcZD5KLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e7yGZ3vz3Wf4QxQAja21q76Wa53FlW9bPUHyvPPrSGyaBOkoRv6l/LLeP20JLyHQT
	 w0PDSpUz9EeTPF3d7E3fH0WlpTYxT2zqD2VAmfUyRsMrrEKQaThlFDzk7HfueAV4O+
	 EVuBnz6c8UbN+yTGUp8+o3nDMdzvauiE0Ljn8/nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgDKMTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728529AbgDKMTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:19:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CBB2137B;
        Sat, 11 Apr 2020 12:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607575;
        bh=cxaqw+gj13L48qPCR+g9Lk8enKGNLTboZwEzcZD5KLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tJQyV7Xc2RnT+ZuMKwpiG2666tQGO74/3b2K/EFSIp1NJ5R4QByHH0wQG+ZluouWn
         MZBVe1QlPYnrB+IKK9BflSozHvR7ZWQOhRapao8JBXg00nw0bQFL81Z1Jp6Fq7GmYd
         XVMQGpiecjh5+AyxZgN2dS4yAeomUnFqqZYOn9iM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.5 33/44] hwrng: imx-rngc - fix an error path
Date:   Sat, 11 Apr 2020 14:09:53 +0200
Message-Id: <20200411115500.131180652@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115456.934174282@linuxfoundation.org>
References: <20200411115456.934174282@linuxfoundation.org>
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
@@ -105,8 +105,10 @@ static int imx_rngc_self_test(struct imx
 		return -ETIMEDOUT;
 	}
 
-	if (rngc->err_reg != 0)
+	if (rngc->err_reg != 0) {
+		imx_rngc_irq_mask_clear(rngc);
 		return -EIO;
+	}
 
 	return 0;
 }



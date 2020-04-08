Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19564C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCD320787
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360805;
	bh=2dtxiXcqpLlxzQY41glPzfxzzobbNtue35byn94ocz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QEsbbB6T8pfk1WEGbByEyMNbSC2xfNK+Xq1WFFrChvw7EuFeAphI03rd8kyoHRXwj
	 B+5Qlvg9EY6ismrEA68DBKT9+4yRX/dFaIojquij6FKhtjvQbX1yZ7G6qfLGbDWLte
	 +O/sKo2ayvUYUYfa66t8++wkWTGByqZ4/3H20Kw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgDHPqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729684AbgDHPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7B2B21D79;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=2dtxiXcqpLlxzQY41glPzfxzzobbNtue35byn94ocz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kj8MextYAoIKsWvztzjCGcKAsGVM1/9pAq2gRfDT/NqG2fUo8IAcqV441T/vNl56C
         9j4AscDetciOP4kRZGj/DcYvPvFhwG9zEusuROZCQJqbTf4AKV89pn+KzOJfzz6K7y
         b33++rZUEOu+m8Yo1q1U9vVZTrdgUcaCXvab2CXo=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cBv-SA; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH 21/35] docs: spi: spi.h: fix a doc building warning
Date:   Wed,  8 Apr 2020 17:46:13 +0200
Message-Id: <d62f3f3536c0da2062bad87524fb184ad5a9a5f2.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to add a blank line to avoid this warning:

	./include/linux/spi/spi.h:401: WARNING: Unexpected indentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/spi/spi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 38286de779e3..aac57b5b7c21 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -394,6 +394,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *                   for example doing DMA mapping.  Called from threaded
  *                   context.
  * @transfer_one: transfer a single spi_transfer.
+ *
  *                  - return 0 if the transfer is finished,
  *                  - return 1 if the transfer is still in progress. When
  *                    the driver is finished with this transfer it must
-- 
2.25.2


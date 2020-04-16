Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C49CC3815B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB5621D93
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587043703;
	bh=fSNbiy2el5P90GKHtiHlis5ld66ekToXznPAUl6Zzjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pamSQ2DgjOcTCIUWiUJRvsIfixXIkCGH3LgDsHnhqYTjvjYu1rHABkIUpuwNbrvR/
	 LIl1/NYM898gfJlyJsdBtS5C2PB42MZiML3/NXcUgbl2cIl1m04qxxXH4oDR1H8Bql
	 yXFVB1NWBBmlgwlXmgsuYzC5daE31xTvJVPRW5fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895734AbgDPN2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895411AbgDPN1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:27:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EC13206E9;
        Thu, 16 Apr 2020 13:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043630;
        bh=fSNbiy2el5P90GKHtiHlis5ld66ekToXznPAUl6Zzjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZ7EgjJN0kBL6p1CI0bOzbkxlKpncEzSsgVKgUCytSfjjQqSmR+J6NFO7RanO6gJR
         1GAEEhTy6iKuY3yx9L2AzBxAogmef8XNCJYscRFp+NyV+SzXjKPmtBTOTaNiqIL6gb
         dz1zPaLftiupQK3YRgL3Nokj9PBFY9k+Y+nIBhGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alain Volmat <avolmat@me.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 009/146] i2c: st: fix missing struct parameter description
Date:   Thu, 16 Apr 2020 15:22:30 +0200
Message-Id: <20200416131243.801663383@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <avolmat@me.com>

[ Upstream commit f491c6687332920e296d0209e366fe2ca7eab1c6 ]

Fix a missing struct parameter description to allow
warning free W=1 compilation.

Signed-off-by: Alain Volmat <avolmat@me.com>
Reviewed-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-st.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 9e62f893958aa..81158ae8bfe36 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -437,6 +437,7 @@ static void st_i2c_wr_fill_tx_fifo(struct st_i2c_dev *i2c_dev)
 /**
  * st_i2c_rd_fill_tx_fifo() - Fill the Tx FIFO in read mode
  * @i2c_dev: Controller's private data
+ * @max: Maximum amount of data to fill into the Tx FIFO
  *
  * This functions fills the Tx FIFO with fixed pattern when
  * in read mode to trigger clock.
-- 
2.20.1




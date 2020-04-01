Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261A7C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F043C212CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758302;
	bh=VVqiKESmK0JzpP6L6hrIobYwxWE1UL9LyqmMttbagOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jyTkeOxQQ/CCb/GNe0bzL/XEUGZ79bhnfa8lDkG6yPkS6KEU2Y5arsarFFMd4Clda
	 +CjUsjs+RuWINExil09mcnyUFAXSy4+MI+htELEwRn9xrwilvm5xhkbhN2Ik+Vra7c
	 zoVmM/2vM+ifg61STjZ3czyRle0pPmQ94rtH1TxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbgDAQZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387553AbgDAQY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:24:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48D12212CC;
        Wed,  1 Apr 2020 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758298;
        bh=VVqiKESmK0JzpP6L6hrIobYwxWE1UL9LyqmMttbagOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bo7lvsEDxxV1dcc0ipcbSrBPikzyENjBEJmoDVQrRT2FLGDbPwAz+YEvqqJrYorRa
         chlUdNFYbYhOjBx2W/Ca31zBRquVlX3JCY+b/Z44byxfCbaACxGXoi4DTrPjMaV15M
         u+WSC2K6e0ht9/NkMTajX3tCyyqCw9Eul0jemSLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org
Subject: [PATCH 4.19 047/116] i2c: hix5hd2: add missed clk_disable_unprepare in remove
Date:   Wed,  1 Apr 2020 18:17:03 +0200
Message-Id: <20200401161548.544784414@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

commit e1b9f99ff8c40bba6e59de9ad4a659447b1e4112 upstream.

The driver forgets to disable and unprepare clk when remove.
Add a call to clk_disable_unprepare to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-hix5hd2.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -482,6 +482,7 @@ static int hix5hd2_i2c_remove(struct pla
 	i2c_del_adapter(&priv->adap);
 	pm_runtime_disable(priv->dev);
 	pm_runtime_set_suspended(priv->dev);
+	clk_disable_unprepare(priv->clk);
 
 	return 0;
 }



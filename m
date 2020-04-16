Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A927C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2877421D94
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="ZR0st7j3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506319AbgDPLbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:31:31 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:44784 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506137AbgDPLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:09:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id D366527E0B5E;
        Thu, 16 Apr 2020 13:08:41 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tE2nbCn87b3q; Thu, 16 Apr 2020 13:08:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 89FA327E0B48;
        Thu, 16 Apr 2020 13:08:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 89FA327E0B48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1587035321;
        bh=CgbnTswji1oQ0xqt//3zV9OilQBy92rJwtf72ywek/U=;
        h=From:To:Date:Message-Id;
        b=ZR0st7j3UUiNtdzZJ51mKQNJV+gO4DcRAppsKwkbyxT1eK8j/dSCAOhmZCJCnzkws
         KPZiRtuMpSo2uXvLJZAu1sfowcN+UUf3GxIRMOGpc9O4j+fkHEct5hOzkbi7zBNkGz
         7OYvKMwyrP3EdjDRlZ/LoZxo1PDxsRecmWTxuq9U=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4gA3PP6zqAWx; Thu, 16 Apr 2020 13:08:41 +0200 (CEST)
Received: from triton.lin.mbt.kalray.eu (unknown [192.168.37.25])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 6BCF027E02FA;
        Thu, 16 Apr 2020 13:08:41 +0200 (CEST)
From:   Clement Leger <cleger@kalray.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Leger <cleger@kalray.eu>
Subject: [PATCH 0/2] Cleanup chip info in spi-dw driver
Date:   Thu, 16 Apr 2020 13:08:23 +0200
Message-Id: <20200416110823.22565-1-cleger@kalray.eu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some mechanisms have no more user, and as such code paths are unused.
Remove these code paths and associated structs members.

Clement Leger (2):
  spi: dw: remove unused dw_spi_chip handling
  spi: dw: remove cs_control and poll_mode members from chip_data

 drivers/spi/spi-dw.c | 57 +-------------------------------------------
 drivers/spi/spi-dw.h | 12 ----------
 2 files changed, 1 insertion(+), 68 deletions(-)

-- 
2.17.1


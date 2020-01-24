Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A55FC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5F2206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860363;
	bh=MOYuMSe5m+xPdrBUrgqNDECPFxtnpuMy0BGF0ZkhL74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e/+EQcXhNokHt74cn96hbC9ji9XrY2MjWi0ol+08oHMTsVS6pqRsOZAKHvjlzYJbN
	 lgIX9dgut593oOPUcdTNE06g8zxmfxEUe9pD5/fR3NwDjY/9LsR4JTaZkFz+/2RbhP
	 bsP/TNk7ChFT0wy181qbfxE/Ge90S5UreMOYFTQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389266AbgAXKGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:06:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389117AbgAXKF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:05:58 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A69412087E;
        Fri, 24 Jan 2020 10:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860358;
        bh=MOYuMSe5m+xPdrBUrgqNDECPFxtnpuMy0BGF0ZkhL74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOYPVcp/DcHvwV05AubwIZf6pR1Gd8ITQROGv8D2m4CBdUgeeOKKx7zSPlN8b7kPj
         MwCpv3JEB8qdHCcYgfmiJh9DMT6PxOcjGVelTK9B8FbWLovDI1J+8suQabiK08GjNK
         B9t9pB6phTYp7IYBle17Jbb5NMgfbT+mFSBhyXY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Antonio Borneo <antonio.borneo@st.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 320/343] net: stmmac: fix length of PTP clocks name string
Date:   Fri, 24 Jan 2020 10:32:18 +0100
Message-Id: <20200124093001.917173374@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antonio Borneo <antonio.borneo@st.com>

[ Upstream commit 5da202c88f8c355ad79bc2e8eb582e6d433060e7 ]

The field "name" in struct ptp_clock_info has a fixed size of 16
chars and is used as zero terminated string by clock_name_show()
in drivers/ptp/ptp_sysfs.c
The current initialization value requires 17 chars to fit also the
null termination, and this causes overflow to the next bytes in
the struct when the string is read as null terminated:
	hexdump -C /sys/class/ptp/ptp0/clock_name
	00000000  73 74 6d 6d 61 63 5f 70  74 70 5f 63 6c 6f 63 6b  |stmmac_ptp_clock|
	00000010  a0 ac b9 03 0a                                    |.....|
where the extra 4 bytes (excluding the newline) after the string
represent the integer 0x03b9aca0 = 62500000 assigned to the field
"max_adj" that follows "name" in the same struct.

There is no strict requirement for the "name" content and in the
comment in ptp_clock_kernel.h it's reported it should just be 'A
short "friendly name" to identify the clock'.
Replace it with "stmmac ptp".

Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
Fixes: 92ba6888510c ("stmmac: add the support for PTP hw clock driver")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index e471a903c6543..1c1d6a9428229 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -154,7 +154,7 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 /* structure describing a PTP hardware clock */
 static const struct ptp_clock_info stmmac_ptp_clock_ops = {
 	.owner = THIS_MODULE,
-	.name = "stmmac_ptp_clock",
+	.name = "stmmac ptp",
 	.max_adj = 62500000,
 	.n_alarm = 0,
 	.n_ext_ts = 0,
-- 
2.20.1




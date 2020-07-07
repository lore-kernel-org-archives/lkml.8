Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C39C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E80207C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135128;
	bh=qzPHmZKYuLcVw+C0AcHXnE/OZJMRQVPaCQdrtUOUQj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fOvf9xUB5ZO9V8JaMbimWwcnw/gQVBF9FDocBwgOgrxnYktKzXstnDOr78L7miwZD
	 SYEwq6KT+KKEWKzQ6yD5Q+rWsWbHNb54XObJSRgnEEP4SSIAZm198TfPyuOjo74Hrc
	 a13Rpd+9fATtyHRy6kNbbntiZ56yda/vy2G7VDVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgGGPSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729216AbgGGPSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:18:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E65F20773;
        Tue,  7 Jul 2020 15:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135124;
        bh=qzPHmZKYuLcVw+C0AcHXnE/OZJMRQVPaCQdrtUOUQj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQSLNDpmw/tFPkdXieajM6Y4H9ldGoNUv91mUI2okqMl8INtcHkdNDtgNEQpJP3QT
         RUjoF7TW07EWozoaozMGCLq+TpHguSgn3GgWvJbMUs2T/sBtLsS24alwvTybIB7e/3
         PaORaBFkJTrqNGasNX7yDqMy0heq87e3qL2ZxPbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Andersson <pipatron@gmail.com>,
        Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 03/36] EDAC/amd64: Read back the scrub rate PCI register on F15h
Date:   Tue,  7 Jul 2020 17:16:55 +0200
Message-Id: <20200707145749.295372865@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145749.130272978@linuxfoundation.org>
References: <20200707145749.130272978@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

[ Upstream commit ee470bb25d0dcdf126f586ec0ae6dca66cb340a4 ]

Commit:

  da92110dfdfa ("EDAC, amd64_edac: Extend scrub rate support to F15hM60h")

added support for F15h, model 0x60 CPUs but in doing so, missed to read
back SCRCTRL PCI config register on F15h CPUs which are *not* model
0x60. Add that read so that doing

  $ cat /sys/devices/system/edac/mc/mc0/sdram_scrub_rate

can show the previously set DRAM scrub rate.

Fixes: da92110dfdfa ("EDAC, amd64_edac: Extend scrub rate support to F15hM60h")
Reported-by: Anders Andersson <pipatron@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org> #v4.4..
Link: https://lkml.kernel.org/r/CAKkunMbNWppx_i6xSdDHLseA2QQmGJqj_crY=NF-GZML5np4Vw@mail.gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/amd64_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 268ada29cd987..cbe4158531979 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -261,6 +261,8 @@ static int get_scrub_rate(struct mem_ctl_info *mci)
 
 		if (pvt->model == 0x60)
 			amd64_read_pci_cfg(pvt->F2, F15H_M60H_SCRCTRL, &scrubval);
+		else
+			amd64_read_pci_cfg(pvt->F3, SCRCTRL, &scrubval);
 		break;
 
 	case 0x17:
-- 
2.25.1




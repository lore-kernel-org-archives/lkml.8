Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243AEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023B52068D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="hXS2eopB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbgEYIYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:24:52 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:51760 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbgEYIYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:24:49 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49Vqrw4bXWz9vC8F
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:24:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UOltj2F8jyCY for <linux-kernel@vger.kernel.org>;
        Mon, 25 May 2020 03:24:48 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49Vqrw30lYz9vC7f
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 03:24:48 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49Vqrw30lYz9vC7f
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49Vqrw30lYz9vC7f
Received: by mail-io1-f70.google.com with SMTP id a2so7335350iok.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UgPHdCth6FfAh45Sp7ZUoEgt/yFAzGGw7Kx8LIhpmq8=;
        b=hXS2eopB+hvH691nPeB1Zs2AMGFgmIX2UDsXvN31/HKoTn0XPTA+V61fDS1KpI6EAP
         fKAC4tW56wRc49zPqmwJOjxCgYCIy5aXHVtsIKjqoUBNRg/uUknqu47ZU04B3FanFDX0
         VUApByauUqYaafkLS+r10m/lgxPlP0GV/0DcJLMQnKU2hfcQ2wRwCwoiym1+sZ3UN+Za
         8tlPGzYreXpKNYgPWO3j3OCST7oTFyDc1Jw9hD2CKQjLWYlExq2//jW55N59s33I11xg
         qRmPCa337Ja13H7oiv/S2E3Ul0DyhQtaV6Pc8rhU4x7h0OK/QUwWpAEtUDcTIf9o+00S
         PfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UgPHdCth6FfAh45Sp7ZUoEgt/yFAzGGw7Kx8LIhpmq8=;
        b=sJCGpIEGXvlix2JyyMWDC7CTHyGW4gjZUq7o4qxQwNF2MJNoo1Zpar1ZJpqY21Exlr
         jsyQ0LVSizMIplzvFZ/N5i/wME9otTqXLvFh3fWh8/AmJNnlXN4N/aorEORlGitXzlJ5
         3cIScHoUqkzDoP8gxoEHzZWWMhPKXpnr/BtNIEGlM4a1uvnUcwMkYBEgWK8+OjH3u8wD
         x3j7OW/rkaJ/CaPk7HPGTLJEIJodJTKA2k00DlgTTZhwZDZX00Q6mGo5fF/TT5WnIK9e
         fKwIoMmV3AQ+EFM5MU5cqJ1z3ZpQlR0L1R2vLQb3ymWdYzTQI5cC2Lqftx+wx+k7zFFl
         i87A==
X-Gm-Message-State: AOAM530Elu34hPzW9E20iOba/78ydriUWPN1X4K3c0nwhHtszt7LJlWi
        N3CLhdLX8c6e5M9A7twslH6OVEnSYrUiv4HAkCngQazr9WZY+oDVvt3ZEfLTJP/0Qc2RLz0mqXy
        hirRAbNYuRS8Yc16VU2fEUdNQQkRp
X-Received: by 2002:a92:7f03:: with SMTP id a3mr7363180ild.269.1590395086906;
        Mon, 25 May 2020 01:24:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLEnS9ErHtnXEYR675VkwcBtM4ELkTqkTi0AF3EzLzdY1KPbwvUJq+fAVZlkTlUM+RbSgA7Q==
X-Received: by 2002:a92:7f03:: with SMTP id a3mr7363168ild.269.1590395086524;
        Mon, 25 May 2020 01:24:46 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id b7sm7173816ioq.40.2020.05.25.01.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 01:24:45 -0700 (PDT)
From:   wu000273@umn.edu
To:     shshaikh@marvell.com
Cc:     manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] qlcnic: fix missing release in qlcnic_83xx_interrupt_test.
Date:   Mon, 25 May 2020 03:24:39 -0500
Message-Id: <20200525082439.14113-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function qlcnic_83xx_interrupt_test(), function
qlcnic_83xx_diag_alloc_res() is not handled by function
qlcnic_83xx_diag_free_res() after a call of the function
qlcnic_alloc_mbx_args() failed. Fix this issue by adding
a jump target "fail_mbx_args", and jump to this new target
when qlcnic_alloc_mbx_args() failed.

Fixes: b6b4316c8b2f ("qlcnic: Handle qlcnic_alloc_mbx_args() failure")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
index 2a533280b124..29b9c728a65e 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
@@ -3651,7 +3651,7 @@ int qlcnic_83xx_interrupt_test(struct net_device *netdev)
 	ahw->diag_cnt = 0;
 	ret = qlcnic_alloc_mbx_args(&cmd, adapter, QLCNIC_CMD_INTRPT_TEST);
 	if (ret)
-		goto fail_diag_irq;
+		goto fail_mbx_args;
 
 	if (adapter->flags & QLCNIC_MSIX_ENABLED)
 		intrpt_id = ahw->intr_tbl[0].id;
@@ -3681,6 +3681,8 @@ int qlcnic_83xx_interrupt_test(struct net_device *netdev)
 
 done:
 	qlcnic_free_mbx_args(&cmd);
+
+fail_mbx_args:
 	qlcnic_83xx_diag_free_res(netdev, drv_sds_rings);
 
 fail_diag_irq:
-- 
2.17.1


Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D76C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1D92253D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844992;
	bh=EmVp/FvO12B6npsKyvEA08xNMu5dfLgtPtThwfKw6fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jikxsypEhgM8rXgJlOUAy8v4H9Vhyrix8D0DgZjy8Gxi8ZqNAZm5PJ2MldCHQF0UK
	 J4AO6Rn2hKH7k8M+mUzTNtxKiEI67SXKYD4hoDmwQquKdLv0yHOMt40fqLRy6kZ8+B
	 q0atLA4WvS79IgSrZdIzQ0vuyLSVJmQi6JyrF2R0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgCJM4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbgCJM4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:56:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 447CA2253D;
        Tue, 10 Mar 2020 12:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844982;
        bh=EmVp/FvO12B6npsKyvEA08xNMu5dfLgtPtThwfKw6fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19Jhvg/SpIWpo++TGENHruHz3CGvGksMNT9fXRsrwBbEvHXPOyl+oGdvb/ow2Ehsv
         AF5g25hluNlinIv6kao1ijTh5VWmcVdMMKkwhaJGchHn23ylF2nHzJYYXbnE5VKdKX
         ZikZlWyE3UDXw7GjH8WcAKBYbcNX3pRDjhmxcLJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omer Shpigelman <oshpigelman@habana.ai>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 020/189] habanalabs: do not halt CoreSight during hard reset
Date:   Tue, 10 Mar 2020 13:37:37 +0100
Message-Id: <20200310123641.507093495@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

[ Upstream commit a37e47192dfa98f79a0cd5ab991c224b5980c982 ]

During hard reset we must not write to the device.
Hence avoid halting CoreSight during user context close if it is done
during hard reset.
In addition, we must not re-enable clock gating afterwards as it was
deliberately disabled in the beginning of the hard reset flow.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 166883b647252..b680b0caa69be 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -598,7 +598,9 @@ int hl_device_set_debug_mode(struct hl_device *hdev, bool enable)
 			goto out;
 		}
 
-		hdev->asic_funcs->halt_coresight(hdev);
+		if (!hdev->hard_reset_pending)
+			hdev->asic_funcs->halt_coresight(hdev);
+
 		hdev->in_debug = 0;
 
 		goto out;
-- 
2.20.1




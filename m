Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02C2C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5B420754
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584450681;
	bh=k83KdBoXfW98aKS+hy1RJ+LlInvLpqLoXHg6DrbdTGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v5ay3ou7ZgBPZcd8eM9tdTXpK0a/vINV+JoC0/UHkfHApfsDXHRPd/Ranezaa6CKz
	 bRfZQOvKlS1cgsFZv12oYSGQ48FxYgV7QhS+SzWeRu61bzPh/6+ThpmL0iUfhl2+hm
	 a1MyNuyU39wkuTtfbDSqxMjwxS7T0nyU+chbI+dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCQNK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgCQNKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:10:55 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E39120754;
        Tue, 17 Mar 2020 13:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584450655;
        bh=k83KdBoXfW98aKS+hy1RJ+LlInvLpqLoXHg6DrbdTGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCRjndv4mNqha5oCgKY81AuSZwCPUw+16Di6NWb6AzOqQAUZmgw/S2G5tcLGf4Xqw
         wwwth0POCoDZPcma78Ja55L8DKCOLQGmVB+8D82u7P3SMeP0ru44MI90bl2NwrjDhI
         d21u+WA2VZZRR8dyjVwhn4X23dxJXaLpMO09IU44=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEBzh-0006Rx-Hl; Tue, 17 Mar 2020 14:10:53 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 03/12] MAINTAINERS: drop an old reference to stm32 pwm timers doc
Date:   Tue, 17 Mar 2020 14:10:42 +0100
Message-Id: <46a19a2074ed772c2f4aaa95ebe06892f235188c.1584450500.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584450500.git.mchehab+huawei@kernel.org>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT files for pwm were merged and converted to json.
The new reference is already at the maintainers file, so
just drop the obsoleted one.

Fixes: 56fb34d86e87 ("dt-bindings: mfd: Convert stm32 timers bindings to json-schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 21204be0b4bf..39da9ac4cc1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16055,7 +16055,6 @@ F:	drivers/pwm/pwm-stm32*
 F:	include/linux/*/stm32-*tim*
 F:	Documentation/ABI/testing/*timer-stm32
 F:	Documentation/devicetree/bindings/*/*stm32-*timer*
-F:	Documentation/devicetree/bindings/pwm/pwm-stm32*
 
 STMMAC ETHERNET DRIVER
 M:	Giuseppe Cavallaro <peppe.cavallaro@st.com>
-- 
2.24.1


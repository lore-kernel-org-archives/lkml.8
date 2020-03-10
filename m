Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931E2C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7A024677
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583847799;
	bh=DdDJtWHi2H49ww4hWds4DmXdrTa7wUbWexaZ3wt/zYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UxIcLEwAIb5MH/TzGLohDvkjlPZpfRTMeP3TsW2MNtJpvorR1i+NkFp3pKXbbMsAw
	 uAvVQeeCGS044QtSrIE7rByWMtgksIF262QT1NERDnMiW1Me8/ZMO5EVl2QD/tR7Yz
	 ykExM/kLB3Ax7l4wqhGqfUonRf/OAPpSFAdEgbaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgCJNnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbgCJNnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:43:17 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0094220675;
        Tue, 10 Mar 2020 13:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583847797;
        bh=DdDJtWHi2H49ww4hWds4DmXdrTa7wUbWexaZ3wt/zYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WjfniYzOwm2CohNAOZh7zJNXAHlQti0HgsoiMkypFaYMgS8LAUtk2LAJH4sukwIj7
         wH+2jh/Gm7phpsGFC2q7uX7iqKZdGugPf6PZQDPjP3fQoywkqvbcLgYkuUlemAvtfj
         3XHeVHd/67FeuRjbOzspQ4h4boYXDwhQkDz2UuUc=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jBfAA-0005vI-UE; Tue, 10 Mar 2020 14:43:14 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-media@vger.kernel.org
Subject: [PATCH v2 01/22] media: docs: avermedia.rst: mark a table as such
Date:   Tue, 10 Mar 2020 14:42:52 +0100
Message-Id: <f7b17f5d922034e9b5b1be326635e268d68eec1d.1583847556.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583847556.git.mchehab+huawei@kernel.org>
References: <cover.1583847556.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a table on this file, with aren't using the ReST
markups. Fix that.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/media/dvb-drivers/avermedia.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/media/dvb-drivers/avermedia.rst b/Documentation/media/dvb-drivers/avermedia.rst
index 14f437ca38d3..bf35fd88e164 100644
--- a/Documentation/media/dvb-drivers/avermedia.rst
+++ b/Documentation/media/dvb-drivers/avermedia.rst
@@ -172,12 +172,16 @@ Dandenong.
 The frequencies broadcast by Mount Dandenong are:
 
 Table 1. Transponder Frequencies Mount Dandenong, Vic, Aus.
+
+=========== ======= ===========
 Broadcaster Channel Frequency
+=========== ======= ===========
 ABC         VHF 12  226.5 MHz
 TEN         VHF 11  219.5 MHz
 NINE        VHF 8   191.625 MHz
 SEVEN       VHF 6   177.5 MHz
 SBS         UHF 29  536.5 MHz
+=========== ======= ===========
 
 The Scan utility has a set of compiled-in defaults for various
 countries and regions, but if they do not suit, or if you have
-- 
2.24.1


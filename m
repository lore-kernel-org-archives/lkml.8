Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB47C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8627D20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="xP1SoCnD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NIPncPZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgFJR5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:57:21 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:57777 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726982AbgFJR5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:57:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 576EE7A3;
        Wed, 10 Jun 2020 13:57:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 10 Jun 2020 13:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=SiHw8t1C76QbP
        q88iFMh4v4nWIh2uDFrVmug2k4eJjA=; b=xP1SoCnDecokXmz7i+a4eF/nUQAFv
        0HmZ2vbc2+/9+Lw71z9UU0ZrGr6F0cG+R8cGoyqfc1Ju1BSYhnlblidvvhhAzUJ+
        F3iZ6FjuwMp61Op5JzVEzUxYfoC7Qt8mo+avO50xgKiJHBc5DG4QYur+3azsWkLO
        GsCNhMWL46aRzeLP0R1f3fOQx3ir/e4XdtSZHAxlMDRiQTLLlzTX4oSkSNcKF47e
        2Y7ep1ubkB/MEuAzRVvYP2hdVD1HLsrXZjN4VKzLUi+3JRQnZWzQ8XYavPKewzRN
        yfxzTq11qIZd/7BNRn0ncJ9x8YbHR28Noojy8KhjyGhJQORHblCZlCl6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=SiHw8t1C76QbPq88iFMh4v4nWIh2uDFrVmug2k4eJjA=; b=NIPncPZ4
        Tuwv7GU2P3lvvxPUdpaS2MISSS0U8SqgAwjlXSpf/kMT8SdXXDuYpbxNKEn1ydgr
        2ycozcldApJHzJRo3afRfXHm4AF5jMNMUeT90lY064rZXDsjAdvvVOYv6fEDCBop
        vbHlf2eIFOPpQrGBdi6MG045qdLWpTqxGZ31qq0c/B8fb9iFFhll+7TcgOaQM4IU
        Gvwk3Y4nRK7sJXEatIMC0ue1borOAs4pAqyg8vzt3aA3uKZZ0DPEuBx/d5H1LzRh
        cqG/04tq866tnzRQSSVVeO4Rbe88Nn0pthG12U4vuRf2FiNKps+c9MV1oUCpvGSX
        GJhk0nhCYs5wWA==
X-ME-Sender: <xms:-x7hXu7h5XoKovcPJGdbCmOjBb6uMBYYhk0cLkQECazQjid3AB1L0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehiedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepjgcurfgr
    rhhithgthhgvrhcuoeihrdhlihhnuhigsehprghrihhttghhvghrrdgtohhmqeenucggtf
    frrghtthgvrhhnpeejgeefteelueelveetjeetteeifffggfefvdffffdvtddvvdevvefh
    hfdthedukeenucfkphepieejrdekgedrudelgedrudejheenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeihrdhlihhnuhigsehprghrihhttghh
    vghrrdgtohhm
X-ME-Proxy: <xmx:-x7hXn4iO9Dwl8Y5Hkt3cF6_Sgnha79OKwJ-HSxYv8x-uEuZNArc7A>
    <xmx:-x7hXtc7s9G4DXfVR_ls6J2iGe-Mi-08NgF1tBsZ5CpDlklAvH4ehA>
    <xmx:-x7hXrIQKzIOGENVTNyyEmz0xDf_5tEBPspuxbnCy0hGXvNdvKNkig>
    <xmx:-x7hXkjA_Ek7wD4682TrjdEt6OVRZ97QPRBcM9oXXa_v8JyCOpnJAg>
Received: from localhost.localdomain (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2F0B33060FE7;
        Wed, 10 Jun 2020 13:57:15 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mario.Limonciello@dell.com
Subject: [PATCH v4 0/3] platform/x86: dell-wmi: new keys
Date:   Wed, 10 Jun 2020 13:56:55 -0400
Message-Id: <cover.1591811549.git.y.linux@paritcher.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591584631.git.y.linux@paritcher.com>
References: <cover.1591584631.git.y.linux@paritcher.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change since v3:
    No code changes.
    Update commit message to reflect info given by Mario at dell.
    
Is there anything more i have to do for the patches that were reviewed
or will they be picked up by the maintainers?
Thanks

Y Paritcher (3):
  platform/x86: dell-wmi: add new backlight events
  platform/x86: dell-wmi: add new keymap type 0x0012
  platform/x86: dell-wmi: add new dmi mapping for keycode 0xffff

 drivers/platform/x86/dell-wmi.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

-- 
2.27.0


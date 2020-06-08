Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC46AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4EA720842
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="3y961/Qs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rgRjV6WM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbgFIBKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:10:07 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:46893 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726896AbgFHXGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:06:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 13AAB88D;
        Mon,  8 Jun 2020 19:06:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 19:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=NY39phx6m9tvz
        RpZvc6G/x6My2ajZYgVoDhFetwnDNw=; b=3y961/Qs87Bf+KYKX4YxIgCvnfLuA
        gWQq4q78O9mnFR0fs3FP636ZKlyPgKBcqpQxnTu3vcHWI2O0RQX42vZayYse+s3M
        mpdf6YsyPnfutTOgwEyA8yJsh/k+kvFPp+cDMFLQFfUh123Q5YyLB9gKB1zi54g5
        hRHjHqn2mzyhcX9kUBCJw7aB/IQ4I1dbZnAQ74sAqQvb9+V2JTaeALjA/46P+UCK
        5SylFXuXZ7tjRYRdmK8PICBnzX1TF4bzoUcSFshkqjU77oFATefXqyAqLQ96zyWG
        v8fxTCwRa0FvZ3pkr+SlUJO3Ni3zZMV/2g8dcKvYqFRvu3aAWfBCPUFgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=NY39phx6m9tvzRpZvc6G/x6My2ajZYgVoDhFetwnDNw=; b=rgRjV6WM
        GiY3XgB6uQZ46DxNkZN8MlwksEf+9ajYuek1mFXCOjMttSn4kjogOYhKStestv1c
        8LShT9kuedPTUazCVOejJtVsuwfqeXTchY6TwaIYgrySnhOM1+Lt4OwVgFYzUBx2
        KZpCRhQxyGQDCGfFIPulucQxVOWOkakj52okFwZCfKKh3pyzy0upZAPrnDrug/m4
        oGID/jHMx7hP9rTdqz81ZHUk8tyazj0PjUc8ah5k67nqcBD6XI1RRq1+TL+akE2X
        /CZpM+77PQi934KroHNvbVwiLX3sPoRl+EYDh78NVZvm2qz0NP8fDrgdK1DMfO9Z
        nQCIVRufK1lQTw==
X-ME-Sender: <xms:ZcTeXoSENO1o_R4MAfcUrDXn3vCIhkf-ChQdEuW8mku_cgOzRtPb2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehfedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhephffvufffkffojghf
    ggfgsedtkeertdertddtnecuhfhrohhmpegjucfrrghrihhttghhvghruceohidrlhhinh
    hugiesphgrrhhithgthhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepjeegfeetleeu
    leevteejteetieffgffgfedvffffvddtvddvveevhffhtdehudeknecukfhppeeijedrke
    egrdduleegrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhephidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomh
X-ME-Proxy: <xmx:ZsTeXlwgERgB0y0DVejWGDRLlOBpquJAapvLicZ5PKw5pW5y_TwKuA>
    <xmx:ZsTeXl3HjTb3bzw-yxQToKQ4IkaarUByft0p1dF2NH7-T3BiA3vdOA>
    <xmx:ZsTeXsDcGlCawsHL-52KwG9yxIMc-X4AT_uh25DK2AqsV1nPVxyN-A>
    <xmx:ZsTeXhbAqEUhkjlXGa2q7bvSXfAXjdWDsEHM0cZCA6btDBHin60bdQ>
Received: from localhost.localdomain (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id B9F2A3280066;
        Mon,  8 Jun 2020 19:06:13 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Mario.Limonciello@dell.com
Subject: [PATCH v2 0/3] platform/x86: dell-wmi: new keys
Date:   Mon,  8 Jun 2020 19:05:27 -0400
Message-Id: <cover.1591656154.git.y.linux@paritcher.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591584631.git.y.linux@paritcher.com>
References: <cover.1591584631.git.y.linux@paritcher.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per discussion backlight events are passed on as they are
filtered by acpi-video.

Events of type 0x0012 have extended data in the rest of the
buffer, this data is currently ignored.

The Fn lock key currently is ignored. If userspace has a way
to deal with this a function to pass on the extended data
can be added.

messages of type:
 
    firmware scancode 0xXX maps to unrecognized keycode 0xXXXX

are from unknown keycodes in the DMI table and should be added
to bios_to_linux_keycode to allow them to be processed.

Y Paritcher (3):
  platform/x86: dell-wmi: add new backlight events
  platform/x86: dell-wmi: add new keymap type 0x0012
  platform/x86: dell-wmi: add new dmi keys to bios_to_linux_keycode

 drivers/platform/x86/dell-wmi.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

-- 
2.27.0


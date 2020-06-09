Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5840C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 03:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801842078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 03:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="0VPg6Od+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gQZkj8LU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgFIDxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 23:53:22 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:43531 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726803AbgFIDxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 23:53:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 17A1A71C;
        Mon,  8 Jun 2020 23:53:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 23:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Fpv8Vs6NNHO5E
        BYLXuiJl8+my6EirXEyqYHHw/KlxY4=; b=0VPg6Od+M5jz1wrqSPuRoUlEMJDZ1
        61T4AiAHN3SaHxyx73dV5mF03qk/2ze51mUiZu5/9wrII+5dBBfZAFRC8ZVyAW6h
        yca2sI7hLvDZdo9KD1kmc2Q5lEPUCXIvG8dgxD2izBom8zR7wF9M4HKa5d+Alo6f
        nu3DncMEF034FexdFS1tjFH4leuzGdTsHf4WBj4aBOaSq+5Qij0YJ9gwxuNjVvN1
        iCnoF6peAI/qDhzGUHnVOg/l+TNJHCS8MRdj9zEC8VH5rl59vw9JT6NjioD58w5c
        WdZwoFwhiXzFMfBKmYYA+rMIAuCmpkG7GlomBMj3BWP7rIZuPscKsqyBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Fpv8Vs6NNHO5EBYLXuiJl8+my6EirXEyqYHHw/KlxY4=; b=gQZkj8LU
        S5FHu70jHC1xUuhmO4ULktC7DRO5AyuNrUunCNaFFCGEU/m3OXrzNPiuKsQOcvsw
        CP0ZupS8PtpLNlkgw+KdZIGhsQiM/5SlD0Y1WAIrLDCmzIuDx8uD5QYyUa08hHRQ
        l/cbRQhnsDpPz/uQC9xdKytDzBs0T9HSjEdhZdW1TXA6d4dITPvb68HK72BSVRQH
        qlcLoub3uXUgz+CuvOyREc/05lEPLnRzXU++gGj/cN9zrlRspE1nn7vdQzYYzJxk
        +SiWprFTMmyeh0TPpowwNfk4a/Sl0Asn5PpELikT1oLl2tMIGjsh4QNSWsm5tW5E
        iaE1/yE4+ThguA==
X-ME-Sender: <xms:pgffXm_H6ER9CwCgNeYIje9mwTU9MBdQeXdIJS0ADLnx8qF0qdkJqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehfedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpegjucfrrghr
    ihhttghhvghruceohidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomheqnecuggftrf
    grthhtvghrnhepjeegfeetleeuleevteejteetieffgffgfedvffffvddtvddvveevhffh
    tdehudeknecukfhppeeijedrkeegrdduleegrddujeehnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhephidrlhhinhhugiesphgrrhhithgthhgv
    rhdrtghomh
X-ME-Proxy: <xmx:pgffXmvAlN6qJRBYGlQUM-50SvSWGtNSG_mrylJXSEUs9keW2VpZTg>
    <xmx:pgffXsBnOo5jRMf95IAnKBUwCXGKf2bWPwakY9vAFn8iB6TdTMA2LA>
    <xmx:pgffXucY-HEDKHvE_xMQgzMHVPi1lrGqlJNhYaDLkg3jnlPkjAK2xA>
    <xmx:pgffXh26LPaphTMY2Fh8Z9LmpCmvEuo-pSAG0-i6IXOpZeM2UspzeA>
Received: from localhost.localdomain (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id E325F328005A;
        Mon,  8 Jun 2020 23:53:09 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mario.Limonciello@dell.com
Subject: [PATCH v3 0/3] platform/x86: dell-wmi: new keys
Date:   Mon,  8 Jun 2020 23:52:51 -0400
Message-Id: <cover.1591673143.git.y.linux@paritcher.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591584631.git.y.linux@paritcher.com>
References: <cover.1591584631.git.y.linux@paritcher.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extended data and events like Fn lock are currently ignored.
This is consistent with what was done until now.
Changing this is out of scope of this patch and would require
rethinking how events are processed, as on some devices the status
is sent as it own event, and on some devices via extended data.
That is also dependent on better docs from the team at Dell.

The keycode 0xffff look to be a special case and was added as an
exception code (Thanks Randy for the implementation).
It was not found for any key on my device, it is only located in
the DMI table parsed at boot into the keymap.

Overall I am trying to get useless data (to me) out of my syslog
by documenting the correct scancode/keycode mappings

Y Paritcher (3):
  platform/x86: dell-wmi: add new backlight events
  platform/x86: dell-wmi: add new keymap type 0x0012
  platform/x86: dell-wmi: add new dmi mapping for keycode 0xffff

 drivers/platform/x86/dell-wmi.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

-- 
2.27.0


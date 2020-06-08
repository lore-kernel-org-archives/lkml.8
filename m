Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC61C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 04:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C416020801
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 04:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="H9Z3mysF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b5OEvGRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgFHEW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 00:22:56 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39149 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726869AbgFHEWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 00:22:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0513F5C00C3;
        Mon,  8 Jun 2020 00:22:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 00:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=IWsOiUbZwkTY4DBGI6yY4sXXU3
        nmL/23BRuCy+XeQik=; b=H9Z3mysFvsIQx+W9ICd54hNVdHXn6bVs2cPWdZ/PxP
        rlyMrnqD3wxMldCzzYC2cEjJPUs1RjMsK1RG5GnlqfV153ZIZjm8k/fzt5Uwa/rA
        cwNvr5ot+A6VzM3adHxWXld7MDiZgWbNBwyb/Ke/u1y59G/XbPbvZyGVaE2AZUWy
        xqthLz4mklOE7sLJ5WsPCSHqMdwKygSz+BFlJ60Rap6z4DzTdJt8TiKaCN4gOp5H
        uB0cU9CjgH3sK14yLduBl8hWeR3o7Ibm5f+pemJUHxJMBjlsKHaLsv5/J4QAIuu0
        7hLZyUkn+ActPvQYrPbymhdX9G2yKkqar45kUcmTCQVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=IWsOiUbZwkTY4DBGI
        6yY4sXXU3nmL/23BRuCy+XeQik=; b=b5OEvGRWLJ/27sqj7wW+hUtlyVukCka+u
        7Aj0acSJRcnijTSIKBmQ1jMowt+IcLcG8I7cMEVNgwR24RHJWvz3FqoK9fpBiAnn
        U9BgK/qWRpPywb6CWmhLYSQJZmsnJg4xV6BoBZdsA7xrM6o+Av/Lf3OmBG9qHsyO
        LZ3/gRPHXQTTRhBuo4/BErW8mTo61qyCDLRbkdR321ou9B3+zdZeaUDGtlJvZFWQ
        KMoISy594M6RoxiK48IEF18vojaMla1y3vrfforA48YoXQA6mHxOXbcp77PcT4yc
        nt5ltwUTEM6xkfQyZbGMziAd31Rg6BKliBTz9RMcslOq1ac+0xh9g==
X-ME-Sender: <xms:Eb3dXs4n8HvSqTRs8OWd2RfY7qzHIElJ2Kscaz11O14HGC7U_uXhUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehtddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhephffvufffkffoggfg
    sedtkeertdertddtnecuhfhrohhmpegjucfrrghrihhttghhvghruceohidrlhhinhhugi
    esphgrrhhithgthhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepfedvgeeggeejkedt
    lefhfeeklefhhfekvdetudehteegudejgeekjedvueegteeinecukfhppeeijedrkeegrd
    duleegrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhephidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomh
X-ME-Proxy: <xmx:Eb3dXt4i4iYYBwZ38SjX_Ug8aLxnBxTwN0g7NC7lCLrwd6cG8b2fHA>
    <xmx:Eb3dXrekpFkQhWfbbA5g3qGa7dcmQIISDOpMAUs8XTBcpCW1VDlE8w>
    <xmx:Eb3dXhL4reb1O-b9i4owcemRfx6yML15OMqpWQ-O2TWaIYyyzxOmsA>
    <xmx:Er3dXqwBR3DZbAOawW9ec98iBBCEV5Nl9rJ-OaVGn61WlNmZ25ijpA>
Received: from localhost.localdomain (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3DFF03280059;
        Mon,  8 Jun 2020 00:22:41 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH 0/3] platform/x86: dell-wmi: new keys
Date:   Mon,  8 Jun 2020 00:22:23 -0400
Message-Id: <cover.1591584631.git.y.linux@paritcher.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add new backlight events with a type of 0x0010 and a code of 0x57 / 0x58,
add a new keymap type table 0x0012 for keycode of 0xe035 from the Fn-lock
key
extend bios_to_linux_keycode to 2 bytes to allow for a new keycode 0xffff

Y Paritcher (3):
  platform/x86: dell-wmi: add new backlight events
  platform/x86: dell-wmi: add new keymap type 0x0012
  platform/x86: dell-wmi: add new dmi keys to bios_to_linux_keycode

 drivers/platform/x86/dell-wmi.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

-- 
2.27.0


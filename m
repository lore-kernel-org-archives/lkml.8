Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61BDC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8644A20756
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b="SebW2Pv1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="issGFrct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEPAj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 20:39:26 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:60633 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726223AbgEPAj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 20:39:26 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DFA2984C;
        Fri, 15 May 2020 20:39:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 15 May 2020 20:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=UeBx2y3FLJnkkis+nd8tFB9upw
        ptQOMPel+ZzUd5MMA=; b=SebW2Pv1Yc18edFKadex4EsVsmOjbxQdTukBOkGyNU
        z8aTpj2GDev4y9Sn4SRfGv31285ntuuYF1vVIaRSaHf3myVZvuRewcLiilhf54dz
        8EuL0hWzftsKGnCbVd0bpG59Jg0cE1Vi/jvuY+8165RMoItsCVApdkqO/XKqe7fi
        31wF6wdQsGHCAL2Yq+laCORBg+6hJViL5YeKgvmLzSWlfojhh85NgxfH3A5/1bqV
        MUT7FehB3Aw04Kwc2titPgf56i3WwuyGgOLMnKqiPunBVdsrNyp1kdAbZQYi5hS1
        HYviIwO8umUVlw43GDOnjvIxVxYzGi8YNGcTv76jtZhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=UeBx2y3FLJnkkis+n
        d8tFB9upwptQOMPel+ZzUd5MMA=; b=issGFrctaPdZvf+VTCLggzswZqjBmi2vN
        LOkaOt9028a7iRAz1oQaFQtknpyYN2SCKtaV2Sj+LELIS4v9CbukV18/jd9gSVDp
        FxxNYYINFg7f9BmSsf8nGDqFGuCp37UzqEZ28btDq3irDumFxDxFlbL3bLSwrccL
        c7hPsQD74ik6NvJI1Xy2WQPrjHrX9560ySaWDDNChh2BcN9wphgZsRN/FH8miRlx
        Z+avZHY7h3eKPjmLNa41N0T0bdp0/cQRqJFcnWhhLJYND2hYDEze2mAH98AL/tdZ
        vV5uGoOspJPYII7bR9ExwH/41vH3ftGTAt+QzCaus1+hSxfY+bf1w==
X-ME-Sender: <xms:PDa_XnFf1S_UfESJDLkPx0Edu8f_wxfau-6YUXSFGLHjeRXrOUmJyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleelgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuvghnuceuohgvtghkvghluceomhgvsegsvghnsghovggtkhgvlhdr
    nhgvtheqnecuggftrfgrthhtvghrnheptdetvdegvdetudegieekjeefteeukeefhfeuue
    fgkeehgeejueffgeefffeggfeunecukfhppeeiledrvddtgedrudeikedrvdeffeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgessggvnh
    gsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:PDa_XkVFu1OXbccfCcVHxT4P5BXHAaHZk9wmVURSbuqzX6u1duix0g>
    <xmx:PDa_XpLU9I9VRKnB4tiH4XkYTPdRWPlzaUcDDHVxynFTWu0WrZoTvg>
    <xmx:PDa_XlEatRlrJXw3DtgFIoN_qFvTfz7fOKUbovg-HhPiQ-uuoJ6G1g>
    <xmx:PDa_XgTenGTSglK7yXFKd-riO8dc14A82zaePg27O51WawkK1WmoXw>
Received: from localhost (cpe-69-204-168-233.nycap.res.rr.com [69.204.168.233])
        by mail.messagingengine.com (Postfix) with ESMTPA id D41CC3066366;
        Fri, 15 May 2020 20:39:23 -0400 (EDT)
From:   Ben Boeckel <me@benboeckel.net>
To:     keyrings@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Document keyctl(KEYCTL_PKEY_QUERY) arguments correctly
Date:   Fri, 15 May 2020 20:39:16 -0400
Message-Id: <20200516003917.2035545-1-list.lkml.keyrings@me.benboeckel.net>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Boeckel <mathstuf@gmail.com>

This is the way the code parses the arguments and libkeyutils calls the
syscall.

Note on the email split: I'm still in the process of migrating emails
for various usages hence the email From mismatch here (I've migrated my
list subscription, but not my general contribution email).

Ben Boeckel (1):
  Documentation: security: core.rst: add missing argument

 Documentation/security/keys/core.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)


base-commit: 12bf0b632ed090358cbf03e323e5342212d0b2e4
-- 
2.25.4


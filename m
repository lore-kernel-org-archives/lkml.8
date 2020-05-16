Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28D1C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76C62207C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b="iA+GrvBH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+P3RCZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgEPAj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 20:39:28 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:60631 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbgEPAj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 20:39:26 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C8291850;
        Fri, 15 May 2020 20:39:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 15 May 2020 20:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=ke8aQ0QSzOho9
        AR5F2u+q+Ff9wFD7APCaAFa5HdpwcU=; b=iA+GrvBH1rYWW0KQItwFimEeC5XMX
        B8XUs3gBbdF1o2blCJzI3lGx3M6ziM5uEBnNEZd3VXNff5ghsdqpymGZeY3to2D7
        OOV9H2VQWrs7p4C20qzei/ajT5h90KHs3QgnWPi0mQGRn6Qvus5+pz4bVW2pdJtz
        Z2CCG+RjeYk4rAway6rIfFjVw79nChjS54Jg1wyFmipaJZP1ANW4InPCGQ6iAFhI
        36kBpOdm+wtGxy5DqXvJi+H3X/DisPdAuuLCqi0uSZhr9+ex1pexa3oytmNBskEd
        CEJVTg3XgWl1Xmc7FdLUTIFkZw7OadjI0D7/yoJCVY4Lbe/Jf+jBkTdPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ke8aQ0QSzOho9AR5F2u+q+Ff9wFD7APCaAFa5HdpwcU=; b=m+P3RCZ2
        M13zdsGb6BraJTeACCcD9DmrJZAGqXbibh5kwAQi86i8LLU0PTWmPOTsZCPrJD3o
        6M3Od6M5fJwOjebP8hCAT0e4WGe9T9k1p5B3394BwuqVp9mlpqgVKv5i1fgLitGW
        rpc20Cn9diFjlGbD7x4Jl0HBhS/ZlUKsbxx4KmoALpHmOfrad9/2KeQgclp6nCd6
        Aarb//p+4qvJ00bCFlkCvieRRdlBJWhE2kpjDo9rwgBpv3jK6pNo2cUCG0NMKMDh
        zEb0zKG1S/OPzUVJWuKNJrRnJkq5NB1037SlzdxoAgo7y0EM+eMe1+5FTPyHkUqB
        lqgX2OKJbxBotw==
X-ME-Sender: <xms:PTa_XlFZ12-NbwdBe9zoBkkflesQhNp28Hb2uv1JJF5dN37K7EO7ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleelgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuvghnuceuohgvtghkvghluceomhgvsegsvghnsghovggtkhgv
    lhdrnhgvtheqnecuggftrfgrthhtvghrnhepffekheelgfetleeghfehkeefieegffeltd
    ekhfevieefheeltdffheekueehkeehnecukfhppeeiledrvddtgedrudeikedrvdeffeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgessg
    gvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:PTa_XqXpkfWYVaAoUv5HwVMZNT6sBYTxyL8pADLm7YElrF_GPCS7-w>
    <xmx:PTa_XnIRhxjtbRaCOYmOfaam-LmBAPpA9PppzIDHfaiCjnd-IaHaHQ>
    <xmx:PTa_XrFFKgF_iR0o_r_9en74lhdQLZJYYhfGLrmoW5_jqenAvYnI4Q>
    <xmx:PTa_XmRUQLlm32ktxPjzRE6MhoCGKY1oK70b6mF3LJBq4wuivBgjyQ>
Received: from localhost (cpe-69-204-168-233.nycap.res.rr.com [69.204.168.233])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0E3523280059;
        Fri, 15 May 2020 20:39:25 -0400 (EDT)
From:   Ben Boeckel <me@benboeckel.net>
To:     keyrings@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Documentation: security: core.rst: add missing argument
Date:   Fri, 15 May 2020 20:39:17 -0400
Message-Id: <20200516003917.2035545-2-list.lkml.keyrings@me.benboeckel.net>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200516003917.2035545-1-list.lkml.keyrings@me.benboeckel.net>
References: <20200516003917.2035545-1-list.lkml.keyrings@me.benboeckel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Boeckel <mathstuf@gmail.com>

This argument was just never documented in the first place.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 Documentation/security/keys/core.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index d9b0b859018b..c26b9e7d47c2 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -920,10 +920,14 @@ The keyctl syscall functions are:
 
 	long keyctl(KEYCTL_PKEY_QUERY,
 		    key_serial_t key_id, unsigned long reserved,
+		    const char* params,
 		    struct keyctl_pkey_query *info);
 
-     Get information about an asymmetric key.  The information is returned in
-     the keyctl_pkey_query struct::
+     Get information about an asymmetric key.  Specific algorithms and
+     encodings may be queried by using the ``params`` argument.  This is a
+     string containing a space- or tab-separated string of key-value pairs.
+     Currently supported keys include ``enc`` and ``hash``.  The information
+     is returned in the keyctl_pkey_query struct::
 
 	__u32	supported_ops;
 	__u32	key_size;
-- 
2.25.4


Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FE0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7519B20772
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXMaZ05O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGGFdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 01:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGGFdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:33:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE08CC061755;
        Mon,  6 Jul 2020 22:33:12 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m9so7682739pfh.0;
        Mon, 06 Jul 2020 22:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+JFD8DByOq2aanx0SZRhh+Vls72xH1YM2iTf6wGQD9M=;
        b=qXMaZ05OPFr8XghZ/DM63tq49n93UeuV/Tc74NdaAS/mIzVXphXqFj1xMbNAlrg9Bk
         ZD6ySib361st7B7RlnQqiTAh0DS6PpASJXHHLgqkI8Wn/E1/plyR8w4TRds00MTmRxfb
         1NzIHYmy9/oQiborDAnFYxHmbal4TIE/oN2w16I3HLi/+2PuPUE6tN0xEgszIiljtzdH
         0Mz9yENEO51MVkFIzFjAMHYpaZ3sttpzmPsOFEgWYlOupYIw7mdbqfJGpv2UJ2VLMKN3
         Dq8RE8lW+2cp+dhtiZMtdaoK9A4uUHM7pBZ1/L1gbZX4ZmNTBpz5EK9hUjBzFcL2bi/u
         fCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+JFD8DByOq2aanx0SZRhh+Vls72xH1YM2iTf6wGQD9M=;
        b=qgqUTCrdiI4gUHETqaZvUwPC1w3XFM+gAReCxEsR7IN7XHfMMWqmh7z/safNGa82DZ
         FiaYH8zLjuStRelHh5/n7GW8d/fWwZ/C7l5sGI9RO+HeFECTRCe7RBsw/zCEblIt5pMG
         NrkQsE1ciAZLY+XnyWprI67j/+YUJrrmH6bKMDjI3HzPvS8+C1A1Zw9sAkamNLH+YO8d
         CH4FWfIu/bLh1RpPBu4B1AWzB3MRKO7Kz3xnzfCiIXiOhSclR4Yin++9nr9QwMww127K
         irAD8rmIFiqUrprdhA5MRUb7/jrD5nfCLcfINPM8HR6gD06srlXdSWzlY0WSX9AQnMRS
         2KFw==
X-Gm-Message-State: AOAM532Um0C8e+SAQHHhnxQn/lwRdLIxd/ScKSYticv1ggnbkR1ZS1yj
        hslBLzf+sbxv5MOcf6sj71I=
X-Google-Smtp-Source: ABdhPJyaySvye310FQsJb9Fg89bE8ENWrJzXsFp5usM1/bDJypggjC4+MWPThxUsb7RDHW0LuPmgwQ==
X-Received: by 2002:aa7:8391:: with SMTP id u17mr755529pfm.156.1594099992183;
        Mon, 06 Jul 2020 22:33:12 -0700 (PDT)
Received: from localhost.localdomain ([117.214.135.157])
        by smtp.googlemail.com with ESMTPSA id h1sm13110023pgn.41.2020.07.06.22.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 22:33:11 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Driver-API: Documentation: Replace deprecated :c:func: Usage
Date:   Tue,  7 Jul 2020 11:02:52 +0530
Message-Id: <20200707053252.32703-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace :c:func: with func() as the previous usage is deprecated.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 Documentation/driver-api/device-io.rst | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/driver-api/device-io.rst b/Documentation/driver-api/device-io.rst
index 0e389378f71d..764963876d08 100644
--- a/Documentation/driver-api/device-io.rst
+++ b/Documentation/driver-api/device-io.rst
@@ -36,14 +36,14 @@ are starting with one. Physical addresses are of type unsigned long.
 
 This address should not be used directly. Instead, to get an address
 suitable for passing to the accessor functions described below, you
-should call :c:func:`ioremap()`. An address suitable for accessing
+should call ioremap(). An address suitable for accessing
 the device will be returned to you.
 
 After you've finished using the device (say, in your module's exit
-routine), call :c:func:`iounmap()` in order to return the address
+routine), call iounmap() in order to return the address
 space to the kernel. Most architectures allocate new address space each
-time you call :c:func:`ioremap()`, and they can run out unless you
-call :c:func:`iounmap()`.
+time you call ioremap(), and they can run out unless you
+call iounmap().
 
 Accessing the device
 --------------------
@@ -60,8 +60,8 @@ readb_relaxed(), readw_relaxed(), readl_relaxed(), readq_relaxed(),
 writeb(), writew(), writel() and writeq().
 
 Some devices (such as framebuffers) would like to use larger transfers than
-8 bytes at a time. For these devices, the :c:func:`memcpy_toio()`,
-:c:func:`memcpy_fromio()` and :c:func:`memset_io()` functions are
+8 bytes at a time. For these devices, the memcpy_toio(),
+memcpy_fromio() and memset_io() functions are
 provided. Do not use memset or memcpy on IO addresses; they are not
 guaranteed to copy data in order.
 
@@ -135,15 +135,15 @@ Accessing Port Space
 
 Accesses to this space are provided through a set of functions which
 allow 8-bit, 16-bit and 32-bit accesses; also known as byte, word and
-long. These functions are :c:func:`inb()`, :c:func:`inw()`,
-:c:func:`inl()`, :c:func:`outb()`, :c:func:`outw()` and
-:c:func:`outl()`.
+long. These functions are inb(), inw(),
+inl(), outb(), outw() and
+outl().
 
 Some variants are provided for these functions. Some devices require
 that accesses to their ports are slowed down. This functionality is
 provided by appending a ``_p`` to the end of the function.
-There are also equivalents to memcpy. The :c:func:`ins()` and
-:c:func:`outs()` functions copy bytes, words or longs to the given
+There are also equivalents to memcpy. The ins() and
+outs() functions copy bytes, words or longs to the given
 port.
 
 Public Functions Provided
-- 
2.27.0


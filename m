Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE38C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ECF7207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhbLVoAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgHJSVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgHJSVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:21:41 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C53C061756;
        Mon, 10 Aug 2020 11:21:41 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u20so6051339pfn.0;
        Mon, 10 Aug 2020 11:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+JFD8DByOq2aanx0SZRhh+Vls72xH1YM2iTf6wGQD9M=;
        b=OhbLVoAmgO0WtSwfbFIuvITgBG1A+Us1nAmbkAZn3bFQeE3X+l4rBRnyDfNAcPhS9G
         X/caSXxnAEXwluvvK8fIO0LBn5uuVKLykPO5/CzgZeOeIHVk5kSyfZ3YCQPPbgRS2cPV
         poQmNOEIEmD1ElgvvH1ThkKafEsPYVdLZSBn7QV0vumFefyCRldQNb/AZsaQmiSZi7pn
         459o0a16rVd6HWW+OjqZ0xqOs8HEb2dBLOImDUfrZ6gqXhvCVMhhqZVfdGiqeBF1f8sl
         e1dPLxwbXVgq4lkQIiab7Q36BFbHMtie6AwDT81jmITyz2/65UCkZg6oqyfP1sFDEk2H
         bWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+JFD8DByOq2aanx0SZRhh+Vls72xH1YM2iTf6wGQD9M=;
        b=Qu6uK4y4UkqKAgAKgiC8LCZkzLgR5uQ7FNxGziFuasqO7LP8mqwTGtVvaoO9CVkWjS
         4eZIkyTbWWMU6wWQVOL2VjVtl1c0ltzYq5tTnlPFCxR1j+GqNf9KbakCitJ0vMhz2wFi
         Sy8TWyMeap4VhNlkyAEI3AIu4q1m0qJBDdnkV4CzPeek4s6j3hv2ROiNX4xJgvg4iqb4
         IhGPzmm6LcOWeiw2CPQrwsHCnzZAh2ySWh4T8EqwUPoGos0m8xp2CS4sZO9uMnMi2yNT
         VvMn7hqYwCl/uNcykcF1T7v3HMBCtVvRovVWSLeG/WwvyUPfiCz/AAfW9QV1uXUwnW0W
         2yZg==
X-Gm-Message-State: AOAM532cOmUlQQpvJktuusS6TAkweeZ5z4k51u5PqOdT/04gq4317aNz
        wYwTtfuVmKlryJvKkES3mYEXYmjzUds=
X-Google-Smtp-Source: ABdhPJwu+iKNRl9MVy9gLlxJdubMRx/+OdkJRXm4XqpZdr9WoC9uMx9DnGcenr2NxNJ6nOoQFzk8RA==
X-Received: by 2002:a63:4b63:: with SMTP id k35mr23855342pgl.235.1597083700496;
        Mon, 10 Aug 2020 11:21:40 -0700 (PDT)
Received: from localhost.localdomain ([124.253.77.168])
        by smtp.googlemail.com with ESMTPSA id 80sm23176615pfy.147.2020.08.10.11.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 11:21:38 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Driver-API: Documentation: Replace deprecated :c:func: Usage
Date:   Mon, 10 Aug 2020 23:51:07 +0530
Message-Id: <20200810182107.18577-1-puranjay12@gmail.com>
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


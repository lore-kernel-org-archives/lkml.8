Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC14C2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E899E2137B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645544;
	bh=P7eaBlYz4GzVkyvhowH9g6w/cqbHD7kEmXW8Sh3FLOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=agxbsf9q3HB0DPmK8iR1TXHDhMJWK3MEfgMnamYx5f4Lr4FVpiN6j8CaRwIgfFz1A
	 vBMGMvTZvsceyVQzDv6P0+kLPle2jHtbX/B7WTPVdeOApJs3lIU2JJVqZ7GGOGkhfz
	 fm08Vdeg4TZZzYc4fLTW4jM5WdBsaGY5ZekjmK7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbgCaJFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730541AbgCaJFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:05:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E35E20B1F;
        Tue, 31 Mar 2020 09:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645539;
        bh=P7eaBlYz4GzVkyvhowH9g6w/cqbHD7kEmXW8Sh3FLOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0RGjjvGrKqah8X/YblHRxr+bpBJcl+F687rsjGhJUTwsee/hfdaG8cwJGtCadSM/7
         kWL8QdUkulOYDPWI4vJluWj0BSlsInopwG3oAwWd7UoDkR9qBrKYAg5d6B/BkwhnBD
         ebwtGFFt0pUDsxqBlb4ZL2DrmkmuWY93AsGJzhAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugene Syromiatnikov <esyr@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.5 085/170] Input: avoid BIT() macro usage in the serio.h UAPI header
Date:   Tue, 31 Mar 2020 10:58:19 +0200
Message-Id: <20200331085433.312691286@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugene Syromiatnikov <esyr@redhat.com>

commit 52afa505a03d914081f40cb869a3248567a57573 upstream.

The commit 19ba1eb15a2a ("Input: psmouse - add a custom serio protocol
to send extra information") introduced usage of the BIT() macro
for SERIO_* flags; this macro is not provided in UAPI headers.
Replace if with similarly defined _BITUL() macro defined
in <linux/const.h>.

Fixes: 19ba1eb15a2a ("Input: psmouse - add a custom serio protocol to send extra information")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
Cc: <stable@vger.kernel.org> # v5.0+
Link: https://lore.kernel.org/r/20200324041341.GA32335@asgard.redhat.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/serio.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/include/uapi/linux/serio.h
+++ b/include/uapi/linux/serio.h
@@ -9,7 +9,7 @@
 #ifndef _UAPI_SERIO_H
 #define _UAPI_SERIO_H
 
-
+#include <linux/const.h>
 #include <linux/ioctl.h>
 
 #define SPIOCSTYPE	_IOW('q', 0x01, unsigned long)
@@ -18,10 +18,10 @@
 /*
  * bit masks for use in "interrupt" flags (3rd argument)
  */
-#define SERIO_TIMEOUT	BIT(0)
-#define SERIO_PARITY	BIT(1)
-#define SERIO_FRAME	BIT(2)
-#define SERIO_OOB_DATA	BIT(3)
+#define SERIO_TIMEOUT	_BITUL(0)
+#define SERIO_PARITY	_BITUL(1)
+#define SERIO_FRAME	_BITUL(2)
+#define SERIO_OOB_DATA	_BITUL(3)
 
 /*
  * Serio types



Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC520C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 04:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A597520719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 04:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qsz45JQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgCXENo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 00:13:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22289 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725784AbgCXENo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 00:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585023223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=mjQ9MbkN2lg9YBuiVW+Ce9he0mEnlCLjk/uJWKcwNpY=;
        b=Qsz45JQDfEc8063RiWlBt0NYfHNUtY0tChySONc1DfYUZKuw0P6LA8okLVmz5cdiiifuj6
        GPvjZOpvcAqNJOk26Aqdp8pnOIXItHujuSSz5xAXoCcaY61VqB42Q6Kn/jxPYWSUqJufoZ
        gYpFmW/d7U0pwetoEA1hpXRI0xNl8hY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-wxBI9LdeNoamUVSLYULY7A-1; Tue, 24 Mar 2020 00:13:41 -0400
X-MC-Unique: wxBI9LdeNoamUVSLYULY7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06187800D50;
        Tue, 24 Mar 2020 04:13:40 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12527BBBCE;
        Tue, 24 Mar 2020 04:13:35 +0000 (UTC)
Date:   Tue, 24 Mar 2020 05:13:41 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Markus Koch <markus@notsyncing.net>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] input: avoid BIT() macro usage in the serio.h UAPI header
Message-ID: <20200324041341.GA32335@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 19ba1eb15a2a ("Input: psmouse - add a custom serio protocol
to send extra information") introduced usage of the BIT() macro
for SERIO_* flags; this macro is not provided in UAPI headers.
Replace if with similarly defined _BITUL() macro defined
in <linux/const.h>.

Cc: <stable@vger.kernel.org> # v5.0+
Fixes: 19ba1eb15a2a ("Input: psmouse - add a custom serio protocol to send extra information")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 include/uapi/linux/serio.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/serio.h b/include/uapi/linux/serio.h
index 50e9919..ed2a96f 100644
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
-- 
2.1.4


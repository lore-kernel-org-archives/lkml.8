Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71ADC2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F76F2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646095;
	bh=P7eaBlYz4GzVkyvhowH9g6w/cqbHD7kEmXW8Sh3FLOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RtLFZ/hSa2Sp8Tgf1brWjYm1D/j+cp87aRtHxoZ9diOyZhD4O/avcMouyTaEWausA
	 Y+R+bjIHgF/kM8D+JPIDQsyd01t2pett4+C2f10sKIzgLw2QbPpZwE1D8/Axnr1DHB
	 YnEb1fanbQ+5Zqmo0n1IpiZ71AIA023L6FpH8jvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731867AbgCaJOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730619AbgCaJOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:14:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1348C2072E;
        Tue, 31 Mar 2020 09:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646089;
        bh=P7eaBlYz4GzVkyvhowH9g6w/cqbHD7kEmXW8Sh3FLOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pcs/s6tLeeUpj3VLaJgDn+klo21j8vLpTRwj672manO7US+4X6IoYOb6bWatBSECe
         yjSl+jBCOWOgtz6lQIMYtEI/eKH+E3DSjc3oNoef7Lu2IWNYj851j+nDtf+7bQmKXA
         mHz/OrSsFl/o8MTfDzKP2MbcDffkvVTGVbvew7cU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugene Syromiatnikov <esyr@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.4 080/155] Input: avoid BIT() macro usage in the serio.h UAPI header
Date:   Tue, 31 Mar 2020 10:58:40 +0200
Message-Id: <20200331085427.301306268@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
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



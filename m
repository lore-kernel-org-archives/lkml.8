Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967BCC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EF3206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kz5/1BLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389997AbgDBRC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:02:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:58937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732625AbgDBRC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585846936;
        bh=8UWypK5pgVcYcqIwFlJJIKU66AJRcAaCGYCCv5rqHSc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=kz5/1BLakRSoXGwoWbzj0G2RsRakRC3O083MpECK0lcusQNnUBrcvbBKK3RDqcJin
         K7dUMj5WTR471Ftf/q0RbDgXdzM0CFakZoCYpRUPJ+Yx++hOCSIMrQ5sXXG7ZKsoe9
         DWftEnWe1HekBoC3HXKCAMV7RonuRGQ756ByiSzE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MqJqN-1ixvlT1b4l-00nPcN; Thu, 02 Apr 2020 19:02:16 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Oscar Carter <oscar.carter@gmx.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Subject: [PATCH v2] staging: vt6656: Define EnCFG_BBType_MASK as OR between previous defines
Date:   Thu,  2 Apr 2020 19:01:03 +0200
Message-Id: <20200402170103.22520-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:92r1pGjCMbrGkXpHcqtHjCNU/M4fbFzS1R86MSFEIhWrF4H/JMF
 QemgjEJ4zbeOHAsxeXaaeTRQRiLIvKb60mA/Yd/ylGNPEBNj8muDZHsC79ZuoneZVb5DXY9
 b+HJBhz6t9R95in47coyaiolMD+vEBbQ3rnujgtm30qDo5Qtye+8KhtNNtsliMkdAt8HOjB
 wIU71B12rn5896tXfXZNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lHToelEcjb4=:B1oScJRzOkmBzLG0RFEIvy
 /I6B8VNsZHjt6h+W5K1Y7eAaYKfTbRobNsysN2MepWDF1HtRSl9bN1zXj0EFWbUzJG2i1efTy
 ZMhzJHncqJFwydMF2XoibrOE++9YuFiyx0s77jVyXW2SI1u7V3MaQUz8OZWDAT7M6pWb9ZrL4
 dlwxh9PrfDXb+mK+0QT+lx1QswBSVEG/EPqfMxAraa/+lMDrtob0N4gsrL9JeR4kTamH3OzxE
 e4I5DjUrDlxkJJjiR9Ux2E0pRb8OD1hE3GlWbFrLd3cNvUHMKY4X5PNXGjbC4BKfsSvNtmZTs
 j16IDXQixAbLHBJiWbYZrqXlZJ+Bs5by1dg+bkhm9I7CgeKigJadNnwzAkfP27mjDG0juNnh6
 IfpPAVEPOZ7lwPIQ4EA/rjM9KD5B5aIrcjXRSuy9IKpRt3gNcRD15esP8yfb8mOMLtvnVzAaM
 Ck87DhuL4+mD1khLNL5yjzUvHOf2nECIvCFaKOcutsEROXx/clkQC633MFOzlVdlD9N/DMl22
 ip1EfV9iBJ5jYr4mNxeJe/qIzmjwseMuxhZ2uxZEmTeiItQprwdyZnOHHQlqiWuvvXSO23woT
 cC3YkGD3dPBN9/jm7yAsFgGTkr110YifGBoxnlMqOJOu/EGm5g/DT/DUtaGEpKjJyoO0Dkug9
 kcCmpn11uJkd7L2Uxn6kKBi7F2bsinGED+aOLtlr4bJP2W6zKLhlwJErlxHNE0uW4kZmnD+5A
 O50qfHsaaDgVmnmtiHWaSpcGqqiFQWHDvwVwmswWDTsRTTD/QardBDoXPUk8n9wl1Ay1vYE7S
 lkOFSlS2oLGOmAN+aSHLrDRfF3xosSslMeYqR8FRZln7di9nEmubiyysVhnrBaBAlEWV8YyXd
 pTLhCWH2XdiGNjAfhgA0qxV73pjGRe5rvA75pZ+IvsRTkF1AvOqfsgOFW7Beg7gknqFDUq/sS
 j++7Hirrx3Shep/1NW8TXGYlLo5AMsTsJwK/QquFUjUIM9Xh4iYBd+1PEMq2+pSXWNh+F9QGN
 O5v861QMyTaCIBfDBjQfOFy3wg6pgUlrSz7/szWi7ZYT6JGPLhIHe9zfUHq2PmFvh8+pr9tj1
 wCFyViMe+eWIvR6gfl8otWogem457GbD2jzFdgQYWb4Aq1C4bgnaHQeULV6t84Yk1/saOigl8
 p70HSeyhUdqTaPyg9ugGu7+hfDccSlPXaHFyVBZ3KtpwSztWcaW/316EQcWGrF8nqDzkvL2cW
 hUk4t4xb906JZax70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the EnCFG_BBType_MASK bit as an OR operation between two previous
defines instead of using the OR between two new BIT macros. Thus, the
code is more clear.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
=2D--
Changelog v1 -> v2
- Remove the "Fixes:" tag line.
- Add "Reviewed-by: Quentin Deslandes"

 drivers/staging/vt6656/mac.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/mac.h b/drivers/staging/vt6656/mac.h
index c532b27de37f..b01d9ee8677e 100644
=2D-- a/drivers/staging/vt6656/mac.h
+++ b/drivers/staging/vt6656/mac.h
@@ -177,7 +177,7 @@
 #define EnCFG_BBType_a		0x00
 #define EnCFG_BBType_b		BIT(0)
 #define EnCFG_BBType_g		BIT(1)
-#define EnCFG_BBType_MASK	(BIT(0) | BIT(1))
+#define EnCFG_BBType_MASK	(EnCFG_BBType_b | EnCFG_BBType_g)
 #define EnCFG_ProtectMd		BIT(5)

 /* Bits in the EnhanceCFG_1 register */
=2D-
2.20.1


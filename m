Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29659C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9F12074A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YicCjW2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgC0Q6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:58:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:39369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbgC0Q6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585328304;
        bh=+uDA6fUULy2itpfPeZKL70mFEOIwL9s7Y+uFzpR56Ow=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=YicCjW2JixYy1fX2OZjkYlrC0ioG3zYAJMWANZFx8uzY2EG6Z5H6Ri6hsRxyBC/Da
         Fe5vgpOTy566zjVPltuNgGjRtw/jQ2qG7TeUeHTUl8s1UyRjKQJRdWvW4GzgVrk4iV
         J2WhQuxJJrEOW6/9DFixEzUbYedHAM2WJPSTZVZ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1Mlw3N-1ji6VY3MDz-00j0Zs; Fri, 27 Mar 2020 17:58:23 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: Define EnCFG_BBType_MASK as OR between previous defines
Date:   Fri, 27 Mar 2020 17:58:02 +0100
Message-Id: <20200327165802.8445-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i64WLuuBlH5zjJOlTQQLImLgRD41YGY5ZJhHE0jJuQEnzwq4yqR
 TVxVsqlhsukqr+R8qyYaVkSg1uoGovJ/gYvzNr6hpsRB4wz2D4hGkcYv+saJ2UuPKbNFSw9
 AImGOIrho19SqvurSfIN9HHr84Z2xYM6TNZR81GqW+MBaExnuE8ftKEL81iLWMJlxIfXnMA
 Y62+XZKHG+0p170vaaKaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/TOggogyzWo=:ufr9yTlqutiJ14LyJOqua3
 KSKJmuG/upPK5CUlInYL+kYYYwvvOXACQ0vKwKYzT4QJ+CdDBEuBsuu+7814rk8aSQ8/89RoU
 Yw0FgBRgCKkKJbm77FWGgSNyFxSjmzxrCpKXxpfdi98fWkqBCpDUKm2SrppSqBMZwPDHksLNC
 VwMghFNF2PdY7pgrq95pKg2tU+5lcapwuqSR6u38fZDmPtuMbMpPOVZ7p0TQeHYA3tYsQXj8e
 T6OB6b+g//ABBP45YsC3XEcUu3H3sxl+qyC0wrIflG9Rtiwo1C0ByDHQKLXzWaYcuBTOUPmEc
 xrEuU4pGZvwb/L6SdAFXYEbKU4oKwBUVRwXUGQ8HiMZJcV+dnqvjzJ2PWWay5oEqDJjgQQDas
 6RMb8xWClw0lY24Tf4joY4ZOiGHZrLfR311iguXoJTURQ6kZrGwK5viUOsLQMWM6Lm2dvXOJV
 zES36rY9u5ErYUT65mIXPRU9FZjks4uh3YIZbkdnRTVuOjOdYUrbTioccwLa03E4AamATtvN9
 qYJJaC0WfWQevhfccsmbI0fo58aII0n9xjwX/wiEdKK2JbfWEmtrYwXCYHdgYOk3jub1d04Sy
 DXykaBrOcsFD18OnAXU32Ryl3Liuos5i5PxsuhRTAFoKkr6IFexyTlWFAntN3MYa/SLGI0vHt
 7kZjIdN3LV0k59xr2hCv+g/e7sog8h9mJ1mx6kTlV/tdFw7AbP+QK5iiXpX55ZpQcZ2Zlj6xP
 7UMv1hYvqw2h9I/MDhqJG3bYCR4VX9RspYkrAXLxtLw7gjQeXLKg4B62BYQqIBWVOWzAuoYe2
 97RJBPKC5ICxWtWevQGR+hxV/hlevjIS+eErJs2fPB+cBnFOkulhGS4rVQfpp1WhNL7Q9evff
 1ZO0zIF5tlaR4/1tOEKvvJUI9VZuyI7NCvN0580SZBEcL07l9jRlelJj+8qYFiBBhIt7P6GqY
 AUHqExz61C6zV2MEw4R0Zqf9qGhrHlf8kbGYTJDsaYBgqRJQB7HWwphZzyZdIy5x52ZP1UK1i
 3ZnV2YiSmJQjHYWMF3UHqm0cDTaXNhVzvRrxVz0OSLFRF6NLL/P1Pfl5DldD/re4Z9OlEoRxP
 agkSOFXNBuhg8IUCe5sHxFa8Vxy5XokBSlNzGqX4jTWU3JKnAuWJmdZCBqQzstX9pXxg/LRMj
 plTIWihhabeoiGWXXK+HAW//0UYh9d+ugiyNInDT87nOqoO/cGcMgL6Yva5ruVqvaCcoWEctg
 24fTDHRIzYzKKT368
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the EnCFG_BBType_MASK bit as an OR operation between two previous
defines instead of using the OR between two new BIT macros. Thus, the
code is more clear.

Fixes: a74081b44291 ("staging: vt6656: Use BIT() macro instead of hex valu=
e")
Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
=2D--
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


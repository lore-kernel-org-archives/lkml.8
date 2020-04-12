Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549C1C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FE920709
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lpMW0V8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDLJdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 05:33:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:55903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgDLJdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 05:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586684015;
        bh=OuyR1SN5A5h2iXjX9bvJx44wlsxA9cn/XSDx5oHn6/c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=lpMW0V8G6XcGecBwRmCD+XKo/oYEbK1jW5SSVK1DX91e+QsxgivojoZqnsqULMTtr
         zjt8rOtO7gNCExuJt42ssvylbXCjrnuRnLC3KAk4hx73nSCy7l8EaapLeYC+ESmcz0
         4GDvF8lMMQ2yvoWh1M+hFMvPJUB55Ln7KMIfytrI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N95e9-1jAyPw2hkt-0164bK; Sun, 12 Apr 2020 11:33:35 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: Use BIT() macro instead of bit shift operator
Date:   Sun, 12 Apr 2020 11:33:11 +0200
Message-Id: <20200412093311.5279-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uYug2iKdckrToWPIQh7BOyJSXAU1uzmY+Mp54Bl5+tSZAgW4rIy
 iI0IZy4KnG5AxUd9WfMi7ihzD9V/kSTpoSmW4zhSXcJuuIxvNVspAEn2zq+p6+WXPDXftxi
 dUe4vwbWQyytQ7KACioxoEl+JOodSPbcdI8YyO1gJLwPJzdfewvs7JG7mGVJm8gSHRxQ9BI
 Pl0NXGpmK6SyOBHQX1+1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p3IeFuTvofw=:CEXVJDtGbPfVnKNjwgPfpy
 MDvPaYZxi0ccytxvlFj+b37LyK9Y8YYbqIKqn75cMSZ242cwG04ATXM4RRuBxjv2TGHGhKlTc
 RkaQXAsl5ST8UruoPDzgte9Ku+mBaHEsNdAsFn5O2IqNy0KF+fvYn7qGB2/hfHqqrKRX8uOmA
 2aRM67aNyIuOF1D8yLY1DmcyyVr039vNR8h6Sa8/XQS2kSkbIO2EHm87hIrEpsPdOUc0hgu4u
 1WxzrNv8fMwIcVMjVbJfyFzf0wMFesu5Xx4sQ0Rall/fOlVBphskh371nfHS75sNvNPDjlcVV
 +dtNBRSuP4J5WBBa4Ti6kyaTTeiTHRNa1AFcoI/FBXjA2td7XRlwINdIhfnFyNIRRsTJo/R1v
 YSAB8h0WkLb5xZ1C8TyZFhBaYVZpGQyO06DQ90LQZCj7Ivj63crhrWgdapbsp4tbNC3xY4kGa
 kLHpeMzVSYC1oLR2rirYSNOUkmhId8du9JqFc13E1fZHB7O4AFsW6VOBdKK1eQM7JatZwwGKH
 iXuqbK6FRWDVgZTMZEt2GFA8Auc2Io8qlejRCbtbF2qVe/bnwdP3VVhm19OgFvH+Fc9wtYNGy
 LxrS+l7wYVGS3LIiG62j+GJ4WxL4MN/tGjyVheyzHioQv7V7BuXxsyb/FDn+oaittF/AJq+H/
 qR52UBeXjUpA7/qPHvjTRQ6s7VIpJqZH/PvgDU6eyxRTQJy5Z5c80CTB0dv4auMbK5TLn3PuU
 zHIVMJOSs0NAT0L3WevQk9cY7mHoUFF+asBdjIL3H75hZhSG18e6IQ163WYUwutr3knKVbGSi
 Ol392UuvkrkRBB6WFaX07uF2NjuGuq6m1eKhKWeIQCpAqQmLeXkVcV2RQ4w0lRLQnhKaOLX0J
 ZRHZYCwbUGnuvdeaGRJqAQMNzuVLRTnRU8xlnf8HJwZbR7yFYgghEKvjGoQFCmUyiCOKIZuLS
 Cw8VWo1+j2lTz2qUq0NNL7Wjx4ZTN1IQkQIOS13aOs23yJYxBGQpjuodsFmhEiKQKPus1+Zbv
 x7MtKKWvAkoCmosq9Bh8UsLS3l4s0MUROozkGf43qLtFa9XJSro2uVYoxfJgpcv1psviemLuw
 cU0LbNmjZ+mv7na+iYMyLlUbzvTcRRhOWL3aU6IsHfZGkhDHqA//Q6mJW5JUAr0XqaMfm6ro5
 vVVu5wlcaIozD7u411x/I6wwtpj6pVw0urlY0NV0uGb7M4YRUIswTLOtk6dk3YbCeTed7Yt+6
 QDpNvDaZ0elQnOyFb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the BIT() macro instead of the bit left shift operator. So the code
is more clear.

It's safe to remove the casting to u16 type because the value obtained
never exceeds 16 bits. So the casting is unnecessary.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/card.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index dc3ab10eb630..14e6c71f122c 100644
=2D-- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -92,7 +92,7 @@ static u16 vnt_get_cck_rate(struct vnt_private *priv, u1=
6 rate_idx)
 	u16 ui =3D rate_idx;

 	while (ui > RATE_1M) {
-		if (priv->basic_rates & (1 << ui))
+		if (priv->basic_rates & BIT(ui))
 			return ui;
 		ui--;
 	}
@@ -129,7 +129,7 @@ static u16 vnt_get_ofdm_rate(struct vnt_private *priv,=
 u16 rate_idx)
 	}

 	while (ui > RATE_11M) {
-		if (priv->basic_rates & (1 << ui)) {
+		if (priv->basic_rates & BIT(ui)) {
 			dev_dbg(&priv->usb->dev, "%s rate: %d\n",
 				__func__, ui);
 			return ui;
@@ -420,7 +420,7 @@ void vnt_update_top_rates(struct vnt_private *priv)

 	/*Determines the highest basic rate.*/
 	for (i =3D RATE_54M; i >=3D RATE_6M; i--) {
-		if (priv->basic_rates & (u16)(1 << i)) {
+		if (priv->basic_rates & BIT(i)) {
 			top_ofdm =3D i;
 			break;
 		}
@@ -429,7 +429,7 @@ void vnt_update_top_rates(struct vnt_private *priv)
 	priv->top_ofdm_basic_rate =3D top_ofdm;

 	for (i =3D RATE_11M;; i--) {
-		if (priv->basic_rates & (u16)(1 << i)) {
+		if (priv->basic_rates & BIT(i)) {
 			top_cck =3D i;
 			break;
 		}
=2D-
2.20.1


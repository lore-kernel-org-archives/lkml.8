Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F39C433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B168720838
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859084;
	bh=cG/2WH/UY49/aXW0Api1LLFDIEPIklWAnsPDhfemt+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gnbmLnDp//+TTf3vTINVwcpoGWMZ1y+pbk1+ovxG2ixfCBDC4r2ovAKqyQvYUnfI8
	 b5Dxx9Cieajv5gaL3Lt3Mso9SZtAh5xmjoo0D5k60++Y3q1OfYFMnVGCdmF42aXuUu
	 HsUaXDUkpo5EE/Giq8g+4EdijKmCaD8tcezj5fvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgG0OLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729439AbgG0OLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:11:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FE8D2073E;
        Mon, 27 Jul 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859065;
        bh=cG/2WH/UY49/aXW0Api1LLFDIEPIklWAnsPDhfemt+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktIlJDte7+usTnrJVbtUaI4WRC6C81GPW/aGmh+cWcoBWWBkcago425WvtA0CX8Gc
         E4jaAcChoq5pVb2r/gH8ANG22fCgphvX/lp30QDL909HyEI2pspEeycMW1urhPLrro
         ERPsLRy2d97yEVQdGmWRPAybpxr8IL6s82JKgJuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Katsnelson <me@0upti.me>,
        Lyude Paul <lyude@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 53/86] Input: synaptics - enable InterTouch for ThinkPad X1E 1st gen
Date:   Mon, 27 Jul 2020 16:04:27 +0200
Message-Id: <20200727134917.076837731@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134914.312934924@linuxfoundation.org>
References: <20200727134914.312934924@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Katsnelson <me@0upti.me>

[ Upstream commit dcb00fc799dc03fd320e123e4c81b3278c763ea5 ]

Tested on my own laptop, touchpad feels slightly more responsive with
this on, though it might just be placebo.

Signed-off-by: Ilya Katsnelson <me@0upti.me>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Link: https://lore.kernel.org/r/20200703143457.132373-1-me@0upti.me
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 671e018eb363a..c6d393114502d 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -182,6 +182,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0093", /* T480 */
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
+	"LEN0099", /* X1 Extreme 1st */
 	"LEN009b", /* T580 */
 	"LEN200f", /* T450s */
 	"LEN2044", /* L470  */
-- 
2.25.1




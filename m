Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB60C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90EB21556
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577931;
	bh=rJ6qWfDyRHcxsYASqxaiCs+SO1NYI3B32WFsKYDkMbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f1l01Gcy4+hE5EJqkN3q/JPimU2O9elSPT3+FD6fktd/hgG/O85s2L3EaHtfexct1
	 Ua/lFwCgSy0owAbNLswJwoddFzJ8/mf3aJnPrLyKDStfTZZtu21lbJO+Qq5rU5dxAg
	 Rb2AmKNA1njARQyxIsxZ+PfcppRmpF8M6W4JioSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbgFSOp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388618AbgFSOpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:45:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EEA82083B;
        Fri, 19 Jun 2020 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577915;
        bh=rJ6qWfDyRHcxsYASqxaiCs+SO1NYI3B32WFsKYDkMbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sd4B9zJR/GSU9BoG7uaFJSJxOf1CP64JQtpFIq58e2M4mDtmw1cflSLwmvrNjCL+g
         KJRR2gd0wbwD9qDmAoyext9nYcuS77zzAOG8p383K68hZZcxljhEnoR29n+KGstZAj
         JVFsdszPr1lEkgPMotA+VVG8I7eA4yHZDmlRH+b8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dennis Kadioglu <denk@eclipso.email>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 012/190] Input: synaptics - add a second working PNP_ID for Lenovo T470s
Date:   Fri, 19 Jun 2020 16:30:57 +0200
Message-Id: <20200619141634.099047143@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dennis Kadioglu <denk@eclipso.email>

[ Upstream commit 642aa86eaf8f1e6fe894f20fd7f12f0db52ee03c ]

The Lenovo Thinkpad T470s I own has a different touchpad with "LEN007a"
instead of the already included PNP ID "LEN006c". However, my touchpad
seems to work well without any problems using RMI. So this patch adds the
other PNP ID.

Signed-off-by: Dennis Kadioglu <denk@eclipso.email>
Link: https://lore.kernel.org/r/ff770543cd53ae818363c0fe86477965@mail.eclipso.de
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 2bca84f4c2b2..85db184321f7 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -173,6 +173,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN005b", /* P50 */
 	"LEN005e", /* T560 */
 	"LEN006c", /* T470s */
+	"LEN007a", /* T470s */
 	"LEN0071", /* T480 */
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
 	"LEN0073", /* X1 Carbon G5 (Elantech) */
-- 
2.25.1




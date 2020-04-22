Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A14C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB14120776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550162;
	bh=U3hm7SiGMK2dMDjRBbZZI0DRkBM9O1aZDKQ7XAcyxFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RKzC7TJTQdcDt5V7fXCvXKZ11VIjiXR35YQwDwzzJlSo0HvvfamvEOPw+DaWzg0MH
	 VErHJppDXC6lAkaDOJRBX7pTiL8u2MHM2yzHw/VKWAWy/OczWvS+/WDfTFiCS0+KuP
	 Zj6OCUxZ850QlEgQOMKug8rpU1kHvbVyg9CLZkz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgDVKJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728814AbgDVKJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:09:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E64820575;
        Wed, 22 Apr 2020 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550157;
        bh=U3hm7SiGMK2dMDjRBbZZI0DRkBM9O1aZDKQ7XAcyxFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t14bJ6gnz+jE1aRa2T9TpCjpkNvZejX33svfpHBIJn3BsRWxCZob69WpyAZklwRa0
         nbHkRG6ftwlMUGZEGg/LM1jlVS5KzG56ZN+vGmQ6u6HR8qZ2QJdvsCsEtt4He/jZMo
         sVZJ0vP7oCprvxR9lPehHkIrWWPoxdatvyy1XHZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gyeongtaek Lee <gt82.lee@samsung.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 032/199] ASoC: fix regwmask
Date:   Wed, 22 Apr 2020 11:55:58 +0200
Message-Id: <20200422095101.287345404@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095057.806111593@linuxfoundation.org>
References: <20200422095057.806111593@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 이경택 <gt82.lee@samsung.com>

commit 0ab070917afdc93670c2d0ea02ab6defb6246a7c upstream.

If regwshift is 32 and the selected architecture compiles '<<' operator
for signed int literal into rotating shift, '1<<regwshift' became 1 and
it makes regwmask to 0x0.
The literal is set to unsigned long to get intended regwmask.

Signed-off-by: Gyeongtaek Lee <gt82.lee@samsung.com>
Link: https://lore.kernel.org/r/001001d60665$db7af3e0$9270dba0$@samsung.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-ops.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -837,7 +837,7 @@ int snd_soc_get_xr_sx(struct snd_kcontro
 	unsigned int regbase = mc->regbase;
 	unsigned int regcount = mc->regcount;
 	unsigned int regwshift = component->val_bytes * BITS_PER_BYTE;
-	unsigned int regwmask = (1<<regwshift)-1;
+	unsigned int regwmask = (1UL<<regwshift)-1;
 	unsigned int invert = mc->invert;
 	unsigned long mask = (1UL<<mc->nbits)-1;
 	long min = mc->min;
@@ -886,7 +886,7 @@ int snd_soc_put_xr_sx(struct snd_kcontro
 	unsigned int regbase = mc->regbase;
 	unsigned int regcount = mc->regcount;
 	unsigned int regwshift = component->val_bytes * BITS_PER_BYTE;
-	unsigned int regwmask = (1<<regwshift)-1;
+	unsigned int regwmask = (1UL<<regwshift)-1;
 	unsigned int invert = mc->invert;
 	unsigned long mask = (1UL<<mc->nbits)-1;
 	long max = mc->max;



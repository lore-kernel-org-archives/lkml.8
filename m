Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB28C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C7E2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552699;
	bh=PkqY5os02qCbo/HNGnzajYh6FNoNP4kntucX+B0/Sm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IomPI2tNZiV5fIUP+xPI2Iw2EpUfzrl6ekRtgzhVrEkiObkuJgirZZI7y/mguoSyR
	 CDlzl238glChQXGS6w26kXcSKqFMVfwsuHUDgsQoPMb//R7s7M+Yxka7peEWO0AUfa
	 OutFmJgPVaXVIPZBn8BOlR3t0EWovHO+1A5lHEYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbgDVKvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729135AbgDVKLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:11:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C558F208E4;
        Wed, 22 Apr 2020 10:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550263;
        bh=PkqY5os02qCbo/HNGnzajYh6FNoNP4kntucX+B0/Sm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDGkMlVehUC3SkkuQTh+yp+9Oj+7y2yAoTQ1FXbgkBtlvH7bxftrzECpX8dicTH+G
         3uJTDdyL1WgY01/qejdXXyxUD5ZB4XzgERTfzgstHNH0K9qXZSOFEXkoHId7250wCa
         PAedLTWvkodp6qLG+MVoXYWBDDgt5veJj51PYwuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.14 075/199] rtc: omap: Use define directive for PIN_CONFIG_ACTIVE_HIGH
Date:   Wed, 22 Apr 2020 11:56:41 +0200
Message-Id: <20200422095105.646780527@linuxfoundation.org>
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

From: Nathan Chancellor <natechancellor@gmail.com>

commit c50156526a2f7176b50134e3e5fb108ba09791b2 upstream.

Clang warns when one enumerated type is implicitly converted to another:

drivers/rtc/rtc-omap.c:574:21: warning: implicit conversion from
enumeration type 'enum rtc_pin_config_param' to different enumeration
type 'enum pin_config_param' [-Wenum-conversion]
        {"ti,active-high", PIN_CONFIG_ACTIVE_HIGH, 0},
        ~                  ^~~~~~~~~~~~~~~~~~~~~~
drivers/rtc/rtc-omap.c:579:12: warning: implicit conversion from
enumeration type 'enum rtc_pin_config_param' to different enumeration
type 'enum pin_config_param' [-Wenum-conversion]
        PCONFDUMP(PIN_CONFIG_ACTIVE_HIGH, "input active high", NULL, false),
        ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
macro 'PCONFDUMP'
        .param = a, .display = b, .format = c, .has_arg = d     \
                 ^
2 warnings generated.

It is expected that pinctrl drivers can extend pin_config_param because
of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
isn't an issue. Most drivers that take advantage of this define the
PIN_CONFIG variables as constants, rather than enumerated values. Do the
same thing here so that Clang no longer warns.

Link: https://github.com/ClangBuiltLinux/linux/issues/144
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/rtc-omap.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -559,9 +559,7 @@ static const struct pinctrl_ops rtc_pinc
 	.dt_free_map = pinconf_generic_dt_free_map,
 };
 
-enum rtc_pin_config_param {
-	PIN_CONFIG_ACTIVE_HIGH = PIN_CONFIG_END + 1,
-};
+#define PIN_CONFIG_ACTIVE_HIGH		(PIN_CONFIG_END + 1)
 
 static const struct pinconf_generic_params rtc_params[] = {
 	{"ti,active-high", PIN_CONFIG_ACTIVE_HIGH, 0},



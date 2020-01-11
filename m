Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F904C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA794205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738483;
	bh=3l1KICiLGAHbaDqp64hBkx4pmtGm3ykWiyUsFzWdfSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rce+N1zd2OOSEBKAcO+pTfgtn95E6e3li+Kf2DrhmMelXMwv/O1q+jDCwN+14W/s9
	 QkqHQmT4thkPjKPiePTDZDg0hr3k7Zttuq7NKuYXGnLPgUzQ4lvcd6JsOR98n2SO3v
	 Axb+ykhC+umdx/t1l5uVN5znuP+AOOzMnnWVC8Ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbgAKK2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:28:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729295AbgAKK17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:27:59 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 945862082E;
        Sat, 11 Jan 2020 10:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738479;
        bh=3l1KICiLGAHbaDqp64hBkx4pmtGm3ykWiyUsFzWdfSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DPTGIkZD8tbiCFOh3FRajIq+yty9lh9L8nmN48GsPGYr3lBN5CZuUn9yjsurDL+gW
         Cxu7df5R4GHP74OyoveKi5hhr1XsrN+LTuKO28WrkPF5A3wRkJmqV4Tqwc7Me1jveD
         RpQ8ap4nb0IBdKxpt8/HkeJ4at86VCNP8eIyMMoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 102/165] usb: typec: fusb302: Fix an undefined reference to extcon_get_state
Date:   Sat, 11 Jan 2020 10:50:21 +0100
Message-Id: <20200111094930.268150068@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>

[ Upstream commit 547fc228755d79af648898187e7831a825d4f42c ]

Fixes the following compile error:

drivers/usb/typec/tcpm/fusb302.o: In function `tcpm_get_current_limit':
fusb302.c:(.text+0x3ee): undefined reference to `extcon_get_state'
fusb302.c:(.text+0x422): undefined reference to `extcon_get_state'
fusb302.c:(.text+0x450): undefined reference to `extcon_get_state'
fusb302.c:(.text+0x48c): undefined reference to `extcon_get_state'
drivers/usb/typec/tcpm/fusb302.o: In function `fusb302_probe':
fusb302.c:(.text+0x980): undefined reference to `extcon_get_extcon_dev'
make: *** [vmlinux] Error 1

It is because EXTCON is build as a module, but FUSB302 is not.

Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/1576239378-50795-1-git-send-email-zhongjiang@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
index 72481bbb2af3..5b986d6c801d 100644
--- a/drivers/usb/typec/tcpm/Kconfig
+++ b/drivers/usb/typec/tcpm/Kconfig
@@ -32,6 +32,7 @@ endif # TYPEC_TCPCI
 config TYPEC_FUSB302
 	tristate "Fairchild FUSB302 Type-C chip driver"
 	depends on I2C
+	depends on EXTCON || !EXTCON
 	help
 	  The Fairchild FUSB302 Type-C chip driver that works with
 	  Type-C Port Controller Manager to provide USB PD and USB
-- 
2.20.1




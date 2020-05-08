Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDBEC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10BEE208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943568;
	bh=m4M+PkibrHPFqGtmTkw9rW6kVtotRYDU+szixlLFLw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HCRtpDz926fQUJZbb6wQogJNO/ycpjlCOJMqPYIpzhzLo8haamklD1RxVy6x/wET8
	 BN1lcNxN5/o0Xty7nl739llPIxjq/6YhzTmDLW+S8K2PVsRt9XAQYrQ7jsVZUSTlRN
	 fi4Ay+zvywA7/ujbwvPClZGO0IJC2WpzUQfJM/VU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgEHNMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgEHMsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:48:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADBD021473;
        Fri,  8 May 2020 12:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942116;
        bh=m4M+PkibrHPFqGtmTkw9rW6kVtotRYDU+szixlLFLw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jnzmENG9jtIn9mxd5L6bkjIHsRscXxEMTYi8DQLsXmtIWWS6/ehCstPgcpXAIqQfT
         hwsiRFXuJaBmIe2HpDOuuhkG3Lal8K/t4EGm9+qtT9v2R4lda1EaqgTu1wknudUmcF
         phojUTtW84o3lM2MrSQlLK9JUdWz6k96WGx+4zWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.4 302/312] pinctrl: tegra: Correctly check the supported configuration
Date:   Fri,  8 May 2020 14:34:53 +0200
Message-Id: <20200508123145.684740656@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laxman Dewangan <ldewangan@nvidia.com>

commit b22ef2a0979f2b91cfeeabb086e4d665183a93a1 upstream.

The pincontrol registers of Tegra chips has multiple filed per
registers. There is two type of registers mux and drive. All
configurations belongs to one of these registers.

If any configurations are supported then <config>_bit is set to
bit position of these registers otherwise -1 to not support it.
The member is defined as
	s32 <config>_bit:6;

So if config is not supported ifor given SoC then it is set to -1
in soc pinmmux table.
In common driver code, to find out that given config is supported
or not, it is checked as:

s8 bit = <config>_bit;
if (bit > 31) {
	/* Not supported config */
}

But in this case, bit is s8 and hence for non supporting it is -1.

Correct the check as:
if (bit < 0) {
	/* Not supported config */
}

Fixes: e4c02dced975cb ("pinctrl: tegra: use signed bitfields for optional fields")
Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/pinctrl-tegra.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/pinctrl-tegra.c
+++ b/drivers/pinctrl/pinctrl-tegra.c
@@ -418,7 +418,7 @@ static int tegra_pinconf_reg(struct tegr
 		return -ENOTSUPP;
 	}
 
-	if (*reg < 0 || *bit > 31) {
+	if (*reg < 0 || *bit < 0)  {
 		if (report_err) {
 			const char *prop = "unknown";
 			int i;



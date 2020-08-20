Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ECDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48FA2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgHTWUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:20:55 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:51005 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgHTWUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:20:53 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 26A92240002;
        Thu, 20 Aug 2020 22:20:52 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Ran Wang <ran.wang_1@nxp.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Peng Ma <peng.ma@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: fsl-ftm-alarm: update acpi device id
Date:   Fri, 21 Aug 2020 00:20:51 +0200
Message-Id: <159796203825.2241003.2548110356916718922.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818063609.39859-1-ran.wang_1@nxp.com>
References: <20200818063609.39859-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 14:36:09 +0800, Ran Wang wrote:
> Original device id would conflict with crypto driver, change it.

Applied, thanks!

[1/1] rtc: fsl-ftm-alarm: update acpi device id
      commit: 0d982de3e27e8091dfa62368cd3eefbc7c17c8a2

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>

Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B656C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2643B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbgFOUdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:33:19 -0400
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:32944 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgFOUdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:33:18 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2020 16:33:18 EDT
Received: from [192.168.1.102] (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id A62E3250E5;
        Mon, 15 Jun 2020 22:23:59 +0200 (CEST)
Date:   Mon, 15 Jun 2020 22:23:53 +0200
From:   David Heidelberg <david@ixit.cz>
Reply-To: 20181129133119.29387-1-linus.walleij@linaro.org
Subject: [PATCH] irq: Request and release resources for chained IRQs
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Message-Id: <TZHZBQ.SOVDZ4DJB30O1@ixit.cz>
X-Mailer: geary/3.36.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

is there chance to get this patch included or could be this issue 
solved with different approach?

Actually this patch solve issue on two APQ8064 devices:
 * Nexus 7 2013
Tested-by: David Heidelberg <david@ixit.cz>
 * Nexus 4
Tested-by: Iskren Chernev
Best regards
David Heidelberg



Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED00C55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 22:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52BB2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 22:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDXWLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:11:33 -0400
Received: from v6.sk ([167.172.42.174]:59624 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgDXWLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 18:11:33 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 953AC610A8;
        Fri, 24 Apr 2020 22:11:29 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mfd: Add ENE KB3930 Embedded Controller driver
Date:   Sat, 25 Apr 2020 00:11:21 +0200
Message-Id: <20200424221123.106527-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please take a look at the following patch set and consider applying it
to the MFD tree. It a new driver with DT binding documentation changes,
utilized by the LED driver submitted here:

https://lore.kernel.org/lkml/20200424220240.106055-1-lkundrak@v3.sk/

Compared to v1 the dt-bindings validation failure has been fixed.

Thanks,
Lubo



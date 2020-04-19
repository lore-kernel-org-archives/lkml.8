Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB68C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E647206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgDSRMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:12:03 -0400
Received: from v6.sk ([167.172.42.174]:43796 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgDSRMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:12:02 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 76297610AF;
        Sun, 19 Apr 2020 17:12:01 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] ARM: dts: Marvell SoC Device Tree updates (for 5.8)
Date:   Sun, 19 Apr 2020 19:11:42 +0200
Message-Id: <20200419171157.672999-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider applying the patches chained to this message to arm/dt.

I've sent about the same patch set before, but there were some issues
and it was way too close to 5.7-rc1. Sorry for that. I decided not to
hurry it, because none of the fixes is really all that important.

Majority of the patches just deal with reducing DT validation noise once
more schemas are converted to JSON-schema. Those that actually fix
things relevant to older released kernels have been Cc'd to stable@.

Thank you
Lubo



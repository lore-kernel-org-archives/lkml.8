Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B97C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 10:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA76A2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 10:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbgEWKlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 06:41:44 -0400
Received: from v6.sk ([167.172.42.174]:40000 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgEWKln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 06:41:43 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id C9B86610B3;
        Sat, 23 May 2020 10:41:41 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] drm/etnaviv: Tidy up clocks handling
Date:   Sat, 23 May 2020 12:41:33 +0200
Message-Id: <20200523104137.12562-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider applying patches that are chained to this message.

They make getting/enabling the clocks in the etnaviv driver slightly nicer,
first two also fix potential problems.

Compared to v1, patch 2/4 was fixed and patch 3/4 was added.

As it was pointed out in response to v1, the clocks documented as
mandatory by the binding document are different from what the driver
enforces. Moreover, there is no agreement on which clocks must be
present in the device tree, so I'm leaving the binding document until
it's cleared up.

In any case, the "core" clock is always present so it's safe to make it
mandatory and regardless of what ends up happening to the binding
documentation, the other clocks can't be enforced without regressions.
At most a comment or a warning could be added. I'm leaving it as it is.

Thank you
Lubo




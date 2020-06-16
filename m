Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FD4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50752080D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFPVVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:21:33 -0400
Received: from v6.sk ([167.172.42.174]:48282 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFPVVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:21:33 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 8B6DE61634;
        Tue, 16 Jun 2020 21:21:31 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@arlinux.org.uk>,
        Christian Geiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 0/4] drm/etnaviv: Tidy up clocks handling
Date:   Tue, 16 Jun 2020 23:21:23 +0200
Message-Id: <20200616212127.986410-1-lkundrak@v3.sk>
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



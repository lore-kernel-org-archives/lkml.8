Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021D8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D3820672
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="DVwguvFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgG3IFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:05:14 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:25806 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgG3IFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1596096299;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=jAU4zx3KLqkuh8Fcd/ydkgYI0tR+fPGhEugBXGuulu4=;
        b=DVwguvFXKxrpiSz7KL6YBVR2I+f/QxnS1/YVmqu3k8JjBFvqaMJNqD8P4N4bThUPIv
        xyedaiONx4ay6CAPSbqSbvVnqhOGGKBqey8Ny6kIiOu4DT7avM2SGQllktvTCLwEBcUq
        qPtkXIlvQU4gLkKzlesEUe6E6zyw6xPPGvGu+SZB051kPsNY4caxq/nCSbAzBInMgYHm
        xmHRA+xEoQdPMmqjYXJ3oxmBA/nnMytUuBcpSMt+f77gQgo/IHhUd/hvoj9R8WdvJcXL
        RIgac8A9D7zC54wEPJIeydKvtnRouLGZRgSfQAkrx15yoh/OZBkQTJVzhkxpBqlXNqH6
        CZ5w==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4G6NeHYC"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id Y0939ew6U81wgul
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 30 Jul 2020 10:01:58 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: [RFC PATCH 0/3] opp: required_opps: Power on genpd, scale down in reverse order
Date:   Thu, 30 Jul 2020 10:01:43 +0200
Message-Id: <20200730080146.25185-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get CPR (Core Power Reduction, AVS) working for MSM8916 on mainline.
Shortly said there are two power domains that must be scaled with the CPU OPP table:

  - (VDD)MX
  - CPR

My idea for this was to add both as "required-opps" to the CPR OPP table
and let the OPP core take care of all the scaling.

There are two remaining problems that need to be addressed for that to work:

  1. The power domains should be scaled down in reverse order
     (MX, CPR when scaling up, CPR, MX when scaling down).
  2. Something has to enable the virtual genpd devices to make the rpmpd driver
     actually respect the performance states we vote for.

Both issues were briefly discussed before (see links in the patches),
but I think we did not agree on an exact solution yet. After some consideration,
I thought it would be best to address these directly in the OPP core.

However, note that this patch is RFC because it is just supposed to initiate
discussion if alternative solutions would be better. :)

Stephan Gerhold (3):
  opp: Reduce code duplication in _set_required_opps()
  opp: Set required OPPs in reverse order when scaling down
  opp: Power on (virtual) power domains managed by the OPP core

 drivers/opp/core.c | 115 ++++++++++++++++++++++++++++++++++++---------
 drivers/opp/opp.h  |   1 +
 2 files changed, 93 insertions(+), 23 deletions(-)

--
2.27.0

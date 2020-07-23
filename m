Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C83BC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB9E20888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgGWHl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:41:29 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:57428 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725846AbgGWHlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:41:25 -0400
Received: from [78.134.114.177] (port=33386 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jyVr0-0007WW-RA; Thu, 23 Jul 2020 09:41:22 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-clk@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH v4 0/3] dt-bindings: clk: versaclock5: change maintainer, convert to yaml, typo
Date:   Thu, 23 Jul 2020 09:41:09 +0200
Message-Id: <20200723074112.3159-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a loosely-assorted series for versaclock5.

Since v3 [0] I removed a patch to the driver code (sent separately [1]) and
added a cover letter as requested by Stephen.

Patch 1 is a trivial typo fix in DT bindings (already approved by Rob).

Patch 3 converts the DT bindings to yaml.

And since in patch 3 I'm adding a new file which needs a maintainer I asked
the current driver maintanier, Marek. He suggested I should take over
maintainership as he does not plan to work on that driver for the
foreseeable future, while I'm going to. And so here's patch 2 to change
maintainer.

[0] https://lkml.org/lkml/2020/7/21/939
[1] https://lkml.org/lkml/2020/7/23/128

Luca Ceresoli (3):
  dt-bindings: clk: versaclock5: fix 'idt' prefix typos
  MAINTAINERS: take over IDT VersaClock 5 clock driver
  dt-bindings: clk: versaclock5: convert to yaml

 .../bindings/clock/idt,versaclock5.txt        | 125 --------------
 .../bindings/clock/idt,versaclock5.yaml       | 154 ++++++++++++++++++
 MAINTAINERS                                   |   3 +-
 3 files changed, 156 insertions(+), 126 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/idt,versaclock5.txt
 create mode 100644 Documentation/devicetree/bindings/clock/idt,versaclock5.yaml

-- 
2.27.0


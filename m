Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0933AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA2620825
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgHSNFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:05:01 -0400
Received: from mail.v3.sk ([167.172.186.51]:54584 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728605AbgHSNE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:04:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3D74DDFA44;
        Wed, 19 Aug 2020 13:04:00 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cWLOxwqKPIt6; Wed, 19 Aug 2020 13:03:59 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A93C3DFA74;
        Wed, 19 Aug 2020 13:03:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wl2dX1KjOX-V; Wed, 19 Aug 2020 13:03:59 +0000 (UTC)
Received: from localhost (unknown [77.240.177.143])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 7F439DFA44;
        Wed, 19 Aug 2020 13:03:59 +0000 (UTC)
Date:   Wed, 19 Aug 2020 15:04:52 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] dt-bindings: display: himax,hx8837: Add Himax HX8837
 bindings
Message-ID: <20200819130452.GB152043@furthur.local>
References: <20200819102246.634039-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819102246.634039-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Re-sending the cover letter here, because I left the subject empty and
the archive didn't pick it up. Sorry.)

Hi,

please take a look at the patches chained to this messages and consider
applying them. They add support for the controller that drives the panel
on the OLPC XO laptops.

Compared to the previous version the bindings have been converted to
YAML and the driver itself has been rewritten without any fancy features
such as the self-refresh so that the bare minimum works before the rest
can be figured out. Detailed change logs are in individual patches.

Tested on an OLPC XO-1.75 laptop.

Thank you
Lubo

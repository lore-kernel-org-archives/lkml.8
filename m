Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43368C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 07:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF0A206DA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 07:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgHPHN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 03:13:56 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:35628 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgHPHNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 03:13:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 88F7FFB05;
        Sun, 16 Aug 2020 09:13:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id obmw7upeefIK; Sun, 16 Aug 2020 09:13:44 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id C38CE457CC; Sun, 16 Aug 2020 09:13:43 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Modernize rocktech,jh057n00900 bindings a bit
Date:   Sun, 16 Aug 2020 09:13:41 +0200
Message-Id: <cover.1597561897.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was prompted by Sam's review in
https://lore.kernel.org/dri-devel/20200815210802.GA1242831@ravnborg.org/
and yamllint. I also added myself as maintainer, hope that's o.k.

Guido Günther (2):
  dt-bindings: panel: rocktech,jh057n00900: Modernize
  dt-bindings: panel: rocktech,jh057n00900: Add myself as maintainer

 .../display/panel/rocktech,jh057n00900.yaml   | 40 +++++++++----------
 1 file changed, 19 insertions(+), 21 deletions(-)

-- 
2.26.2


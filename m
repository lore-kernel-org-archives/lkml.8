Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A949C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6084F2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411021AbgDOR1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:27:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59004 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410993AbgDOR1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:27:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C88332A0733
Received: by jupiter.universe (Postfix, from userid 1000)
        id 1762F4800F7; Wed, 15 Apr 2020 19:27:34 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 0/3] Add multiple AUO panels
Date:   Wed, 15 Apr 2020 19:27:22 +0200
Message-Id: <20200415172725.84257-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patches are more or less independent of each other. There
was a previous version for the 12" and 15" panels, which
was missing the DT binding update. The 19" patch is new,
for the previous 10" panel a different patch has been merged
in the meantime.

-- Sebastian

Sebastian Reichel (3):
  drm/panel: simple: Add support for AUO G190EAN01 panel
  drm/panel: simple: Add support for AUO G156XTN01.0 panel
  drm/panel: simple: Add support for AUO G121EAN01.4 panel

 .../bindings/display/panel/panel-simple.yaml  |  6 ++
 drivers/gpu/drm/panel/panel-simple.c          | 89 +++++++++++++++++++
 2 files changed, 95 insertions(+)

-- 
2.25.1


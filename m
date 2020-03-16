Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AFFC3F2CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D1420736
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="daxUK7He"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbgCPOrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:47:00 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:34160 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731478AbgCPOq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:46:59 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B230040084;
        Mon, 16 Mar 2020 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1584370019; bh=aFBQtm+prDFNgjmfrUsKNbthIoV6yCpKEB9C+4dQqqY=;
        h=From:To:Cc:Subject:Date:From;
        b=daxUK7Heo5k6tjGfCoJ+k43Xpgo2Eplyu9f4ZA84cZ9kRdHymcRa3NioYZvlEUDCu
         0k/rqbRbG9sEbxNq6KOSU6V91ga15p3+uelmvqhcaRseHB7CeGwyOt1ugOjk/iA+/S
         TD0arN+Rc3+fGtHaqHeHgKZ2uxzdHh1MYE6mfUVqzA4upa8BjOXpSi4vlkjW2iLe+6
         EZUyplh/3L9hl1omB0m+Ms4IN2qTspOqzTdxCQz9aYtXQXbMlhNbD1wY4bh/VJ/dM1
         XABVnoEcnbzNGYFHU7Yrmqw1mKeWoVNmWiFi4MLku8TSR6/FOmho/kpPgrO9hgjWM9
         UVbMxqE75/NNQ==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id C565DA005B;
        Mon, 16 Mar 2020 14:46:52 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     dri-devel@lists.freedesktop.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 0/2] DRM: ARC: add HDMI 2.0 TX encoder support
Date:   Mon, 16 Mar 2020 17:46:45 +0300
Message-Id: <20200316144647.10416-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eugeniy Paltsev (2):
  DRM: ARC: add HDMI 2.0 TX encoder support
  dt-bindings: Document the Synopsys ARC HDMI TX bindings

 .../display/bridge/snps,arc-dw-hdmi.txt       |  73 ++++++++++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/Makefile                      |   2 +-
 drivers/gpu/drm/arc/Kconfig                   |   7 +
 drivers/gpu/drm/arc/Makefile                  |   1 +
 drivers/gpu/drm/arc/arc-dw-hdmi.c             | 126 ++++++++++++++++++
 6 files changed, 214 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/snps,arc-dw-hdmi.txt
 create mode 100644 drivers/gpu/drm/arc/arc-dw-hdmi.c

-- 
2.21.1


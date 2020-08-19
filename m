Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81186C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65994207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHSKMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:12:35 -0400
Received: from mail.v3.sk ([167.172.186.51]:51730 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727808AbgHSKMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:12:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3FFD6DFA71;
        Wed, 19 Aug 2020 10:11:24 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3Ym15nfYp3ad; Wed, 19 Aug 2020 10:11:23 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E05D0DFA44;
        Wed, 19 Aug 2020 10:11:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AD0s2r5Zerf0; Wed, 19 Aug 2020 10:11:22 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 81696DEE69;
        Wed, 19 Aug 2020 10:11:22 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/panel: Add support for Innolux LS075AT011
Date:   Wed, 19 Aug 2020 12:12:04 +0200
Message-Id: <20200819101206.633253-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please take a look at the patches chanied to this message and consider
applying them. They add description of the display panel found on OLPC
laptops to the simple panel driver.

There is no datasheet for the hardware and thus the timings were
determined on a best effort basis. The clock range is gotten from the
data sheet of the display controller [1] and the other timings are what
OLPC laptops actually use. The panel seems to cope with different sync
timings, but I'm not sure wherher there's any value in attempting to
figure out what range is actually permissible.

I could not figure out the right definitions for the connector and the
bus format. I'm not sure how necessary they are, but at least the
drm-panel driver insists on connector type being defined so I picked
LVDS because that seems to be used for internal laptop screens.

The signalling is not actually differential. It uses TTL levels with
data sampled on rising and falling clock edges; sort of like this (taken
from [1], P.20):

          __
    FSTH /  \_______________________________________
          ____      ____      ____      ____      __
    FCLK /    \____/    \____/    \____/    \____/
                  ____ ____ ____ ____ ____ ____ ____
    FD00 ........X____X____X____X____X____X____X____
                  ____ ____ ____ ____ ____ ____ ____
    FD01 ........X____X____X____X____X____X____X____
                  ____ ____ ____ ____ ____ ____ ____
    FD10 ........X____X____X____X____X____X____X____
                  ____ ____ ____ ____ ____ ____ ____
    FD11 ........X____X____X____X____X____X____X____
                  ____ ____ ____ ____ ____ ____ ____
    FD20 ........X____X____X____X____X____X____X____
                  ____ ____ ____ ____ ____ ____ ____
    FD21 ........X____X____X____X____X____X____X____
                   |    |    |    |
                   data 1    data 2   ...
                   (2x6bit)  (2x6bit)

I believe the data just carries brightness because each pixel on the
panel has a fixed color; with the red, green and blue pixels organized
in a pattern [2]. (The HX8837 that drives the color does the conversion
from RGB).

Tested on an OLPC XO-1.75 laptop. XO-1 and XO-1.5 use the same hardware,
but their display controllers are not supported by DRM at the moment.

[1] http://wiki.laptop.org/images/0/09/DCON_datasheet_HX8837-A.pdf
[2] http://wiki.laptop.org/go/Display

Thank you!
Lubo



Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5050C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3102072B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Qda1g2/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgANSZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:25:55 -0500
Received: from smtp110.ord1c.emailsrvr.com ([108.166.43.110]:35543 "EHLO
        smtp110.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbgANSZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1579026354;
        bh=mJXDOVmyQnLPIEOfgT1BgAAbTanRahyW+uQTzgnQ2XI=;
        h=From:To:Subject:Date:From;
        b=Qda1g2/vhO9vTeB+YWSA0qryHOw0BoQeKf0bJxh6dFEUZO7ImO5B74by9wTMJAaUz
         Dyd/Sz8rP/H/uKg01Wse2hJj008xw7hmnYIH4/1u+s6ZmNF96Seoam3Yp89ck3qmf2
         w4B/LlD8QaAZG+xkxg/A8o//t61ZUtGzqvyTp/wI=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp6.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 8A700A0239;
        Tue, 14 Jan 2020 13:25:53 -0500 (EST)
X-Sender-Id: abbotti@mev.co.uk
Received: from ian-deb.inside.mev.co.uk (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 14 Jan 2020 13:25:54 -0500
From:   Ian Abbott <abbotti@mev.co.uk>
To:     devel@driverdev.osuosl.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org, Spencer Olson <olsonse@umich.edu>
Subject: [PATCH 0/2] staging: comedi: ni_routes: fix some regressions
Date:   Tue, 14 Jan 2020 18:25:30 +0000
Message-Id: <20200114182532.132058-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some regressions resulting from the routing functionality
implemented for the National Instruments comedi drivers in kernel 4.20
when board-specific routing information is absent.

Patch 1 fixes a null pointer dereference, but the set-up of asynchronous
commands that use external triggers on boards with missing
board-specific routing information will now fail gracefully with an
error.

Patch 2 allows routing values for the device family to be filled in even
if the board-specific routing information is missing, which should allow
asynchronous commands that use external triggers to be used on these
boards.

1) staging: comedi: ni_routes: fix null dereference in ni_find_route_source()
2) staging: comedi: ni_routes: allow partial routing information

 drivers/staging/comedi/drivers/ni_routes.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Cc: Spencer Olson <olsonse@umich.edu>


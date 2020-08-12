Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AF9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9556207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="fmcFXjbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgHLBbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 21:31:45 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:34618 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgHLBbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 21:31:40 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BRBxk5FrGzL3;
        Wed, 12 Aug 2020 03:31:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597195898; bh=XEoKRBZECEkyN1oihPs+gezDGNLo5+SRcrR4YW7HYzQ=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=fmcFXjbr9wFg/JR0K4IhDH2h5KldlVA2zJEsU+phi1kXNIaZW7L80SvSVfhAclV0D
         6Mlmfpk9j2yMUv3usEuniXHQlJ3ZGQ0B5tzlRYzWH0Zpz1CjArKTHlFPLnnQsmm00t
         I1N7t0LR36GSckVlm+zgW+X6Wmi61x16eFXcc5RnE5IdgFSbR7ITgWoYaBB9ChCe/L
         N8N/jaVPMkhiiwyQ2dgKrZf+q5I8iUVS2fWwBa+CsVxBmyzJEuG3wH94jdeuN+DqP3
         SWc+Agc9jLUgYkmXx0Eyf1/w1UDvA8mTbIGlHkm6h+0UCxLGA2fiNmO6F3CIq7upLr
         C6eMx/14g+z2g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Wed, 12 Aug 2020 03:31:38 +0200
Message-Id: <25eb81cefb37a646f3e44eaaf1d8ae8881cfde52.1597195321.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597195321.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597195321.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 7/7] regulator: remove superfluous lock in
 regulator_resolve_coupling()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code modifies rdev, but locks c_rdev instead. Remove the lock
as this is held together by regulator_list_mutex taken in the caller.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Fixes: f9503385b187 ("regulator: core: Mutually resolve regulators coupling")
---
v2: reword commitmsg
---
 drivers/regulator/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index bfd4114d6654..9ca89fee0d7e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4942,13 +4942,9 @@ static void regulator_resolve_coupling(struct regulator_dev *rdev)
 			return;
 		}
 
-		regulator_lock(c_rdev);
-
 		c_desc->coupled_rdevs[i] = c_rdev;
 		c_desc->n_resolved++;
 
-		regulator_unlock(c_rdev);
-
 		regulator_resolve_coupling(c_rdev);
 	}
 }
-- 
2.20.1


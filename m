Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFB1C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5789222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846318;
	bh=E3EhBWcEq5pdHu/iHbfF2I3g5wRmXGkx1phYs45uAU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W20AjPwOkuqntbdU0BFgbouN366kJxJlROe3UH7FaRng4jmU9DUpNb17XnxEUYBUH
	 Vwh+x8gOzp56y0r+MH42tG2qG/xK1eNvQ0EGm0p5NCNROsDL5RTYLRZD5ERCeZfbSP
	 hvEyucZmqmTJbVAx/Hy14gYD5ASnwsyOdqrQsuNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbgCJNSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730650AbgCJNKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:10:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A4CE208E4;
        Tue, 10 Mar 2020 13:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845833;
        bh=E3EhBWcEq5pdHu/iHbfF2I3g5wRmXGkx1phYs45uAU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J40CDwX8gRCnZd6EZvSBFuSEDMgXkfHnO6ghnNOYEEpygZLqufH6O1BzOoUoa4FjN
         TFWXP2pBAMhumzJppPpM1CDZjQnRkyYE8qL5AaNtN39u50DsjVSvRupV2VeGq0lJS6
         zZbB23wkXRYSNVaXi7e69v2LcF1eqU9dF5tgaLY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 116/126] ASoC: dapm: Correct DAPM handling of active widgets during shutdown
Date:   Tue, 10 Mar 2020 13:42:17 +0100
Message-Id: <20200310124210.912557251@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
References: <20200310124203.704193207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

commit 9b3193089e77d3b59b045146ff1c770dd899acb1 upstream.

commit c2caa4da46a4 ("ASoC: Fix widget powerdown on shutdown") added a
set of the power state during snd_soc_dapm_shutdown to ensure the
widgets powered off. However, when commit 39eb5fd13dff
("ASoC: dapm: Delay w->power update until the changes are written")
added the new_power member of the widget structure, to differentiate
between the current power state and the target power state, it did not
update the shutdown to use the new_power member.

As new_power has not updated it will be left in the state set by the
last DAPM sequence, ie. 1 for active widgets. So as the DAPM sequence
for the shutdown proceeds it will turn the widgets on (despite them
already being on) rather than turning them off.

Fixes: 39eb5fd13dff ("ASoC: dapm: Delay w->power update until the changes are written")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20200228153145.21013-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-dapm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4481,7 +4481,7 @@ static void soc_dapm_shutdown_dapm(struc
 			continue;
 		if (w->power) {
 			dapm_seq_insert(w, &down_list, false);
-			w->power = 0;
+			w->new_power = 0;
 			powerdown = 1;
 		}
 	}



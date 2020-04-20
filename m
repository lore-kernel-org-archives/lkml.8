Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51D7C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0CFE206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386985;
	bh=x6obM/CduAWie+8FcaDLnDXEVtgF+cqfK2NxnMy5rb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fjToKyx6/sv5TQ8FibXwttsBA1Cu7dSRJ+H+ih02I+ZRxKV/V3p6CzSMNGRdPLe5g
	 sLs7t/PokDPQM46F432h1dTnCtJyEom0wLrBjbiuoirSDBYBYOalE1QJ2YLUZB/rmt
	 lKO3h5hplqqiUkXy4isog9qGcMTJJPZyb/SuCA9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgDTMto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729448AbgDTMtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:49:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3141A20735;
        Mon, 20 Apr 2020 12:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386974;
        bh=x6obM/CduAWie+8FcaDLnDXEVtgF+cqfK2NxnMy5rb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qCCSGC9VT23Bt/HMwC5Evb1TR9tixlkTripN8bS9aHdpIE2MGvPPy0Uy8UHHH9t25
         8F6vkkm9Qnmzhzs4eB8rMvjSEZuZyCch+39sWYv5q0F3wnrdjMrqTgCbbRkFaHkeTS
         tUwt1jNtbhUshG6tUPJZ/sHQ5+Qt07vtVisahunE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 15/40] ASoC: Intel: mrfld: fix incorrect check on p->sink
Date:   Mon, 20 Apr 2020 14:39:25 +0200
Message-Id: <20200420121458.076035564@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121444.178150063@linuxfoundation.org>
References: <20200420121444.178150063@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit f5e056e1e46fcbb5f74ce560792aeb7d57ce79e6 upstream.

The check on p->sink looks bogus, I believe it should be p->source
since the following code blocks are related to p->source. Fix
this by replacing p->sink with p->source.

Fixes: 24c8d14192cc ("ASoC: Intel: mrfld: add DSP core controls")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Addresses-Coverity: ("Copy-paste error")
Link: https://lore.kernel.org/r/20191119113640.166940-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/atom/sst-atom-controls.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -1341,7 +1341,7 @@ int sst_send_pipe_gains(struct snd_soc_d
 				dai->capture_widget->name);
 		w = dai->capture_widget;
 		snd_soc_dapm_widget_for_each_source_path(w, p) {
-			if (p->connected && !p->connected(w, p->sink))
+			if (p->connected && !p->connected(w, p->source))
 				continue;
 
 			if (p->connect &&  p->source->power &&



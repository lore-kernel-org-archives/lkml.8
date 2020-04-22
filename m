Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F42C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C9F20780
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550382;
	bh=x6obM/CduAWie+8FcaDLnDXEVtgF+cqfK2NxnMy5rb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TId29cgRfkhdakzLeTiXjO0FnjdGYqdhUGhnm3Fv/BMLCDU6BxHBypBJ+VcNcjP1m
	 xVFkJZbwZf2Ki/reEUrueAHo+J7oG2/qqHAkcTeeN8knQFsOy4DC2t9Dqwk02a9c79
	 A7oXsIwhnf4mzNTHe6DXFQVQ+4lFZ1lwcPD8N4BU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgDVKNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbgDVKMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:12:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEEC820575;
        Wed, 22 Apr 2020 10:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550366;
        bh=x6obM/CduAWie+8FcaDLnDXEVtgF+cqfK2NxnMy5rb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LDOWea8ufn2mCVZVTaDoDbnW0F1eLcK4bI++at44Ts/UTFhmtOL6XAQSDu3AzVfJ3
         KCVCEj5dcxAB3b9M3BwQS9JXoPBuTBqdmrF4J/+SjYphqiy4Vk9KdsPecf39noevQo
         9zic1nql83OJrEoORWqcPTEJ2R1cNO+g6WRJ+x3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 118/199] ASoC: Intel: mrfld: fix incorrect check on p->sink
Date:   Wed, 22 Apr 2020 11:57:24 +0200
Message-Id: <20200422095109.435480289@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095057.806111593@linuxfoundation.org>
References: <20200422095057.806111593@linuxfoundation.org>
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



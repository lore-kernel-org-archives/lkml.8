Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205AEC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC07A2468D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844480;
	bh=XT/MO7aK5SsWIBRiMbJ29n7rSEC/rEmTvtY415pZyWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IeWLBkxB7JFE8vCvSoZXk53dSQPopk/xm6suRuQkmKmYWFd+LjRIjXOdWVLC0KVv4
	 mjQJvDye9EOuxeJrj1hqFg5y/kJRQkSJYDWUBhdkMlYonPUbtfqtVQD/9evEBFx+4t
	 mJCer4W8TYRk54GGvPrd33uiLC31O/RbEp0jYhXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgCJMr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgCJMry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:47:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68AAC2468D;
        Tue, 10 Mar 2020 12:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844473;
        bh=XT/MO7aK5SsWIBRiMbJ29n7rSEC/rEmTvtY415pZyWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KSBvStdHp++J+4rQN/ba8goRiYbrgRLCHDkArO4s2VLLEsaEFRBZqfSjMBA5bUqeN
         AHEB9IykHtGFSyv3X5DPmQmUQx7a0nUNaald67fHg8cd7sYCt/rJV1J/vMgWBsRn4q
         XmpvvQhHNVUXzGxiRUJCO3AazuE2/GytYloyNBy0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 80/88] ASoC: dapm: Correct DAPM handling of active widgets during shutdown
Date:   Tue, 10 Mar 2020 13:39:28 +0100
Message-Id: <20200310123624.461651289@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123606.543939933@linuxfoundation.org>
References: <20200310123606.543939933@linuxfoundation.org>
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
@@ -4363,7 +4363,7 @@ static void soc_dapm_shutdown_dapm(struc
 			continue;
 		if (w->power) {
 			dapm_seq_insert(w, &down_list, false);
-			w->power = 0;
+			w->new_power = 0;
 			powerdown = 1;
 		}
 	}



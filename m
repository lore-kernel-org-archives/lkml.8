Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4755C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A812F2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrsGgTn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbgCPROE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:14:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45777 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730970AbgCPROE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:14:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id 2so10279923pfg.12;
        Mon, 16 Mar 2020 10:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=n0HrVYrrWofJA/xq8wNbLm9ySnJWhIjb7xOSoQKdy+Q=;
        b=RrsGgTn2QcTZsg26SnbkKoJOWGOG79wg9uMcGp1sXh85tq6hr08Tocygkq6Y4liZTY
         1wRG6mHSNdRuYiA3fbXGbztEGlNTLlH5LPtqi7iUFYHO2l9Jaj/PkpAqpnt/N5Lkq+1j
         QkGyoczSkOUpWF6xmEQwyrmBIejNNVjov7ACZTv2f+O97V4RQ4sa9oDoovYgJyCRx+ky
         ktIYZXqyNUdOZc9td2BOqJwXFu+1OcFz+jl3Bt66Y57VfcaYmCfDjtnQ24b/UK6b+nxU
         POr9Ag2juUyP/H/uY/DG9/zkVHAIeCiunP6PUdqbKCiH3nZ+LC2x4Ql35/1Cw8QayekI
         jMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n0HrVYrrWofJA/xq8wNbLm9ySnJWhIjb7xOSoQKdy+Q=;
        b=hvpAOTH5Mwm8Vn5JlzzSSLL1ehaqpCJfUfrXLkPMg3x9DfpEbK51zoQnLmnngU0nLg
         GXaApVTM07HtKtsDddRTGaS24sQupjVTPPVBly/nTGaorpauyI0fsZkKBkbsGoNxRS6v
         NhhfmXxUdBpCeoQyF35qNBag4vrRBP1SqxAHj7yuJSgvHxsrcBGdvDIC6aQjnf4D/Wfq
         ACBdaKMqg6b/FXUFXdB6/s4SBSPGf0ZaHCBd5aAhT4kpHCRGts7I5TdLjwZfthcYxLI7
         3bxzt2KCfZGIILnOVCIdys9Uqu9hK/Z6Ey+tAl9Z/s+Z0SitDyyFO1i3kGhl4DDKfnWJ
         qdbQ==
X-Gm-Message-State: ANhLgQ3/jfZsQ/fPTj9sa8m9e6rZ8eYCI791MDpmt2JUi9xm8G9/0dd9
        f9ta3orKklaxFPJQ7mTTsg==
X-Google-Smtp-Source: ADFU+vvuwMxgfeu6x4E/uUeWNAtCALUq8pN6adkXtbMbrUtDMz0eos8fEG/ilJT/8FzDJeYLd2rvOQ==
X-Received: by 2002:a65:67ca:: with SMTP id b10mr816409pgs.69.1584378843158;
        Mon, 16 Mar 2020 10:14:03 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:13be:8e5f:dc51:a251:57da:d357])
        by smtp.gmail.com with ESMTPSA id k14sm19591869pje.3.2020.03.16.10.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 10:14:02 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        frextrite@gmail.com, paulmck@kernel.org, joel@joelfernandes.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] net: kcm: kcmproc.c: Fix RCU list suspicious usage warning
Date:   Mon, 16 Mar 2020 22:43:52 +0530
Message-Id: <20200316171352.3298-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This path fixes the suspicious RCU usage warning reported by
kernel test robot.

net/kcm/kcmproc.c:#RCU-list_traversed_in_non-reader_section

There is no need to use list_for_each_entry_rcu() in
kcm_stats_seq_show() as the list is always traversed under
knet->mutex held.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 net/kcm/kcmproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/kcm/kcmproc.c b/net/kcm/kcmproc.c
index 370da2f80e3c..25c1007f1098 100644
--- a/net/kcm/kcmproc.c
+++ b/net/kcm/kcmproc.c
@@ -261,7 +261,7 @@ static int kcm_stats_seq_show(struct seq_file *seq, void *v)
 	aggregate_strp_stats(&knet->aggregate_strp_stats,
 			     &strp_stats);
 
-	list_for_each_entry_rcu(mux, &knet->mux_list, kcm_mux_list) {
+	list_for_each_entry(mux, &knet->mux_list, kcm_mux_list) {
 		spin_lock_bh(&mux->lock);
 		aggregate_mux_stats(&mux->stats, &mux_stats);
 		aggregate_psock_stats(&mux->aggregate_psock_stats,
-- 
2.17.1


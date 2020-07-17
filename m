Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD113C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A241620734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgGQKjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:39:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56032 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQKjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:39:19 -0400
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:c567:382e:1974:9868])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B51C92A536F;
        Fri, 17 Jul 2020 11:39:17 +0100 (BST)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     alsa-devel@alsa-project.org
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v3 0/1] ASoC: fsl_asrc: always select different clocks
Date:   Fri, 17 Jul 2020 12:38:56 +0200
Message-Id: <20200717103857.31877-1-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716232000.GA27246@Asurada-Nvidia>
References: <20200716232000.GA27246@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the automatic clock selection so it always selects
distinct input and output clocks.

v2 -> v3:
- Update code comment, fix formatting and add more detailed explanations
  in commit message

v1 -> v2:
- compare clock indexes (and not the location in the clock table) to
  make sure input and output clocks are different

 Arnaud Ferraris(1):
   ASoC: fsl_asrc: make sure the input and output clocks are different

 sound/soc/fsl/fsl_asrc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)



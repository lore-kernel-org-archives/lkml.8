Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC61C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A250C207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgGPOwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGPOwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:52:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A277CC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:52:36 -0700 (PDT)
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:95f7:ce7f:fb76:c54a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8F2E82A50D4;
        Thu, 16 Jul 2020 15:52:34 +0100 (BST)
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
Subject: [PATCH 0/2] ASoC: fsl_asrc: improve clock selection and quality
Date:   Thu, 16 Jul 2020 16:51:59 +0200
Message-Id: <20200716145201.186270-1-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the automatic clock selection and enables internal
ratio in order to improve audio quality.

The clock selection patches have been set aside for now, as the
discussion is still ongoing regarding that matter.

 Arnaud Ferraris(2):
   ASoC: fsl_asrc: make sure the input and output clocks are different
   ASoC: fsl_asrc: always use internal ratio

 sound/soc/fsl/fsl_asrc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)



Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DE9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC7C208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519996;
	bh=bFUuWf7lEhjrgELh7Ay8Q+iXglie08ZUdzhs4xcPd48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DkE150h3vlRZPflVNczWYyeTcVfyLFjHLY/+lZyBqp7Gu3E/V2L9odTExqNCzb74c
	 VW83sWbfdz4+q3QAWF4TUloww8WMO4kPdXmoWuJhovwV8Ld4hkWxwvagQL2Hkb+LTA
	 oF010wiko4fPLT4WWKGQs8cNvE1K/vuZZvblgoT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391189AbgEZTGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391559AbgEZTG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:06:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1126F20873;
        Tue, 26 May 2020 19:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519986;
        bh=bFUuWf7lEhjrgELh7Ay8Q+iXglie08ZUdzhs4xcPd48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NxUJtBYENcpG+Br5QfSpPZm5NjFNcIPwEHGt2BlnLQr1oLgy6nnMmZE/RV6fu/fg1
         odMOgYOm/O1Tmhx1hTKasWPWCBU642/KBfPDWL02xDE+j+6txBEkn0D9ZT9XsVrF9O
         VJPwEhYbmG2+3SWWkHhE6MxKruFrdN4TudatLfP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 014/111] i2c: mux: demux-pinctrl: Fix an error handling path in i2c_demux_pinctrl_probe()
Date:   Tue, 26 May 2020 20:52:32 +0200
Message-Id: <20200526183933.933884548@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183932.245016380@linuxfoundation.org>
References: <20200526183932.245016380@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit e9d1a0a41d4486955e96552293c1fcf1fce61602 ]

A call to 'i2c_demux_deactivate_master()' is missing in the error handling
path, as already done in the remove function.

Fixes: 50a5ba876908 ("i2c: mux: demux-pinctrl: add driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 0e16490eb3a1..5365199a31f4 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -272,6 +272,7 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 err_rollback_available:
 	device_remove_file(&pdev->dev, &dev_attr_available_masters);
 err_rollback:
+	i2c_demux_deactivate_master(priv);
 	for (j = 0; j < i; j++) {
 		of_node_put(priv->chan[j].parent_np);
 		of_changeset_destroy(&priv->chan[j].chgset);
-- 
2.25.1




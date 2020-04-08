Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6D6C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82532075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360870;
	bh=a3JpEtgqMbhSCDXAHAnASAtVj+ma3vbopyY6WyqAmxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zs61wUzLMjWoKVzvHR7kdg1JCLQ9MwTeclqt3ld85lYqicYDPf/X5y1kkhLCj8za5
	 H2G1bEN28YVf2VehDeaFoUyuI80RhpJub3EAzlQM7Mtti139/ij0npuM6ap8R4gein
	 PWEhcXga2xMc/AXHBtCQB483tdlP1xfXaje8OrZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgDHPrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729704AbgDHPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A9B822206;
        Wed,  8 Apr 2020 15:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360792;
        bh=a3JpEtgqMbhSCDXAHAnASAtVj+ma3vbopyY6WyqAmxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M5JOF+z+I7+cY7nGfSrBvIrUf+7/BBGl7IM61FprqM6C30cGMKO/Db8Om9e/96TSX
         xq7h22xkayEKBe0Q8Ag7MJIGHuBH8HjvcHrFErQ/GCgg/6jNdOmissA/OeWGpdUmSr
         td/5w4OHBGG9MDnp7ozlMTdfgMX7PnKttFmGd6VE=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuM-000cD4-By; Wed, 08 Apr 2020 17:46:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 35/35] docs: update recommended Sphinx version to 2.4.4
Date:   Wed,  8 Apr 2020 17:46:27 +0200
Message-Id: <2de15bd64b2c0bf7320c96ec2f8c7fba923e0962.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some docs that have nested tables. While this was
always part of the spec, only Sphinx version 2.4.x can
translate it to LaTeX.

In other words, if someone is using a Sphinx version < 2.4,
the LaTeX and PDF output won't work for some of the docs.

So, it seems that it is time to raise the bar again
for the recommented version.

The Sphinx check script is already smart enough to keep
working, with older versions, warning the users that
an upgrade is recommended (and explaining how):

	Sphinx version 1.7.9
	Warning: It is recommended at least Sphinx version 2.4.4.
	Detected OS: Fedora release 31 (Thirty One).

	To upgrade Sphinx, use:

		/usr/bin/virtualenv sphinx_2.4.4
		. sphinx_2.4.4/bin/activate
		pip install -r ./Documentation/sphinx/requirements.txt

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 14e29a0ae480..489f6626de67 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,3 +1,3 @@
 docutils
-Sphinx==1.7.9
+Sphinx==2.4.4
 sphinx_rtd_theme
-- 
2.25.2


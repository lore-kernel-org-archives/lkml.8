Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C748C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2973A20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883021;
	bh=a3JpEtgqMbhSCDXAHAnASAtVj+ma3vbopyY6WyqAmxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B4BSPy6YY5mWspMe9gKGz5UMKLeKU2RhVWDz1cNiP+f2dhQFSILsWkwbVTblC3EqO
	 7f+3huRL96MCDRM7TglGP5xwJi/N/isKu9w9I6PNTgzB7ZXj11TYRQrbREYewwAqtI
	 +gBZ93DL+ve1OUvPjGMNSqT8thBiPQUSjY335RRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501964AbgDNQtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440301AbgDNQtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:06 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A3B020774;
        Tue, 14 Apr 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882942;
        bh=a3JpEtgqMbhSCDXAHAnASAtVj+ma3vbopyY6WyqAmxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2bciHI3uu0HYt4aATccayspSX8sp4/l56AGKYuGMiWf9Q84L2c5n8cg1nakfBITzl
         LeAWyXNqj7be4vTkfFtxHEYTD56N+XcUaI6vCuFGkR5/z2nyEt+CledG5DxJQafOD0
         x1lqbQSA6o7T1b5pQzAwo3EQzMUOFI0xvydcCThY=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk8-0068lA-J7; Tue, 14 Apr 2020 18:49:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 04/33] docs: update recommended Sphinx version to 2.4.4
Date:   Tue, 14 Apr 2020 18:48:30 +0200
Message-Id: <498f701c618f7d0cf5f0a37e5889ee926f7c8bf4.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
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


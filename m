Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E5FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81FD208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586361332;
	bh=KuJIzuvRNSLzidHnV+wYR6+coKvgXXJ7VEM3xlP2xRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nlMDese3v6Secl9d7b2Iok4GxKjRBsUJ8MYypxxtD9o29DgDDZqF1Mm6QgqIsWs96
	 jKcqAMP6zs5fXfGgEixFW1gcHRLeI+hHgOGiUZHQlnhFwOYaMvKrjI+pB8O8XYqyIN
	 xKSQShXr+R9JbLhajDgnpWhq/3bTXXCNcsHr4WC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgDHPzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729887AbgDHPz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:55:29 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B731720730;
        Wed,  8 Apr 2020 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586361328;
        bh=KuJIzuvRNSLzidHnV+wYR6+coKvgXXJ7VEM3xlP2xRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AuUVnlqD2rNHrZatxX3b1S0IXnDVaNGl6DyTXafGS1LigxUpTkCfqabpTdFXcwKWH
         9m+iTNzg81Z+xSTaW7mYzFux0vlUOVDhV+4b50uilbLbhjex6mxLDf/YNvLFlhtHN/
         1zbeLxLN7QreSJ1VUkLzvbIOB5bPbUksg+aIi8CE=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMD30-000cGo-VM; Wed, 08 Apr 2020 17:55:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tim Bird <Tim.Bird@sony.com>,
        Markus Heiser <markus.heiser@darmarit.de>
Subject: [PATCH 2/6] scripts: sphinx-pre-install: improve openSuse Tumbleweed check
Date:   Wed,  8 Apr 2020 17:55:21 +0200
Message-Id: <6bfb24f9203205cef02d3dee3fda48a062a1dfa6.1586361086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586361086.git.mchehab+huawei@kernel.org>
References: <cover.1586361086.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, with openSUSE Tumbleweed 20200303, it keeps
recommending this forever:

	sudo zypper install --no-recommends rsvg-view

This dependency will never be fulfilled there, as the package
now is named as on other distros: rsvg-convert.

So, improve the detection to avoid such issue.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index c2071a1c69ea..46c58a5795f1 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -446,9 +446,11 @@ sub give_opensuse_hints()
 		"convert"		=> "ImageMagick",
 		"Pod::Usage"		=> "perl-Pod-Usage",
 		"xelatex"		=> "texlive-xetex-bin",
-		"rsvg-convert"		=> "rsvg-view",
 	);
 
+	# On Tumbleweed, this package is also named rsvg-convert
+	$map{"rsvg-convert"} = "rsvg-view" if (!($system_release =~ /Tumbleweed/));
+
 	my @suse_tex_pkgs = (
 		"texlive-babel-english",
 		"texlive-caption",
-- 
2.25.2


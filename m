Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E77C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8280D2082D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586361349;
	bh=qp3qEYEeHjKKxIsRa+ChwJ5Ycbkeaz0aFxGnu0R/3g0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qDBe/plK0PfJXhEWqXytazmLmh/cqF6Re+yNqd0GwypR+gdKBmaxnqn5+jgRmiP33
	 NMe/bmYHofzmfIltilRs6B7xpfd4FDO7olgyNHj4jtJXJD4xxoGFwQw1lRduGZot7e
	 H8XCKP1Ml+24w28fkQaVzIoAAnsl5AbU0bMb7WEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgDHPz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729824AbgDHPz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:55:29 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B73B52075E;
        Wed,  8 Apr 2020 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586361328;
        bh=qp3qEYEeHjKKxIsRa+ChwJ5Ycbkeaz0aFxGnu0R/3g0=;
        h=From:To:Cc:Subject:Date:From;
        b=r9d7FEi/HI76EEOUJNA+TD9ORGT9eWPIkLUEanPgtfogQhipauzvcUXWUr88FdY9X
         bsWa6FAeXE+nsKzrXShusODWGE4DQ0lvElthVIOsfF9cZlbxQwbG0FqCiq6FJl3JNr
         eIas/O4S1y2H1oUqCxjJZiqT8q05FaG0EzV9KSHk=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMD30-000cGh-TQ; Wed, 08 Apr 2020 17:55:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tim Bird <Tim.Bird@sony.com>,
        Markus Heiser <markus.heiser@darmarit.de>
Subject: [PATCH 0/6] sphinx-pre-install improvements for Kernel 5.8
Date:   Wed,  8 Apr 2020 17:55:19 +0200
Message-Id: <cover.1586361086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is based on the discussions we had with regards to use

	python -m venv

to create python3 virtual machines.

After this series, the script will be smarter when detecting python3 and
python2.

As I had to re-test it with different distributions, it also do several
improvements and fixes at the detection logic and at the support for
some distributions that I don't use (except when testing this script)
and/or for some corner cases.

Mauro Carvalho Chehab (6):
  scripts: sphinx-pre-install: improve distro detection check
  scripts: sphinx-pre-install: improve openSuse Tumbleweed check
  scripts: sphinx-pre-install: fix a dependency hint with Ubuntu 16.04
  scripts: sphinx-pre-install: address some issues with Gentoo
  scripts: sphinx-pre-install: add support for OpenMandriva
  scripts: sphinx-pre-install: add support for python -m venv

 scripts/sphinx-pre-install | 168 +++++++++++++++++++++++++++----------
 1 file changed, 122 insertions(+), 46 deletions(-)

-- 
2.25.2



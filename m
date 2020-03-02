Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6BBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C4820848
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgCBWkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:40:09 -0500
Received: from ms.lwn.net ([45.79.88.28]:59664 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgCBWkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:40:09 -0500
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 5C57F823;
        Mon,  2 Mar 2020 22:40:08 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/3] Better organize the core-api manual
Date:   Mon,  2 Mar 2020 15:39:54 -0700
Message-Id: <20200302223957.905473-1-corbet@lwn.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a brief series trying to create some order in the core-api manual.
The first patch organizes the contents into subsections, hopefully
straightening things out a bit.  The other two then move a couple of
documents to more suitable homes.

Jonathan Corbet (3):
  docs: Organize core-api/index.rst
  docs: move gcc-plugins to the kbuild manual
  docs: move core-api/ioctl.rst to driver-api/

 Documentation/core-api/index.rst              | 93 ++++++++++++++-----
 Documentation/driver-api/index.rst            |  1 +
 .../{core-api => driver-api}/ioctl.rst        |  0
 .../{core-api => kbuild}/gcc-plugins.rst      |  0
 Documentation/kbuild/index.rst                |  1 +
 MAINTAINERS                                   |  2 +-
 scripts/gcc-plugins/Kconfig                   |  2 +-
 7 files changed, 75 insertions(+), 24 deletions(-)
 rename Documentation/{core-api => driver-api}/ioctl.rst (100%)
 rename Documentation/{core-api => kbuild}/gcc-plugins.rst (100%)

-- 
2.24.1


Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA63BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9550A206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466622;
	bh=YbxJalyVGHm1SOjDLZ72yzU9Tf+RBOgPQtWzC3+C6V0=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=qf8jhJLrihw94HfWCjF9SqLu4SOKhjqSGaVJqCLwNrSIp8lmV9Q/T4hAVqOM2wvIO
	 aoOKBhJPdaqrLE+Tl3TJGFcIazBvMFnC5OMbo9qQt2Omhqb/quqK/oFMmw0m9L0TjU
	 WoYyeDHk3wqPII2eK9RLrOvvqT9Scv7G4HBjp/Rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403852AbgF2VhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgF2Skj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:39 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D401223139;
        Mon, 29 Jun 2020 09:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593423343;
        bh=YbxJalyVGHm1SOjDLZ72yzU9Tf+RBOgPQtWzC3+C6V0=;
        h=From:To:Cc:Subject:Date:From;
        b=sRB2rMKD9jgBvfzfnC2L99xFQYMNo/LqjPATbhoO9J4zMFXKDF0TRFOgAhluYJ0IM
         L++U1yAN2fVCMwqriqNRFC7bB6GVhw1yLkIHiBQniCKonZ+KPkZloC40RuUJRetQe1
         wWCje7DCFqeZHZ+P9Oc12U3I9b3AMzL2A/gP7tAE=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jpqCS-006cAC-Ct; Mon, 29 Jun 2020 11:35:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 0/5] Fix split view search and debug info navigation
Date:   Mon, 29 Jun 2020 11:35:34 +0200
Message-Id: <cover.1593423060.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes some issues with search while on split view and fix the
broken hyperlink navigation.

The first patches restore the pre-Qt5 conversion behavior. The last
one implements navigation on a different way. I opted to keep this one
in separate, as this one is a new feature.

Mauro Carvalho Chehab (5):
  kconfig: qconf: cleanup includes
  kconfig: qconf: ensure that only one item will be highlighted
  kconfig: qconf: make search fully work again on split mode
  kconfig: qconf: make debug links work again
  kconfig: qconf: navigate menus on hyperlinks

 scripts/kconfig/qconf.cc | 120 +++++++++++++++++++++++++++++----------
 scripts/kconfig/qconf.h  |  15 ++---
 2 files changed, 98 insertions(+), 37 deletions(-)

-- 
2.26.2



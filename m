Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC48C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E6242075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgESTmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:42:39 -0400
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:40970 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726059AbgESTmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:42:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B0520182CF666;
        Tue, 19 May 2020 19:42:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ants16_4315b1e26d0f
X-Filterd-Recvd-Size: 1276
Received: from joe-laptop.perches.com (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 May 2020 19:42:37 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC PATCH 0/2] printk/init: multi-line kernel command line logging
Date:   Tue, 19 May 2020 12:42:33 -0700
Message-Id: <cover.1589916689.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <79e649a5a73b2137bc576a75271854dc4024ae24.camel@perches.com>
References: <79e649a5a73b2137bc576a75271854dc4024ae24.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches (2):
  printk: Move and rename maximum printk output line length defines
  init: Allow multi-line output of kernel command line

 include/linux/printk.h | 18 ++++++++++++++++++
 init/main.c            | 31 ++++++++++++++++++++++++++++++-
 kernel/printk/printk.c | 28 ++++++++++------------------
 3 files changed, 58 insertions(+), 19 deletions(-)

-- 
2.25.1


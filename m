Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EC9C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61ACD20848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583234645;
	bh=rv9OqmSphTP2/Bi7sPUwcbWh5FMkNeF2by0BEe7Sn6I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jtmKy9qmwxnhFx9GjntrXLjFrnUgT9D247kmFuS7eEPhqbL0CSMdqF87wKvZd+BVB
	 CBf5O8y17uhC1BIfXKNrS7pH6OqstC+MPTTqx6sP7SfWuJdEZMkufvJTWLR8sr6hTs
	 kS9c9wdVUJCeCPU7IcGrD/RtB/TgKnh1cPekCoyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgCCLYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:24:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:55280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbgCCLYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:24:04 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A4AB20836;
        Tue,  3 Mar 2020 11:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583234643;
        bh=rv9OqmSphTP2/Bi7sPUwcbWh5FMkNeF2by0BEe7Sn6I=;
        h=From:To:Cc:Subject:Date:From;
        b=Iw0l0Q5N7eOJlHiQLaerZS0euSAAZaPI4e/yl+CD/ul+wOq/x+vFoB50BnOnnvxbO
         1ckY9XlDS0DzBaOxr1qLbc767jfv16nkiZkLDa3O8t7QVKca8JMIIgP7SV1CwXC5Xx
         DHhOldpn0L8bV8C5Evj/w9TqWSlcL99eWYw9Kdjs=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] tools/bootconfig: Add O= option and enhance error message
Date:   Tue,  3 Mar 2020 20:23:59 +0900
Message-Id: <158323463879.10281.9905975413630653620.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are patches to update tools/bootconfig to add O= option
support and enhance error message so that user can easily
locate the error position.

Thank you,

---

Masami Hiramatsu (2):
      bootconfig: Support O=<builddir> option
      tools/bootconfig: Show line and column in parse error


 include/linux/bootconfig.h          |    3 ++-
 init/main.c                         |   14 ++++++++++----
 lib/bootconfig.c                    |   35 ++++++++++++++++++++++++++---------
 tools/bootconfig/Makefile           |   27 +++++++++++++++++----------
 tools/bootconfig/main.c             |   35 +++++++++++++++++++++++++++++++----
 tools/bootconfig/test-bootconfig.sh |   14 ++++++++++----
 6 files changed, 96 insertions(+), 32 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

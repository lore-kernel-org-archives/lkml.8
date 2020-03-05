Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02A8C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F3C21556
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583390657;
	bh=a4aJEqUwvJ6/7STY08t7rKwFcED+LE1xGTYq8HoLoRA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Cd+rzfzuHBwVEqQvU/8NfxmWjr1aOTjasvA1BvgO+AKHYMHfIIsHYUu0ijZEubaOG
	 e+ii7uMhUEJ/jF5Amv6B2yomc5UOY+NKk2L9OEGIZKIADrmcZKdEMMqxUt6nYJTD2R
	 SQefK+JKy8V+ZonSP9fMJw6h9ckLV+B1uYvMq6n0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgCEGoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 01:44:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgCEGoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 01:44:16 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F945208CD;
        Thu,  5 Mar 2020 06:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583390656;
        bh=a4aJEqUwvJ6/7STY08t7rKwFcED+LE1xGTYq8HoLoRA=;
        h=From:To:Cc:Subject:Date:From;
        b=vcRiLx5ON5PzsPLXKxh3FQZz4Ec+SMCO0kFvfohkqo00564mTrjuUuT/V5Zn7DYOb
         yrGWAKwuS5Hh7wOxUXYlgEKZy7+Jxq4RS8JmIo6q/nyPEDZfFc+Qu4EN7gkgWDfFtk
         xt5ZlWKLmkiMxWCJq8pZi0vrB/xfHxODIYODABEY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v5 0/1] Documentation: bootconfig: Documentaiton updates
Date:   Thu,  5 Mar 2020 15:44:12 +0900
Message-Id: <158339065180.26602.26457588086834858.stgit@devnote2>
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

Here is the 5th version of the documentation update.
- Elaborated according to Randy's comment.
- Fix some typos.

Thank you,

---

Masami Hiramatsu (1):
      Documentation: bootconfig: Update boot configuration documentation


 Documentation/admin-guide/bootconfig.rst |  201 +++++++++++++++++++-----------
 Documentation/trace/boottime-trace.rst   |    2 
 2 files changed, 131 insertions(+), 72 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

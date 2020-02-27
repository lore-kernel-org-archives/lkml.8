Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D347C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 07:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A7E20714
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 07:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582788349;
	bh=3BJS1fwCXkPIehkComn8dtpK8P07gYtIM3huuSL3+rs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Plns+O3r/basnyONWBo3+JXLRZZWOvcGSoBmbeC1fnUdt5EPK4piwFf033+ZkOGGR
	 JUOVn0pZu2zdeaOcvg3WJIoPPlduuwZIPgMJSE3IjwRDxRz3R6MsWr13cqbGsvOImN
	 zHgZHUod73mRNh6WK8BPjRZSOlPGvHRSMWNp4V7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgB0HZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 02:25:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgB0HZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 02:25:47 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99C1A24656;
        Thu, 27 Feb 2020 07:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582788347;
        bh=3BJS1fwCXkPIehkComn8dtpK8P07gYtIM3huuSL3+rs=;
        h=From:To:Cc:Subject:Date:From;
        b=fyxIsWdgvOtNDzMGZaoLc+7SE62lPjV1gXtmRr7Fgv5OJU2lJyk/TIUgjUi8m4vw+
         LTbGjpIw8FQIuTDNqRiM5U5rL1KNvUrs6GqYiZJJoYUBaBa6LGE/Uv5CCfFz6oJC4F
         BaKD/3Km59wX/hU9DHmKsLvi2uDLTkSvi210yWSE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] Documentation: bootconfig: Documentaiton updates
Date:   Thu, 27 Feb 2020 16:25:42 +0900
Message-Id: <158278834245.14966.6179457011671073018.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a couple of patches to update the bootconfig documentation.
I hope this clarify what the boot configuration is :)

Thank you,

---

Masami Hiramatsu (2):
      Documentation: bootconfig: Update boot configuration documentation
      Documentation: bootconfig: Add EBNF syntax file


 Documentation/admin-guide/bootconfig.ebnf |   41 +++++++
 Documentation/admin-guide/bootconfig.rst  |  180 +++++++++++++++++++----------
 Documentation/trace/boottime-trace.rst    |    2 
 MAINTAINERS                               |    1 
 4 files changed, 162 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/admin-guide/bootconfig.ebnf

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B4AC3F2D4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFEE246B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583136224;
	bh=jvZ9ChLJEH+7A4zTPFo3Afj6QQThw+sgjPSHjQyNRPA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BI7t4T9n+tPBHb8fN9NeAn0ctqXy33/7fF2BHfZgev4eBTa3tuBQLtC038LwFkeOA
	 4TpZWscSSqB2FQ2dhr+XuXNgsZXrL1Sh0g4AOuHROOrhGi58VfNPvgPAXEnqfjWDYr
	 P4YpFhekv5Y7VXRvT3A8jnXoLb/Ms8uGg7dMj398=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgCBIDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:03:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBIDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:03:43 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C68224699;
        Mon,  2 Mar 2020 08:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136222;
        bh=jvZ9ChLJEH+7A4zTPFo3Afj6QQThw+sgjPSHjQyNRPA=;
        h=From:To:Cc:Subject:Date:From;
        b=lqM/jfso67NF1Uij0Rcaa0+BM0Y7ccXC+sxB9qKKtuLfaGdlCc4Zribx6YHbZBf7Q
         Z80IdOFkkk05+9vXmTXkjbtPtp83Asjz/+CrLuhSZV9cF6z9bxlMABcE7xZ2vPj/IX
         GOLRhAxU95pWl9I43z6252VY94sz7r8ohzUWJ/OU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v3 0/1] Documentation: bootconfig: Documentaiton updates
Date:   Mon,  2 Mar 2020 17:03:38 +0900
Message-Id: <158313621831.3082.9886161529613724376.stgit@devnote2>
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

Here is the 3rd version of the documentation update.
I updated it according to Randy's comment.

Thank you,

---

Masami Hiramatsu (1):
      Documentation: bootconfig: Update boot configuration documentation


 Documentation/admin-guide/bootconfig.rst |  181 +++++++++++++++++++-----------
 Documentation/trace/boottime-trace.rst   |    2 
 2 files changed, 117 insertions(+), 66 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

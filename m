Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F706C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51ADB24953
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340263;
	bh=eRAtNJ/HWH4sVqYaO5Frc3YDE4F9g8IJVo3snPfoH0M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=MCSS++0FXpzU+KZ6BPnfIHiLgvlBZfRd4h58EW7qWD37zY/+CXblhKtb6iPmJmDzS
	 MpmW4XbJx80Z+tJXRt9v/ZX3DkutXky47wEiT/fCoPMuOkrJ8DS5MYpDZcjHHzNiwD
	 yHY6Wm9Q7pIsdz5FbTdUa+/4PEu0BBgSN1gnsnhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbgEANhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730961AbgEANhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:37:36 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A8B208DB;
        Fri,  1 May 2020 13:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340256;
        bh=eRAtNJ/HWH4sVqYaO5Frc3YDE4F9g8IJVo3snPfoH0M=;
        h=From:To:Cc:Subject:Date:From;
        b=FI7jz2afSuPHE4c7uMPD//oMdbnNIcOu6Ys5e8TA8b+S6NjGIouVp5liYXuA8Q3Gb
         HxccV8nXOw9jri5qgO3221uRwfdCTKPrAcQCmySVWx6+O8eMkYaE/qyCqxTuH4xYGx
         m4ep+C55sPz3zw/9uYjjUUNzU2OODh6fSZeHvq4I=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: [PATCH 0/3] selftests/ftrace: Fix ftracetest testcases for dash, etc.
Date:   Fri,  1 May 2020 22:37:31 +0900
Message-Id: <158834025077.28357.15141584656220094821.stgit@devnote2>
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

Here are some patches to update ftracetest to fix some issues.
 - [1/3] Fix coloring of XFAIL
 - [2/3] Fix a testcase not to expect just one event entry
 - [3/3] Do not use built-in echo because the behavior is different
         on dash and bash. (Thanks Liu for reporting!)

Thank you,

---

Masami Hiramatsu (3):
      selftests/ftrace: Make XFAIL green color
      selftests/ftrace: Pick only the first kprobe event to test
      selftests/ftrace: Use /bin/echo instead of built-in echo


 tools/testing/selftests/ftrace/ftracetest          |    2 +-
 tools/testing/selftests/ftrace/test.d/functions    |    3 +++
 .../ftrace/test.d/kprobe/kprobe_args_type.tc       |    2 +-
 .../test.d/trigger/trigger-trace-marker-hist.tc    |    2 +-
 .../trigger-trace-marker-synthetic-kernel.tc       |    4 ++++
 .../trigger/trigger-trace-marker-synthetic.tc      |    4 ++--
 6 files changed, 12 insertions(+), 5 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E0CC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3DA2467A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272821;
	bh=fdYaIhDtpUmeGjpEwSQOJIRdU16c1wd9/4DaS2e/RIo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=X4hXTr9NHSUNBkvNDaqOFtna0Wo12hJgH/EKzV3zAxfXIOS48kHMDVgkJpvEeP8wm
	 MdtODK2IMaNSoKScuDHY/LQVmxDm4sdoQioPbwYVKMpwJ0OOQ+ZxOPgRM6M7ZmzKAp
	 C860q+4umRYvcZOUS8BWUdAaaSqrZOEMUC/HFeQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733036AbgBUINk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:13:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733026AbgBUINg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:13:36 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEE7520722;
        Fri, 21 Feb 2020 08:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272816;
        bh=fdYaIhDtpUmeGjpEwSQOJIRdU16c1wd9/4DaS2e/RIo=;
        h=From:To:Cc:Subject:Date:From;
        b=ya8hlsKPyGWS4YwpOXY/gVxTbdbqQ4jfVNRSMqNgeus8kVSzop/EtPZxq160d8cXR
         r7Ah2UXLQgOEBfmbdb0hP4pzSSmwDSMemKUIsmexHVJpl5bKZNcReWJG4mTfCxFX/M
         YxCAiG6PF5AaBOLpNXxXZ1LTHQWNcqM/GTajgI/k=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 0/2] bootconfig: Syntax updates
Date:   Fri, 21 Feb 2020 17:13:32 +0900
Message-Id: <158227281198.12842.8478910651170568606.stgit@devnote2>
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

Here is the 3rd version of the bootconfig syntax update
which remains on my queue.

 - [1/2] A new patch for prohibiting re-definition of value.
 - [2/2] Update the value append operator patch on [1/2].

Thank you,

---

Masami Hiramatsu (2):
      bootconfig: Prohibit re-defining value on same key
      bootconfig: Add append value operator support


 Documentation/admin-guide/bootconfig.rst   |   19 ++++++++++++++++++-
 lib/bootconfig.c                           |   26 ++++++++++++++++++--------
 tools/bootconfig/samples/bad-samekey.bconf |    6 ++++++
 tools/bootconfig/test-bootconfig.sh        |   16 ++++++++++++++--
 4 files changed, 56 insertions(+), 11 deletions(-)
 create mode 100644 tools/bootconfig/samples/bad-samekey.bconf

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

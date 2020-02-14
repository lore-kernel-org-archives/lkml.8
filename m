Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EC4C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39AC72465D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581660623;
	bh=z9Q3A4p/YuRxSKXwFUkfWRY4BWOu3yIZZGFKszBfx78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YxsQl7/fLJuamXlui5GRaznHVPppv38CXHFGfYQH6qIpNm174O+Q7ybAnZhv6DCjh
	 YTInyGBdF4tuJaMo8z6RT91Fs6eFeA3FCoOtRdX+SXDBbV9nlAD6YE4/Vm8fzFNym1
	 fXGte0ZClj+0RqtKWFDH2HfOaXF2wdLL8xvd4km8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgBNGKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgBNGKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:10:22 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71CDC22314;
        Fri, 14 Feb 2020 06:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581660622;
        bh=z9Q3A4p/YuRxSKXwFUkfWRY4BWOu3yIZZGFKszBfx78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nWDy4oWH1U/rDG5s12yhsyukQ3cGcA3yVzr13jGELJBTkMjkElDFUi7Six1mlPmpP
         CCVVcwrfc6lB30KRfgQQl8hv4zXqNIwbG7wb/vRHlwbSei2xm19aWIbitYLlEL8WCM
         5ScJFzT6Rya7GRaZz0cYQNTrljITpWj97l4+s9xA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH 1/3] bootconfig: Support non-ascii characters in value
Date:   Fri, 14 Feb 2020 15:10:14 +0900
Message-Id: <158166061395.9887.16192852210178543724.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158166060044.9887.549561499483343724.stgit@devnote2>
References: <158166060044.9887.549561499483343724.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support non-ascii (u8 code > 128) characters in the
value data. This will allow user to pass utf-8 data
as a value in a bootconfig. (Note that ascii non-
printable characters are still not allowed.)

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 lib/bootconfig.c                              |    2 +-
 tools/bootconfig/samples/good-non-ascii.bconf |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 100644 tools/bootconfig/samples/good-non-ascii.bconf

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 3ea601a2eba5..9f15b8bef3a0 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -466,7 +466,7 @@ static int __init __xbc_parse_value(char **__v, char **__n)
 	}
 	p = v - 1;
 	while ((c = *++p)) {
-		if (!isprint(c) && !isspace(c))
+		if (c >= 0 && !isprint(c) && !isspace(c))
 			return xbc_parse_error("Non printable value", p);
 		if (quotes) {
 			if (c != quotes)
diff --git a/tools/bootconfig/samples/good-non-ascii.bconf b/tools/bootconfig/samples/good-non-ascii.bconf
new file mode 100644
index 000000000000..b6cb4c24fad6
--- /dev/null
+++ b/tools/bootconfig/samples/good-non-ascii.bconf
@@ -0,0 +1 @@
+hello.japanese = "こんにちは"


Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E110BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D4220658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594829031;
	bh=Y8284yERRo+KqCcBf+q3NCh9szlZqEj1ByfomoYfk3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oH1rQfnECuvmYQ7sv7UvGXDAfSmh15VU8UFkW5GJkB69NEHGBc4+9zk/CezZZKCq2
	 MEEGqLQFmzAS9zurQecuG0Ae0+PZ/OSAkT2eDtUNP3I4gFMPvf8qZgXQN3unZKuoZ+
	 CSsdQ75umxDHaQFRTs5yeY/ajXVDH62ID8n6KGlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgGOQDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgGOQAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:00:54 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A63F2071B;
        Wed, 15 Jul 2020 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594828850;
        bh=Y8284yERRo+KqCcBf+q3NCh9szlZqEj1ByfomoYfk3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nfxFYGmq207aAppxvYriLkIFkBC3HC7K/VgBrOLgpHdMQtIYzfblj0hvOYtGuB4B4
         0Fa4VC4Nz3jxTDQCGxFXfn/0cZYUZ3drXaJOV5kZ+95HQZK0Bwutt8NGpcUfOTaU61
         JKGp9A8PwmfoEiTOG6cfraJB664x9WaazOqC5HjQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alistair Delva <adelva@google.com>, mhiramat@kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] Documentation: bootconfig: Add bootconfig override operator
Date:   Thu, 16 Jul 2020 01:00:47 +0900
Message-Id: <159482884682.126704.7198860675721719878.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159482882056.126704.15508672095852220119.stgit@devnote2>
References: <159482882056.126704.15508672095852220119.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sentence about bootconfig override operator (":=") to
bootconfig.rst.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/admin-guide/bootconfig.rst |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index d6b3b77a4129..a22024f9175e 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -71,6 +71,16 @@ For example,::
  foo = bar, baz
  foo = qux  # !ERROR! we can not re-define same key
 
+If you want to update the value, you must use the override operator
+``:=`` explicitly. For example::
+
+ foo = bar, baz
+ foo := qux
+
+then, the ``qux`` is assigned to ``foo`` key. This is useful for
+overriding the default value by adding (partial) custom bootconfigs
+without parsing the default bootconfig.
+
 If you want to append the value to existing key as an array member,
 you can use ``+=`` operator. For example::
 
@@ -84,6 +94,7 @@ For example, following config is NOT allowed.::
 
  foo = value1
  foo.bar = value2 # !ERROR! subkey "bar" and value "value1" can NOT co-exist
+ foo.bar := value2 # !ERROR! even with the override operator, this is NOT allowed.
 
 
 Comments


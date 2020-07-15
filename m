Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CACBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB65F20658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594828889;
	bh=r2YnEV9cxZM540gF/4uEROxq/iKUQNDEAAOnbE7D4rM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=fQFq3qIiBoaD22FncDl+cohr2tVooDkPCsVJ5Zp4G5uk/bdktdNuGazdyMrsJkGEl
	 dvM4Y1f7AlOqdc+LbgxXQbALBoGrsSV3gzKBzjNaoplBIo4TB90OutYp2kxdB1dNDf
	 wwCWtbhPxmyYnj18dMcgIQ29Ihq6e73zGFUVrq5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgGOQBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgGOQAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:00:41 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 288E620658;
        Wed, 15 Jul 2020 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594828824;
        bh=r2YnEV9cxZM540gF/4uEROxq/iKUQNDEAAOnbE7D4rM=;
        h=From:To:Cc:Subject:Date:From;
        b=TSraei5WAVUss84PNiZUOAWjKbF5UhQIXgrUAKGiz+XmNKDJPQVcfJn1He6kSERvG
         UFW0lSXJmP1LSGNWz3Yiy8QRGgGuLq5FESuWbAfPz8D0K/5CPNpsGuYrxH7dH3z9bj
         /Ae+yQ/Ga6f+neztta058RKTVaLEx6cyWGzqzqtI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alistair Delva <adelva@google.com>, mhiramat@kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] bootconfig: Add value override operator
Date:   Thu, 16 Jul 2020 01:00:21 +0900
Message-Id: <159482882056.126704.15508672095852220119.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a seires of value-override operator support for bootconfig.

Currently, the bootconfig syntax supports normal assignment operator
("=") and value append operator ("+="), but there is no way to
override (or update) existing value.

This patch adds the value override operator (":=") to update the
existing value with another value. For example,

key.word = value1
key.word := value2, value3

In this case, the 2nd "key.word" config overwrites the 1st one.
Thus this is equal to;

key.word = value2, value3

Note that it is still not allowed to override a subkey with
a value, and a value with a subkey. This means the following
case is not allowed.

key.word = value1
key := value2 # Error!


With this change, if the bootloader wants to change some value
in the default bootconfig, it doesn't need to parse the existing
bootconfig, but it can just append the new configs at the tail
of the bootconfig and update the footer (size, checksum and magic
word).

Thank you,

---

Masami Hiramatsu (3):
      lib/bootconfig: Add override operator support
      tools/bootconfig: Add testcases for value override operator
      Documentation: bootconfig: Add bootconfig override operator


 Documentation/admin-guide/bootconfig.rst     |   11 +++++++++
 lib/bootconfig.c                             |   33 ++++++++++++++++++--------
 tools/bootconfig/samples/bad-override.bconf  |    3 ++
 tools/bootconfig/samples/bad-override2.bconf |    3 ++
 tools/bootconfig/samples/good-override.bconf |    6 +++++
 tools/bootconfig/test-bootconfig.sh          |   13 ++++++++++
 6 files changed, 59 insertions(+), 10 deletions(-)
 create mode 100644 tools/bootconfig/samples/bad-override.bconf
 create mode 100644 tools/bootconfig/samples/bad-override2.bconf
 create mode 100644 tools/bootconfig/samples/good-override.bconf

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

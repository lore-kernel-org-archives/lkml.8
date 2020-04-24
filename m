Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24484C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E592D2071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587746048;
	bh=OGgn4SN24TNomJz/Gi7PzZVJ33s9Wr+ofJ0PArUa8jo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rmh0LN4oNQf73ZVwa8yBxdBXznz8OEh3/Lov2DohIW/Q72mrxIu/H+YP3yu5/jk53
	 vVcD/e/G++lZeyX6kgh7kPl900cs8cY4s6VYd7KLYR5gs9ahIHnktb/lo6UD8CctQ9
	 YIfQC/ldEvDfbC3sFCOf3U2ihtwajV1of6Y76xaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgDXQeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbgDXQeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:34:06 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD763206D7;
        Fri, 24 Apr 2020 16:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587746046;
        bh=OGgn4SN24TNomJz/Gi7PzZVJ33s9Wr+ofJ0PArUa8jo=;
        h=From:To:Cc:Subject:Date:From;
        b=QmEAPGnEZjx8X71+18TXk0RRBxG2dNwnOipIigJknGrw3yX8nbHOymiNq4BPiN5jS
         JIcTfHySap6HqeHnZGDlsLf1hyyE3w87UyZtHXAwoscP664x8A8kNAdsDarmDXc34z
         dngxFt5KU74UTxZHQyBbIwWLpw1UDSkKX0N9Z5us=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [BUGFIX PATCH 0/1] bootconfig: Fix wrong initramfs/initrd error with bootconfig
Date:   Sat, 25 Apr 2020 01:34:00 +0900
Message-Id: <158774604073.7423.11492815214537711118.stgit@devnote2>
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

I found that the bootconfig breaks initramfs unpacking.
I saw an error message as following if I apply a bootconfig
to initramfs image.

[    0.883882] Unpacking initramfs...
[    2.696429] Initramfs unpacking failed: invalid magic at start of compressed archive

Without CONFIG_BLK_DEV_RAM, it has no failback method,
so boot up with unpacked initramfs normally. But with
CONFIG_BLK_DEV_RAM=y, the kernel tries to failback to
initrd and failes to mount rootfs.

To fix this issue, I took a way to shrink the initrd_end
so that the kernel can ignore the bootconfig data.

Any thought?

Thank you,

---

Masami Hiramatsu (1):
      bootconfig: Fix to remove bootconfig data from initrd while boot


 init/main.c |   62 +++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 17 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

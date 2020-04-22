Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98F8C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71F620775
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552989;
	bh=MD+lP7LaGzMFM2MJTnyl8A2xD+CowdfsUJGVlZGld9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BfQJhRL7qn4k6PhzcPq/S6pgbgASjXEdIC/M+Gu8Wgox+teT3whB++2Rh4XJ05kNg
	 7Kkv5V8bg3Hm/Wpxt+Q7BAvVriesF6AtVvZ9doe41F/ebZESmR8tekIyYWzmtMbyK7
	 6eNXevApauhgC6QnOzW2VzUYbNnbtBVFqmS7a4eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgDVKG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbgDVKGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:06:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44ADD20575;
        Wed, 22 Apr 2020 10:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549981;
        bh=MD+lP7LaGzMFM2MJTnyl8A2xD+CowdfsUJGVlZGld9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mPEfyeLGzKK4a8ACfAeJ120dZefn6I+7oG17yNKxFj5az+phJvz4UfJsMWfQuJJ9A
         GQEUmJVsYguz65ZrGQnBIgDJvnsww/uimxpMM365KgL6dydYRLkzXHzbLKP562Icq6
         wGsnUAoOUEI/t3Es2U0taI71OL2jfKQaa/2td66M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 4.9 085/125] objtool: Fix switch table detection in .text.unlikely
Date:   Wed, 22 Apr 2020 11:56:42 +0200
Message-Id: <20200422095046.792338248@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit b401efc120a399dfda1f4d2858a4de365c9b08ef upstream.

If a switch jump table's indirect branch is in a ".cold" subfunction in
.text.unlikely, objtool doesn't detect it, and instead prints a false
warning:

  drivers/media/v4l2-core/v4l2-ioctl.o: warning: objtool: v4l_print_format.cold()+0xd6: sibling call from callable instruction with modified stack frame
  drivers/hwmon/max6650.o: warning: objtool: max6650_probe.cold()+0xa5: sibling call from callable instruction with modified stack frame
  drivers/media/dvb-frontends/drxk_hard.o: warning: objtool: init_drxk.cold()+0x16f: sibling call from callable instruction with modified stack frame

Fix it by comparing the function, instead of the section and offset.

Fixes: 13810435b9a7 ("objtool: Support GCC 8's cold subfunctions")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/157c35d42ca9b6354bbb1604fe9ad7d1153ccb21.1585761021.git.jpoimboe@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -914,10 +914,7 @@ static struct rela *find_switch_table(st
 	 * it.
 	 */
 	for (;
-	     &insn->list != &file->insn_list &&
-	     insn->sec == func->sec &&
-	     insn->offset >= func->offset;
-
+	     &insn->list != &file->insn_list && insn->func && insn->func->pfunc == func;
 	     insn = insn->first_jump_src ?: list_prev_entry(insn, list)) {
 
 		if (insn != orig_insn && insn->type == INSN_JUMP_DYNAMIC)



Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2594AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF21220721
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391354AbgE0Qmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:42:46 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:13177 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390729AbgE0Qmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:42:45 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 27 May 2020 09:42:42 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 9826B4046A;
        Wed, 27 May 2020 09:42:44 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 0/3] objtool: Support implicit addend relocations
Date:   Wed, 27 May 2020 09:42:30 -0700
Message-ID: <cover.1590597288.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Future tools that use objtool to process ELF object files may require
reading or even modifying relocations with implicit addends. This
series cleans up the naming of the relocation struct in objtool,
variable names, and function names to be consistent with a more
generic use rather than being specific to those applying explicit
addends.

From there we switch to the specification compliant method of
finding the section the relocations apply to and fall back to the
old naming-heuristic basis if that's not available.

Finally, add support for implicit addends. Note that we don't
completely convert the orc tools to work with both kinds of
relocations. I'm hoping to get feedback on whether it makes more
sense to convert it or leave it as-is.

Matt Helsley (3):
  objtool: Rename rela to reloc
  objtool: Find relocation base section using sh_info
  objtool: Add support for relocations without addends

 tools/objtool/arch.h            |   2 +-
 tools/objtool/arch/x86/decode.c |   2 +-
 tools/objtool/check.c           | 196 +++++++++++++-------------
 tools/objtool/check.h           |   2 +-
 tools/objtool/elf.c             | 237 +++++++++++++++++++++-----------
 tools/objtool/elf.h             |  27 ++--
 tools/objtool/orc_gen.c         |  46 +++----
 tools/objtool/special.c         |  28 ++--
 8 files changed, 311 insertions(+), 229 deletions(-)


base-commit: 7c0577f4e609f7278ebd6d21e2de82b42f110944
prerequisite-patch-id: 387905b1da8b1293e7736b28fcc1585583e3e7cf
prerequisite-patch-id: 2fd7ac6c4dfd717ab117fc771623c01040188b4e
prerequisite-patch-id: bfeefd995e3f80d6fa0edfa2205d98be31fbee4e
prerequisite-patch-id: abcb5732607ad17f4c99c06b8bb83c9db1b15c42
prerequisite-patch-id: 5179e659d828bed48051d365f669a8ba3a36c206
-- 
2.20.1


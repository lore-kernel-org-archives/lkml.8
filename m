Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F950C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 158D120776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgE2VB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:01:26 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:31979 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727781AbgE2VBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:01:25 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 29 May 2020 14:01:20 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.200.192.41])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id D85C4B29FC;
        Fri, 29 May 2020 17:01:24 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH 0/2] objtool: Support implicit addend relocations
Date:   Fri, 29 May 2020 14:01:12 -0700
Message-ID: <cover.1590785960.git.mhelsley@vmware.com>
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

Changes since RFC [1]:
* Dropped the second patch and rebased on tip objtool/core with
  patch[2] from Sami Tolvanen [Josh Poimboeuf]
* Remade the rename patch with a sed script and added script to
  the commit message to aid backports. [Josh]
* Removed function pointers from last patch. [Josh]
* Added relocation type parameter to elf_create_reloc_section()
  to match pattern with relocation section rebuilding.

[1] https://lore.kernel.org/lkml/cover.1590597288.git.mhelsley@vmware.com
[2] https://lore.kernel.org/lkml/20200421182501.149101-1-samitolvanen@google.com/


Matt Helsley (2):
  objtool: Rename rela to reloc
  objtool: Add support for relocations without addends

 tools/objtool/arch.h            |   2 +-
 tools/objtool/arch/x86/decode.c |   2 +-
 tools/objtool/check.c           | 190 +++++++++++------------
 tools/objtool/check.h           |   2 +-
 tools/objtool/elf.c             | 262 +++++++++++++++++++++++---------
 tools/objtool/elf.h             |  27 ++--
 tools/objtool/orc_gen.c         |  44 +++---
 tools/objtool/special.c         |  22 +--
 8 files changed, 333 insertions(+), 218 deletions(-)


base-commit: 0decf1f8de919782b152daf9c991967a2bac54f0
prerequisite-patch-id: 83ac956b6b4a769cafcdc4abaea4a3bcc3136d6d
-- 
2.20.1


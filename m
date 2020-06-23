Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEBEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0975020723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732740AbgFWOMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:12:21 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:52086 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732657AbgFWOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:12:20 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 23 Jun 2020 07:12:17 -0700
Received: from localhost (unknown [10.166.68.167])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id BB9C740880;
        Tue, 23 Jun 2020 07:12:19 -0700 (PDT)
Date:   Tue, 23 Jun 2020 07:12:19 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v5 00/51] objtool: Make recordmcount a subcommand
Message-ID: <20200623141219.GA5580@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <cover.1592510545.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1592510545.git.mhelsley@vmware.com>
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 01:37:46PM -0700, Matt Helsley wrote:
> recordmcount has its own ELF wrapper code and could utilize
> objtool's ELF code to more-portably handle architecture variations.
> This series makes recordmcount a subcommand of objtool. It very
> gradually converts recordmcount to become a subcommand of objtool and
> then reuses parts of objtool's ELF code.
> 
> recordmcount maps the file in and collects simple information it needs to
> append a section to the object file. The only part of the original file it
> modifies is the address of new section tables -- interestingly enough this
> resembles RCU in that we don't really trim the old tables so
> much as unlink them via a critical offset and then rely on
> future tooling, in this case, to drop the unused bits.
> 
> Much of the recordmcount ELF code is only reading and walking the data
> structures to collect the mcount locations it records in a separate
> area of memory. This means it's safe to mix access to the mapped
> file with access to the objtool-style linked data
> structures as we gradually convert it to using only the linked data
> structures. Once the old ELF code is no longer in use we can drop it
> and use objtool to take over the task of writing the results without
> using the RCU-like trick any more.
> 
> After that we greatly simplify the mcount subcommand by adding a
> few flags to the ELF reading code in objtool. Overall the series
> removes about 600 lines of recordmcount while adding little to
> objtool's ELF code.
> 
> Testing so far:
> 
> I've been using scripts to test cross compilation and execution of
> objtool, and mcount on objects built for x86, ppc64le, arm64, s390, and
> sparc.
> 
> 
> Applies on top of:
> 	objtool/core
> 
> 	Peter Zijlstra's "x86/entry: noinstr fixes" [2]

Just thought I'd note for anyone reviewing/playing with this series:

Peter's patches are now in objtool/core

> 	Sami Tolvanen's patch enabling support for more than 64k
> 	sections in recordmcount, already going upstream. [3]

Sami's patch is now in Linus' master branch

Cheers,
    -Matt

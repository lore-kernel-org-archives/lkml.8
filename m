Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03764C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD2E207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbgFPTvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:51:11 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:13840 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730393AbgFPTvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:51:08 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 16 Jun 2020 12:51:05 -0700
Received: from localhost (unknown [10.129.221.29])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 83A4D40A09;
        Tue, 16 Jun 2020 12:51:07 -0700 (PDT)
Date:   Tue, 16 Jun 2020 12:51:06 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <dvyukov@google.com>, <elver@google.com>, <andreyknvl@google.com>,
        <mark.rutland@arm.com>, <rostedt@goodmis.org>,
        <jthierry@redhat.com>, <mbenes@suse.cz>
Subject: Re: [RFC][PATCH 2/3] objtool: Provide elf_write_{insn,reloc}()
Message-ID: <20200616195106.GE25598@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, dvyukov@google.com, elver@google.com,
        andreyknvl@google.com, mark.rutland@arm.com, rostedt@goodmis.org,
        jthierry@redhat.com, mbenes@suse.cz
References: <20200612143034.933422660@infradead.org>
 <20200612143554.012293047@infradead.org>
 <20200616091253.GN2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200616091253.GN2531@hirez.programming.kicks-ass.net>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 11:12:53AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 12, 2020 at 04:30:36PM +0200, Peter Zijlstra wrote:
> > +int elf_write_insn(struct elf *elf, struct section *sec,
> > +		   unsigned long offset, unsigned int len,
> > +		   const char *insn)
> > +{
> > +	Elf_Data *data = sec->data;
> > +
> > +	if (data->d_type != ELF_T_BYTE || data->d_off) {
> > +		WARN("write to unexpected data for section: %s", sec->name);
> > +		return -1;
> > +	}
> > +
> > +	memcpy(data->d_buf + offset, insn, len);
> > +	elf_flagdata(data, ELF_C_SET, ELF_F_DIRTY);
> > +
> > +	sec->changed = true;
> > +	elf->changed = true;
> > +
> > +	return 0;
> > +}
> > +
> > +int elf_write_reloc(struct elf *elf, struct reloc *reloc)
> > +{
> > +	struct section *sec = reloc->sec;
> > +
> > +	if (sec->sh.sh_type == SHT_REL) {
> > +		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
> > +		reloc->rel.r_offset = reloc->offset;
> > +
> > +		if (!gelf_update_rel(sec->data, reloc->idx, &reloc->rel)) {
> > +			WARN_ELF("gelf_update_rel");
> > +			return -1;
> > +		}
> > +	} else {
> > +		reloc->rela.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
> > +		reloc->rela.r_addend = reloc->addend;
> > +		reloc->rela.r_offset = reloc->offset;
> > +
> > +		if (!gelf_update_rela(sec->data, reloc->idx, &reloc->rela)) {
> > +			WARN_ELF("gelf_update_rela");
> > +			return -1;
> > +		}
> > +	}
> > +
> > +	sec->changed = true;
> > +	elf->changed = true;
> > +
> > +	return 0;
> > +}
> 
> Doing the change Matt asked for #1, I realized that sec->changed is only
> required if we need to rewrite the section header, neither of these two
> changes requires that, they already mark the elf data dirty so
> elf_update() DTRT.

This is really useful information.

As long as you're adding the elf->changed flag it might make sense to add this
as a comment in the struct section definition or even rename sec->changed
to reflect this (e.g. sec->shdr_changed).

Cheers,
     -Matt Helsley

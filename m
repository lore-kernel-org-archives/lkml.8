Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BD0C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0575820842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578671009;
	bh=p7SZ6kULpIMIigeY/yhZS1vpu34onz1Ng7fdbX+9T2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sbb2bkQwgQfblXiX/7pVqcAtuQTd2oMQGi7+MbqJUrlnVW9UZRIJb2WFy+3CrJEKl
	 Egkttp74Pokj0hTbkHb3dT7RQ6g+QITkRT2YsO4bcnRnBJpx37bumcsnLeyESuRtLv
	 OlHN25gI3hAm4uuDMz8eQie34x96TrSlJChk78MI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgAJPn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:43:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbgAJPn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:43:27 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D0882077C;
        Fri, 10 Jan 2020 15:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578671006;
        bh=p7SZ6kULpIMIigeY/yhZS1vpu34onz1Ng7fdbX+9T2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XggWSjZFdXwLym8fwhUHJP+60Yll9NHk4bvqr+DP/9Ur8cAQut2L9UUpxPs20SQ6Z
         9YfhXrjhRPsHWP4jxFoLr3qFkPJG9DSG9yFuXjPrvcnJwCRlAMC3gYODkL1xekC/e8
         UIUXuU9J38kEhy7ZOjuRkWNbXbRZYueQb8SqcTj0=
Date:   Sat, 11 Jan 2020 00:43:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc:     "arnaldo.melo@gmail.com" <arnaldo.melo@gmail.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUGFIX PATCH 1/4] perf probe: Skip end-of-sequence and non
 statement lines
Message-Id: <20200111004323.ebeebf40191d2e8956602513@kernel.org>
In-Reply-To: <f2230bb1eb14e238b40429ebf051f31d9183f51f.camel@nokia.com>
References: <157241935028.32002.10228194508152968737.stgit@devnote2>
        <157241936090.32002.12156347518596111660.stgit@devnote2>
        <20191106200401.GB13829@kernel.org>
        <f2230bb1eb14e238b40429ebf051f31d9183f51f.camel@nokia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommi,

Thank you for reporting!

On Fri, 10 Jan 2020 09:29:22 +0000
"Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com> wrote:

> 
> Hello,
> 
> I'm getting perf test failures after this patch hit mainline and LTS
> kernels.
> 
> With v5.5-rc5 (x86_64 gcc-9.2.1) I get:
> 
>  # perf test
>  ...
>  69: Add vfs_getname probe to get syscall args filenames   : FAILED!
>  71: Use vfs_getname probe to get syscall args filenames   : FAILED!
>  73: Check open filename arg using perf trace + vfs_getname: FAILED!
> 
> Reason is that it's no longer possible to add probe in getname_flags()
> line "result->uptr = filename;", and this is causing the perf tests to
> fail:
> 
> # perf probe -L getname_flags
> <getname_flags@/root/linux-core2/fs/namei.c:0>
>       0  getname_flags(const char __user *filename, int flags, int *empty)
>          {
> ...
>      61         result->refcnt = 1;
>                 /* The empty path is special. */
>      63         if (unlikely(!len)) {
>      64                 if (empty)
>      65                         *empty = 1;
>      66                 if (!(flags & LOOKUP_EMPTY)) {
>      67                         putname(result);
>      68                         return ERR_PTR(-ENOENT);
>                         }
>                 }
>          
>                 result->uptr = filename;
>      73         result->aname = NULL;
>                 audit_getname(result);
>                 return result;
>          }
> 
> 
> I can reproduce it locally with a kernel config change (with attached KVM
> guest config): when kernel is built with CONFIG_MCORE2=y the issue
> reproduces. When switching to CONFIG_GENERIC_CPU=y it's again possible to
> add the probe to the source line and the tests pass.
> 
> Diffing the disassembly of fs/namei.o between CONFIG_MCORE2=y and
> CONFIG_GENERIC_CPU=y, all instructions in getname_flags() are the same,
> but there are some changes in the instruction ordering.
> 
> Any ideas what's going wrong here...?
> Something wrong in the dwarf data?

Hmm, I guess gcc's dwarf generator gets some effects from the optimizer.
Maybe since the optimizer reordering the insturction, the dwarf generator
might lose the line statement information. For example, if instructions
from different lines are mixed, it is hard to say "this is the begining
of a line".

> 
> In 4.19.y it's enough to revert this patch ("perf probe: Skip end-of-
> sequence and non statement lines") to fix this (assuming it's bug...), but
> in v5.5-rc5 it's not enough (switching to v5.4 perf fixed it).

I think perf test should be fixed to use more stable lines.
(But I'm not sure why it uses this line...)

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>

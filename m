Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96384C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6672B206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583518229;
	bh=0YlfMj9B0kSnBGQccG/U0TuPPJY1j/6k2BUYIC6jeOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Pg8pMHjDz9sAUlUqu2K+PYNiAd+D7fn3BevrbUxrXq8Ve93ZVJBPZzCzeijGlBJES
	 bAclGe9cdAeZVuROU2xkGBO36sdWbtD1B8GX4X3YS4RLT9uj3r/jc346r0OmPjUZ1Y
	 DdhnihVHQd0CNLR8YZH/+LV9CzYNth5X80L/GKN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCFSK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:10:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgCFSK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 13:10:27 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F14E02067C;
        Fri,  6 Mar 2020 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583518227;
        bh=0YlfMj9B0kSnBGQccG/U0TuPPJY1j/6k2BUYIC6jeOM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jXDqVEljUPOoPOFVqF2HxQcbpLXUn6fpEtM8TtPcfNrWzh+6nA0iYaQEFrGdTwKA4
         Ypto6zvgeLSKMODnhZ25ClUJB03/VR05Wf64knP6RcS7f4q7eBUBGY2VmSuu/N/BGI
         uBHSbXZXXpn14GLJq4Eo9uUpD7HOBm1hx6h+8ymY=
Date:   Sat, 7 Mar 2020 03:10:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [BUGFIX PATCH] tools: Let O= makes handle a relative path with
 -C option
Message-Id: <20200307031021.4e25253e7ff4aeb14b8a1095@kernel.org>
In-Reply-To: <69916e54-f555-191b-a9b1-8e7bc1043002@infradead.org>
References: <9e7beb31-b41f-9e95-c92b-1829e420af77@infradead.org>
        <158338818292.25448.7161196505598269976.stgit@devnote2>
        <CAMuHMdXSNwPwxOTDxK09LKTyOwL=LqTH6+HZRd=RY4P5VHg5Ew@mail.gmail.com>
        <20200307000712.62c32a04c794b9a12e2342bb@kernel.org>
        <69916e54-f555-191b-a9b1-8e7bc1043002@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Mar 2020 08:26:43 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 3/6/20 7:07 AM, Masami Hiramatsu wrote:
> > Thanks Geert,
> > 
> > So Randy, what you will get if you add "echo $(PWD)" instead of "cd $(PWD)" ?
> > Is that still empty or shows the tools/bootconfig directory?
> > 
> > Thanks,
> 
> OK, in these lines:
> +       dummy := $(if $(shell cd $(PWD); test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
> +       ABSOLUTE_O := $(shell cd $(PWD); cd $(O) ; pwd)
> 
> I changed both "cd $(PWD)" to "echo $(PWD)" and did
> $ make O=BUILD -C tools/bootconfig/
> 
> and this is the build log:
> 
> make: Entering directory '/home/rdunlap/lnx/next/linux-next-20200306/tools/bootconfig'
> cc ../../lib/bootconfig.c main.c -Wall -g -I./include -o bootconfig
> make: Leaving directory '/home/rdunlap/lnx/next/linux-next-20200306/tools/bootconfig'
> 
> 
> Does that help?

Hmm, did you apply "[PATCH 1/2] bootconfig: Support O=<builddir> option" too?

Also, I found this is not enough for perf. perf does more tricky thing in its Makefile.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>

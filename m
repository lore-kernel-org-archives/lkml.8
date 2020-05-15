Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE84EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D575120657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgEOSKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgEOSKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:10:11 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A1FC061A0C;
        Fri, 15 May 2020 11:10:11 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A0FC572D;
        Fri, 15 May 2020 18:10:09 +0000 (UTC)
Date:   Fri, 15 May 2020 12:10:08 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Xu <peterx@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org
Subject: Re: [PATCH 11/14] docs: move other kAPI documents to core-api
Message-ID: <20200515121008.4debe669@lwn.net>
In-Reply-To: <70cca102282ccd36b107487c60346f414011c684.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
        <70cca102282ccd36b107487c60346f414011c684.1588345503.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 May 2020 17:37:55 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There are a number of random documents that seem to be
> describing some aspects of the core-api. Move them to such
> directory, adding them at the core-api/index.rst file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/admin-guide/sysctl/vm.rst                     | 2 +-
>  Documentation/core-api/index.rst                            | 6 ++++++
>  Documentation/{mailbox.txt => core-api/mailbox.rst}         | 0
>  Documentation/{nommu-mmap.txt => core-api/nommu-mmap.rst}   | 0
>  .../{this_cpu_ops.txt => core-api/this_cpu_ops.rst}         | 0
>  .../unaligned-memory-access.rst}                            | 0
>  Documentation/gpu/drm-mm.rst                                | 2 +-
>  arch/Kconfig                                                | 2 +-
>  init/Kconfig                                                | 2 +-
>  mm/Kconfig                                                  | 2 +-
>  mm/nommu.c                                                  | 2 +-
>  11 files changed, 12 insertions(+), 6 deletions(-)
>  rename Documentation/{mailbox.txt => core-api/mailbox.rst} (100%)
>  rename Documentation/{nommu-mmap.txt => core-api/nommu-mmap.rst} (100%)
>  rename Documentation/{this_cpu_ops.txt => core-api/this_cpu_ops.rst} (100%)
>  rename Documentation/{unaligned-memory-access.txt => core-api/unaligned-memory-access.rst} (100%)

This one doesn't apply for me.  Beyond that, I'm not entirely convinced
about a couple of the moves...

 - mailbox.txt seems like driver-api stuff to me?
 - nommu-mmap.txt is mostly (though not completely) about the semantic of
   mmap() options as seen by user space, so perhaps belongs in that
   manual...?

Thanks,

jon

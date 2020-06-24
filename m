Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D54DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 253F920706
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404280AbgFXPhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:37:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:44168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404137AbgFXPhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:37:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7799AC40;
        Wed, 24 Jun 2020 15:37:13 +0000 (UTC)
Date:   Wed, 24 Jun 2020 17:37:13 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Matt Helsley <mhelsley@vmware.com>
cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v5 01/51] objtool: Factor out reasons to build
 objtool
In-Reply-To: <6ac0671bef706812b1751a7a04d1854e9586e890.1592510545.git.mhelsley@vmware.com>
Message-ID: <alpine.LSU.2.21.2006241734560.24656@pobox.suse.cz>
References: <cover.1592510545.git.mhelsley@vmware.com> <6ac0671bef706812b1751a7a04d1854e9586e890.1592510545.git.mhelsley@vmware.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a nice improvement.

> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index 7770edcda3a0..aa0c6d3d2d46 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  include ../scripts/Makefile.include
>  include ../scripts/Makefile.arch
> +include $(OUTPUT)/../../include/config/auto.conf
>  
>  # always use the host compiler
>  ifneq ($(LLVM),)
> @@ -47,8 +48,8 @@ CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
>  
>  AWK = awk
>  
> -SUBCMD_CHECK := n
> -SUBCMD_ORC := n
> +SUBCMD_CHECK := $(CONFIG_OBJTOOL_SUBCMD_CHECK)
> +SUBCMD_ORC := $(CONFIG_OBJTOOL_SUBCMD_ORC)
>  
>  ifeq ($(SRCARCH),x86)
>  	SUBCMD_CHECK := y

I guess you can remove ifeq for x86 in this patch, right? You do it later 
in 3/51, but it seems to belong here.

Miroslav

Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91535C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CFE7208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgIKKnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 06:43:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:49292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgIKKn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:43:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93D96B314;
        Fri, 11 Sep 2020 10:43:40 +0000 (UTC)
Date:   Fri, 11 Sep 2020 12:43:24 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Julien Thierry <jthierry@redhat.com>
cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, raphael.gault@arm.com,
        benh@kernel.crashing.org
Subject: Re: [PATCH v3 00/10] Make check implementation arch agnostic
In-Reply-To: <20200904153028.32676-1-jthierry@redhat.com>
Message-ID: <alpine.LSU.2.21.2009111242160.28305@pobox.suse.cz>
References: <20200904153028.32676-1-jthierry@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020, Julien Thierry wrote:

> Hi,
> 
> The current implementation of the check subcommand has various x86 bits
> here and there. In order to prepare objtool to provide check for other
> architectures, add some abstraction over the x86 specific bits, relying
> on objtool arch specific code to provide some necessary operations.
> 
> This is part of the effort to implement check for arm64, initiated [1]
> by Raphael. The series is based on top of the separation of check & orc
> subcommands series[2].
> 
> I've push both series base on top of tip/objtool/core at [3].
> 
> - The first two patches make it simpler for new arches to provide their
> list of kernel headers, without worrying about modifications in the x86
> headers.
> - Patch 3 Moves arch specific macros to more suitable location
> - Patches 4 and 5 add abstraction to handle alternatives
> - Patch 6 adds abstraction to handle jump table
> - Patches 7-10 makes unwind hint definitions shared across architectures
> 
> Changes since v2 [4]:
> - Rebased on v5.9-rc1
> - Under tools/objtool/arch/x86/, rename arch_special.c to special.c
> - Rename include/linux/frame.h to inclide/linux/objtool.h
> - Share unwind hint types across architectures
> 
> [1] https://lkml.org/lkml/2019/8/16/400
> [2] https://lkml.org/lkml/2020/6/4/675
> [3] https://github.com/julien-thierry/linux/tree/arch-independent-check
> [4] https://lkml.org/lkml/2020/7/30/424

Hi,

Josh merged the patch set already, but FWIW

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

for the new changes (patches 7, 9 and 10).

Miroslav

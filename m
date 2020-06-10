Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C6FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDEA62072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgFJNUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:20:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:39188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgFJNUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:20:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EDB40B042;
        Wed, 10 Jun 2020 13:20:50 +0000 (UTC)
Date:   Wed, 10 Jun 2020 15:20:46 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Julien Thierry <jthierry@redhat.com>
cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, raphael.gault@arm.com
Subject: Re: [PATCH 0/7] Make check implementation arch agnostic
In-Reply-To: <20200608152754.2483-1-jthierry@redhat.com>
Message-ID: <alpine.LSU.2.21.2006101520150.26666@pobox.suse.cz>
References: <20200608152754.2483-1-jthierry@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020, Julien Thierry wrote:

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
> - Patch 7 abstracts the use of unwind hints. Adding it as RFC as I'm sure
>   there's room for improvement.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

for patches 1-6.

M

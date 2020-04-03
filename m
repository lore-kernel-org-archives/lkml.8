Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A890C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1927520B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390476AbgDCJAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:00:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:59082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgDCJAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:00:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7FAA1B001;
        Fri,  3 Apr 2020 09:00:17 +0000 (UTC)
Date:   Fri, 3 Apr 2020 11:00:17 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>
Subject: Re: [PATCH 0/5] objtool fixes
In-Reply-To: <cover.1585761021.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.21.2004031059540.25955@pobox.suse.cz>
References: <cover.1585761021.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020, Josh Poimboeuf wrote:

> Some objtool fixes related to CONFIG_UBSAN_TRAP, Clang assembler, and
> more...
> 
> Josh Poimboeuf (5):
>   objtool: Fix CONFIG_UBSAN_TRAP unreachable warnings
>   objtool: Support Clang non-section symbols in ORC dump
>   objtool: Support Clang non-section symbols in ORC generation
>   objtool: Fix switch table detection in .text.unlikely
>   objtool: Make BP scratch register warning more robust
> 
>  tools/objtool/check.c    | 26 ++++++++++++++++--------
>  tools/objtool/orc_dump.c | 44 ++++++++++++++++++++++++----------------
>  tools/objtool/orc_gen.c  | 33 +++++++++++++++++++++++-------
>  3 files changed, 71 insertions(+), 32 deletions(-)

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M

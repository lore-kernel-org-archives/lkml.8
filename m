Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FC4C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE1420772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCYMLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:11:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:53894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgCYMLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:11:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D8D7CAC37;
        Wed, 25 Mar 2020 12:11:38 +0000 (UTC)
Date:   Wed, 25 Mar 2020 13:11:38 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        brgerst@gmail.com
Subject: Re: [PATCH v3 15/26] objtool: Delete cleanup()
In-Reply-To: <20200324160924.800720170@infradead.org>
Message-ID: <alpine.LSU.2.21.2003251311150.21800@pobox.suse.cz>
References: <20200324153113.098167666@infradead.org> <20200324160924.800720170@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020, Peter Zijlstra wrote:

> Perf shows we spend a measurable amount of time spend cleaning up
> right before we exit anyway. Avoid the needsless work and just
> terminate.
> 
> This reduces objtool on vmlinux.o runtime from 5.4s to 4.8s
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M

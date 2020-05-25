Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75ECC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02B320723
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390051AbgEYLH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:07:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:42386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389897AbgEYLH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:07:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 93A3BAD45;
        Mon, 25 May 2020 11:07:30 +0000 (UTC)
Date:   Mon, 25 May 2020 13:07:27 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for May 21 (objtool warnings)
In-Reply-To: <alpine.LSU.2.21.2005251101030.24984@pobox.suse.cz>
Message-ID: <alpine.LSU.2.21.2005251303430.24984@pobox.suse.cz>
References: <20200522001209.07c19400@canb.auug.org.au> <22332d9b-5e9f-5474-adac-9b3e39861aee@infradead.org> <alpine.LSU.2.21.2005251101030.24984@pobox.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll try to find out which optimization does this, because it is a 
> slightly different scenario than hiding __noreturn from the callees. 
> Probably -fno-ipa-pure-const again.

And it is indeed -fno-ipa-pure-const again.

Miroslav

Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E121C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417602078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgIBNyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:54:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:40674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgIBNqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:46:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6256AB60A;
        Wed,  2 Sep 2020 13:46:30 +0000 (UTC)
Date:   Wed, 2 Sep 2020 15:46:29 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] samples/livepatch: Add README.rst disclaimer
In-Reply-To: <20200721161407.26806-3-joe.lawrence@redhat.com>
Message-ID: <alpine.LSU.2.21.2009021546110.23200@pobox.suse.cz>
References: <20200721161407.26806-1-joe.lawrence@redhat.com> <20200721161407.26806-3-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020, Joe Lawrence wrote:

> The livepatch samples aren't very careful with respect to compiler
> IPA-optimization of target kernel functions.
> 
> Add a quick disclaimer and pointer to the compiler-considerations.rst
> file to warn readers.
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M

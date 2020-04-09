Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2340EC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC93020753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgDIQzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:55:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:41166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgDIQzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:55:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DA561AB7F;
        Thu,  9 Apr 2020 16:55:21 +0000 (UTC)
Date:   Thu, 9 Apr 2020 18:55:21 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jessica Yu <jeyu@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org
Subject: Re: [PATCH] module: Harden STRICT_MODULE_RWX
In-Reply-To: <alpine.LSU.2.21.2004070939041.1817@pobox.suse.cz>
Message-ID: <alpine.LSU.2.21.2004091854280.31635@pobox.suse.cz>
References: <20200403163716.GV20730@hirez.programming.kicks-ass.net> <20200403165631.hrxxm3pnzqa4vxln@treble> <alpine.LSU.2.21.2004061146590.26870@pobox.suse.cz> <20200406104615.GA9629@linux-8ccs> <20200406112732.GK20730@hirez.programming.kicks-ass.net>
 <alpine.LSU.2.21.2004070939041.1817@pobox.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I am still wondering if there are modules out there with sections flags 
> combination which would cause the same problem with layout_sections() and 
> move_module() logic I described earlier. But that it is a separate issue.

And of course I misread the condition in layout_sections() and all should 
be fine. Oh well...

Miroslav

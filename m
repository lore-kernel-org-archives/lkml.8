Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91111C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595AA20665
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgIAMeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:34:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:40976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbgIAMbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:31:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD17FAEF8;
        Tue,  1 Sep 2020 12:31:14 +0000 (UTC)
Date:   Tue, 1 Sep 2020 14:31:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        John Ogness <john.ogness@linutronix.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2][next] update gdb scripts for lockless printk
 ringbuffer
Message-ID: <20200901123113.GO4928@alley>
References: <20200814212525.6118-1-john.ogness@linutronix.de>
 <20200821080813.GM4353@alley>
 <d81e8b0d-fa7f-1da1-671f-0541b94ad349@siemens.com>
 <a5f4c178-9b3c-6ccd-9ea1-24d8fdc13273@kernel.org>
 <20200825123542.GU4353@alley>
 <20200825171756.830d5895eb40d2dded2803ae@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825171756.830d5895eb40d2dded2803ae@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-08-25 17:17:56, Andrew Morton wrote:
> On Tue, 25 Aug 2020 14:35:42 +0200 Petr Mladek <pmladek@suse.com> wrote:
> 
> > Andrew, would you mind when I take the three gdb/lockless-printk
> > related changes via printk tree to avoid synchronization problems?
> 
> No probs.  If such patches turn up in linux-next I just drop my copy.
> After checking that the patches fully match...

I have just pushed the two patches into printk/linux.git, branch
printk-rework.

Andrew's typo fix has been squashed into the 2nd patch.

Best Regards,
Petr

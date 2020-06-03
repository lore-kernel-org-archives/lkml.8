Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2103FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C2B2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgFCKQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:16:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:53970 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCKQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:16:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 732DCAC2C;
        Wed,  3 Jun 2020 10:16:33 +0000 (UTC)
Date:   Wed, 3 Jun 2020 12:16:28 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] crash: add VMCOREINFO macro for anonymous structs
Message-ID: <20200603101627.GE14855@linux-b0ei>
References: <20200501094010.17694-1-john.ogness@linutronix.de>
 <20200501094010.17694-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501094010.17694-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-05-01 11:46:08, John Ogness wrote:
> Some structs are not named and are only available via their typedef.
> Add a VMCOREINFO macro to export field offsets for such structs.

Honestly, I did not get the meaning until I looked at the sample
usage added by the 2nd patch.

The term "anonymous structures" has another meaning in C++. It is
used for structures without any name that are defined inside a named
structure.

Something like this might be better:

"crash: Add VMCOREINFO macro to define offset in a struct declared by typedef

 The existing macro VMCOREINFO_OFFSET() can't be used for structures
 declared via typedef because "struct" is not part of type definition.

 Create another macro for this purpose."


Anyway, thanks a lot for the prototype of crash implementation.
I am happy that it is possible.

Best Regards,
Petr

PS: It might take few more days until I send some feedback for the
other patches. They are a bit more complex ;-)

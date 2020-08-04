Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FD7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928312070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgHDIeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:34:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:39656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgHDIeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:34:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F3E1ABF4;
        Tue,  4 Aug 2020 08:34:45 +0000 (UTC)
Date:   Tue, 4 Aug 2020 10:34:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Replace hidden BUILD_BUG_ON() with
 static_assert()
Message-ID: <20200804083428.GA24529@alley>
References: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
 <20200801044620.GA683@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801044620.GA683@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-08-01 13:46:20, Sergey Senozhatsky wrote:
> On (20/07/31 21:08), Andy Shevchenko wrote:
> > First of all, there is no compile time check for the SMALL
> > to be ' ' (0x20, i.e. space). Second, for ZEROPAD the check
> > is hidden in the code.
> > 
> > For better maintenance replace BUILD_BUG_ON() with static_assert()
> > for ZEROPAD and move it closer to the definition. While at it,
> > introduce check for SMALL.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Just for record, for the entire series:

Reviewed-by: Petr Mladek <pmladek@suse.com>

> The series was applied to for-5.9

There is no need to rebase the git repository. I just want to inform you
that the changes look fine to me.

Thanks a lot for the fixes and their handling.

Best Regards,
Petr

Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BC3C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15FD206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgBKLcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:32:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:57844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgBKLcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:32:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1CE49B437;
        Tue, 11 Feb 2020 11:32:14 +0000 (UTC)
Date:   Tue, 11 Feb 2020 12:32:13 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5 1/7] console: Don't perform test for CON_BRL flag
Message-ID: <20200211113213.eaftwrq3tbt3rjwo@pathway.suse.cz>
References: <20200203133130.11591-1-andriy.shevchenko@linux.intel.com>
 <20200204013426.GB41358@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204013426.GB41358@google.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-02-04 10:34:26, Sergey Senozhatsky wrote:
> On (20/02/03 15:31), Andy Shevchenko wrote:
> > 
> > We don't call braille_register_console() without CON_BRL flag set.
> > And the _braille_unregister_console() already tests for console to have
> > CON_BRL flag. No need to repeat this in braille_unregister_console().
> > 
> > Drop the repetitive checks from Braille console driver.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Looks good to me overall
> 
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

The entire patchset has been commited into printk.git,
branch for-5.7-console-exit

Best Regards,
Petr

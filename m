Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D17DC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11E821D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgBRTuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:50:17 -0500
Received: from tartarus.angband.pl ([54.37.238.230]:45242 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:50:17 -0500
X-Greylist: delayed 1110 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2020 14:50:16 EST
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1j48am-0007Xq-OO; Tue, 18 Feb 2020 20:31:36 +0100
Date:   Tue, 18 Feb 2020 20:31:36 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH] vsprintf: don't obfuscate NULL and error pointers
Message-ID: <20200218193136.GA22499@angband.pl>
References: <20200217222803.6723-1-idryomov@gmail.com>
 <202002171546.A291F23F12@keescook>
 <CAOi1vP-2uAD83Vi=Eebu_GPzq5DUt+z9zogA7BNGF1B1jUgAVw@mail.gmail.com>
 <CAHk-=whj0vMcdVPC0=9aAsN2-tsCyFKF4beb2gohFeFK_Z-Y9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whj0vMcdVPC0=9aAsN2-tsCyFKF4beb2gohFeFK_Z-Y9g@mail.gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 10:49:30AM -0800, Linus Torvalds wrote:
> On Mon, Feb 17, 2020 at 4:07 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> >
> > I'm not sure what you mean by efault string.  Are you referring to what
> > %pe is doing?  If so, no -- I would keep %p and %pe separate.
> 
> Right.
> 
> But bringing up %pe makes me realize that we do odd things for NULL
> for that. We print errors in a nice legible form, but we show NULL as
> a zero value, I think.
> 
> So maybe %pe should show NULL as "(null)"? Or even as just "0" to go
> with the error names that just look like the integer error syntax (eg
> "-EINVAL")

"(null)" stands for a dereference of a null pointer rather than for printing
the pointer itself.  This is a convention copied from glibc's printf("%s").
Either "0" or "NULL" (or "∅" if you allow cp437-subset Unicode ☺ ) wouldn't
cause such confusion.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ A MAP07 (Dead Simple) raspberry tincture recipe: 0.5l 95% alcohol,
⣾⠁⢠⠒⠀⣿⡁ 1kg raspberries, 0.4kg sugar; put into a big jar for 1 month.
⢿⡄⠘⠷⠚⠋⠀ Filter out and throw away the fruits (can dump them into a cake,
⠈⠳⣄⠀⠀⠀⠀ etc), let the drink age at least 3-6 months.

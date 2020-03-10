Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D38C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 01:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C73424655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 01:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCJBGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 21:06:55 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:44568 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgCJBGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 21:06:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 9DE7380307C5;
        Tue, 10 Mar 2020 01:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7s97QYij5BRW; Tue, 10 Mar 2020 04:06:53 +0300 (MSK)
Date:   Tue, 10 Mar 2020 04:06:03 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jiri Slaby <jslaby@suse.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/22] tty: mips_ejtag_fdc: Mark expected switch
 fall-through
References: <20200306124705.6595-1-Sergey.Semin@baikalelectronics.ru>
 <20200306124913.151A68030792@mail.baikalelectronics.ru>
 <20200309161243.D5D5180307C7@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200309161243.D5D5180307C7@mail.baikalelectronics.ru>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200310010653.9DE7380307C5@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 05:12:40PM +0100, Jiri Slaby wrote:
> On 06. 03. 20, 13:47, Sergey.Semin@baikalelectronics.ru wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > Mark mips_ejtag_fdc_encode() methods switch-case-4 as expecting to
> > fall through.
> > 
> > This patch fixes the following warning:
> > 
> > drivers/tty/mips_ejtag_fdc.c: In function ‘mips_ejtag_fdc_encode’:
> > drivers/tty/mips_ejtag_fdc.c:245:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    word.word &= 0x00ffffff;
> >    ~~~~~~~~~~^~~~~~~~~~~~~
> > drivers/tty/mips_ejtag_fdc.c:246:2: note: here
> >   case 3:
> >   ^~~~
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > ---
> >  drivers/tty/mips_ejtag_fdc.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
> > index 620d8488b83e..21e76a2ec182 100644
> > --- a/drivers/tty/mips_ejtag_fdc.c
> > +++ b/drivers/tty/mips_ejtag_fdc.c
> > @@ -243,6 +243,7 @@ static struct fdc_word mips_ejtag_fdc_encode(const char **ptrs,
> >  		/* Fall back to a 3 byte encoding */
> >  		word.bytes = 3;
> >  		word.word &= 0x00ffffff;
> > +		/* Fall through */
> 
> We now have "fallthrough;", so I believe you should use that instead of
> comments.
> 

Hello Jiri,

Thanks for the comment. I didn't know about that new macro. Since Greg
already pulled this patch in his tty-next branch, I won't send an
update in the next patchset revision. But I'll certainly remember that
there is a specific macro to fix the fallthrough warning in the kernel
and will use it next time I find the same problem someplace else.

Regards,
-Sergey

> thanks,
> -- 
> js
> suse labs

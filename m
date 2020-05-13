Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D8EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5239C205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgEMVWR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgEMVWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:22:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A72C05BD0B
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:22:08 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYypH-0004UG-Hd; Wed, 13 May 2020 23:22:03 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id EC0EE100605; Wed, 13 May 2020 23:22:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Xianting Tian <tian.xianting@h3c.com>, john.stultz@linaro.org,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, tian.xianting@h3c.com
Subject: Re: [PATCH] timers: use set_current_state macro
In-Reply-To: <20200508020222.15791-1-tian.xianting@h3c.com>
References: <20200508020222.15791-1-tian.xianting@h3c.com>
Date:   Wed, 13 May 2020 23:22:02 +0200
Message-ID: <875zcz1qf9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xianting,

Xianting Tian <tian.xianting@h3c.com> writes:

thanks for your patch.

Can you please fix your mail client to have proper mail headers? It
provides:

  Content-Type: text/plain
  Content-Transfer-Encoding: quoted-printable

but it fails to provide the charset information. That causes the footer
to become unreadable garbage not only in my mail reader. See:

  https://lore.kernel.org/lkml/20200508020222.15791-1-tian.xianting@h3c.com/

What's worse is that is causes my patch handling scripts to decode the
mail body correctly. And I'm not really inclined to figure out how to
handle this case.

> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1885,7 +1885,7 @@ signed long __sched schedule_timeout(signed long timeout)
>                         printk(KERN_ERR "schedule_timeout: wrong timeout "
>                                 "value %lx\n", timeout);
>                         dump_stack();
> -                       current->state = TASK_RUNNING;
> +                       set_current_state(TASK_RUNNING);

That's not the same and adds a barrier which is not needed.

Not a big problem in that particular error handling code path, but in
general you really have to look whether your replacement is resulting in
the same code.

If not then you need to make an argument in the changelog why you are
replacing existing code with something which is not fully equivalent.

For this particular case, please check the implementation and read the
documentation of set_current_state() in include/linux/sched.h.

> -------------------------------------------------------------------------------------------------------------------------------------
> ±¾ÓÊ¼þ¼°Æä¸½¼þº¬ÓÐÐÂ»ªÈý¼¯ÍÅµÄ±£ÃÜÐÅÏ¢£¬½öÏÞÓÚ·¢ËÍ¸øÉÏÃæµØÖ·ÖÐÁÐ³ö
> µÄ¸öÈË»òÈº×é¡£½ûÖ¹ÈÎºÎÆäËûÈËÒÔÈÎºÎÐÎÊ½Ê¹ÓÃ£¨°üÀ¨µ«²»ÏÞÓÚÈ«²¿»ò²¿·ÖµØÐ¹Â¶¡¢¸´ÖÆ¡¢
> »òÉ¢·¢£©±¾ÓÊ¼þÖÐµÄÐÅÏ¢¡£Èç¹ûÄú´íÊÕÁË±¾ÓÊ¼þ£¬ÇëÄúÁ¢¼´µç»°»òÓÊ¼þÍ¨Öª·¢¼þÈË²¢É¾³ý±¾
> ÓÊ¼þ£¡

This is the resulting garbage. Not that I could decipher the chinese
characters which should be here instead, but at least they would look
way nicer. But see below:

> This e-mail and its attachments contain confidential information from New H3C, which is
> intended only for the person or entity whose address is listed above. Any use of the
> information contained herein in any way (including, but not limited to, total or partial
> disclosure, reproduction, or dissemination) by persons other than the intended
> recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
> by phone or email immediately and delete it!

Can you please remove this disclaimer completely (which avoids the
garbage issue as well) ?

It does not make any sense if you send mail to a public mailing list:

 1) If you send mail to a public list which is archived in public then
    the information can't be confidential and restricted to a particular
    audience. It can be accessed by everyone on this planet who has
    access to the internet.

 2) If you really send confidental information accidentally then there
    is no way to delete it. It's out there in the public and in archives
    and you can't call it back.

Thanks,

        tglx
    


Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993D5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 10:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B7A2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 10:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OZO9eCCz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PPxvtWc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgHJKfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 06:35:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50350 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgHJKfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 06:35:08 -0400
Date:   Mon, 10 Aug 2020 12:35:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597055706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OjjK56vi+OiP5R8kvP7R0V1sr3ZxerDdKSGBt8tWSbQ=;
        b=OZO9eCCzf/3FQy2RL+5yiI9OGswKwcIhDTU8S2Ozq/N2JddZQYpKPBJk9frCsslIWY9a3x
        RQd5Nsobt+Wi8DuFCgXteXUBNX5EwquY9WL1eyHEmhTWxI8ByIxt/hGVNH8nh4l8c2mGVv
        XU8bcwZDUd7crDKUFtUnE8cExP08f50PVKWu5SHSpcuUS8SZJKCBE2FrZ9noktnTvrc4zp
        S8yF10T4rwXnJFEd8ahpRAFuKGylLNlm/MkhxSfmGUl4i2xKz0KTASQCvFxB/1p4+aNE58
        4u7HCWu7tJjfXzJ5eueKNxyYG/sxsWJVMaB2XdS9Ve9Q3rV+hOsEJsQZ/XU0EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597055706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OjjK56vi+OiP5R8kvP7R0V1sr3ZxerDdKSGBt8tWSbQ=;
        b=PPxvtWc+bZcQfLzOZptxtrftfrk8+YBuhoUU0Wte37IcC0x5NTrK40eW/1Pjn4+ftQYMo3
        1lss+rc6rVql0ABg==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, mingo@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
        will@kernel.org
Subject: Re: [PATCH] Revert "seqlock: lockdep assert non-preemptibility on
 seqcount_t write"
Message-ID: <20200810103508.GA142779@lx-t490>
References: <20200810085954.GA1591892@kroah.com>
 <20200810095428.2602276-1-a.darwish@linutronix.de>
 <20200810100502.GA2406768@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810100502.GA2406768@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 12:05:02PM +0200, Greg KH wrote:
> On Mon, Aug 10, 2020 at 11:54:28AM +0200, Ahmed S. Darwish wrote:
> > This reverts commit 859247d39fb008ea812e8f0c398a58a20c12899e.
> >
> > Current implementation of lockdep_assert_preemption_disabled() uses
> > per-CPU variables, which was done to untangle the existing
> > seqlock.h<=>sched.h 'current->' task_struct circular dependency.
> >
> > Using per-CPU variables did not fully untangle the dependency for
> > various non-x86 architectures though, resulting in multiple broken
> > builds. For the affected architectures, raw_smp_processor_id() led
> > back to 'current->', thus having the original seqlock.h<=>sched.h
> > dependency in full-effect.
> >
> > For now, revert adding lockdep_assert_preemption_disabled() to
> > seqlock.h.
> >
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Link: https://lkml.kernel.org/r/20200808232122.GA176509@roeck-us.net
> > Link: https://lkml.kernel.org/r/20200810085954.GA1591892@kroah.com
> > References: Commit a21ee6055c30 ("lockdep: Change hardirq{s_enabled,_context} to per-cpu variables")
> > Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Even after this, there are still some build errors on arm32, but I don't
> think they are due to this change:
>
> 	ERROR: modpost: "__aeabi_uldivmod" [drivers/net/ethernet/sfc/sfc.ko] undefined!
> 	ERROR: modpost: "__bad_udelay" [drivers/net/ethernet/aquantia/atlantic/atlantic.ko] undefined!
>

Yes, they are unrelated to the seqlock.h changes.

(I've locally reverted the whole series just to be sure, and the same
 linking errors as above were still there for an ARM allyesconfig.)

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH

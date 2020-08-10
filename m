Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225FEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 10:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F034520729
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 10:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597053893;
	bh=mvCtbaQWqQwxaFpcHbRDygRoOjwTGaYJbnOoivqrt3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WNDCJH1thbR5s6BeF6KCw71IOjs0DoIQTn59KnbTIClCPT2NxoCcgFoYEBNx2Fode
	 cgq1MNz/sEcL6LZp49Om+T57BMAWjfAK26RLDF4aK+kg9WpgRYcC3HTvVCPBBYu9qr
	 xvYd+drGTDIk54TQgk6TDl/D0va3qQcg1+cLYHqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHJKEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 06:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgHJKEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 06:04:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987E220709;
        Mon, 10 Aug 2020 10:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597053891;
        bh=mvCtbaQWqQwxaFpcHbRDygRoOjwTGaYJbnOoivqrt3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSaka4gxJb2Zgqr8ZCaGdaJ/fDgmdCQmQdBD+FpBRnvznQSPc1hvnQAcdG9z8E4sR
         Z+r+NwV4I6nbaqCmCs94L02L/dyqrEQsgZJBUOoZ9mu9NaGC8uyWceNr0qefGA2QVI
         j9cAprsqDFUUUY8+a3Jg4P9pPxWaDSJ3O64w2ug4=
Date:   Mon, 10 Aug 2020 12:05:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, mingo@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
        will@kernel.org
Subject: Re: [PATCH] Revert "seqlock: lockdep assert non-preemptibility on
 seqcount_t write"
Message-ID: <20200810100502.GA2406768@kroah.com>
References: <20200810085954.GA1591892@kroah.com>
 <20200810095428.2602276-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810095428.2602276-1-a.darwish@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:54:28AM +0200, Ahmed S. Darwish wrote:
> This reverts commit 859247d39fb008ea812e8f0c398a58a20c12899e.
> 
> Current implementation of lockdep_assert_preemption_disabled() uses
> per-CPU variables, which was done to untangle the existing
> seqlock.h<=>sched.h 'current->' task_struct circular dependency.
> 
> Using per-CPU variables did not fully untangle the dependency for
> various non-x86 architectures though, resulting in multiple broken
> builds. For the affected architectures, raw_smp_processor_id() led
> back to 'current->', thus having the original seqlock.h<=>sched.h
> dependency in full-effect.
> 
> For now, revert adding lockdep_assert_preemption_disabled() to
> seqlock.h.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lkml.kernel.org/r/20200808232122.GA176509@roeck-us.net
> Link: https://lkml.kernel.org/r/20200810085954.GA1591892@kroah.com
> References: Commit a21ee6055c30 ("lockdep: Change hardirq{s_enabled,_context} to per-cpu variables")
> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Even after this, there are still some build errors on arm32, but I don't
think they are due to this change:

	ERROR: modpost: "__aeabi_uldivmod" [drivers/net/ethernet/sfc/sfc.ko] undefined!
	ERROR: modpost: "__bad_udelay" [drivers/net/ethernet/aquantia/atlantic/atlantic.ko] undefined!

thanks,

greg k-h

Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60025C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A79206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duCawprx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgBCX5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 18:57:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42109 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726834AbgBCX5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580774268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=377KzugWtdEB1RiDk7iefCk+Qa+LIHv5m9/4EkwomLQ=;
        b=duCawprxM30AbMNVHZ3Sx1vZJyJJ+aoQ7bHmnPL65879k2j33FdHFEy7XJVwkLsw1dRBkx
        EuEO3XXbE28ObsdxoSn/d7qYDvvTkuKBQZL9OspbNdgXkI0PLNfE3HkXv+6GgzRMjRc7pM
        iW6E+4juy+XQzNq5afP8hokRmiq4hKE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-ehzYx0NTPqOsuzfdw4nB7A-1; Mon, 03 Feb 2020 18:57:46 -0500
X-MC-Unique: ehzYx0NTPqOsuzfdw4nB7A-1
Received: by mail-qv1-f72.google.com with SMTP id v3so10621112qvm.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 15:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=377KzugWtdEB1RiDk7iefCk+Qa+LIHv5m9/4EkwomLQ=;
        b=GtoxdrIDvYWEQBLwfN5FTxoiBvMsXKnsjdsJK74lVGUaoNEx7jZ+oj6ypYdu7HT2lL
         XM6W1YbUVB/uih/BVoNl9K9NNQa8uiTrbPsbExc2zcCDaZCVZktGC15XtjtJoPmyxzGW
         NqB/hCYDD3BX4BJqwIhZbo6uVTgXDPx/+iMLFU35DrX7ibA8onJHP175PisLftO0/kcd
         xecPbBeB0Jo+OKd1FWbxFxq6ikIn8LS5wbCUzxBvRtSngTstjjkkK8mffIQbLFsbql3q
         glYlqLDd2nYRPlV9N2HyTvPaClhWgSkLFE62H4qSlLiDI67QyF4h8pto5JM63jynzPbO
         rwPw==
X-Gm-Message-State: APjAAAVw+UfG+1mAwU3iO4JJWALdm5OMS4OB0Ou/ikHeeGxxEzL862II
        gWRY/jEQxSt9wnN0I/4+SCQ7LVLLBBsn6masU3Snf3YYF5QQoKe7wnjuJFPvO+VLwIg+gZfg9oG
        FWJW3I6lMsBU5tRrwIP/TET+t
X-Received: by 2002:a05:6214:4f2:: with SMTP id cl18mr25491054qvb.89.1580774266436;
        Mon, 03 Feb 2020 15:57:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6N76q16RG6gaA3Ccei9IOEfvL+VW0BlpNSl5MYgnCZ7NxgKf3lkrSb8R3wf0XT5Uq1MHCGA==
X-Received: by 2002:a05:6214:4f2:: with SMTP id cl18mr25491037qvb.89.1580774266111;
        Mon, 03 Feb 2020 15:57:46 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id 13sm10092406qke.85.2020.02.03.15.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 15:57:45 -0800 (PST)
Date:   Mon, 3 Feb 2020 18:57:43 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH V4] sched/isolation: isolate from handling managed
 interrupt
Message-ID: <20200203235743.GH155875@xz-x1>
References: <20200120091625.17912-1-ming.lei@redhat.com>
 <87eevrei7h.fsf@nanos.tec.linutronix.de>
 <20200203192154.GG155875@xz-x1>
 <87a75zz2hl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a75zz2hl.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 11:15:50PM +0000, Thomas Gleixner wrote:
> Peter Xu <peterx@redhat.com> writes:
> > The new "managed_irq" works for us, thanks for both of your work!
> >
> > However I just noticed that this new sub-parameter might break users
> > if applied incorrectly to old kernels, because iiuc "isolcpus="
> > parameter will not apply at all when there's unknown sub-parameters:
> >
> > static int __init housekeeping_isolcpus_setup(char *str)
> > {
> > 	unsigned int flags = 0;
> >
> > 	while (isalpha(*str)) {
> >                 ...
> >                 pr_warn("isolcpus: Error, unknown flag\n");
> >                 return 0;
> >         }
> >         ...
> > }
> >
> > Then the same kernel parameter will break isolcpus= if the user
> > reboots and switches to an older kernel.
> >
> > A solution to this could be that we introduce an isolated parameter
> > for "managed_irq", then on the old kernels only the new parameter will
> > be ignored rather than the whole "isolcpus=" parameter, so nothing
> > will break.
> >
> > I'm not sure whether it's already too late for this, or if there's any
> > better alternative.  Just raise this question up to see whether we
> > still have chance to fix this up.
> 
> No, really. The basic guarantee is that your new kernel is going to work
> fine with the previous command line, but making a guarantee that new
> command line options still work on an old kernel are just creating a
> horrible mess. So if that command line interface was not designed to
> handle unknown arguments in the first place, you better fix that.

Hi, Thomas,

Just to make sure I understand it right: are you suggesting that we
fix up housekeeping_isolcpus_setup() to be able to skip unknown sub
parameters?

Thanks,

-- 
Peter Xu


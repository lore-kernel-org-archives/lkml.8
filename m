Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F02C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BAC21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHzp5XMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgBENeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:34:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34079 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726575AbgBENeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580909655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3tLQu5t6FNKMd1M6ndxO7hl29srWUbYCikoJ3KAg1rY=;
        b=UHzp5XMZDWbzLo3T1U5FpQBdmuISuEqS41I8e1wxAUTGGQc64xs9nu/cKM6lfakRht/KiM
        VbYrXEowvvr2oyYQIKA0u/yYOswYcNeEkBk7CVI9T/SKhX0Ke2OGAhYksGW9WGj+sYOxEn
        EOuaDYW95bSF8brh08t9Z4BHwEg8vtQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-Bg0_Kq_9MDOayMKvm9bjTQ-1; Wed, 05 Feb 2020 08:34:11 -0500
X-MC-Unique: Bg0_Kq_9MDOayMKvm9bjTQ-1
Received: by mail-qt1-f197.google.com with SMTP id c22so1297443qtn.23
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 05:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3tLQu5t6FNKMd1M6ndxO7hl29srWUbYCikoJ3KAg1rY=;
        b=H9R6n9+yZOcN6JsFBVxMHPLQa4kkXh3VEFEmUgGl3p+3lTFf3a0Sg0lwd/0LmjmbU3
         V0EhHnZVUvgs61afAypwqIck+TSb7C+iPwe7IykhdBNOYkvfaiFqRizemLdz1jUqPb9z
         qeVkmgskvK7BpENhRBNxA23MdzZTFdoWeu25PE9q9ShlI4vQIjrdy//RXBfizADh0eXO
         m8elXCmrOp1Mg/PDYJp0MxxCDuMVZnECDFsBLcjJBwo6WJmf/4GmiIVs9qq24krcH/Xb
         fIrhulw2FytVVR7P4X9EV6iyo2w4gMEjbpi+hmhpPt7j4tRCmnQn2jIZ6ZWan4v1JM2F
         AfDg==
X-Gm-Message-State: APjAAAVFz7Lez/RQoTT6gum1i8MaYdVwv3f/BUeN9LOg3MsrLs2Qfw2Z
        XPymcWLWRx42ALd5y36Yt4xtB9i6gFTewW5RfcEoNlBQuzKvv/bg6/Tq9XlImZRPFG4QNjfnURY
        cll6LrafO9e5wcunxeNs7A4gJ
X-Received: by 2002:ac8:460a:: with SMTP id p10mr31641306qtn.98.1580909651386;
        Wed, 05 Feb 2020 05:34:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcjg5MabxsCxWEPpu10LHZ+AsIvtZzwuDx0yBGKLl/1G0DTEWqeKanyPWtBsgwqWwUF2//6A==
X-Received: by 2002:ac8:460a:: with SMTP id p10mr31641284qtn.98.1580909651128;
        Wed, 05 Feb 2020 05:34:11 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id z185sm7515087qkb.116.2020.02.05.05.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 05:34:10 -0800 (PST)
Date:   Wed, 5 Feb 2020 08:34:08 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/isolation: Allow "isolcpus=" to skip unknown
 sub-parameters
Message-ID: <20200205133408.GK155875@xz-x1>
References: <20200204161639.267026-1-peterx@redhat.com>
 <20200205122754.GA28748@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200205122754.GA28748@ming.t460p>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 08:27:54PM +0800, Ming Lei wrote:
> On Tue, Feb 04, 2020 at 11:16:39AM -0500, Peter Xu wrote:
> > The "isolcpus=" parameter allows sub-parameters to exist before the
> > cpulist is specified, and if it sees unknown sub-parameters the whole
> > parameter will be ignored.  This design is incompatible with itself
> > when we add more sub-parameters to "isolcpus=", because the old
> > kernels will not recognize the new "isolcpus=" sub-parameters, then it
> > will invalidate the whole parameter so the CPU isolation will not
> > really take effect if we start to use the new sub-parameters while
> > later we reboot into an old kernel. Instead we will see this when
> > booting the old kernel:
> > 
> >     isolcpus: Error, unknown flag
> > 
> > The better and compatible way is to allow "isolcpus=" to skip unknown
> > sub-parameters, so that even if we add new sub-parameters to it the
> > old kernel will still be able to behave as usual even if with the new
> > sub-parameter is specified.
> > 
> > Ideally this patch should be there when we introduce the first
> > sub-parameter for "isolcpus=", so it's already a bit late.  However
> > late is better than nothing.
> > 
> > CC: Ming Lei <ming.lei@redhat.com>
> > CC: Ingo Molnar <mingo@redhat.com>
> > CC: Peter Zijlstra <peterz@infradead.org>
> > CC: Juri Lelli <juri.lelli@redhat.com>
> > CC: Luiz Capitulino <lcapitulino@redhat.com>
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  kernel/sched/isolation.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index 008d6ac2342b..d5defb667bbc 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -169,8 +169,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
> >  			continue;
> >  		}
> >  
> > -		pr_warn("isolcpus: Error, unknown flag\n");
> > -		return 0;
> > +		str = strchr(str, ',');
> > +		if (str)
> > +			/* Skip unknown sub-parameter */
> > +			str++;
> > +		else
> > +			return 0;
> 
> Looks fine, even though the 'old' kernel has to apply this patch. 

Right, I think this suites for stable.  However I guess there's no way
we can really fix this on all old kernel binaries, which is really a
lesson that we should always design the parameters to be compatible
with the old binaries.

> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks!

-- 
Peter Xu


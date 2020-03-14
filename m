Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BCBC1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015272071B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ne6LZ96u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgCOBzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:55:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54491 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727179AbgCOBzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584237310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=565avK8xJpAxODlaB/JYpjP9wqhY+h6lHR7kwiIqL2I=;
        b=Ne6LZ96uzE9fBXsXrH9+379reHWeO+rSjqoaJgsfkVNKWtT+tMuOxrXrU3Wy6Z9wMnJNsc
        UDwQLOrkkIDYchdGn37ByssPqpPbHh0/zvnHC9E6E06aMuDkPM9heSzkI07yPOKotoMlCX
        49YqZCDgfFsTthKADHE+SqgWFXsCptI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-zu_EdkH8PuS8Q1kmjhAjTA-1; Sat, 14 Mar 2020 19:53:59 -0400
X-MC-Unique: zu_EdkH8PuS8Q1kmjhAjTA-1
Received: by mail-qk1-f197.google.com with SMTP id a21so13069908qkg.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 16:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=565avK8xJpAxODlaB/JYpjP9wqhY+h6lHR7kwiIqL2I=;
        b=DaTbCaFquWbd6KKF9ZPKdynqWdal6aDT7wA6S+GVsq4WkZG6DKKau3M0NxMYFMZz/5
         AVvN2UcA6O+7sWg0Xrd1Hh2mxu5YQHstiyjbl/UPVxgH2N7oSvLX1oprF6yyGsN5CVLf
         lMt0zEgUuQz6SqFNr5jJc/Q73nMg+2KmimSueDuOuXLBLlkU7ghUlD4Pla6d1jRkKrbK
         ZbPeHajPxpIHn0DDeOndXj5dL1HkCiI7pU8VlBJ6IzUu26mc2HI3aM4NC4a9bTtzB2aE
         YjYYKUiE3l66YPXepJ9Q2QiczKJpOo+T4cgJBGxucaBjI2EwdzfbWu2ltYAO8s8JKIcg
         COFw==
X-Gm-Message-State: ANhLgQ23Ag48sSV3lJ3+jJB/0vmE4whjbe7ZKlyxNaGR5OftuR3sONT+
        liYo3HVz6OKh9R1fZpn1CPRqNl1dNWh1TIurq/oq52nvkWq8asm9a/Jx7FakBpIOahLzEYvjop7
        8FShFEoGi2n6vtooyXM1TIpoi
X-Received: by 2002:ac8:1c17:: with SMTP id a23mr19463752qtk.239.1584230038863;
        Sat, 14 Mar 2020 16:53:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vukUzf1dliM8+2cni4jqlg65/XNyAkwtLjGkUnrbxTo4ZpZkaT7Pp3AHAKTy/tWVKdcbCmTew==
X-Received: by 2002:ac8:1c17:: with SMTP id a23mr19463733qtk.239.1584230038493;
        Sat, 14 Mar 2020 16:53:58 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 17sm15872064qkm.105.2020.03.14.16.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 16:53:57 -0700 (PDT)
Date:   Sat, 14 Mar 2020 19:53:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ming Lei <minlei@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] x86/vector: Allow to free vector for managed IRQ
Message-ID: <20200314235356.GD95517@xz-x1>
References: <20200313151908.GA95517@xz-x1>
 <87v9n7erq3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v9n7erq3.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 12:54:12AM +0100, Thomas Gleixner wrote:
> Peter Xu <peterx@redhat.com> writes:
> > On Fri, Mar 13, 2020 at 03:24:08PM +0100, Thomas Gleixner wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> What is this backtrace for? It's completly useless as it merily shows
> >> that the warning triggers. Also even if it'd be useful then it wants to
> >> be trimmed properly.
> >
> > I thought it was a good habit to keep the facts of issues.  Backtrace
> > is one of them so I kept them.  It could, for example, help people who
> > spot the same issue in an old/downstream kernel so when they google or
> > grepping git-log they know the exact issue has been solved by some
> > commit, even without much knowledge on the internals (because they can
> > exactly compare the whole dmesg error).
> 
> This is not really good habit. Changelogs should contain factual
> information which is relevant to understand the problem. Backtraces are
> useful when the callchain leading to a bug/warn/oops _is_ relevant for
> understanding the issue. For things like this where the backtrace is
> completly out of context it's more of an distraction than of value.
> 
> Aside of that your 'spot the same issue' argument is wrong in this
> context as this does not affect anything old/downstream. The feature was
> merged during the 5.6 merge window. So it has not reached anything
> downstream which needs backports. If distro people pick out such a
> feature and backport it to their frankenkernels before the final release
> then I really dont care.
> 
> One way to preserve the backtrace for google's sake is to write a cover
> letter and stick the back trace there if it is not useful in the
> changelog.
> 
> Also having 40+ lines of untrimmed backtrace is just a horrible
> distraction. The timestamps are completely useless and depending on the
> type of problem most of the other gunk which is emitted by a
> bug/warn/oops backtrace is useless as well.
> 
> Why would you be interested in the register values for this problem or
> the code or the interrupt flags tracer state? That thing triggered a
> warning and nothing in the backtrace gives any clue about why that
> happened, IOW it's pure distraction.
> 
> If the call chain is relevant to explain the problem, then a trimmed
> down version is really sufficient. Here is an example:
> 
>      BUG: unable to handle kernel NULL pointer dereference at 0000000000000078
>      RIP: 0010:apic_ack_edge+0x1e/0x40
>      Call Trace:
>        handle_edge_irq+0x7d/0x1e0
>        generic_handle_irq+0x27/0x30
>        aer_inject_write+0x53a/0x720
> 
> This helps, because it illustrates exactly how this BUG was triggered
> and it's reduced to exactly the 6 lines because everything else in the
> original 50+ lines is useless.

Fair enough.

> 
> > However I think I still miss one thing in the puzzle (although it
> > turns out that we've agreed on removing the warning already, but just
> > in case I missed something important) - do you mean that offlining all
> > the non-isolated CPUs in the mask won't trigger this already?  Because
> > I also saw some similar comment somewhere else...
> >
> > Here's my understanding - when offlining, we'll disable the CPU and
> > reach:
> >
> >   - irq_migrate_all_off_this_cpu
> >     - migrate_one_irq
> >       - irq_do_set_affinity
> >         - calculate HK_FLAG_MANAGED_IRQ and so on...
> >
> > Then we can still trigger this irq move event even before we bring
> > another housekeeping cpu online, right?  Or could you guide me on what
> > I have missed?
> 
> The migration when offlining the CPU to which an interrupt is affine
> does not trigger this because that uses a different mechanism.
> 
> It clears the vector on the outgoing CPU brute force simply because this
> CPU can't handle any interrupts anymore. There is some logic to catch
> the device interrupt racing against this, but while careful it's not
> perfect. There is a theoretical hole there which probably could be
> triggered by carefully orchestrating things, but we can't do anything
> about it except disabling CPU unplug :)

Ah I haven't thought about the "theoretical hole" and that far...  I
think I was only focusing on whether set_affinity() would happen, but
I ignored the fact that x86 __send_cleanup_vector() treated offlining
CPU in the special way to avoid sending IRQ_MOVE_CLEANUP_VECTOR at
all.  And that part makes perfect sense since we can't do much with an
offlined core.

> 
> So the only two ways to trigger this are the ones I described in the
> changelog.
> 
> Hope that helps.

Definitely.

Thanks for writting this up, Thomas!

-- 
Peter Xu


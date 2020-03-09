Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEF0C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402ED20578
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drPScwSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgCIPTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:19:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55144 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbgCIPTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583767162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VX2DGxYyCfy6aqBrzrQoFIhRv7k080Iin067EZLHZHg=;
        b=drPScwSkYakJqDjI/13ddd/boer9yWXmENtNeOuU7OFh4agsijpjA3rvpNj+RYzn+kbreX
        vCULd3uPkB3NqzmPsnK0IrbS1gXD3kzkFo8SnCh4LCfvZsWJYTGAuYnbPYuCIFQDFJWyz3
        04/H3fd6adG80RHr8WKzTyV479jDkdI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-KfzqMuV7OiitBMs0V6VsXw-1; Mon, 09 Mar 2020 11:19:20 -0400
X-MC-Unique: KfzqMuV7OiitBMs0V6VsXw-1
Received: by mail-qv1-f70.google.com with SMTP id g12so3515724qvp.20
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 08:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VX2DGxYyCfy6aqBrzrQoFIhRv7k080Iin067EZLHZHg=;
        b=FgTEB0GPPXJ0supN9Em4pRUpghgvMKJpnSj9Zg6I9FC5AE5VTSicFHWTc6xM9jn4Pb
         RgUxGiulfXPSDk8zuH1pOdPZecXZR9VN9UTARQoQqPIuIntng9bztpoYGfApYpgtPgnn
         pN4qLJ0rRQLV9ygaQA8eHMDp+FfVyghtqWBcucqGI9jbaEXV8MxXj6mB5FAz6A95KSOc
         lkr6T4ERjDDncsNFEz3lcHrQmA6DfxmyTr0BLWWd26W1TkbyvnN4shTCyMG+8jaEnEPl
         5+OJ972nEGTLAap1aXkUtgjdqs9qpCSnMLZnO2C+kEjThxqVO2SbKYKqZvWj2T3s4dPH
         b1ZA==
X-Gm-Message-State: ANhLgQ0kTlyH4L8zmhV/U1eCAzU3rN62zp5RluenIrDu5DISeNm9nAkb
        9hVxP998EFSYY2n5PT/+y32wgkV1jsaYJlCD/Tr7714Cg0jVL7GOi4vczNg0lowtHlyhyE0Qe5F
        VKAI/lavmG3m4E2Ym1ArLKT79
X-Received: by 2002:a0c:80a5:: with SMTP id 34mr2133423qvb.184.1583767160361;
        Mon, 09 Mar 2020 08:19:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt+hDUMb6rNTbLRm/d1PBNVvSGonrrDbyOE8DDgydCwYE3uygRLgoX+kWoF0qKNmYR4X+m87w==
X-Received: by 2002:a0c:80a5:: with SMTP id 34mr2133399qvb.184.1583767160050;
        Mon, 09 Mar 2020 08:19:20 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id p18sm22315902qkp.47.2020.03.09.08.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 08:19:19 -0700 (PDT)
Date:   Mon, 9 Mar 2020 11:19:17 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] sched/isolation: Allow "isolcpus=" to skip unknown
 sub-parameters
Message-ID: <20200309151917.GB4206@xz-x1>
References: <20200204161639.267026-1-peterx@redhat.com>
 <20200214194008.GA1193332@xz-x1>
 <877e0oud5i.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877e0oud5i.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 09:28:25PM +0100, Thomas Gleixner wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Feb 04, 2020 at 11:16:39AM -0500, Peter Xu wrote:
> >> The "isolcpus=" parameter allows sub-parameters to exist before the
> >> cpulist is specified, and if it sees unknown sub-parameters the whole
> >> parameter will be ignored.  This design is incompatible with itself
> >> when we add more sub-parameters to "isolcpus=", because the old
> >> kernels will not recognize the new "isolcpus=" sub-parameters, then it
> >> will invalidate the whole parameter so the CPU isolation will not
> >> really take effect if we start to use the new sub-parameters while
> >> later we reboot into an old kernel. Instead we will see this when
> >> booting the old kernel:
> >> 
> >>     isolcpus: Error, unknown flag
> >> 
> >> The better and compatible way is to allow "isolcpus=" to skip unknown
> >> sub-parameters, so that even if we add new sub-parameters to it the
> >> old kernel will still be able to behave as usual even if with the new
> >> sub-parameter is specified.
> >> 
> >> Ideally this patch should be there when we introduce the first
> >> sub-parameter for "isolcpus=", so it's already a bit late.  However
> >> late is better than nothing.
> >
> > Ping - Hi, Thomas, do you have any further comment on this patch?
> 
> Fine with me.
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks Thomas!

Does anyone like to pick this up, or does this patch needs more
review?

Thanks,

-- 
Peter Xu


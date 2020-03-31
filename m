Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19823C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EB6207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmnABhqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbgCaU6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:58:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21554 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731303AbgCaU6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585688287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nMTuWgH43GvSmLl3/vGFHtIMAhCbcDhmbQIosf8L0DQ=;
        b=BmnABhqZkM8Ecipy/dwn2qDoMFhcCoyaQC+v7aYMSxD4GmaQeYfVq+U8Mzex1nAWRGfAGL
        7XRl+W3xNQZfF8suFbv69LGMIGue8T4A7K3YC5L9PKaaRR5LCPmuAiix8c3gP1P8PMSJ+x
        FCVAP6wj4X+mJzvk+gg/Z4flm2TY1So=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-bjSavILoN6KuVEDGmG00Ww-1; Tue, 31 Mar 2020 16:58:05 -0400
X-MC-Unique: bjSavILoN6KuVEDGmG00Ww-1
Received: by mail-wr1-f72.google.com with SMTP id m15so13564491wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 13:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nMTuWgH43GvSmLl3/vGFHtIMAhCbcDhmbQIosf8L0DQ=;
        b=FI7r4tEqDtwN9TtEYQ5jdf6nYLdvqx7PpHHX3GfcDouMk3GzYrww1vXW3jAjJcMdNy
         gt/u0yfw78NiwMWbGOqPSs8C6rnf1cuhVBnMpRjqk6XRurIACccz0wFUKiARmSBPCmce
         YHOjLyeQBi3Wbt3Uylzc7ANfToTG+1fcoD6f9cQbFOjjw2sTDSq4Xkq55059UI+qvCD1
         vGVGFv9n0UnKwWB/v0RIQYCQzQxxY8+EyHw10dMblY0Z8qO5CwlqPB7Fj7yTs58rHSZZ
         0lmnyH+9JUuugZMBbuXJ0OglbnL58JNaURMr16QKM0X9ul0qDz+HZdfozvLw3eqHI5wu
         qPGw==
X-Gm-Message-State: ANhLgQ16BqR5a5qfZbGOVAOVhKXNl88Q/xFZQKGl0Wp9uDIReClPuh8A
        AsOZs+FSMh1B6gkgr+EJNTHkGbPR9BSGvUySTDYSulHhbo7lNR1n/w1T2SnuABk7cTtEwawcknp
        k9mPJqxhNuQZK2lyNQ9CX+dSm
X-Received: by 2002:a05:6000:10c8:: with SMTP id b8mr20964628wrx.138.1585688284479;
        Tue, 31 Mar 2020 13:58:04 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtjE8SVKcDqJXpBwY3z/nljFiImBJhiy66LJgYJ18HOdry7Gow9qqZRHMNtuEBqfbVTRq42RQ==
X-Received: by 2002:a05:6000:10c8:: with SMTP id b8mr20964598wrx.138.1585688284037;
        Tue, 31 Mar 2020 13:58:04 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id e5sm27609022wru.92.2020.03.31.13.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:58:03 -0700 (PDT)
Date:   Tue, 31 Mar 2020 16:57:59 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] sched/isolation: Allow "isolcpus=" to skip unknown
 sub-parameters
Message-ID: <20200331205759.GA648829@xz-x1>
References: <20200204161639.267026-1-peterx@redhat.com>
 <20200214194008.GA1193332@xz-x1>
 <877e0oud5i.fsf@nanos.tec.linutronix.de>
 <20200309151917.GB4206@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200309151917.GB4206@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 11:19:17AM -0400, Peter Xu wrote:
> On Fri, Feb 14, 2020 at 09:28:25PM +0100, Thomas Gleixner wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > On Tue, Feb 04, 2020 at 11:16:39AM -0500, Peter Xu wrote:
> > >> The "isolcpus=" parameter allows sub-parameters to exist before the
> > >> cpulist is specified, and if it sees unknown sub-parameters the whole
> > >> parameter will be ignored.  This design is incompatible with itself
> > >> when we add more sub-parameters to "isolcpus=", because the old
> > >> kernels will not recognize the new "isolcpus=" sub-parameters, then it
> > >> will invalidate the whole parameter so the CPU isolation will not
> > >> really take effect if we start to use the new sub-parameters while
> > >> later we reboot into an old kernel. Instead we will see this when
> > >> booting the old kernel:
> > >> 
> > >>     isolcpus: Error, unknown flag
> > >> 
> > >> The better and compatible way is to allow "isolcpus=" to skip unknown
> > >> sub-parameters, so that even if we add new sub-parameters to it the
> > >> old kernel will still be able to behave as usual even if with the new
> > >> sub-parameter is specified.
> > >> 
> > >> Ideally this patch should be there when we introduce the first
> > >> sub-parameter for "isolcpus=", so it's already a bit late.  However
> > >> late is better than nothing.
> > >
> > > Ping - Hi, Thomas, do you have any further comment on this patch?
> > 
> > Fine with me.
> > 
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Thanks Thomas!
> 
> Does anyone like to pick this up, or does this patch needs more
> review?

Another gentle ping with the hope that this patch can be picked up.

It's a very simple patch, but I really hope it can be in asap because
the latter means the more kernel versions will be affected by this
isolcpus incompatibility defect (and imo should consider stable too).

Thanks.

-- 
Peter Xu


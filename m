Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E522C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9DE520857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxSfatqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgDQVZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:25:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47405 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726129AbgDQVZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587158698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=676iv0NwOpTsu4j3S5YhFnzxqEtKPiConQpSqMF3tS0=;
        b=AxSfatqXplF+C2yWSnUTJPB0x8I5264UHOjn9oQtErj5zWJxASsV20OpnqISy0W+TyLiXm
        0y2c+0sOBSFwW8mOIgTxmJ5W5fdjRjI52CvBul11FOLkE1tsZhEBuMkpPpHWe7GLqF1Jve
        p1tI7Nok24MzCEVTl8Q4vSaCY7SFUqw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-mTapu7jMN76ZYTX9bhdp6g-1; Fri, 17 Apr 2020 17:24:56 -0400
X-MC-Unique: mTapu7jMN76ZYTX9bhdp6g-1
Received: by mail-qv1-f71.google.com with SMTP id d2so3501504qve.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=676iv0NwOpTsu4j3S5YhFnzxqEtKPiConQpSqMF3tS0=;
        b=ZSoGag2+HBzw2+7/JybqjXog+7HQRXSAUgIn3hYJiWSq3DH1T/HpnBSUMYbTpkv6ep
         oL+p7pM9+e8nfybRdB4S0dvM7MFIm/8m3pJ2RoGwRMyFfOApUnOesA+Eb5HV93OWJ7BD
         zCONGwXPCN1gupGm6JlmIGvuY4tFs2zr7XC1GWM4mQ7GCsXxOqt3SvQdrDAj/oHug3MF
         UEd0Q3LKJnpsMt1MM2D31js2Cen4hAtJvv5tPrbcwHBM2dl17B9P2xOa1GcENQhuQA47
         iqOFElU9LcZZIJPFPCio2IhyQ5PemdsdlxKRW1ZU3LAQrTval4/WnsoEo1N42kth1C0c
         88Ag==
X-Gm-Message-State: AGi0Puah2Oj9jh5+BbS77D8JETx74CQ8PYMdBZXvYaPFKB4btoNnrsWY
        Q2gCcjcRZsA5Ey1OeRC92tBDE6HQ/uvIP7Qnpa1tel8DzdGy2xz1rHjOvFDgYwPOLh3o+i9Myv7
        zAUHlE2hAsliXSw8ZSm1f46FB
X-Received: by 2002:aed:2006:: with SMTP id 6mr5259637qta.276.1587158696122;
        Fri, 17 Apr 2020 14:24:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypI1CPeoFj+QzDX5RrxcP3toefY4DTPQMttZYrN31kNR8CA407FSN+eHTT2P82xGEdUpFktFSQ==
X-Received: by 2002:aed:2006:: with SMTP id 6mr5259619qta.276.1587158695863;
        Fri, 17 Apr 2020 14:24:55 -0700 (PDT)
Received: from Ruby.lyude.net (static-173-76-190-23.bstnma.ftas.verizon.net. [173.76.190.23])
        by smtp.gmail.com with ESMTPSA id y52sm8647286qth.38.2020.04.17.14.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 14:24:55 -0700 (PDT)
Message-ID: <dbdf3853cc1e6fa5a05ced6bc72667e24fa7d8ef.camel@redhat.com>
Subject: Re: [Poke: Tejun] Re: [RFC v3 03/11] drm/vblank: Add vblank works
From:   Lyude Paul <lyude@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Date:   Fri, 17 Apr 2020 17:24:54 -0400
In-Reply-To: <20200417210356.GD43469@mtj.thefacebook.com>
References: <20200417194145.36350-1-lyude@redhat.com>
         <20200417194145.36350-4-lyude@redhat.com>
         <ef9da9d93022822fe4bec7e906540fcc9852ce59.camel@redhat.com>
         <20200417210356.GD43469@mtj.thefacebook.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-17 at 17:03 -0400, Tejun Heo wrote:
> Hello,
> 
> On Fri, Apr 17, 2020 at 04:16:28PM -0400, Lyude Paul wrote:
> > Hey Tejun! So I ended up rewriting the drm_vblank_work stuff so that it
> > used
> > kthread_worker. Things seem to work alright now. But while we're doing
> > just
> > fine with vblank workers on nouveau, we're still having trouble meeting
> > the
> > time constraints needed for using vblank works for i915's needs. There
> > still
> > seems to be a considerable latency between when the irq handler for the
> > vblank
> > interrupts fires, and when the actual drm_vblank_work we scheduled starts:
> ...
> > Tejun, do you have any idea if we might be able to further reduce the
> > latency
> > from the scheduler here? I believe we're already using pm_qos to at least
> > reduce the latency between when the vblank interrupt fires and the
> > interrupt
> > handler starts, but that still isn't enough to fix the other latency
> > issues
> > apparently. We're also already setting the priority of kthread_worker-
> > >task to
> > RT_FIFO as well.
> 
> I don't think the kernel can do much better than what you're seeing. I don't
> know the time scale that you need - is it some tens of microseconds range?
> I'm
> definitely not an expert on the subject but on generic kernels I don't think
> you can achieve anything sub millisec with any kind of reliability.
yeah, it's microsecond range :(

> 
> If the timing is that tight and it's not a hot path, the right solution may
> be
> polling for it rather than yielding the cpu and hoping to get scheduled in
> time.
> 
> > Also, of course, let me know if you're not happy with the
> > __kthread_queue_work() changes/kthread_worker usage in drm_vblank_work as
> > well
> 
> Just glanced over it and I still wonder whether it needs to be that tightly
> integrated, but we can look into that once we settle on whether this is the
> right direction.

FWIW - I think everyone on the DRM side is happy with the concept of vblank
workers, I think all that's really up for discussion at this point (ignoring
the nouveau patches that need Ben's OK) is just getting the code itself
reviewed and figuring out if we still want to use kthread_workers for this, or
if we should just go back to using kthreadd. At least, since it sounds like
there isn't much more we can do to improve on this latency-wise.

> 
> Thanks.
> 
-- 
Cheers,
	Lyude Paul (she/her)
	Associate Software Engineer at Red Hat


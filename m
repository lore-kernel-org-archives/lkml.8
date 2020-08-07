Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B72C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34595221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596808192;
	bh=f9hsfk0DdVJ8+W08UXjqrFKtjqVcWl0LHTQ9Byfd7UA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kQdCXPeomipnDwU0ZxbFj3GzvgDJPTgWEn6EBgoIgl7JnZsONRQ/BrVELhZ15xchQ
	 U3BHLWuLAOpdFCeqFvyZ8uJHWek7XaeWeue9H2v8X1ROZHiKxQ/m3tCJLKsxMCkaAZ
	 9JGXC2KohP0DjTLWM6lTMWXD9Djz+hFspO7icb9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgHGNts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:49:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40486 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgHGNte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:49:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id k20so1907173wmi.5;
        Fri, 07 Aug 2020 06:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KvDB1R7/fz/MRMKaaPVGRhilQhRguSriuVDfLnfR5hM=;
        b=afoZvi+Lp/bS+PctC02U7j5qIlCR+se8j7IggAWwri/6bL4x5tMUNURVUn6O/8JLqc
         tp3ywx5PsE7TFQ1y8DlptraKSbC5XWVfPoqwKoSgoDQ1bi88uy/44xzefS++aedrPVf1
         2MqxnW2utQKiMIXwMjN5gM8QruNYSwNaFN/2hsJdpKqeEiFwGJ1DKjOCIPVUOZx8PVP+
         ijJONyGkWerQZSFoQc9V64QKpPjuYGQSRd/cd+8QGaCErUsy92Xh+JDH6J03gR+v1X0B
         h5bkoy1uNM5LTNnVsQnq0U+7JHEZdaBUnpnhDMBLLrYPkOSort7VfUk+RRydf+E2KkI/
         uw9g==
X-Gm-Message-State: AOAM530koWqMPpTTQmC6fMrlV9HoUBa/Q66lP04uAMuQxTdyZLmIkqMC
        5K5oU0OCJuZ6dl+uRSqF7B8=
X-Google-Smtp-Source: ABdhPJz1TMkcfEaz6ZNJkbXt1tWugQb6eY4Iitz/Ydvx+aR4R7NDUT+9N6dt8NydrSom/64m16cpIA==
X-Received: by 2002:a1c:660a:: with SMTP id a10mr12195084wmc.115.1596808172161;
        Fri, 07 Aug 2020 06:49:32 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a3sm10445484wme.34.2020.08.07.06.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 06:49:31 -0700 (PDT)
Date:   Fri, 7 Aug 2020 13:49:30 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Only notify Hyper-V for die
 events that are oops
Message-ID: <20200807134930.tzdfbt7ekcetvnxu@liuwe-devbox-debian-v2>
References: <1596730935-11564-1-git-send-email-mikelley@microsoft.com>
 <87o8nmome0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8nmome0.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 11:06:47AM +0200, Vitaly Kuznetsov wrote:
> Michael Kelley <mikelley@microsoft.com> writes:
> 
> > Hyper-V currently may be notified of a panic for any die event. But
> > this results in false panic notifications for various user space traps
> > that are die events. Fix this by ignoring die events that aren't oops.
> >
> > Fixes: 510f7aef65bb ("Drivers: hv: vmbus: prefer 'die' notification chain to 'panic'")
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index b50081c..910b6e9 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -86,6 +86,10 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
> >  	struct die_args *die = (struct die_args *)args;
> >  	struct pt_regs *regs = die->regs;
> >  
> > +	/* Don't notify Hyper-V if the die event is other than oops */
> > +	if (val != DIE_OOPS)
> > +		return NOTIFY_DONE;
> > +
> 
> Looking at die_val enum, DIE_PANIC also sounds like something we would
> want to report but it doesn't get emitted anywhere and honestly I don't
> quite understand how is was supposed to be different from DIE_OOPS.
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Applied to hyperv-fixes.

Wei.

> 
> >  	/*
> >  	 * Hyper-V should be notified only once about a panic.  If we will be
> >  	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
> 
> -- 
> Vitaly
> 

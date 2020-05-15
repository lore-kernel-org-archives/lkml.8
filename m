Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9352EC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BD720758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvZs61nN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgEOPYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:24:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54957 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726592AbgEOPY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589556266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VzRPEcij2ytmRUjwXvwU3l+szvwHyZ1DrCsePgKdvx4=;
        b=YvZs61nN4o04lYw5W9hGKBltcFIcH4TZqM1VxOtPlW/hTeKhtrjYPZhNlewxBurdI9d2dl
        fKjbdVhIMWLszPiUAW/XehogYPh8Ia8X/4d2Wc/bBylNIXinM6YCbUKxQ7UCuFi52cg0RT
        cI0TWlTVOpAlYV2rCq+N8quN5lviBvQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-nA03JjyKM76dkLc-Xm3K1Q-1; Fri, 15 May 2020 11:24:22 -0400
X-MC-Unique: nA03JjyKM76dkLc-Xm3K1Q-1
Received: by mail-wr1-f69.google.com with SMTP id 37so1360215wrc.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VzRPEcij2ytmRUjwXvwU3l+szvwHyZ1DrCsePgKdvx4=;
        b=gy3tcIUKG07kcYdftDdjffGh2wBQPQ73e/SFLSYvX3Nljphh35Vh7zE3jrNVojYTex
         MUCCYh0eFWcOPOOyYEJrWeihLWa2WdtDYqXx6RNYguKNsPYeh3smsMtImEH5q0dVWAHK
         +eE26exzgOJXBQYTj1Co5SZgwlfw9+xNAVnNucG7xYZbpXpnoMg0M9Mq7lJqMRHM19M9
         5a/0i11r6zVj0RmX/c3C5x18Ss6UJCtJKLCQxk2wO3Vdp67v2l+cmnFGAIWLkLRMIfF3
         35rkulriD3njDk6D4cJKeJ605I+opbIIads6ePbAw630Gv2RU3ootHT2dd+GjFueRe0u
         kBNA==
X-Gm-Message-State: AOAM531Hcx/Ci58TPgKcimQ3hveR96DHSACfQXEE8tDtTTRLzJpuVUOa
        EoUBET4Jaay5NStimgNiPAoPeJ63W0UbJ+UY78nYE5RDgQHhKTN4WPp3ru60AuLL4epvtu+4MZh
        UuihgG94GnFS1KviDIud5lrVy
X-Received: by 2002:a7b:c149:: with SMTP id z9mr4390242wmi.57.1589556261468;
        Fri, 15 May 2020 08:24:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/JFClA1epQedUH1J6n85nIzDyd7T1UscbMYrQgKvv7JHyXYFXRLEdr/uSOI7mJshrJFl0kQ==
X-Received: by 2002:a7b:c149:: with SMTP id z9mr4390211wmi.57.1589556261046;
        Fri, 15 May 2020 08:24:21 -0700 (PDT)
Received: from steredhat ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id a14sm3920850wme.21.2020.05.15.08.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 08:24:20 -0700 (PDT)
Date:   Fri, 15 May 2020 17:24:18 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/2] io_uring: add a CQ ring flag to enable/disable
 eventfd notification
Message-ID: <20200515152418.oi6btvogplmuezfn@steredhat>
References: <20200515105414.68683-1-sgarzare@redhat.com>
 <eaab5cc7-0297-a8f8-f7a9-e00bcf12b678@kernel.dk>
 <20200515143419.f3uggj7h3nyolfqb@steredhat>
 <a7ac101d-0f5d-2ab2-b36b-b40607d65878@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7ac101d-0f5d-2ab2-b36b-b40607d65878@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 09:13:33AM -0600, Jens Axboe wrote:
> On 5/15/20 8:34 AM, Stefano Garzarella wrote:
> > On Fri, May 15, 2020 at 08:24:58AM -0600, Jens Axboe wrote:
> >> On 5/15/20 4:54 AM, Stefano Garzarella wrote:
> >>> The first patch adds the new 'cq_flags' field for the CQ ring. It
> >>> should be written by the application and read by the kernel.
> >>>
> >>> The second patch adds a new IORING_CQ_NEED_WAKEUP flag that can be
> >>> used by the application to enable/disable eventfd notifications.
> >>>
> >>> I'm not sure the name is the best one, an alternative could be
> >>> IORING_CQ_NEED_EVENT.
> >>>
> >>> This feature can be useful if the application are using eventfd to be
> >>> notified when requests are completed, but they don't want a notification
> >>> for every request.
> >>> Of course the application can already remove the eventfd from the event
> >>> loop, but as soon as it adds the eventfd again, it will be notified,
> >>> even if it has already handled all the completed requests.
> >>>
> >>> The most important use case is when the registered eventfd is used to
> >>> notify a KVM guest through irqfd and we want a mechanism to
> >>> enable/disable interrupts.
> >>>
> >>> I also extended liburing API and added a test case here:
> >>> https://github.com/stefano-garzarella/liburing/tree/eventfd-disable
> >>
> >> Don't mind the feature, and I think the patches look fine. But the name
> >> is really horrible, I'd have no idea what that flag does without looking
> >> at the code or a man page. Why not call it IORING_CQ_EVENTFD_ENABLED or
> >> something like that? Or maybe IORING_CQ_EVENTFD_DISABLED, and then you
> >> don't have to muck with the default value either. The app would set the
> >> flag to disable eventfd, temporarily, and clear it again when it wants
> >> notifications again.
> > 
> > You're clearly right! :-) The name was horrible.
> 
> Sometimes you go down that path on naming and just can't think of
> the right one. I think we've all been there.

:-)

> 
> > I agree that IORING_CQ_EVENTFD_DISABLED should be the best.
> > I'll send a v2 changing the name and removing the default value.
> 
> Great thanks, and please do queue a pull for the liburing side too.

For the liburing side do you prefer a PR on github or posting the
patches on io-uring@vger.kernel.org with 'liburing' tag?

Thanks,
Stefano


Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780E6C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EAF020737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sqo0BbhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgGQINo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:13:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34690 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726201AbgGQINo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594973622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4AhK0Zzm0uakjm5OFnnhauntdAQG4ut12mfNiIODHdo=;
        b=Sqo0BbhBSmOj9HFvnWn8mIsbNWZdfPhmIooyltBHmZ0fwQLPX7H0BH95W/hAH7/bhhXIh6
        lLo6+kYv53H1ujz3olCxss0XIAkTSTDzh7hnY+836wQ23a6oNYXflwlb3p+WlA6O+PfCQo
        PVdJUbjl1PCEWuz34AKwpWCcbL0m1rI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-qDc6bktpNXyY2uOE9se7qg-1; Fri, 17 Jul 2020 04:13:40 -0400
X-MC-Unique: qDc6bktpNXyY2uOE9se7qg-1
Received: by mail-wm1-f70.google.com with SMTP id c81so7746657wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 01:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4AhK0Zzm0uakjm5OFnnhauntdAQG4ut12mfNiIODHdo=;
        b=ldbnaNAnDg0GFWd55kwkytirM7Pida1Ft6zYWwtuHiQDioFytVQdGlyD7TiKfVcRSH
         J3mDFxb6EDXuqZIhReU/0I2jmzt6Ve4sGYKcyPGorNhrxGZr6o4fUB2+uEG9DE4c4jNz
         H+EH/9rabkQ5PcKFbkT/DFlJyW8AJbPQNT+UyvWZZErNQD0ABqj5HYS9aGoMyheaU/sG
         syWyLgdpAYo4BMnLjbzSgK01LBTcJz5/ZXfwRciOK7vdYFcCLiO3syCLsQy/M0YEAnUo
         k3SGGeLQ4Op36m/VPWAJ6HJWtzZWUCVCYMYw4caKoMwUFMZLxRvc/9XYCb70CDbJriUA
         5dUQ==
X-Gm-Message-State: AOAM5333jbfEpnSUNQTd3IYEeVIfJeJvP+AfOGPeM5CSzXWeJ0nJFLTE
        u0BXBAsYrrJJUT7pbBvaZsUwtKBPaCOhu5ZLTGxt9+trhNXI2skq/oJzIxdSSGILnCSpd9YJfS4
        AnrbA6EpBPVF1v8LyLlnOSRiO
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr8623608wme.177.1594973619427;
        Fri, 17 Jul 2020 01:13:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeW6RsdiE3kyUT5zs2nMNiDhKPd7zXn+E25Grakr6B0wzn0S3WYa0J8I4e51M3iaPMLfxKUA==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr8623586wme.177.1594973619210;
        Fri, 17 Jul 2020 01:13:39 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id a4sm14353571wrg.80.2020.07.17.01.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 01:13:38 -0700 (PDT)
Date:   Fri, 17 Jul 2020 10:13:33 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <asarai@suse.de>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/3] io_uring: use an enumeration for
 io_uring_register(2) opcodes
Message-ID: <20200717081333.6z6rtwx3jtktwdvp@steredhat.lan>
References: <20200716124833.93667-1-sgarzare@redhat.com>
 <20200716124833.93667-2-sgarzare@redhat.com>
 <ca242a15-576d-4099-a5f8-85c08985e3ff@gmail.com>
 <a2f109b2-adbf-147d-9423-7a1a4bf99967@kernel.dk>
 <20326d79-fb5a-2480-e52a-e154e056171f@gmail.com>
 <76879432-745d-a5ca-b171-b1391b926ea2@kernel.dk>
 <0357e544-d534-06d2-dc61-1169fc172d20@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0357e544-d534-06d2-dc61-1169fc172d20@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 03:20:53PM -0600, Jens Axboe wrote:
> On 7/16/20 2:51 PM, Jens Axboe wrote:
> > On 7/16/20 2:47 PM, Pavel Begunkov wrote:
> >> On 16/07/2020 23:42, Jens Axboe wrote:
> >>> On 7/16/20 2:16 PM, Pavel Begunkov wrote:
> >>>> On 16/07/2020 15:48, Stefano Garzarella wrote:
> >>>>> The enumeration allows us to keep track of the last
> >>>>> io_uring_register(2) opcode available.
> >>>>>
> >>>>> Behaviour and opcodes names don't change.
> >>>>>
> >>>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >>>>> ---
> >>>>>  include/uapi/linux/io_uring.h | 27 ++++++++++++++++-----------
> >>>>>  1 file changed, 16 insertions(+), 11 deletions(-)
> >>>>>
> >>>>> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> >>>>> index 7843742b8b74..efc50bd0af34 100644
> >>>>> --- a/include/uapi/linux/io_uring.h
> >>>>> +++ b/include/uapi/linux/io_uring.h
> >>>>> @@ -253,17 +253,22 @@ struct io_uring_params {
> >>>>>  /*
> >>>>>   * io_uring_register(2) opcodes and arguments
> >>>>>   */
> >>>>> -#define IORING_REGISTER_BUFFERS		0
> >>>>> -#define IORING_UNREGISTER_BUFFERS	1
> >>>>> -#define IORING_REGISTER_FILES		2
> >>>>> -#define IORING_UNREGISTER_FILES		3
> >>>>> -#define IORING_REGISTER_EVENTFD		4
> >>>>> -#define IORING_UNREGISTER_EVENTFD	5
> >>>>> -#define IORING_REGISTER_FILES_UPDATE	6
> >>>>> -#define IORING_REGISTER_EVENTFD_ASYNC	7
> >>>>> -#define IORING_REGISTER_PROBE		8
> >>>>> -#define IORING_REGISTER_PERSONALITY	9
> >>>>> -#define IORING_UNREGISTER_PERSONALITY	10
> >>>>> +enum {
> >>>>> +	IORING_REGISTER_BUFFERS,
> >>>>> +	IORING_UNREGISTER_BUFFERS,
> >>>>> +	IORING_REGISTER_FILES,
> >>>>> +	IORING_UNREGISTER_FILES,
> >>>>> +	IORING_REGISTER_EVENTFD,
> >>>>> +	IORING_UNREGISTER_EVENTFD,
> >>>>> +	IORING_REGISTER_FILES_UPDATE,
> >>>>> +	IORING_REGISTER_EVENTFD_ASYNC,
> >>>>> +	IORING_REGISTER_PROBE,
> >>>>> +	IORING_REGISTER_PERSONALITY,
> >>>>> +	IORING_UNREGISTER_PERSONALITY,
> >>>>> +
> >>>>> +	/* this goes last */
> >>>>> +	IORING_REGISTER_LAST
> >>>>> +};
> >>>>
> >>>> It breaks userspace API. E.g.
> >>>>
> >>>> #ifdef IORING_REGISTER_BUFFERS
> >>>
> >>> It can, yes, but we have done that in the past. In this one, for
> >>
> >> Ok, if nobody on the userspace side cares, then better to do that
> >> sooner than later.
> 
> I actually don't think it's a huge issue. Normally if applications
> do this, it's because they are using it and need it. Ala:
> 
> #ifndef IORING_REGISTER_SOMETHING
> #define IORING_REGISTER_SOMETHING	fooval
> #endif
> 
> and that'll still work just fine, even if an identical enum is there.
> 

Thank you both for the review!

Then if you agree, I'll leave this patch as it is by introducing the enum.

Stefano


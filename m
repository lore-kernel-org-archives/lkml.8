Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48062C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F8920786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ew+QOu9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgH0HLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbgH0HLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598512295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wA1E5VINX4qFtBzgdOzHpby4Hxj21VGI22LvPkpMV1U=;
        b=ew+QOu9+yZBKWVD1bgmuNZs6AK4oxgHTlR4QCagvL2Em0XeFVD+9XUoKDS94Io9nhPPIo5
        V5T5cqWMRrBa9NrtonaAvABW+X9cUCyHzrWqipp9gqfKutOTHKd4nByfOR/pM3jbqv5Y8X
        8yNg4Yj65UF+eBA7g1RP9xAzNftfTck=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-2jstvCFqP3SS-SzYHeMntg-1; Thu, 27 Aug 2020 03:11:34 -0400
X-MC-Unique: 2jstvCFqP3SS-SzYHeMntg-1
Received: by mail-wr1-f72.google.com with SMTP id r11so1174438wrj.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wA1E5VINX4qFtBzgdOzHpby4Hxj21VGI22LvPkpMV1U=;
        b=bSKZB9nC+VCvd2gDka5yFXya2ekQSMGri9LNTfrp7VmkkmYDxhMMBfOTgowQLReG94
         n488pSoPOfwPIIb4f0+5iOgZnV4ZzBw2wbyhvC4k2nt7yhMBSvohulvxwNl6cXMBkczo
         eLapTy0KOZZLZby31pxlr6V0EW0RxLOGEssd7mvm8AEX7818tmgEuB/+bE2ZBXMbv/kk
         tRVnpFEbWON7aMqCaWhqGGKkQMIi0BGiyMVYG5QKhTV4vJBtc1ec5L8ckO7RobowZIGq
         FWccFXB15LKkNuAZyjMLN2lM+KsAcWQz0Z/H1hbu3wzQ16sQ7zEVVrlPgZ46yQ5W1Ap6
         lTWQ==
X-Gm-Message-State: AOAM533DTu7N7/84OQ7gdX4GiYzWVss0w9S6hMlgEAPZ8kYUT9VoTWaV
        LgcSckI4P8BPhRMv3z2LpfctA/1MRkSSCYEzqgROOdLIU/JMOiMUKUwLAEU4nbdVvsrwwTJvpPy
        GTgITdcCGOiVw/tnnxi3u71Uu
X-Received: by 2002:a1c:e1d6:: with SMTP id y205mr5699016wmg.92.1598512292922;
        Thu, 27 Aug 2020 00:11:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQLLfupwT3htk3SZsVuWhYX6+i7LaFRQaqAJ1Z0qPYkQk0csrl0zkKVvfPCI25zfzRfGsBQw==
X-Received: by 2002:a1c:e1d6:: with SMTP id y205mr5698987wmg.92.1598512292689;
        Thu, 27 Aug 2020 00:11:32 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id v3sm3099244wmh.6.2020.08.27.00.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 00:11:32 -0700 (PDT)
Date:   Thu, 27 Aug 2020 09:11:27 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Andreas Dilger <adilger@dilger.ca>,
        Kees Cook <keescook@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <asarai@suse.de>, io-uring@vger.kernel.org
Subject: Re: [PATCH v4 1/3] io_uring: use an enumeration for
 io_uring_register(2) opcodes
Message-ID: <20200827071127.iqq4gt3d5bpsq4xu@steredhat.lan>
References: <20200813153254.93731-1-sgarzare@redhat.com>
 <20200813153254.93731-2-sgarzare@redhat.com>
 <202008261241.074D8765@keescook>
 <C1F49852-C886-4522-ACD6-DDBF7DE3B838@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C1F49852-C886-4522-ACD6-DDBF7DE3B838@dilger.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 01:52:38PM -0600, Andreas Dilger wrote:
> On Aug 26, 2020, at 1:43 PM, Kees Cook <keescook@chromium.org> wrote:
> > 
> > On Thu, Aug 13, 2020 at 05:32:52PM +0200, Stefano Garzarella wrote:
> >> The enumeration allows us to keep track of the last
> >> io_uring_register(2) opcode available.
> >> 
> >> Behaviour and opcodes names don't change.
> >> 
> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> ---
> >> include/uapi/linux/io_uring.h | 27 ++++++++++++++++-----------
> >> 1 file changed, 16 insertions(+), 11 deletions(-)
> >> 
> >> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> >> index d65fde732518..cdc98afbacc3 100644
> >> --- a/include/uapi/linux/io_uring.h
> >> +++ b/include/uapi/linux/io_uring.h
> >> @@ -255,17 +255,22 @@ struct io_uring_params {
> >> /*
> >>  * io_uring_register(2) opcodes and arguments
> >>  */
> >> -#define IORING_REGISTER_BUFFERS		0
> >> -#define IORING_UNREGISTER_BUFFERS	1
> >> -#define IORING_REGISTER_FILES		2
> >> -#define IORING_UNREGISTER_FILES		3
> >> -#define IORING_REGISTER_EVENTFD		4
> >> -#define IORING_UNREGISTER_EVENTFD	5
> >> -#define IORING_REGISTER_FILES_UPDATE	6
> >> -#define IORING_REGISTER_EVENTFD_ASYNC	7
> >> -#define IORING_REGISTER_PROBE		8
> >> -#define IORING_REGISTER_PERSONALITY	9
> >> -#define IORING_UNREGISTER_PERSONALITY	10
> >> +enum {
> >> +	IORING_REGISTER_BUFFERS,
> > 
> > Actually, one *tiny* thought. Since this is UAPI, do we want to be extra
> > careful here and explicitly assign values? We can't change the meaning
> > of a number (UAPI) but we can add new ones, etc? This would help if an
> > OP were removed (to stop from triggering a cascade of changed values)...
> > 
> > for example:
> > 
> > enum {
> > 	IORING_REGISTER_BUFFERS = 0,
> > 	IORING_UNREGISTER_BUFFERS = 1,
> > 	...
> 
> Definitely that is preferred, IMHO, for enums used as part of UAPI,
> as it avoids accidental changes to the values, and it also makes it
> easier to see what the actual values are.
> 

Sure, I agree.

I'll put the values in the enumerations in the v5.

Thanks,
Stefano


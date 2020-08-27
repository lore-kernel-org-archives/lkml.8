Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DC1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 490332177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3hgkicw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgH0OWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727949AbgH0OKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598537411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p3UaJor8m6UPSLfz0Cwgwz9tei6T+Ko+yHdee7F5pCI=;
        b=U3hgkicwANJkdU0V4e1fkj6xC1xjHJzZDJI0K86zdcAgU52LwoDNH7yDlqXKJIAbxAkv9v
        9OQiRlUN9WbLIiQabAluz0YjHk0xssVBM5H/HQcDF40mJJ0fKi/wI+LPBmuybrU6NaGZ1h
        RXyMzQnKYUa380uCGPIosDcicNq8I3A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-rQpLvx5TNP27CBSvjTszyg-1; Thu, 27 Aug 2020 10:10:08 -0400
X-MC-Unique: rQpLvx5TNP27CBSvjTszyg-1
Received: by mail-wm1-f72.google.com with SMTP id f125so2187423wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p3UaJor8m6UPSLfz0Cwgwz9tei6T+Ko+yHdee7F5pCI=;
        b=Bfd/2o2MkB6d0QDkp537D0fDccSwTh4lIcKzgA+yCkcZ3eVe2OqoTnTPg1NvFx4EBB
         ce8Fiv5eMdx0ijJt+GIqXuSx+OtSo5s3xRqqANkZaoQMCsJUS1p/e4Fm+GTWyN52zIbp
         wIMA+tu6kM9s2UuQwMbkabK3izY9VEK9rd5259olG7bnoWh+ZbfeJxBXDbu2IhBi4Ox3
         6Os2fRicmZHmCXjQYXlGXQqDja0oSyiqajoZeNstwer+qJ2f0pOAcSO9bhfKEUfIecne
         hu/aNLuJTYmSEHACx7QqoPcGVA2pMFrwbuEe4jBw82aWUxZvHycdq4C2VndraQFILRD3
         dSCA==
X-Gm-Message-State: AOAM532p1i9u1FtG4KzPDVubVupCqfwh+JWSrvqXLjLWyUI1JMJsmZSO
        Lgb38nwLYselwppwAXVJ3TDRLpq2LU3dowoiM8FHJ+RB8rJ/iuYVsceaPoOMTG3X/gCryQgoZKb
        3e0El20RGfTPhMl8XGKEg5vdl
X-Received: by 2002:adf:ea0b:: with SMTP id q11mr18400753wrm.285.1598537407344;
        Thu, 27 Aug 2020 07:10:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIyoHL6pydlVZ4mUCwXiexrkWU5beyLiimAC7oyStXfYcu8GXZZ2ytD3aLAfsrScWOA6WOpQ==
X-Received: by 2002:adf:ea0b:: with SMTP id q11mr18400722wrm.285.1598537407089;
        Thu, 27 Aug 2020 07:10:07 -0700 (PDT)
Received: from steredhat.lan ([5.171.209.212])
        by smtp.gmail.com with ESMTPSA id p8sm6052216wrq.9.2020.08.27.07.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:10:06 -0700 (PDT)
Date:   Thu, 27 Aug 2020 16:10:02 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Aleksa Sarai <asarai@suse.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jannh@google.com>, io-uring@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v5 0/3] io_uring: add restrictions to support untrusted
 applications and guests
Message-ID: <20200827141002.an34n2nx6m4dfhce@steredhat.lan>
References: <20200827134044.82821-1-sgarzare@redhat.com>
 <2ded8df7-6dcb-ee8a-c1fd-e0c420b7b95d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ded8df7-6dcb-ee8a-c1fd-e0c420b7b95d@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 07:50:44AM -0600, Jens Axboe wrote:
> On 8/27/20 7:40 AM, Stefano Garzarella wrote:
> > v5:
> >  - explicitly assigned enum values [Kees]
> >  - replaced kmalloc/copy_from_user with memdup_user [kernel test robot]
> >  - added Kees' R-b tags
> > 
> > v4: https://lore.kernel.org/io-uring/20200813153254.93731-1-sgarzare@redhat.com/
> > v3: https://lore.kernel.org/io-uring/20200728160101.48554-1-sgarzare@redhat.com/
> > RFC v2: https://lore.kernel.org/io-uring/20200716124833.93667-1-sgarzare@redhat.com
> > RFC v1: https://lore.kernel.org/io-uring/20200710141945.129329-1-sgarzare@redhat.com
> > 
> > Following the proposal that I send about restrictions [1], I wrote this series
> > to add restrictions in io_uring.
> > 
> > I also wrote helpers in liburing and a test case (test/register-restrictions.c)
> > available in this repository:
> > https://github.com/stefano-garzarella/liburing (branch: io_uring_restrictions)
> > 
> > Just to recap the proposal, the idea is to add some restrictions to the
> > operations (sqe opcode and flags, register opcode) to safely allow untrusted
> > applications or guests to use io_uring queues.
> > 
> > The first patch changes io_uring_register(2) opcodes into an enumeration to
> > keep track of the last opcode available.
> > 
> > The second patch adds IOURING_REGISTER_RESTRICTIONS opcode and the code to
> > handle restrictions.
> > 
> > The third patch adds IORING_SETUP_R_DISABLED flag to start the rings disabled,
> > allowing the user to register restrictions, buffers, files, before to start
> > processing SQEs.
> > 
> > Comments and suggestions are very welcome.
> 
> Looks good to me, just a few very minor comments in patch 2. If you
> could fix those up, let's get this queued for 5.10.
> 

Sure, I'll fix the issues. This is great :-)

Thanks,
Stefano


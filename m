Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD31C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8914422BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGBDWIK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgH0HSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:18:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41453 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726882AbgH0HSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598512691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u9fFbu1GhOR5EEBDVCiFc4v2JfgRv9dRTWq43a81ToQ=;
        b=RGBDWIK3G1NQQkSAwosQoT3Q5eSWHJy201C0S2AGNDU0gCkW+f9WfkL69xlIj1++3JQoCx
        pKTlR9dwzOjmcAcImxT0vWTNEWM/p5456/vkfwhwwoA3sfYF6h+YqZ+VVzGjHm4wfKiLOY
        2kMHQSTJuQ9xPuZn0+I8NVoR3TuMTBk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-OxBJ50QkOv-MIDhBb-qJgA-1; Thu, 27 Aug 2020 03:18:08 -0400
X-MC-Unique: OxBJ50QkOv-MIDhBb-qJgA-1
Received: by mail-wm1-f71.google.com with SMTP id z1so1800599wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u9fFbu1GhOR5EEBDVCiFc4v2JfgRv9dRTWq43a81ToQ=;
        b=fQpPAywC0i/5f9wxE7479D5BcF1cqIrmqvwM0hujtcgn2uYPQHd8D0by+PqDzdpAAQ
         sFeLANC/AaCwDTKjQLOzZKz/SfXXCvXH5BmX6xnI0uMmTNdwc/C8Fo/tSxhHccqsjAJw
         cXanOpZg/c0S8o8vuuwyyVa/WheWW4gI8ZI5X85HwbSB+chm3OVoGAjlOSEuKR5/l450
         /OaHk527XUqRwz735r/VxZjgPb195mSdBh4PNqxIAfXo48zgII7MNnpNTlDw3K41SaZH
         wz89CLNiN8ZsKU0AtQgHVRmMHtYpx9VsxftpJf6n35HQgnEOPAez2lIz05r9/niuepY6
         lhtg==
X-Gm-Message-State: AOAM533FX3bNR+kfuznHwUAm9CI64eqaLuewnG2rWmOx+cPvOC/7PkNs
        JPcRWdUywjam8qE8B3SIrcssH4i5VMwsGxcyMl+EI0EEPZrodrCVlSq4TPpghGo3jSpdcPumtvb
        a0pD5xjimvhvZPE63mIf7mORZ
X-Received: by 2002:adf:b349:: with SMTP id k9mr13694175wrd.135.1598512687410;
        Thu, 27 Aug 2020 00:18:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwtPSLbAoCV+fY+tWZVhYam7dcbiUmX7cOj0w7rM1ddAdGJMa85Kp5T8Bt7PKtypBfPZj1aw==
X-Received: by 2002:adf:b349:: with SMTP id k9mr13694156wrd.135.1598512687137;
        Thu, 27 Aug 2020 00:18:07 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id s12sm3022065wmj.26.2020.08.27.00.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 00:18:06 -0700 (PDT)
Date:   Thu, 27 Aug 2020 09:18:02 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <asarai@suse.de>,
        io-uring@vger.kernel.org
Subject: Re: [PATCH v4 3/3] io_uring: allow disabling rings during the
 creation
Message-ID: <20200827071802.6tzntmixnxc67y33@steredhat.lan>
References: <20200813153254.93731-1-sgarzare@redhat.com>
 <20200813153254.93731-4-sgarzare@redhat.com>
 <202008261248.BB37204250@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008261248.BB37204250@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:50:31PM -0700, Kees Cook wrote:
> On Thu, Aug 13, 2020 at 05:32:54PM +0200, Stefano Garzarella wrote:
> > This patch adds a new IORING_SETUP_R_DISABLED flag to start the
> > rings disabled, allowing the user to register restrictions,
> > buffers, files, before to start processing SQEs.
> > 
> > When IORING_SETUP_R_DISABLED is set, SQE are not processed and
> > SQPOLL kthread is not started.
> > 
> > The restrictions registration are allowed only when the rings
> > are disable to prevent concurrency issue while processing SQEs.
> > 
> > The rings can be enabled using IORING_REGISTER_ENABLE_RINGS
> > opcode with io_uring_register(2).
> > 
> > Suggested-by: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Where can I find the io_uring selftests? I'd expect an additional set of
> patches to implement the selftests for this new feature.

Since the io_uring selftests are stored in the liburing repository, I created
a new test case (test/register-restrictions.c) in my fork and I'll send it
when this series is accepted. It's available in this repository:

https://github.com/stefano-garzarella/liburing (branch: io_uring_restrictions)

Thanks for the review,
Stefano


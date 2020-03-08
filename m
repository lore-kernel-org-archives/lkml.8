Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CE2C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 20:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89F72067C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 20:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAmpiEcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCHU73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 16:59:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60207 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726332AbgCHU73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 16:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583701167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jTdko1X8oY35o5Ajs4E1sA7nR54LL7YHW9Y7Gtl0cVM=;
        b=jAmpiEcItMZGfxBCUqrleE9qeQ9hXbygxlUHXasT0YIr4qFsXUgikYQGghXE/8MuIZBcf9
        uQQT4JCTvMNBMA+nc1qjz7Vh6bWIKRi2kC2whQQ5K0VqnwAKAfEVcwgbWvjQdab1nVVWQj
        36y+cKxrFwPKzAsmc5uPDJplTbHJyQ0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-FdXKFR0wMFqY7tDCB36StQ-1; Sun, 08 Mar 2020 16:59:26 -0400
X-MC-Unique: FdXKFR0wMFqY7tDCB36StQ-1
Received: by mail-qv1-f70.google.com with SMTP id o18so5514921qvk.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 13:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jTdko1X8oY35o5Ajs4E1sA7nR54LL7YHW9Y7Gtl0cVM=;
        b=ArWdutc+2K9kzeLAOR2+gVXJSpYHqOEQgQdynt3ZQ6j1YP/t3z9n93d2wvRAtqIiTC
         19M0g3JhjCIrfn5FDAxNV2uWfpG7ctRORFAGm0nYn8kBjTpETARvN+atA0TkZ/WLPkok
         4anOkstY+YsHNvQLIhqjxPPX7yAC86bzmHhPoCxeC5ycihYm4XSLsVR+43LgNKbNf/ER
         EWRRezHpG2D2WRCDBQGCj3rY5SLvUqLm7WI2uWoNl1db4zSoHjgHfsw9ZwDsgBFAoqcG
         Rh0TnkJyk4K9EZhdluXIV0nmwLpdkG8Iiml8hEpfsX29sctK9eTi1FfDJFf6fAhfEXUA
         nPbQ==
X-Gm-Message-State: ANhLgQ2HxFwBAPI7dD+EK+YpQcmW0KAci8A+LF5zuzvEFrmNAk95KPML
        biyuhA9dKts8PROYzxghculeoNxDMOiTtt3qwEgeQV+0S4rOR5mvB+LRvKJCbPYsA9k5UH9NIJ1
        H3WFOU45N7T1TRaErOsdwuLiS
X-Received: by 2002:ac8:5211:: with SMTP id r17mr6843910qtn.80.1583701165579;
        Sun, 08 Mar 2020 13:59:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtshCJ03ihAj9AEZY+0Ib3id5JHDk+AC7jJYbpyXLcitB4H29vo4/Fuk9DwMmzBe6qIYBGRDQ==
X-Received: by 2002:ac8:5211:: with SMTP id r17mr6843898qtn.80.1583701165360;
        Sun, 08 Mar 2020 13:59:25 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id w8sm2442025qkj.8.2020.03.08.13.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 13:59:24 -0700 (PDT)
Date:   Sun, 8 Mar 2020 16:59:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] drivers: virtio: Make out_del_vqs dependent on
 BALLOON_COMPACTION
Message-ID: <20200308165831-mutt-send-email-mst@kernel.org>
References: <20200306105528.5272-1-vincenzo.frascino@arm.com>
 <4AB99BBC-0EC7-40F0-96ED-04796A73CBA2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4AB99BBC-0EC7-40F0-96ED-04796A73CBA2@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 08:38:19PM +0100, David Hildenbrand wrote:
> 
> 
> > Am 06.03.2020 um 11:56 schrieb Vincenzo Frascino <vincenzo.frascino@arm.com>:
> > 
> > ﻿out_del_vqs label is currently used only when BALLOON_COMPACTION
> > configuration option is enabled. Having it disabled triggers the
> > following warning at compile time:
> > 
> > drivers/virtio/virtio_balloon.c: In function ‘virtballoon_probe’:
> > drivers/virtio/virtio_balloon.c:963:1: warning: label ‘out_del_vqs’
> > defined but not used [-Wunused-label]
> >  963 | out_del_vqs:
> >      | ^~~~~~~~~~~
> > 
> > Make out_del_vqs dependent on BALLOON_COMPACTION to address the
> > issue.
> > 
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> I think this is now the third patch on the list that tries to fix this warning.
> 
> Michael, can we finally queue one of these (or is there one in -next already - did not check)?
> 
> Thanks

It's queued in my tree (and will be in next eventually), I just didn't
send it to Linus yet.
Sorry about the delay.

-- 
MST


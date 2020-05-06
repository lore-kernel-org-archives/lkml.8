Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AC4C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF83320663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXYbXcn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgEFHUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:20:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43326 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727832AbgEFHUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588749603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=736cry6ayk4bFoTJ6GjBafnY0xYXIZ6Pinl17EvWj60=;
        b=iXYbXcn2wkkHPzf66OFWmbjSyOJCBgF8EQty7nQAS/yFyCQL3gam8jLso3BckTuVNy1RUD
        GiVTCtGYxM1YSkQuZAOgJ1x4J1C5/CQcw//REfBJYrh5Pcr37sXf91kjHn3yrCh0kjzSbz
        wxTrvAMyYzGKB/6U05I1ME1mgiEHqMc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-6Gu47QbHPcSCyEecx8pmLA-1; Wed, 06 May 2020 03:20:00 -0400
X-MC-Unique: 6Gu47QbHPcSCyEecx8pmLA-1
Received: by mail-wm1-f69.google.com with SMTP id j5so737963wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 00:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=736cry6ayk4bFoTJ6GjBafnY0xYXIZ6Pinl17EvWj60=;
        b=OD1eLc3WHP/i/6dha1WNxoFEIsjAyrjwoBMZZmkjqNfr2BTKldFNQfj2yQPxtj/OkC
         7nBB3swCUUuDA/2vhKqRLudUkIWQ7zqqoOwTYdbRIUlKoNfQ4rqrlSeB6znMkA2ftzCJ
         AXwZQMhIUxTSTfWHRgqoJsd5uNv5Z/KA/Aiwt0OkJPhD/FJeSnybDS7A5oEnIMD2Kjl7
         LczVGM6w0v2d1foT5rn51zQXfw95VK47suUxbbPyUNqp8kIVekkl079g4XQqyz7vFcyu
         6+PmyN3BbvyL+L+AQMgWfUZ2R/u2a8yX7sCgHcI2W80ZA48lsuMranso1FN4VKo7/HHB
         WMEQ==
X-Gm-Message-State: AGi0PuYE6v9VYPzqZ4fn+UCvO/aIJmcbEFa/7aTtw12DPIX107PdWQ4W
        219+Ls1bj/qe/bGi4mjyrBOBaSF6FUpa4kRNahiUPixKsyhI9Aj0InGS8uWgqxijv9Hp/N/+iJx
        sIJC3ztDglg+/sY8LBbhHjIBE
X-Received: by 2002:a7b:c38e:: with SMTP id s14mr2569986wmj.12.1588749599087;
        Wed, 06 May 2020 00:19:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypIV+r+NtiFQvVY9XndOnisjRoTPFVUYqnvGw+P8xp0StDMwaXBjj0p0abeACiuHrrh2hF04MA==
X-Received: by 2002:a7b:c38e:: with SMTP id s14mr2569971wmj.12.1588749598878;
        Wed, 06 May 2020 00:19:58 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id o129sm1727634wme.16.2020.05.06.00.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 00:19:58 -0700 (PDT)
Date:   Wed, 6 May 2020 03:19:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Justin He <Justin.He@arm.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ldigby@redhat.com" <ldigby@redhat.com>,
        "n.b@live.com" <n.b@live.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] vhost: fixes
Message-ID: <20200506031918-mutt-send-email-mst@kernel.org>
References: <20200504081540-mutt-send-email-mst@kernel.org>
 <AM6PR08MB40696EFF8BE389C134AC04F6F7A40@AM6PR08MB4069.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB40696EFF8BE389C134AC04F6F7A40@AM6PR08MB4069.eurprd08.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 03:28:47AM +0000, Justin He wrote:
> Hi Michael
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, May 4, 2020 8:16 PM
> > To: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: kvm@vger.kernel.org; virtualization@lists.linux-foundation.org;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Justin He
> > <Justin.He@arm.com>; ldigby@redhat.com; mst@redhat.com; n.b@live.com;
> > stefanha@redhat.com
> > Subject: [GIT PULL] vhost: fixes
> >
> > The following changes since commit
> > 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:
> >
> >   Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> >
> > for you to fetch changes up to
> > 0b841030625cde5f784dd62aec72d6a766faae70:
> >
> >   vhost: vsock: kick send_pkt worker once device is started (2020-05-02
> > 10:28:21 -0400)
> >
> > ----------------------------------------------------------------
> > virtio: fixes
> >
> > A couple of bug fixes.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> > Jia He (1):
> >       vhost: vsock: kick send_pkt worker once device is started
> 
> Should this fix also be CC-ed to stable? Sorry I forgot to cc it to stable.
> 
> --
> Cheers,
> Justin (Jia He)


Go ahead, though recently just including Fixes seems to be enough.


> 
> >
> > Stefan Hajnoczi (1):
> >       virtio-blk: handle block_device_operations callbacks after hot unplug
> >
> >  drivers/block/virtio_blk.c | 86
> > +++++++++++++++++++++++++++++++++++++++++-----
> >  drivers/vhost/vsock.c      |  5 +++
> >  2 files changed, 83 insertions(+), 8 deletions(-)
> 
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.


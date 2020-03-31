Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF3AC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F852072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDb/puwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgCaSzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:55:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60107 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726295AbgCaSzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585680950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9N83ulIWUt944dVDEJ06AJzgWaetQqP5tl+Ibkm3ba4=;
        b=hDb/puwpT4Iu1MHaTt4AKvXL2NAyF0iXNZ0+xRa1/g4IKaFpKe4Q1MlGqBWy2fNGEoaolX
        yvEDHK1rieRLs96sLwz3bO7sX/E5FlIirwiwcq3ycgm0dTkr6DUTftxzxZ5KyNnLzVCea+
        LLHRW2piPxeL1LYKj35WZsQ5R6eVLfY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-8Ao8Gkc-MOa1F4ej1oUXDQ-1; Tue, 31 Mar 2020 14:55:46 -0400
X-MC-Unique: 8Ao8Gkc-MOa1F4ej1oUXDQ-1
Received: by mail-wr1-f69.google.com with SMTP id y1so13365723wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9N83ulIWUt944dVDEJ06AJzgWaetQqP5tl+Ibkm3ba4=;
        b=QnkgE7LVr5lvjqJGoolbwBhGefoLlIAtWgNEeyDgEM0A8FT9DDn5y7IPW2lVWqPdrZ
         iP+eKJ+PDfYQ6/OUj5fisOfAQkMb8KHzg3OGSlmmlr+vNPK15FfEYWaed9MAkGebHT67
         16CiXNlEQunExAXQ3xEGYkcvJKX5nxI0rUgVSTKRiQdVu6cKJQuJ/YtJzwet6RyQh+i0
         NICeuCIHSMRyp5/BWRHvZt1BexyYTAhgx/g3GTDhjCliFAPqj2ZWKHEN1svOEsm8rjtE
         KSRFBAqvZ6SAPJCATT7pqeYtFMdihoSiXRJRWnqcTLQ/W3tIMfSYGJ37QnwIKMt0Clhm
         qcUw==
X-Gm-Message-State: AGi0PuYdOylB3//lkjxVWCFW45TRPMQXV6uT2qpxBmbtOkmfRMAvzn1K
        grOqRMe93+/MBofV8TFp89flBwQS0jkGtOcYlLT5b2JlMerijhqbSpJ91fq3+E2JAZd1W478JGG
        d/2jzG9dCJry0YxNGB92gNBB2
X-Received: by 2002:a1c:82:: with SMTP id 124mr257867wma.63.1585680945326;
        Tue, 31 Mar 2020 11:55:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypIItSTAIpN2eJyUg/bKQdlRjERgE+twajxI2WUL+EtqTwGmwdqtCNM2ixY8sVPtXuyHJWpU4g==
X-Received: by 2002:a1c:82:: with SMTP id 124mr257825wma.63.1585680944950;
        Tue, 31 Mar 2020 11:55:44 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id y7sm30626556wrq.54.2020.03.31.11.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 11:55:44 -0700 (PDT)
Date:   Tue, 31 Mar 2020 14:55:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: mmotm 2020-03-30-18-46 uploaded (VDPA + vhost)
Message-ID: <20200331144650-mutt-send-email-mst@kernel.org>
References: <20200331014748.ajL0G62jF%akpm@linux-foundation.org>
 <969cacf1-d420-223d-7cc7-5b1b2405ec2a@infradead.org>
 <20200331143437-mutt-send-email-mst@kernel.org>
 <9c03fee8-af1a-2035-b903-611a631094b0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c03fee8-af1a-2035-b903-611a631094b0@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 11:42:47AM -0700, Randy Dunlap wrote:
> On 3/31/20 11:37 AM, Michael S. Tsirkin wrote:
> > On Tue, Mar 31, 2020 at 11:27:54AM -0700, Randy Dunlap wrote:
> >> On 3/30/20 6:47 PM, akpm@linux-foundation.org wrote:
> >>> The mm-of-the-moment snapshot 2020-03-30-18-46 has been uploaded to
> >>>
> >>>    http://www.ozlabs.org/~akpm/mmotm/
> >>>
> >>> mmotm-readme.txt says
> >>>
> >>> README for mm-of-the-moment:
> >>>
> >>> http://www.ozlabs.org/~akpm/mmotm/
> >>>
> >>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> >>> more than once a week.
> >>>
> >>> You will need quilt to apply these patches to the latest Linus release (5.x
> >>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> >>> http://ozlabs.org/~akpm/mmotm/series
> >>>
> >>> The file broken-out.tar.gz contains two datestamp files: .DATE and
> >>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> >>> followed by the base kernel version against which this patch series is to
> >>> be applied.
> >>>
> >>> This tree is partially included in linux-next.  To see which patches are
> >>> included in linux-next, consult the `series' file.  Only the patches
> >>> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> >>> linux-next.
> >>>
> >>>
> >>> A full copy of the full kernel tree with the linux-next and mmotm patches
> >>> already applied is available through git within an hour of the mmotm
> >>> release.  Individual mmotm releases are tagged.  The master branch always
> >>> points to the latest release, so it's constantly rebasing.
> >>>
> >>> 	https://github.com/hnaz/linux-mm
> >>
> >> on i386:
> >>
> >> ld: drivers/vhost/vdpa.o: in function `vhost_vdpa_init':
> >> vdpa.c:(.init.text+0x52): undefined reference to `__vdpa_register_driver'
> >> ld: drivers/vhost/vdpa.o: in function `vhost_vdpa_exit':
> >> vdpa.c:(.exit.text+0x14): undefined reference to `vdpa_unregister_driver'
> >>
> >>
> >>
> >> drivers/virtio/vdpa/ is not being built. (confusing!)
> >>
> >> CONFIG_VIRTIO=m
> >> # CONFIG_VIRTIO_MENU is not set
> >> CONFIG_VDPA=y
> > 
> > Hmm. OK. Can't figure it out. CONFIG_VDPA is set why isn't
> > drivers/virtio/vdpa/ built?
> > we have:
> > 
> 
> Ack.  Hopefully Yamada-san can tell us what is happening here.


I reproduced this without difficulty btw, thanks for the report!


> > 
> > obj-$(CONFIG_VDPA) += vdpa/
> > 
> > and under that:
> > 
> > obj-$(CONFIG_VDPA) += vdpa.o
> > 
> > 
> >> CONFIG_VDPA_MENU=y
> >> # CONFIG_VDPA_SIM is not set
> >> CONFIG_VHOST_IOTLB=y
> >> CONFIG_VHOST_RING=m
> >> CONFIG_VHOST=y
> >> CONFIG_VHOST_SCSI=m
> >> CONFIG_VHOST_VDPA=y
> >>
> >> Full randconfig file is attached.
> >>
> >> (This same build failure happens with today's linux-next, Mar. 31.)
> >>
> >> @Yamada-san:  Is this a kbuild problem (or feature)?
> >>
> >> -- 
> >> ~Randy
> >> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > 
> 
> 
> -- 
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>


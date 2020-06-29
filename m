Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D685C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C56206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2V9+9EV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390793AbgF2VS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:18:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31092 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390789AbgF2VST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593465497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YiDtiNB2oFeGuS+CRFVjpgq47fViDI5SfncnPvci6SI=;
        b=J2V9+9EVEOih0573W5b8jCuZHO20QPVH+IrODXg+16XJL/l6mqHpCqw2dh0D/F7u80wZfR
        ChBxflCTvrczXVQfpgMCufAysRrVUu+r6ynwUXajsZCzcSU14dD5xS04FV+JrQj2vJIA0c
        zFAfR91i68QZ8hFjN537aj5NcdWlqto=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-hJO89DaXPY-zkQBnbKX7qw-1; Mon, 29 Jun 2020 17:18:15 -0400
X-MC-Unique: hJO89DaXPY-zkQBnbKX7qw-1
Received: by mail-wm1-f70.google.com with SMTP id g187so19589446wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YiDtiNB2oFeGuS+CRFVjpgq47fViDI5SfncnPvci6SI=;
        b=Uo/ebcf+fZYYrgjwwdpx/tzvHGW4oJlutL2jJOCB/gU2Udnq39W/JeTptiyCOcFKQZ
         wjtxcac/AVs30Z/ePRcPiAoto1VML8lArA+1nuE/3zq5++X+LZyw8aSdPxkbLYMlRtPQ
         cbxHbuQsXHYtJmS4PkjeewJsU5lF9BzUN/LHCO7KleYC8QgcRxODHYt8kgPk/TlHvd6s
         qzczg6Rx41MsdprzISsfs2qjKatb0weySlSXrYlttQn8Ld599j02BKlqFv4MAcUclKEV
         ml9VoZRf6psqj3ExtMfq3dvU9mH0pW/aDSj1JhC40svo+erx2EZOPdwfDS3vSZ4EgHDY
         3wDw==
X-Gm-Message-State: AOAM530swq8MHfn9Yp5DWnoYePa4bAVLftETVITkX6Cujt/sFPmMMxu+
        MFh7S+lutGETzlkD8Nk7bmzEa/Qaz/YKgq+Xrw9dE8r81yA/nunidTSKBLOpGFQo55cHsoCSr3X
        v0nvdRqJJVZed0sIUh/AwHJq5
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr18539545wml.33.1593465493743;
        Mon, 29 Jun 2020 14:18:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzfgRem+KXercJkxWwHYUfzWnoeVDCjjDW1dg0ezKr2F2J/LJYjbsk39o6uhlbY8GuP56chg==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr18539534wml.33.1593465493510;
        Mon, 29 Jun 2020 14:18:13 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id c25sm1063645wml.46.2020.06.29.14.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:18:12 -0700 (PDT)
Date:   Mon, 29 Jun 2020 17:18:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com,
        cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v3 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
Message-ID: <20200629171241-mutt-send-email-mst@kernel.org>
References: <1592390637-17441-1-git-send-email-pmorel@linux.ibm.com>
 <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
 <20200629115952-mutt-send-email-mst@kernel.org>
 <66f808f2-5dd9-9127-d0e8-6bafbf13fc62@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66f808f2-5dd9-9127-d0e8-6bafbf13fc62@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 06:48:28PM +0200, Pierre Morel wrote:
> 
> 
> On 2020-06-29 18:09, Michael S. Tsirkin wrote:
> > On Wed, Jun 17, 2020 at 12:43:57PM +0200, Pierre Morel wrote:
> > > An architecture protecting the guest memory against unauthorized host
> > > access may want to enforce VIRTIO I/O device protection through the
> > > use of VIRTIO_F_IOMMU_PLATFORM.
> > > Let's give a chance to the architecture to accept or not devices
> > > without VIRTIO_F_IOMMU_PLATFORM.
> > 
> > I agree it's a bit misleading. Protection is enforced by memory
> > encryption, you can't trust the hypervisor to report the bit correctly
> > so using that as a securoty measure would be pointless.
> > The real gain here is that broken configs are easier to
> > debug.
> > 
> > Here's an attempt at a better description:
> > 
> > 	On some architectures, guest knows that VIRTIO_F_IOMMU_PLATFORM is
> > 	required for virtio to function: e.g. this is the case on s390 protected
> > 	virt guests, since otherwise guest passes encrypted guest memory to devices,
> > 	which the device can't read. Without VIRTIO_F_IOMMU_PLATFORM the
> > 	result is that affected memory (or even a whole page containing
> > 	it is corrupted). Detect and fail probe instead - that is easier
> > 	to debug.
> 
> Thanks indeed better aside from the "encrypted guest memory": the mechanism
> used to avoid the access to the guest memory from the host by s390 is not
> encryption but a hardware feature denying the general host access and
> allowing pieces of memory to be shared between guest and host.

s/encrypted/protected/

> As a consequence the data read from memory is not corrupted but not read at
> all and the read error kills the hypervizor with a SIGSEGV.

s/(or even a whole page containing it is corrupted)/can not be
	read and the read error kills the hypervizor with a SIGSEGV/


As an aside, we could maybe handle that more gracefully
on the hypervisor side.

> 
> > 
> > however, now that we have described what it is (hypervisor
> > misconfiguration) I ask a question: can we be sure this will never
> > ever work? E.g. what if some future hypervisor gains ability to
> > access the protected guest memory in some abstractly secure manner?
> 
> The goal of the s390 PV feature is to avoid this possibility so I don't
> think so; however, there is a possibility that some hardware VIRTIO device
> gain access to the guest's protected memory, even such device does not exist
> yet.
> 
> At the moment such device exists we will need a driver for it, at least to
> enable the feature and apply policies, it is also one of the reasons why a
> hook to the architecture is interesting.


Not neessarily, it could also be fully transparent. See e.g.
recent AMD andvances allowing unmodified guests with SEV.


> > We are blocking this here, and it's hard to predict the future,
> > and a broken hypervisor can always find ways to crash the guest ...
> 
> yes, this is also something to fix on the hypervizor side, Halil is working
> on it.
> 
> > 
> > IMHO it would be safer to just print a warning.
> > What do you think?
> 
> Sadly, putting a warning may not help as qemu is killed if it accesses the
> protected memory.
> Also note that the crash occurs not only on start but also on hotplug.
> 
> Thanks,
> Pierre

Well that depends on where does the warning go. If it's on a serial port
it might be reported host side before the crash triggers.  But
interesting point generally. How about a feature to send a warning code
or string to host then?

> -- 
> Pierre Morel
> IBM Lab Boeblingen


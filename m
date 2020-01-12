Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E796EC33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 06:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E53214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 06:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGwJbqOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbgALGYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 01:24:18 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42603 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732246AbgALGYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 01:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578810255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2gINvQSCZdG0qbWJGJ+5c4nU5M8lJN6UuQQCQRyRrjU=;
        b=HGwJbqOblE7PrIRjCO0sKvqfZFjnOQG6v4gpMgXJ8Rr+cOhyydJsDiEkIWlYME9wVa3Kg2
        q5lKPfzf7tgXk504NLbLbPI27GZ5H3TLeYK32tC31I/hgxebHhaeS7FC36JHGDDHBlwrlt
        9ebUwXNYWOYtsLrj0mFESm6JJZyaNgI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-wTzpamZ7MMuJLULuygHjgQ-1; Sun, 12 Jan 2020 01:24:14 -0500
X-MC-Unique: wTzpamZ7MMuJLULuygHjgQ-1
Received: by mail-qt1-f197.google.com with SMTP id e1so4467668qto.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 22:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2gINvQSCZdG0qbWJGJ+5c4nU5M8lJN6UuQQCQRyRrjU=;
        b=iRdHlDJw+k+E/hGW4qtzQ3GrODOTPL8FXgZ0ItF4QMclD1/Sz8SapdfQi7pqNPSrSF
         ZKBIu72o33VP+WgmdOsy9no6/7s399uShZCPfHwik7y8NkeEfRyDkOMUIBunGswZKn/6
         a97/6B7RRqw41AZwVsKRqyqFpjH6W2d8O8LUOYqhPUduHF4jzQNtn9EPLeHcD3/VU24S
         cTv9ySCxiScrN9sb7Np/XyzF7WLXImzc6gGZ6D/OXP23nzEBBR+PVPe2MAAFuwHY5J4I
         op6DxbBNvo/SZkdkXxu4iI+O1rD+driru6Nu/DpbT165AUATz2EVlFZRZZDXNOTRhiZ+
         pz4Q==
X-Gm-Message-State: APjAAAXcxIcj86QL191orrkDTjlz/Au8jtBh8mGMjXzmdSeQffR84KUZ
        Pa9cCii1WSKaRfkD5gFEegk6v0Hckf52go6G5Q2vEksvI34wC2GEsfBt49XakgdjHINAh+BvlZs
        7B8x41f7wotY5TohGFIlqGDqV
X-Received: by 2002:ac8:f77:: with SMTP id l52mr9253162qtk.310.1578810253489;
        Sat, 11 Jan 2020 22:24:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqSBsVESH5zUN9VJLuUKP8sK7XMqOHBoru39ceqcQDUbPZPm5d2rLwOAu67m8W7cnh3Z55Og==
X-Received: by 2002:ac8:f77:: with SMTP id l52mr9253149qtk.310.1578810253216;
        Sat, 11 Jan 2020 22:24:13 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id d26sm3225033qka.28.2020.01.11.22.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 22:24:12 -0800 (PST)
Date:   Sun, 12 Jan 2020 01:24:06 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Lei Cao <lei.cao@stratus.com>
Subject: Re: [PATCH v3 12/21] KVM: X86: Implement ring-based dirty memory
 tracking
Message-ID: <20200112012239-mutt-send-email-mst@kernel.org>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-13-peterx@redhat.com>
 <20200109110110-mutt-send-email-mst@kernel.org>
 <20200109191514.GD36997@xz-x1>
 <20200109141634-mutt-send-email-mst@kernel.org>
 <20200109201916.GH36997@xz-x1>
 <20200109171154-mutt-send-email-mst@kernel.org>
 <20200110152959.GC53397@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110152959.GC53397@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 10:29:59AM -0500, Peter Xu wrote:
> On Thu, Jan 09, 2020 at 05:18:24PM -0500, Michael S. Tsirkin wrote:
> > On Thu, Jan 09, 2020 at 03:19:16PM -0500, Peter Xu wrote:
> > > > > while for virtio, both sides (hypervisor,
> > > > > and the guest driver) are trusted.
> > > > 
> > > > What gave you the impression guest is trusted in virtio?
> > > 
> > > Hmm... maybe when I know virtio can bypass vIOMMU as long as it
> > > doesn't provide IOMMU_PLATFORM flag? :)
> > 
> > If guest driver does not provide IOMMU_PLATFORM, and device does,
> > then negotiation fails.
> 
> I mean it's still possible to specify "!IOMMU_PLATFORM" for the virtio
> device even if vIOMMU is enabled in the guest (rather than the
> negociation procedures).  Again I think it's fair, just the same
> reason as why we tend to even make "iommu=pt" by default for all the
> kernel drivers, because we should trust all the drivers as kernel
> itself.  The only thing we want to protect using vIOMMU is the
> userspace driver because we do have a line between the userspace and
> the kernel, and IMHO it's the same thing here for the new kvm
> interface.
> 
> > 
> > > I think it's logical to trust a virtio guest kernel driver, could you
> > > guide me on what I've missed?
> > 
> > 
> > guest driver is assumed to be part of guest kernel. It can't
> > do anything kernel can't do anyway.
> 
> Right, I think all things belongs to the kernel will have the same
> level of trust.  However again, userspace should be differently
> treated, and that's why I tend to prefer the index solution that we
> expose less to userspace to write (read is far safer comparing to
> writes from userspace).

You are mixing up different userspace kinds here. vIOMMU
prtects guest kernel from guest userspace.
Protecting guest kernel against userspace hypervisors
(e.g. QEMU) is mostly futile.


> > 
> > > > 
> > > > 
> > > > >  Above means we need to do these to
> > > > > change to the new design:
> > > > > 
> > > > >   - Allow the GFN array to be mapped as writable by userspace (so that
> > > > >     userspace can publish bit 2),
> > > > > 
> > > > >   - The userspace must be trusted to follow the design (just imagine
> > > > >     what if the userspace overwrites a GFN when it publishes bit 2
> > > > >     over a valid dirty gfn entry?  KVM could wrongly unprotect a page
> > > > >     for the guest...).
> > > > 
> > > > You mean protect, right?  So what?
> > > 
> > > Yes, I mean with that, more things are uncertain from userspace.  It
> > > seems easier to me that we restrict the userspace with one index.
> > 
> > Donnu how to treat vague statements like this.  You need to be specific
> > with threat models. Otherwise there's no way to tell whether code is
> > secure.
> > 
> > > > 
> > > > > While if we use the indices, we restrict the userspace to only be able
> > > > > to write to one index only (which is the reset_index).  That's all it
> > > > > can do to mess things up (and it could never as long as we properly
> > > > > validate the reset_index when read, which only happens during
> > > > > KVM_RESET_DIRTY_RINGS and is very rare).  From that pov, it seems the
> > > > > indices solution still has its benefits.
> > > > 
> > > > So if you mess up index how is this different?
> > > 
> > > We can't mess up much with that.  We simply check fetch_index (sorry I
> > > meant this when I said reset_index, anyway it's the only index that we
> > > expose to userspace) to make sure:
> > > 
> > >   reset_index <= fetch_index <= dirty_index
> > > 
> > > Otherwise we fail the ioctl.  With that, we're 100% safe.
> > 
> > safe from what? userspace can mess up guest memory trivially.
> > for example skip sending some memory or send junk.
> 
> Yes, QEMU can mess the guest up, but it should never mess the host up,
> am I right?  Regarding to QEMU as an userspace, KVM should see it as
> untrusted as well from host-wise.  However guest security is another
> thing, imho.
> 
> > 
> > > > 
> > > > I agree RO page kind of feels safer generally though.
> > > > 
> > > > I will have to re-read how does the ring works though,
> > > > my comments were based on the old assumption of mmaped
> > > > page with indices.
> > > 
> > > Yes, sorry again for a bad cover letter.
> > > 
> > > It's basically the same as before, just that we only have per-vcpu
> > > ring now, and the indices are exposed from kvm_run so we don't need
> > > the extra page, but we still expose that via mmap.
> > 
> > So that's why changelogs are useful.
> > Can you please write a changelog for this version so I don't
> > need to re-read all of it? Thanks!
> 
> Sure, actually I've got a changelog in the cover letter for this
> version [1]... it's:
> 
> V3 changelog:
> 
> - fail userspace writable maps on dirty ring ranges [Jason]
> - commit message fixups [Paolo]
> - change __x86_set_memory_region to return hva [Paolo]
> - cacheline align for indices [Paolo, Jason]
> - drop waitqueue, global lock, etc., include kvmgt rework patchset
> - take lock for __x86_set_memory_region() (otherwise it triggers a
>   lockdep in latest kvm/queue) [Paolo]
> - check KVM_DIRTY_LOG_PAGE_OFFSET in kvm_vm_ioctl_enable_dirty_log_ring
> - one more patch to drop x86_set_memory_region [Paolo]
> - one more patch to remove extra srcu usage in init_rmode_identity_map()
> - add some r-bs for Paolo
> 
> I didn't have detailed changelog for v2 because it could be a long
> list with trivial details which can hide the major things, but I've
> got a small write-up in the cover letter trying to mention the major
> changes [2].
> 
> Again, I'm very sorry for either missing a complete changelog in v2,
> or the high-level overview of v3 in the cover letter.  I'll make it
> better in v4.
> 
> Thanks,
> 
> [1] https://lore.kernel.org/kvm/20200109145729.32898-1-peterx@redhat.com/
> [2] https://lore.kernel.org/kvm/20191220211634.51231-1-peterx@redhat.com/
> 
> -- 
> Peter Xu


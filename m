Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D02C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AC824656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1ufiHoIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgANUjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:39:13 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34221 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgANUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 15:39:12 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so13998405otf.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 12:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIZnzMCbYIPyWmmiZXOrwZsr2d1DaLuYf9PqBFFGxaY=;
        b=1ufiHoIhgkel1wNgfe5RR02iDJ6+fd8UzlDlpmsKFP4dFT9Zw+z+eHe5IHCwBCzia3
         Qx3uIUdT99fmuIsed3Wcx0ZiytVs24h1TKYzEHptbEJN6KLwBLnismJWzCM54qIzbXng
         6i+ainEaEBsD70PzhoIWMZ4fJhRG9/48EC7wGC+l3Tme4CNXCr+PDkn9oDjPuVkiudiu
         Jx7Hin+lVNC4afdBHw5tEOHqQLhQ+LCEm1bcbgLD2uj8DLGYhrZaQksVeFHTnazOxnuZ
         Kf5qJe/0whlXEMBDWBNM1CA1AAsAXa05zB+qlcDBZa7WUgJ3Wn6b+JSCmcNfsshtiJ1A
         CETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIZnzMCbYIPyWmmiZXOrwZsr2d1DaLuYf9PqBFFGxaY=;
        b=RyBTLifPP5dNTQa5hsAonvStqmd0LW2AvKRcb6oLeFdpz6Ds8og/ccQhKJqHLwdHGY
         k3Lj1BuiXgY0MBFu2X24zxwMBIlqhG9VSsy8BzkpI+LNVFwYMRPrLgS06WZXDKivYgRj
         8AJ69GxsHUo+6cni0N5pHnpWhv/BcwogSp7emvWX4rtSn/WI/fG+JedeY9y/ZU+rML9j
         xZomwnvCAsrWOgP+v3LEdjN1gncXjlOaBSHUfXOah78JGY3izpkNAWA+Jwgly3aYdnCg
         oFXEmIRuhVbkWmsgx1hrmqNuKCTP9ohrCK2TyginvbT/ARItTioaAJbPNYgbaBZ5PB7a
         JXew==
X-Gm-Message-State: APjAAAVVyO4biQNXiWbZ6vdTJ8kEgDtKPXItEDPpAg4ub2onN/HTbpgO
        fsXoA2s2tlMAd7cxDncluxcCgyxwRl9YoZhsnxAzuw==
X-Google-Smtp-Source: APXvYqzvyu/O19EV+W3nd5Qbhe0VPu8Zpxx4j6lAGURR9nwfPKNQXF393TmIiEgkujYPUIcgpRgr0BZ6QoEDec2+nxI=
X-Received: by 2002:a9d:68d3:: with SMTP id i19mr130746oto.71.1579034351613;
 Tue, 14 Jan 2020 12:39:11 -0800 (PST)
MIME-Version: 1.0
References: <20200107125159.GA15745@infradead.org> <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia> <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com> <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com> <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200109112447.GG27035@quack2.suse.cz> <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
 <20200114203138.GA3145@redhat.com>
In-Reply-To: <20200114203138.GA3145@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 14 Jan 2020 12:39:00 -0800
Message-ID: <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 12:31 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Jan 09, 2020 at 12:03:01PM -0800, Dan Williams wrote:
> > On Thu, Jan 9, 2020 at 3:27 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 07-01-20 10:49:55, Dan Williams wrote:
> > > > On Tue, Jan 7, 2020 at 10:33 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > W.r.t partitioning, bdev_dax_pgoff() seems to be the pain point where
> > > > > dax code refers back to block device to figure out partition offset in
> > > > > dax device. If we create a dax object corresponding to "struct block_device"
> > > > > and store sector offset in that, then we could pass that object to dax
> > > > > code and not worry about referring back to bdev. I have written some
> > > > > proof of concept code and called that object "dax_handle". I can post
> > > > > that code if there is interest.
> > > >
> > > > I don't think it's worth it in the end especially considering
> > > > filesystems are looking to operate on /dev/dax devices directly and
> > > > remove block entanglements entirely.
> > > >
> > > > > IMHO, it feels useful to be able to partition and use a dax capable
> > > > > block device in same way as non-dax block device. It will be really
> > > > > odd to think that if filesystem is on /dev/pmem0p1, then dax can't
> > > > > be enabled but if filesystem is on /dev/mapper/pmem0p1, then dax
> > > > > will work.
> > > >
> > > > That can already happen today. If you do not properly align the
> > > > partition then dax operations will be disabled. This proposal just
> > > > extends that existing failure domain to make all partitions fail to
> > > > support dax.
> > >
> > > Well, I have some sympathy with the sysadmin that has /dev/pmem0 device,
> > > decides to create partitions on it for whatever (possibly misguided)
> > > reason and then ponders why the hell DAX is not working? And PAGE_SIZE
> > > partition alignment is so obvious and widespread that I don't count it as a
> > > realistic error case sysadmins would be pondering about currently.
> > >
> > > So I'd find two options reasonably consistent:
> > > 1) Keep status quo where partitions are created and support DAX.
> > > 2) Stop partition creation altogether, if anyones wants to split pmem
> > > device further, he can use dm-linear for that (i.e., kpartx).
> > >
> > > But I'm not sure if the ship hasn't already sailed for option 2) to be
> > > feasible without angry users and Linus reverting the change.
> >
> > Christoph? I feel myself leaning more and more to the "keep pmem
> > partitions" camp.
> >
> > I don't see "drop partition support" effort ending well given the long
> > standing "ext4 fails to mount when dax is not available" precedent.
> >
> > I think the next least bad option is to have a dax_get_by_host()
> > variant that passes an offset and length pair rather than requiring a
> > later bdev_dax_pgoff() to recall the offset. This also prevents
> > needing to add another dax-device object representation.
>
> I am wondering what's the conclusion on this. I want to this to make
> progress in some direction so that I can make progress on virtiofs DAX
> support.

I think we should at least try to delete the partition support and see
if anyone screams. Have a module option to revert the behavior so
people are not stuck waiting for the revert to land, but if it stays
quiet then we're in a better place with that support pushed out of the
dax core.

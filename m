Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CA4C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2E82072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+gXw/MS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbgDMPEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:04:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58563 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728578AbgDMPEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586790257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17t47p62WxVqQ3k2XMIaH3GAgbSI+gMIhNKLJVLPfOE=;
        b=M+gXw/MS+jwPrnPq27H7SrIDKc9MZ8mjkRjuSe1Q14D8N5kBYfHCeAIu591uDl4zP7Xw3D
        l9tnJUqjgwWP/OHcM+lDIc+6ptd1fPHUL7T0AZDz+SNdsdSr7S329V5E6UCp6cUB8IbB5M
        9t7D4Ux/1vP/wqJJ1HJkpQZhvVLuQ9M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-kCnqBT87MXSTJhfDcHOXxQ-1; Mon, 13 Apr 2020 11:04:16 -0400
X-MC-Unique: kCnqBT87MXSTJhfDcHOXxQ-1
Received: by mail-wm1-f69.google.com with SMTP id f128so1154302wmf.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=17t47p62WxVqQ3k2XMIaH3GAgbSI+gMIhNKLJVLPfOE=;
        b=Iu2zsg9uR0oIeNUjpms5QsE/McjQ9uFbMmO3wXC6cyYWu3y5v4Sb1OT1M5psAykZQw
         DiI02j4ROiGc9dsPLhQne346pSeODctsQKKyKmMP7MYYm56353fQ0BEyixU3OhuwnDz5
         hSRwCOscCLxZV65vE1m2v0uNpbBkiFXNocgFaTMBMjAivmaKx9o/FDvIhuBF6DE6L9+H
         BqWmCG20GTHUELlySuiW+pSWEtZvRR7lXZnup3N5QD2bY4GT6csTm9amtB21IOk9YJjd
         VZ0TxVAiJKWENacgrHkC5pD2cFb4H+JEWeakYC9O+8RGoX9bcDugLjAS+HP/T4QJIXTa
         ZECA==
X-Gm-Message-State: AGi0Pua9JO9bCKqKvFToZQIJrKYUA/83uX5Z5+D49woaUTpgVi+DAPGT
        OiiTCoElMVbjTUTHRK5v+fUtlsx1aCwQLgsgDnH5Kc/x1oBYfi33TmcmuUAFTCQPDI2TPZvhJtY
        NnjWZqAvwp0RMKSFLDx2DbYPv
X-Received: by 2002:adf:fa41:: with SMTP id y1mr18217356wrr.131.1586790255100;
        Mon, 13 Apr 2020 08:04:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypLb8EpzCSSDu1/k+4HxGtBRat97HSOUEfq2h0YXRdsfzcIOhO5iu2JTbNNJB4PYUfr8gNiRUg==
X-Received: by 2002:adf:fa41:: with SMTP id y1mr18217333wrr.131.1586790254791;
        Mon, 13 Apr 2020 08:04:14 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
        by smtp.gmail.com with ESMTPSA id o11sm14764690wme.13.2020.04.13.08.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 08:04:14 -0700 (PDT)
Date:   Mon, 13 Apr 2020 11:04:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/8] tools/vhost: Reset virtqueue on tests
Message-ID: <20200413110403-mutt-send-email-mst@kernel.org>
References: <20200403165119.5030-1-eperezma@redhat.com>
 <20200413071044-mutt-send-email-mst@kernel.org>
 <CAJaqyWcOmzxfOodudSjrZa1SeYDZKiO3MFMy_w44cL_eaBhYDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWcOmzxfOodudSjrZa1SeYDZKiO3MFMy_w44cL_eaBhYDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 04:50:06PM +0200, Eugenio Perez Martin wrote:
> On Mon, Apr 13, 2020 at 1:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Apr 03, 2020 at 06:51:11PM +0200, Eugenio Pérez wrote:
> > > This series add the tests used to validate the "vhost: Reset batched
> > > descriptors on SET_VRING_BASE call" series, with a small change on the
> > > reset code (delete an extra unneded reset on VHOST_SET_VRING_BASE).
> > >
> > > They are based on the tests sent back them, the ones that were not
> > > included (reasons in that thread). This series changes:
> > >
> > > * Delete need to export the ugly function in virtio_ring, now all the
> > > code is added in tools/virtio (except the one line fix).
> > > * Add forgotten uses of vhost_vq_set_backend. Fix bad usage order in
> > > vhost_test_set_backend.
> > > * Drop random reset, not really needed.
> > > * Minor changes updating tests code.
> > >
> > > This serie is meant to be applied on top of
> > > 5de4e0b7068337cf0d4ca48a4011746410115aae in
> > > git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.
> >
> > Is this still needed?
> 
> ("tools/virtio: fix virtio_test.c") indentation is actually cosmetic.
> ("vhost: Not cleaning batched descs in VHOST_SET_VRING_BASE ioctl")
> just avoid to clean batches descriptors for a third time (they are
> cleaned on backend removal and addition).
> 
> ("vhost: Fix bad order in vhost_test_set_backend at enable") is
> actually a fix, the test does not work properly without it. And
> ("tools/virtio: Reset index in virtio_test --reset.") Makes the test
> work more similar than the actual VM does in a reset.
> 
> ("tools/virtio: Use __vring_new_virtqueue in virtio_test.c") and
> ("tools/virtio: Extract virtqueue initialization in vq_reset") are
> convenience commits to reach the previous two.
> 
> Lastly, ("tools/virtio: Use tools/include/list.h instead of stubs")
> just removes stub code, I did it when I try to test vdpa code and it
> seems to me a nice to have, but we can drop it from the patchset if
> you don't see that way.
> 
> > The patches lack Signed-off-by and
> > commit log descriptions, reference commit Ids without subject.
> > See Documentation/process/submitting-patches.rst
> >
> 
> Sorry, I will try to keep an eye on that from now on. I will send a v2
> with Signed-off-by and extended descriptions if you see it ok.
> 
> Thanks!

Sure, pls go ahead.

> > > Eugenio Pérez (8):
> > >   tools/virtio: fix virtio_test.c indentation
> > >   vhost: Not cleaning batched descs in VHOST_SET_VRING_BASE ioctl
> > >   vhost: Replace vq->private_data access by backend accesors
> > >   vhost: Fix bad order in vhost_test_set_backend at enable
> > >   tools/virtio: Use __vring_new_virtqueue in virtio_test.c
> > >   tools/virtio: Extract virtqueue initialization in vq_reset
> > >   tools/virtio: Reset index in virtio_test --reset.
> > >   tools/virtio: Use tools/include/list.h instead of stubs
> > >
> > >  drivers/vhost/test.c        |  8 ++---
> > >  drivers/vhost/vhost.c       |  1 -
> > >  tools/virtio/linux/kernel.h |  7 +----
> > >  tools/virtio/linux/virtio.h |  5 ++--
> > >  tools/virtio/virtio_test.c  | 58 +++++++++++++++++++++++++++----------
> > >  tools/virtio/vringh_test.c  |  2 ++
> > >  6 files changed, 51 insertions(+), 30 deletions(-)
> > >
> > > --
> > > 2.18.1
> >


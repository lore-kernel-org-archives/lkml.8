Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E52C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822B32078D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWpfndfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbgFSO07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:26:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28394 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726321AbgFSO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592576817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QawtTit9ilWBfcWzRJGBgzMme6mDC3U2WVp0QdlTe14=;
        b=HWpfndflNhEA7Bph0TxIAIikhPncaZpEbZHedE1rnMRR50f8SrPgtHIydbpHFT133Gc88L
        Md9MtxAkif/DE7OEDwdbUVu43+bkNlD1aV1Kcfd7TrBGkNF0A5Poy5sSv/OsQK8RUu6N2S
        5qJAKVcMQU0PZ4XkogPpyM0e0U55nFU=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-p15f9i4mNXe6Kfn9-ptMag-1; Fri, 19 Jun 2020 10:26:54 -0400
X-MC-Unique: p15f9i4mNXe6Kfn9-ptMag-1
Received: by mail-il1-f198.google.com with SMTP id c11so6532406ilq.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QawtTit9ilWBfcWzRJGBgzMme6mDC3U2WVp0QdlTe14=;
        b=lCo1/iRHb5hAAfsV/7Fzf6AewhCR/LsOjyb5J8rBgkFzJ0LtJZC8pjR9/Sh3U09Q6q
         QplrKCD9J6JzroK9m6CnZNP1y0Tmeh0gpYfE3Zw9BSw9QBhn0Pnai9ZTTT1e3BAM5I0C
         jjQuxzxQwhUGdYFvyNUsIlnyMexmg+gjEtTgpZyzKhF5URldzljD77KrSylD0vGG9Ish
         +9IUYwMsJ0sRMuAVkhY5m1jsbIcz63UpR5ihVLRMvWiiRMWYoBfQNZ5h9Pxj9gGUrC6e
         bUnLD2OFmlO3aj0Vk0Qrs/m+1Ctw+ka25XFdIG2hs+vL066AzVRlVirpOo7VgLlBOsfE
         6CHg==
X-Gm-Message-State: AOAM533z8y42h/NaC6rlk6DMSX5mEhG5XwbeNzYbgbulmMxa0C36KoAb
        8ZuoZLyuIQUvguJLGPyn3Gqoat9nOZ3O+EFEWLej84qGc6rPmdXDRijIe+UxKMF+QirAfDhT1lg
        bb96kxoInoPpYEYPYnBLCkzYUoktuhpe1v/BWhX0C
X-Received: by 2002:a02:c802:: with SMTP id p2mr4036675jao.111.1592576814338;
        Fri, 19 Jun 2020 07:26:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxE/w+ErfwfWnr9Fmkf3RuosFy1XAP5JEuenfnPBYSO5RmXN0kjlDcBgmUhw/LWSMNkY9RoyHSyRPMpN29Oi/w=
X-Received: by 2002:a02:c802:: with SMTP id p2mr4036653jao.111.1592576813953;
 Fri, 19 Jun 2020 07:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200608210058.37352-1-jarod@redhat.com> <20200610185910.48668-1-jarod@redhat.com>
 <CAL3LdT5Bo3Cca1eiGykOvPAw18oH3ePQyB0wwEUYKq5ZDHX=3g@mail.gmail.com>
In-Reply-To: <CAL3LdT5Bo3Cca1eiGykOvPAw18oH3ePQyB0wwEUYKq5ZDHX=3g@mail.gmail.com>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Fri, 19 Jun 2020 10:26:43 -0400
Message-ID: <CAKfmpSczw6P=EoxPNmG=475AHiSTzC3vzuHvFBC6=PCfXVRCSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/4] bonding: initial support for hardware
 crypto offload
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 6:26 AM Jeff Kirsher
<jeffrey.t.kirsher@intel.com> wrote:
>
> On Wed, Jun 10, 2020 at 1:18 PM Jarod Wilson <jarod@redhat.com> wrote:
> >
> > This is an initial functional implementation for doing pass-through of
> > hardware encryption from bonding device to capable slaves, in active-backup
> > bond setups. This was developed and tested using ixgbe-driven Intel x520
> > interfaces with libreswan and a transport mode connection, primarily using
> > netperf, with assorted connection failures forced during transmission. The
> > failover works quite well in my testing, and overall performance is right
> > on par with offload when running on a bare interface, no bond involved.
> >
> > Caveats: this is ONLY enabled for active-backup, because I'm not sure
> > how one would manage multiple offload handles for different devices all
> > running at the same time in the same xfrm, and it relies on some minor
> > changes to both the xfrm code and slave device driver code to get things
> > to behave, and I don't have immediate access to any other hardware that
> > could function similarly, but the NIC driver changes are minimal and
> > straight-forward enough that I've included what I think ought to be
> > enough for mlx5 devices too.
> >
> > v2: reordered patches, switched (back) to using CONFIG_XFRM_OFFLOAD
> > to wrap the code additions and wrapped overlooked additions.
> >
> > Jarod Wilson (4):
> >   xfrm: bail early on slave pass over skb
> >   ixgbe_ipsec: become aware of when running as a bonding slave
> >   mlx5: become aware of when running as a bonding slave
> >   bonding: support hardware encryption offload to slaves
...
> Was this ever sent to netdev (the more appropriate ML)?

I believe so, but I'd neglected to notice net-next was closed at the
time, so I was holding on to it to resubmit once net-next is opened
back up.

-- 
Jarod Wilson
jarod@redhat.com


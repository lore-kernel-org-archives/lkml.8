Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EEEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D13206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvPc6aBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgESBvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 21:51:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25231 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbgESBvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 21:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589853100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vKI9vt/QTluNPJ8hc9nIUhogs9tAXpOIFaP0BVZRQ90=;
        b=AvPc6aBGLGRgo2Vemjzjr7H50EBVZtKOpF3uEOdGO0islBwgByjohpC05k/3WZyMbpojVP
        RAfGjNfT21L+fTiP9e/lqpRORSI2qGm1GB3y13dJi8BIo5Nepg5JnMpygG7wh6xAqviM4c
        8ev/MZyTfLKGsyuWnBHRuTQJZqGTQEI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-cNDRhsF7PlWpIzmSTPpGJw-1; Mon, 18 May 2020 21:51:38 -0400
X-MC-Unique: cNDRhsF7PlWpIzmSTPpGJw-1
Received: by mail-pf1-f199.google.com with SMTP id u137so10552392pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 18:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vKI9vt/QTluNPJ8hc9nIUhogs9tAXpOIFaP0BVZRQ90=;
        b=Z/7R5d3xDcHR9eLAy3LqkjS6S9P34F/WgnH5E8PfIKC5DNxRke59PZguEDfQM6whUi
         liuFBXfSzoVnrSnJeplBowQdKoLjZtVdRwZVFAzFZeJg4shLyKZ+QY4zgbxORD+AQwQ3
         7iBcD5x+ks4y8DtpUuqR04OXutpaqkQWyghHRaRIHmuYTkkKiKdLZteN6x86qB2DiSSV
         3ev0Be9rLvYvCkWVgmZWEnqFgvv2fjlOgYRKZHEq3H14aREYddj8HihbuxQwgTS+0iT1
         gJO3pHpFKikZn+Ijln20cxx7M33ocCFRzUhyjlJn6Xjp3zCHpFqW1s4fiMiDXP85IuZq
         oovg==
X-Gm-Message-State: AOAM532Fz6Q8w/KVuJuBb6AlEyWCBm2S/pd8f2W63OXjoEI83PhheRUs
        jqO0uv8FF8VRZ+knbBLQp2qWGjNvCSZPMwgAVKwKKbLdnds0ukulvn7QTKkCxHXvj3I0UUQXpg8
        EmnbmATCqkbblKFwMjNCEtP91GD/pPDbO24A5CpMg
X-Received: by 2002:a17:902:c403:: with SMTP id k3mr19203784plk.12.1589853097524;
        Mon, 18 May 2020 18:51:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHXsyF4vMl2D0/YLl4HH2hp198OK7gAVkb6GH7wVW6wevNEOxLfZAJ9FMoVgk9eTdkddxAEuudwhyxtl28U1w=
X-Received: by 2002:a17:902:c403:: with SMTP id k3mr19203767plk.12.1589853097150;
 Mon, 18 May 2020 18:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <1589270444-3669-1-git-send-email-lingshan.zhu@intel.com>
 <8aca85c3-3bf6-a1ec-7009-cd9a635647d7@redhat.com> <5bbe0c21-8638-45e4-04e8-02ad0df44b38@intel.com>
 <572ed6af-7a04-730e-c803-a41868091e88@redhat.com>
In-Reply-To: <572ed6af-7a04-730e-c803-a41868091e88@redhat.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Tue, 19 May 2020 09:51:26 +0800
Message-ID: <CACLfguXXPArd9UWX-HpfqNvgpWS=Nyt6SJ4kUkjjpVsVvVe9oA@mail.gmail.com>
Subject: Re: [PATCH V2] ifcvf: move IRQ request/free to status change handlers
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Zhu, Lingshan" <lingshan.zhu@intel.com>,
        Michael Tsirkin <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        dan.daly@intel.com, "Liang, Cunming" <cunming.liang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,Jason
It works ok in the latest version of qemu vdpa code , So I think the
patch is ok.
Thanks
Cindy
On Wed, May 13, 2020 at 3:18 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/5/13 =E4=B8=8B=E5=8D=8812:42, Zhu, Lingshan wrote:
> >
> >
> > On 5/13/2020 12:12 PM, Jason Wang wrote:
> >>
> >> On 2020/5/12 =E4=B8=8B=E5=8D=884:00, Zhu Lingshan wrote:
> >>> This commit move IRQ request and free operations from probe()
> >>> to VIRTIO status change handler to comply with VIRTIO spec.
> >>>
> >>> VIRTIO spec 1.1, section 2.1.2 Device Requirements: Device Status Fie=
ld
> >>> The device MUST NOT consume buffers or send any used buffer
> >>> notifications to the driver before DRIVER_OK.
> >>
> >>
> >> This comment needs to be checked as I said previously. It's only
> >> needed if we're sure ifcvf can generate interrupt before DRIVER_OK.
> >>
> >>
> >>>
> >>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >>> ---
> >>> changes from V1:
> >>> remove ifcvf_stop_datapath() in status =3D=3D 0 handler, we don't nee=
d
> >>> to do this
> >>> twice; handle status =3D=3D 0 after DRIVER_OK -> !DRIVER_OK handler
> >>> (Jason Wang)
> >>
> >>
> >> Patch looks good to me, but with this patch ping cannot work on my
> >> machine. (It works without this patch).
> >>
> >> Thanks
> > This is strange, it works on my machines, let's have a check offline.
> >
> > Thanks,
> > BR
> > Zhu Lingshan
>
>
> I give it a try with virito-vpda and a tiny userspace. Either works.
>
> So it could be an issue of qemu codes.
>
> Let's wait for Cindy to test if it really works.
>
> Thanks
>
>


Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422BDC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 08:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1555F206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 08:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqnMxSSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgBPIFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 03:05:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36580 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgBPIFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 03:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581840308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOtjGEIbedMeSAqorVosrRbZsj8B1U3C9ArIGgDEZ2w=;
        b=IqnMxSSW4Wb24G60O1+v92KhSi6TqlDK+3ejSC7Cpz8lRa4Jqn0EsY2PbYlIFN7ap/Tj2t
        mdYVeZULCRkv/BMlUFDd2UJGiM+2r9dYnqbeOxI1HSg7YcTVgCK8qJkH+ZHuMG8v4IZNOG
        ZRvLwYCTrjwcUTO1Oy/ZyKIfgv3Umbw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-fsCoCuFZN2OI898-XWUwvw-1; Sun, 16 Feb 2020 03:05:06 -0500
X-MC-Unique: fsCoCuFZN2OI898-XWUwvw-1
Received: by mail-wr1-f71.google.com with SMTP id z15so6994883wrw.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 00:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=XOtjGEIbedMeSAqorVosrRbZsj8B1U3C9ArIGgDEZ2w=;
        b=mkjDfGk1w+651mEIhkO055//eQtDOr3wPKEVDnaYH7Yl6WH0wzlZ7pIA6JKYjawj7K
         hY3CnT7srna+bYm4qnBkd81QO0dbE+h/DqTRDXEpbYo2SiLZGmXs26/EXfJaI3gXCpGb
         lfYrmgH2tRq0Hwf3PJlwSrP9oZyHy/TuUjB/XmS0V8KIgeuNzRtsQ7I1xGJbsBFy1SOl
         3XeDolT7uzIGwnWnqH7xoXSx8PDsfpZ+pkAWsrc8dzDHT6CCGIvtuCgxKbRfaBhwCJ/D
         NpY4Oryc2UV0e8IdjeX1w6gBMIwMKIurOmYwaLCUvEKDSWJnSC4yKNTDTkyrWx0LYkG5
         nQnw==
X-Gm-Message-State: APjAAAVx0/+GQCuSAqSv1q1XxGMgwYH35obqmbvjW3EKYy6H7dn2dDHg
        ZjupwLkq1y3opG3LsE7CHRlCvR9p5pPiawpwcSBmvoOad4zrHWFPgc0l+JL+qolAWg3c89nWiZA
        scF7F/oxNerLXmCfFqu3pan78
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr13940844wrn.50.1581840305095;
        Sun, 16 Feb 2020 00:05:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqyGXmKr86Nd7T6BOeIKwH3t5TmwJTAXT4j1+KFFsWqbBkC8vpb+ZbELAqZ0A+HoVSoTG/v/6Q==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr13940820wrn.50.1581840304880;
        Sun, 16 Feb 2020 00:05:04 -0800 (PST)
Received: from [192.168.3.122] (p5B0C616F.dip0.t-ipconnect.de. [91.12.97.111])
        by smtp.gmail.com with ESMTPSA id z6sm15225156wrw.36.2020.02.16.00.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 00:05:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] virtio_balloon: Fix unused label warning
Date:   Sun, 16 Feb 2020 09:05:02 +0100
Message-Id: <FF9BD3B9-7D78-4470-89CD-6F6831F4B6A6@redhat.com>
References: <20200216074639.GA25292@ubuntu-m2-xlarge-x86>
Cc:     Borislav Petkov <bp@alien8.de>,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
In-Reply-To: <20200216074639.GA25292@ubuntu-m2-xlarge-x86>
To:     Nathan Chancellor <natechancellor@gmail.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Am 16.02.2020 um 08:46 schrieb Nathan Chancellor <natechancellor@gmail.com=
>:
>=20
> =EF=BB=BFOn Mon, Feb 10, 2020 at 10:33:28AM +0100, Borislav Petkov wrote:
>> From: Borislav Petkov <bp@suse.de>
>>=20
>> Fix
>>=20
>>  drivers/virtio/virtio_balloon.c: In function =E2=80=98virtballoon_probe=E2=
=80=99:
>>  drivers/virtio/virtio_balloon.c:963:1: warning: label =E2=80=98out_del_v=
qs=E2=80=99 defined but not used [-Wunused-label]
>>    963 | out_del_vqs:
>>        | ^~
>>=20
>> The CONFIG_BALLOON_COMPACTION ifdeffery should enclose it too.
>>=20
>> Signed-off-by: Borislav Petkov <bp@suse.de>
>> Cc: David Hildenbrand <david@redhat.com>
>> ---
>> drivers/virtio/virtio_balloon.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
>> index 7bfe365d9372..b6ed5f8bccb1 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -959,9 +959,9 @@ static int virtballoon_probe(struct virtio_device *vd=
ev)
>>    iput(vb->vb_dev_info.inode);
>> out_kern_unmount:
>>    kern_unmount(balloon_mnt);
>> -#endif
>> out_del_vqs:
>>    vdev->config->del_vqs(vdev);
>> +#endif
>=20
> I noticed the same issue and sent an almost identical patch [1] but I
> kept the call to del_vqs outside of the CONFIG_BALLOON_COMPACTION guard
> since it seems like that should still be called when that config is
> unset, as that was the case before commit 1ad6f58ea936 ("virtio_balloon:
> Fix memory leaks on errors in virtballoon_probe()"). Is this patch fully
> correct? I am not a virtio expert at all, just noticing from a brief
> reading of this function.

I think you are right and this splipped my eyes!=


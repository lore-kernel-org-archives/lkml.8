Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E46C7619B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 08:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7EA227BF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 08:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEp8G6lG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgBPIGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 03:06:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32963 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgBPIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 03:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581840399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tg6pRNGI3M93MkmGDKKavCH/Drs31lDGSONfCn4eVtc=;
        b=eEp8G6lGzULIFLxjtkVxlhPBS1YjO6RYn66sntGOh5zrOo4gjssoVv+95MReECtPgp82uj
        EBR9sCq2TbPAeCdip+ksEZ6BCcnLwa6G/JONb5OPhx8/Oz8jFJhvMN9TkIr0MC5tjx0/S6
        cz0D+qGp/+AVKjANeGaazP+JXHojH1M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-b9NGx89LPtC6-KWa4kd2dg-1; Sun, 16 Feb 2020 03:06:37 -0500
X-MC-Unique: b9NGx89LPtC6-KWa4kd2dg-1
Received: by mail-wr1-f72.google.com with SMTP id 50so6997275wrc.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 00:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=tg6pRNGI3M93MkmGDKKavCH/Drs31lDGSONfCn4eVtc=;
        b=ijIWJhH5jXPBhB6R6LHyU8ymzsE8bjO2K9Hq8Cp6xY4XzrG1SmLohybFJFJ3LbAkW6
         0imliwHucsL05kmGnwRNjsDP2j0qpnW9HL0qqeJaykn6VokV6IWloGPfgarDUoPB9Y9u
         oA89eFdx0BQbYwbB+csr9a1MjsnX9FMVU841uvz68Emif5wO52y76sjeDcIcx2qkLe2M
         A2ZE/EkSyGhuphqQLdxHzYa6t2xjBfSz/UDqFkzZ9RIx2XscspnX6XhWbLR6qroIJ0OE
         HdETDMgNW+1FHQOS+vdd8ue37x5YLWeBZyThYd8wCcY1seYjo5meF8WWEMcWJw4vifuK
         YfPg==
X-Gm-Message-State: APjAAAU85XLtabJYKEnHkOKI4/ZmHQyVudMmQDwHBTzAq1RngMHPJCLB
        FOK6UyozxoFAuU4KdVQDPRP7/06daOCsvdI/ZLfLhy66nZGxhNF8YKb3vKxhoXDmNo0fp7vqtZz
        0hMbYu3oKZx7wij89lZNRHEHl
X-Received: by 2002:a05:600c:285:: with SMTP id 5mr14928263wmk.120.1581840395834;
        Sun, 16 Feb 2020 00:06:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzALqocRDDkJtM36otpO+eIjpiue5T2EHCcX2/GjFcmgCaxpInGRcqoTFJ9kZNR8McZjTIC9w==
X-Received: by 2002:a05:600c:285:: with SMTP id 5mr14928233wmk.120.1581840395601;
        Sun, 16 Feb 2020 00:06:35 -0800 (PST)
Received: from [192.168.3.122] (p5B0C616F.dip0.t-ipconnect.de. [91.12.97.111])
        by smtp.gmail.com with ESMTPSA id h128sm16289582wmh.33.2020.02.16.00.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 00:06:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] virtio_balloon: Adjust label in virtballoon_probe
Date:   Sun, 16 Feb 2020 09:06:34 +0100
Message-Id: <BB1929A5-E718-4FC0-BBCD-E673F4F0CC18@redhat.com>
References: <20200216074735.GA4717@ubuntu-m2-xlarge-x86>
Cc:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
In-Reply-To: <20200216074735.GA4717@ubuntu-m2-xlarge-x86>
To:     Nathan Chancellor <natechancellor@gmail.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 16.02.2020 um 08:47 schrieb Nathan Chancellor <natechancellor@gmail.com=
>:
>=20
> =EF=BB=BFOn Sun, Feb 16, 2020 at 08:36:45AM +0100, David Hildenbrand wrote=
:
>>=20
>>=20
>>>> Am 16.02.2020 um 01:41 schrieb Nathan Chancellor <natechancellor@gmail.=
com>:
>>>=20
>>> =EF=BB=BFClang warns when CONFIG_BALLOON_COMPACTION is unset:
>>>=20
>>> ../drivers/virtio/virtio_balloon.c:963:1: warning: unused label
>>> 'out_del_vqs' [-Wunused-label]
>>> out_del_vqs:
>>> ^~~~~~~~~~~~
>>> 1 warning generated.
>>>=20
>>=20
>> Thanks, there is already =E2=80=9E [PATCH] virtio_balloon: Fix unused lab=
el warning=E2=80=9C from Boris on the list.
>>=20
>> Cheers!
>>=20
>=20
> Sorry for the noise, I thought I did a search for duplicate patches but
> seems I missed it :/ I've commented on that patch.

Your patch should be the correct one! :)=


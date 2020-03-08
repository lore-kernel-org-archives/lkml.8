Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28514C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF51620675
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mw2CW8uP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgCHTiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 15:38:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52746 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726322AbgCHTiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 15:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583696303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OhYbYf/ZU5BRDGgvDuE9sRmfmL1pRAe4uJZ1vmuPsdE=;
        b=Mw2CW8uPESdm+24hiJ5jBGTDVtuuglxLKHXy/dclBdEQfNh4KtphJVgJuZv8XEAio0zu61
        QXy3jT32eKsa6dxnILRlxPsYcRUgeWddB7+aXGEC//yigy9T5ZkUEnN+rcmLsHJTttY1ue
        03i1nojHOJI34ij8vIQ+j41KGfxPWZ4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-Hayse1Q1Pz-d94qEpopruQ-1; Sun, 08 Mar 2020 15:38:21 -0400
X-MC-Unique: Hayse1Q1Pz-d94qEpopruQ-1
Received: by mail-wr1-f71.google.com with SMTP id 31so4126175wrq.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 12:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=OhYbYf/ZU5BRDGgvDuE9sRmfmL1pRAe4uJZ1vmuPsdE=;
        b=A49TPRIeIHx3a6Jlg5+6kU16ugq3mqGYFF5Hr8gjpMlcDna8Oq0Dyz6C9M91lNimnv
         oPw6PNJZSxlsqrvsC0YoeA7CUiQlSo4xDiKwwCKj7bKcnslYMaVOOaUzqvXpeygePRmM
         lWmBpSwqx/RoFGtVL9bkZpLwpXWyErp6yh7ClKtQmzRDpLe8S04N7gt2SUFW5xcaV9gJ
         yPfBaS9YChldhdHfF6kpqE6RriFFumBSXBMpqXXtETXv0qZORmZN6GEb0gHDmwU/E8M5
         SwWqXPJpfZzipVW4mps3/C0vHZQmnXQLB0NwmYBiIYi0RMP7NrGzY8XajXP88nWVGSNG
         bMTQ==
X-Gm-Message-State: ANhLgQ2eHs24vXYJKSkayNrQB+0L5Tbl8c15c8wOe6aZ3MRO9BYo0vG8
        3AmNYApsHjNLNjVHf/gf7bSONfooApsLVl5zFl+COnmkmpgQT2DR3RFIXDRAIHN2y25pJDN3FRU
        pzHaqnxEDEkgbeyN2BVvoT3nw
X-Received: by 2002:a5d:4406:: with SMTP id z6mr11146782wrq.68.1583696300589;
        Sun, 08 Mar 2020 12:38:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtR+roVGIB9QcNPPLe+Ab25Z1fyDczychjr0ciDJc5L01xETBP8QuMhOXXxwCs2SpRZL86VGg==
X-Received: by 2002:a5d:4406:: with SMTP id z6mr11146771wrq.68.1583696300395;
        Sun, 08 Mar 2020 12:38:20 -0700 (PDT)
Received: from [192.168.3.122] (p5B0C674A.dip0.t-ipconnect.de. [91.12.103.74])
        by smtp.gmail.com with ESMTPSA id o11sm48616184wrn.6.2020.03.08.12.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2020 12:38:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] drivers: virtio: Make out_del_vqs dependent on BALLOON_COMPACTION
Date:   Sun, 8 Mar 2020 20:38:19 +0100
Message-Id: <4AB99BBC-0EC7-40F0-96ED-04796A73CBA2@redhat.com>
References: <20200306105528.5272-1-vincenzo.frascino@arm.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
In-Reply-To: <20200306105528.5272-1-vincenzo.frascino@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 06.03.2020 um 11:56 schrieb Vincenzo Frascino <vincenzo.frascino@arm.co=
m>:
>=20
> =EF=BB=BFout_del_vqs label is currently used only when BALLOON_COMPACTION
> configuration option is enabled. Having it disabled triggers the
> following warning at compile time:
>=20
> drivers/virtio/virtio_balloon.c: In function =E2=80=98virtballoon_probe=E2=
=80=99:
> drivers/virtio/virtio_balloon.c:963:1: warning: label =E2=80=98out_del_vqs=
=E2=80=99
> defined but not used [-Wunused-label]
>  963 | out_del_vqs:
>      | ^~~~~~~~~~~
>=20
> Make out_del_vqs dependent on BALLOON_COMPACTION to address the
> issue.
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

I think this is now the third patch on the list that tries to fix this warni=
ng.

Michael, can we finally queue one of these (or is there one in -next already=
 - did not check)?

Thanks=


Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A798C3B1BF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 07:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E880320857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 07:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R36mdbvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgBPHgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 02:36:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20364 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725866AbgBPHgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 02:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581838610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O2JW1kkAAj7rNrgatlYafFmGug2dLIWpAOPCneb1jWc=;
        b=R36mdbvOEpbEQlQSAXVIQfzTubZSSN6HV9Xa6ZLags0vNvGaWSpLpKdcSHsdLJvBY+tJT9
        8xl2hEGl5e+A9ex2CvZ+QG8q7PR2+rwU/8RceXQnIAGTigoSWsadeOshNdOWrlxfvbxEZC
        H4eEzAFPe0X2emDBonFxyIM6DQjpf+o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-GRiU4-OVMQGrLLOgTqeuig-1; Sun, 16 Feb 2020 02:36:49 -0500
X-MC-Unique: GRiU4-OVMQGrLLOgTqeuig-1
Received: by mail-wr1-f70.google.com with SMTP id o9so6961279wrw.14
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 23:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=O2JW1kkAAj7rNrgatlYafFmGug2dLIWpAOPCneb1jWc=;
        b=DJnrEOcIKbBMvGNM619f9vJPxEYsUDrl/+BVexj8pzzBsTGpExPlxELzcLefs3uUnK
         QOfSLmH26BQS3fuGL15h57tcwGj4yop8LFjqV4wXDTukEkCQzu1lboIM5SrkUlHOfVJu
         MHtGqsUqvuhIWWWF8aJanqtVN+TmKxdDS4apieVnK+8kWIVG9BntYTAH2l7YgFAj30EO
         d7pD74wFDFrvupgnwmSLv5vX8bkq/6RBwa09sTldIhADdqEN+23NR65QnwEP8kJwDtsE
         AhtgcGCcHUSHEMJ2u2J7uGBa1+pxmnLx5FcXn5c+zeVliIQk5RSJBM43Kt0CErXLOIwt
         Zqig==
X-Gm-Message-State: APjAAAXzobV2hYbaPRTeVc1IUxDo2QRBegnxrMOQhU+zQ8kAIvRYZBbh
        yo3EzvJhiuid3ni2bw0rAURdgf5zIhpblwF6WZOCdZjUZij9z7EOG3Z9NU62Flce7tTBWk6baEu
        yGakaKYVjOQP1svJwG9KbX5J/
X-Received: by 2002:a1c:b08a:: with SMTP id z132mr15686480wme.73.1581838607885;
        Sat, 15 Feb 2020 23:36:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqwlyujzDZ5ard0PHULJI4K66sEcjNncPLWa49mWHbxgOEqnlABkfamJnR4+kBjUWIyC0K1XMg==
X-Received: by 2002:a1c:b08a:: with SMTP id z132mr15686445wme.73.1581838607531;
        Sat, 15 Feb 2020 23:36:47 -0800 (PST)
Received: from [192.168.3.122] (p5B0C616F.dip0.t-ipconnect.de. [91.12.97.111])
        by smtp.gmail.com with ESMTPSA id e22sm15636901wme.45.2020.02.15.23.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2020 23:36:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] virtio_balloon: Adjust label in virtballoon_probe
Date:   Sun, 16 Feb 2020 08:36:45 +0100
Message-Id: <67FCAE69-05CF-4588-A7BC-664267D14BAF@redhat.com>
References: <20200216004039.23464-1-natechancellor@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
In-Reply-To: <20200216004039.23464-1-natechancellor@gmail.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 16.02.2020 um 01:41 schrieb Nathan Chancellor <natechancellor@gmail.com=
>:
>=20
> =EF=BB=BFClang warns when CONFIG_BALLOON_COMPACTION is unset:
>=20
> ../drivers/virtio/virtio_balloon.c:963:1: warning: unused label
> 'out_del_vqs' [-Wunused-label]
> out_del_vqs:
> ^~~~~~~~~~~~
> 1 warning generated.
>=20

Thanks, there is already =E2=80=9E [PATCH] virtio_balloon: Fix unused label w=
arning=E2=80=9C from Boris on the list.

Cheers!=


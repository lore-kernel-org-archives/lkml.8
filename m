Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E84C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 054C020578
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hk4ynhZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgHCMKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:10:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55427 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726118AbgHCMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596456637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U0tL39aLglkJrbRA5E3dM2LRcS8d3XyI4lDc3p0DpU8=;
        b=Hk4ynhZ1ReHggt8hJFmI94bx1Y4geoQ34MzJa1ykXAvFLgwvkKdDNFBoLRtwVh8nZo9X6a
        LX+gak9N+uVlwDxqa10gyaxRz1dZeeeIvoAiAaYIyX1YzaXvDkPgSYJ+h7Quc193u8ylVa
        bKdttf0/tzj2iB0vezRiMvjgXUmCgs0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-yUbhHb5tNVaOU5VD3DJREQ-1; Mon, 03 Aug 2020 08:10:35 -0400
X-MC-Unique: yUbhHb5tNVaOU5VD3DJREQ-1
Received: by mail-oo1-f70.google.com with SMTP id y22so16621115oog.21
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 05:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U0tL39aLglkJrbRA5E3dM2LRcS8d3XyI4lDc3p0DpU8=;
        b=AaWmD9UUVsW20hl6T+loNUYxuLMMzwgashYUlurihpVwcEF2YS3HlcIEb6Dyl5sYCS
         Qt1IKQ5o8I5oOl87eaPu3TlqeIGe20TJfu51Xn7SnP+bJ0n8hBDtH89Gk1/tRlCu9FxO
         ZeJremYL/sIOQ+DNH+jTNVQse2S/0Y/KvHbdSIK0IGhassCuXPWW0pArsMdXVR9r8lX9
         wWsRP9RgTMZxBAvDXwcZ/A5LS40snx9qiUuGcE+N8i3iMU/qJpngFOc7gSrXt4VSnFs3
         OdzVeoPyZRQ3Xu9+7+ErY+ZToe0VpsEe5uVy76UmCQHrOQkTp28qaR09pH9sF2IWl6ud
         YANA==
X-Gm-Message-State: AOAM533QzoG3oXCyEv9zZtWogVN+epNvv0qEmtxaxp0kDF7gVYNhJclz
        afK5SzFx04DbB7fCLYOpApZ9zNZNDLe9wsrAnmpa5UjCm/a8sm0OuGQAFttou7fazZ3WPHCjotm
        2/oJl2t5ZxPmVLgP1ywvM3ZYVqqzIHcnw8anHgY/m
X-Received: by 2002:a9d:2186:: with SMTP id s6mr13383605otb.58.1596456634862;
        Mon, 03 Aug 2020 05:10:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUWYC4ZY+bPuoBG6o3jKDqGL1jEZseRxVi8YLb7bwNZVAyo56uncb4gvu1C+NnUONt6qGv5+NW6Cto9tJdawo=
X-Received: by 2002:a9d:2186:: with SMTP id s6mr13383590otb.58.1596456634670;
 Mon, 03 Aug 2020 05:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200731212818.10782-1-efremov@linux.com> <777bd9d1-35b0-842a-83df-55792126c652@linux.com>
In-Reply-To: <777bd9d1-35b0-842a-83df-55792126c652@linux.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 3 Aug 2020 14:10:23 +0200
Message-ID: <CAHc6FU7VrzJ7wfTLsKZMjgkRiL7pTnwaLA4Jm4Wocm4hZwmrHQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Use kvmalloc instead of opencoded kmalloc/vmalloc
To:     Denis Efremov <efremov@linux.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Aug 1, 2020 at 2:05 PM Denis Efremov <efremov@linux.com> wrote:
> Please, skip this patch. I missed that kvmalloc checks (flags & GFP_KERNEL) == GFP_KERNEL
> before calling vmalloc.

okay. Assuming that you'll follow up with a fixed version, please also
mention that this change supplements commit 3cdcf63ed2d1 ("GFS2: use
kvfree() instead of open-coding it").

Thanks,
Andreas


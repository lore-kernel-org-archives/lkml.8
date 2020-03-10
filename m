Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BA3C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8001520848
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DWyZY+fN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgCJORG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:17:06 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:32997 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgCJORG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:17:06 -0400
Received: by mail-il1-f195.google.com with SMTP id k29so6933453ilg.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHUlshbt0krVyNx6H5AQrYmBp/rsTRhM/TkVqLTK1cA=;
        b=DWyZY+fN2f5GWPycqc6nfqGuuLyjg3vxp56EkljIp4CFmK4rlXVcYb7WGIIrBmtWz9
         NR+EjtBnZDRvDuMV/aRpSTLTMaQIfWG4nIPbzPJwAM0W39llvBvEuEw3xVXPour1P6cG
         OnrgRxf5sAH77uw+c4f2x0E2WfazdfWrmdTjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHUlshbt0krVyNx6H5AQrYmBp/rsTRhM/TkVqLTK1cA=;
        b=NcqzEiRY8epuvIpjQ+A85Olp/texmJDI5PoIyeG+JSoy2HbL99UwSvVbuxh0n/13EK
         mHVvx2IQKhUjV66Y1WhxPo/pIt8y+sRL8PGb7DTtZes5oy7/yCul2H3wDhsobDQiPJ8m
         KTNn6klHSXQM/8U3PnGXufbS5RpERxQrKSa7ceLch2+ASRJRH4TSWPXVI2E4NWk/qRhv
         zgPVwssKhF/KyW16SfIk1npr+RwGp4HUHzCUwx1T3dQsiJGyy8jaIrYIAYHvmP/TTKzR
         1mZog8N9YwX/BhJZWNRfSW87ZGB8DauuECUTLATwPlOCuVPlEHCIUhTY0sNhwjs4cgZ7
         NjtQ==
X-Gm-Message-State: ANhLgQ1BMqeWiYa0WFYAa4rjcbEi0xywbhvOIHZLR9n6Dppb5rNnB2pM
        TwZUgGhIQHFj5U2tAyPH8RIC/QFdRcA+KNEuGo4x7w==
X-Google-Smtp-Source: ADFU+vtV/3QnmLNUezgyv8VStO5uYY+S+sx5ZNP2mhhnVIGPPCKJl2hcyaOkIWXF/dIC/PIi4nqGuhZAh3mfFWAL+mg=
X-Received: by 2002:a92:d745:: with SMTP id e5mr20045107ilq.285.1583849824037;
 Tue, 10 Mar 2020 07:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-9-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-9-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 15:16:53 +0100
Message-ID: <CAJfpegsY1LBe85-Dx49LwM9TOrHE0aQq1CAtZQdYr4pYn5tBbg@mail.gmail.com>
Subject: Re: [PATCH 08/20] fuse,virtiofs: Add a mount option to enable dax
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Add a mount option to allow using dax with virtio_fs.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>

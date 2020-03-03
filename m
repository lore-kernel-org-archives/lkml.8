Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981AEC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDC320838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eE0+Ucwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgCCOtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:49:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33775 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729372AbgCCOtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583246970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZAMz9trEBbggImBzI8TwjqrfBpm7beP6aWAuQ0+PcZA=;
        b=eE0+UcwgNrtQ7W4swxVaZv4ztdpWTyVWPVBnmdeiJ7GlDrVNl/+Y4gEbyeY17hHw7dEGaj
        IU2fDDhCVmsALWZckBJM1xk0HAo+pCZ4wMl6LgCyNBe+bfy9TKsMYijvh99zaE0g1YMR2S
        voRk1KCNCy93zIz2wHiOnLud+hvcEgE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-i_EgLToROyC6dyiyAiA7Pw-1; Tue, 03 Mar 2020 09:49:27 -0500
X-MC-Unique: i_EgLToROyC6dyiyAiA7Pw-1
Received: by mail-qv1-f72.google.com with SMTP id u5so2188097qvj.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 06:49:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZAMz9trEBbggImBzI8TwjqrfBpm7beP6aWAuQ0+PcZA=;
        b=gd4D1dez929OS4ZyeVL6qzRA2VVis4+yEpo361FO5mnfk5mdD/aii+RWIp36QAjQGN
         eDZp3eTvUKInpY6DrlcNKp68RT3Z38IllDSSgrzp0BHh1jvhQeOqZhV6xYDwo1XOygmJ
         FmCMVZlc/yMS99K2wejdyUO1cI1XcLx89T15ga26vEoB0SGVnI3RW4OzbtemqxH8BpDG
         yDFlBIJAa5DvM+4vxyuHnCwEAHpSKZhiR39VzcBLdVf1KUmF8l8jlln0nC1dYT9hhPwU
         QnRZbZjLAceZdVAEhNbU6hXvtQzmZbdaPqdhb9mj5SGu8EHDRMtDkZqcYHyxYPBXK6dN
         3sAg==
X-Gm-Message-State: ANhLgQ0shJsVJD6fP7TI8WJGkyYAzoCKzDxiScC566U41qiy5NDe6G69
        QwtwICPnkikv+D9Ditdw89ltOWbWCR99MI84tY3F/PGEpQGErPGhKDTkaF8N+zVpYHQMxsY1g6B
        qoXJoI4cojUSNaT3+MZzzRlHe
X-Received: by 2002:a0c:f692:: with SMTP id p18mr4372506qvn.61.1583246967041;
        Tue, 03 Mar 2020 06:49:27 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsyjBrEg2YMLlS4Ny5GGY4zKEspwxCc/KeO/4ULBZu3vu5BQGOxB/vGW3jXL4KM69SWf9Bpkw==
X-Received: by 2002:a0c:f692:: with SMTP id p18mr4372474qvn.61.1583246966856;
        Tue, 03 Mar 2020 06:49:26 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id g8sm3079010qke.1.2020.03.03.06.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:49:26 -0800 (PST)
Date:   Tue, 3 Mar 2020 09:49:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 0/2] virtio-blk: improve handling of DMA mapping failures
Message-ID: <20200303094909-mutt-send-email-mst@kernel.org>
References: <20200213123728.61216-1-pasic@linux.ibm.com>
 <20200303151252.59d45e86.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303151252.59d45e86.pasic@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 03:12:52PM +0100, Halil Pasic wrote:
> On Thu, 13 Feb 2020 13:37:26 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > Two patches are handling new edge cases introduced by doing DMA mappings
> > (which can fail) in virtio core.
> > 
> > I stumbled upon this while stress testing I/O for Protected Virtual
> > Machines. I deliberately chose a tiny swiotlb size and have generated
> > load with fio. With more than one virtio-blk disk in use I experienced
> > hangs.
> > 
> > The goal of this series is to fix those hangs.
> > 
> > Halil Pasic (2):
> >   virtio-blk: fix hw_queue stopped on arbitrary error
> >   virtio-blk: improve virtqueue error to BLK_STS
> > 
> >  drivers/block/virtio_blk.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > 
> > base-commit: 39bed42de2e7d74686a2d5a45638d6a5d7e7d473
> 
> ping
> 
> Hi Michael, hi Jason,
> 
> I got some favorable reviews for this, but AFAIK I got nothing form the
> maintainers yet.
> 
> Is some of you going to pick these?
> 
> Regards,
> Halil

I've queued this, thanks!


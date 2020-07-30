Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B935C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532F52070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cq7Ip1mZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgG3TxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:53:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32719 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726838AbgG3TxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 15:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596138793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LUonSFV6XEmNIUenD36yg/0NS2iO4j/UJ8CxJKTK1/c=;
        b=Cq7Ip1mZ48AX6la10bcYwXiKWSC3rFZGnUjr08+orYUemcm/PxphRCT2q3T4L1ni+TndGT
        8vF/7rwJdiPH/ZsBXoXYBiF1JS3X/AQnKnuCP1f3SPTKHlojvm6omvD/a0ka2TFo4j0j3H
        v933QdyiCHQ08g9GQmyTRdp6hx3ALpA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-bPXOrlLxMZ-UeLzHxjHEYA-1; Thu, 30 Jul 2020 15:53:11 -0400
X-MC-Unique: bPXOrlLxMZ-UeLzHxjHEYA-1
Received: by mail-wr1-f70.google.com with SMTP id b13so5574462wrq.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 12:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LUonSFV6XEmNIUenD36yg/0NS2iO4j/UJ8CxJKTK1/c=;
        b=leF86NPsJasKdwtPzMf1/bmEZikdEGkheeGYHwOQDDhCvLkKLmXP3CcVUxhdRYkJ2k
         PwIM1cj+QwLhBd6RjEqlG6BmkN21B4A4uo6/B5DnB35liGU4syn+Z0iamzgSX22WYMNF
         6Fp4hE6wLT8+NiuWpPrO86cXOlJdpuzlhKXVB10o/zwjuXAp3aUnGE167eBWYqG9H0zV
         AHBstSlsbytkTtXibTLjhrrhDbWC6gAs8RFVJyH9HjZm/HoGV3c25TgioO26ccKo4v9t
         7cZwx3CuyBF8jpiGOvHFbKuDm/jSQKFrmneylONewswckeqhr5Nt+aMVZzTDXzNCUVNc
         oPlQ==
X-Gm-Message-State: AOAM530sp/3GoaSSSfDfERlUTTr4jk81Gjd6qXIxMiX2YrSQ3oaHy/OW
        LF0ou1xBNcUZ9MSUp65pyeKV/EXYBVV5oqzZXHQyoPrcxZp2lAiF58SUKD7F5XZ/iJ7aSizfk7U
        J0es4eb6c+gpVoDJOJf0TRa8M
X-Received: by 2002:a5d:5086:: with SMTP id a6mr307337wrt.304.1596138790350;
        Thu, 30 Jul 2020 12:53:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtUCkyYmzlnOirlC1EsPCXGLv7EslLS3tLClf3ZG6+NqtRlH5qYQ9cAiYMPVBZRUrE1bGksg==
X-Received: by 2002:a5d:5086:: with SMTP id a6mr307325wrt.304.1596138790132;
        Thu, 30 Jul 2020 12:53:10 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
        by smtp.gmail.com with ESMTPSA id 3sm312979wms.36.2020.07.30.12.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 12:53:09 -0700 (PDT)
Date:   Thu, 30 Jul 2020 15:53:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the vhost tree
Message-ID: <20200730155043-mutt-send-email-mst@kernel.org>
References: <20200728080556.447ba206@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728080556.447ba206@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 08:05:56AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> ommit
> 
>   ed944d574cc7 ("ack! virtio: VIRTIO_F_IOMMU_PLATFORM -> VIRTIO_F_ACCESS_PLATFORM")
> 
> is missing a Signed-off-by from its author and committer.
> 
> I have never seen an empty commit like this before - I assume it is just
> a way to add an Reviewed-by to a previous commit without rebaseing
> the tree.

Yes - I'm using these to record acks, then squash before the pull
request. git patches I'm using to support this are here - I've rebased
since but didn't have the energy to advocate for upstreaming:
https://lore.kernel.org/r/1460296343-17304-1-git-send-email-mst%40redhat.com


> -- 
> Cheers,
> Stephen Rothwell



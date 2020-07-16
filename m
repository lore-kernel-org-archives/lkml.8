Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CD0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F964206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MO8/5ogS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgGPGnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:43:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28496 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbgGPGne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594881813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=92A49Ojmn2AU0Fmvk+D6Q53rRv9UoaDayPIPpa5wWcs=;
        b=MO8/5ogSgdemiaogmGgiARWFGj9RpG7wn1e0V0kcMI0DZdR+MWf7nt2aF+VvyQEGYfW5WF
        UaEEooi7g4df/WZkWuDPmbinoStPKP5l0Qy2Px00HmAG89DpftWGRcVvT6W8vH9cMWAEGA
        ws6/qnCT6oi+j1k2QXU8604NBG1/cJ8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-agiQ7in4NsaR7ImE9y9K4g-1; Thu, 16 Jul 2020 02:43:29 -0400
X-MC-Unique: agiQ7in4NsaR7ImE9y9K4g-1
Received: by mail-wr1-f71.google.com with SMTP id c6so4728557wru.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=92A49Ojmn2AU0Fmvk+D6Q53rRv9UoaDayPIPpa5wWcs=;
        b=rzuKwp45Kcteg/WbwCIYbtGxx4UOWtf6aRbJ5Rx1dspU+MbU9Ds+bW1+p1J6bEQ3Ya
         a9HtTDyQgaRbFYpSNt5DoYN+XmmWZpzV/ZvcsaPEG1DKtiI4fh/sRvOoulOGlFb0OJoX
         EPN6FXiRN+rAOVun6WUYEIrkTxLjHKAWzDOk7AntmpzZ3quSBv1ZMVMCYEGubiadKPdL
         +KMOHZXIWNMTfO8yWyd/5e/Ti4Evi50HEsCZBXIQ4E2qExPMJDf10WxupF/5ID6fTv8+
         pHkZZ4vIJX/DaWzfFoqhb65ffWjamB9dMaLd3+aTyPuIHbGTHieiF2sQTxwIl7Wbi+dl
         CH2Q==
X-Gm-Message-State: AOAM5316ilekklxaBdC3b6zHghEr5xYVpwPsicX1CwE1BnOJI9InsUD/
        HHTwmV3zXWHx9vxR8lkL72dXkYEl1Wv9RUvNEtHEBT7Cuv3MBj9dNeICYhH43yOr8lFtn+5334m
        2+hpCctnYI5PMPYANq5nwnja5
X-Received: by 2002:a1c:9a07:: with SMTP id c7mr2963443wme.147.1594881808573;
        Wed, 15 Jul 2020 23:43:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6DpABEgJSEbkgqOOGpGbulniuOcb/AXbRsfBNAusCpgTzcOusCDH2paSBBwm1ZZJQp/CfjQ==
X-Received: by 2002:a1c:9a07:: with SMTP id c7mr2963420wme.147.1594881808359;
        Wed, 15 Jul 2020 23:43:28 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id g3sm8085920wrb.59.2020.07.15.23.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 23:43:27 -0700 (PDT)
Date:   Thu, 16 Jul 2020 02:43:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Hui Zhu <teawater@gmail.com>
Cc:     david@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
        Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [RFC for Linux v4 1/2] virtio_balloon: Add
 VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
Message-ID: <20200716024114-mutt-send-email-mst@kernel.org>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <1594867315-8626-2-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594867315-8626-2-git-send-email-teawater@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:41:51AM +0800, Hui Zhu wrote:
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index dc3e656..4d0151a 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -37,6 +37,7 @@
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
>  #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
> +#define VIRTIO_BALLOON_F_CONT_PAGES	6 /* VQ to report continuous pages */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12

So how does the guest/host interface look like?
Could you write up something about it?


Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B9BC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD2420658
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Juip76GX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgBFWHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:07:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53502 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727675AbgBFWHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 17:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581026851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCVOUfYXtJqZqTDmxurK3VSKtKDk2XaSteNP/54JEfc=;
        b=Juip76GXFQkUK41OBD1bVLJog6hriJyOMgtZ3Yysp7GI6MLac7VUsig3isxYPPFKqAP4sG
        +kyw01a+0BgI9RNKEKWpRCc/fzJl1Jx2BLtP56N+46ZuRwXkLsZ5oLe8q3crrzvM7aDEnr
        wDvipVcaIBUFRFDuvr0XqFhedCKYNgE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-sAYAz7n9PI6BDhlkInb4YQ-1; Thu, 06 Feb 2020 17:07:27 -0500
X-MC-Unique: sAYAz7n9PI6BDhlkInb4YQ-1
Received: by mail-qv1-f69.google.com with SMTP id n11so4628917qvp.15
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 14:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gCVOUfYXtJqZqTDmxurK3VSKtKDk2XaSteNP/54JEfc=;
        b=M6gGCm7PKM0XXZuZyEiP8yhR2eaNIRnvYZdYlJsoiwJcWPnLKHaW8/KbgVkMhOOCHN
         u0v8gJGA+hwJzGcC3HSC0UAW0uFDpOkG9tZvM1Z15DgIWM4qJ8x1/7ui8OSOVlHmW0kS
         gllxLxjAspru7jKXikdyJvhD8hbDS83D/g5iBHwaJ1LciaynlGCtkkzVltBEgD2jzmIg
         XEN4OnP20O3BkjO1Y9o10mGuvIOK2PNDSJr0zXG5FplYql6L+3B1muXKRatZvxR/+Olk
         ZjY0AXGl2//IpBPWrZkSWaE2W4lwAEY3Xr3fnEuos2Um/18iYwqZCLVLUwcsFH2xE9cM
         7A5g==
X-Gm-Message-State: APjAAAUoWtEf9ioCKhigMznMzTJLDo7wobeYt0eJMm4taYYr0S6hqhnr
        4mm46wh/1CfZ2uaRXmd+8bx5LiwBE1K8bqtDV44IEg8dBaA5E42/eE8umLb8JcwbnLBQAwAypHB
        ZkWRpvZSowoEdJ97ugB8EiBEf
X-Received: by 2002:a37:9ce:: with SMTP id 197mr4617854qkj.194.1581026846348;
        Thu, 06 Feb 2020 14:07:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqzAgfHaRVNBIU1YBIUwKBiXLz4+7Fyka8EXNPWEWH74Hw3OkWCnDHFfZMkzruPNBzMPRLUrJA==
X-Received: by 2002:a37:9ce:: with SMTP id 197mr4617822qkj.194.1581026846050;
        Thu, 06 Feb 2020 14:07:26 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id z5sm383804qta.7.2020.02.06.14.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 14:07:25 -0800 (PST)
Date:   Thu, 6 Feb 2020 17:07:20 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     eperezma@redhat.com
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: vhost changes (batched) in linux-next after 12/13 trigger random
 crashes in KVM guests after reboot
Message-ID: <20200206170005-mutt-send-email-mst@kernel.org>
References: <2ffdbd95-e375-a627-55a1-6990b0a0e37a@de.ibm.com>
 <20200106054041-mutt-send-email-mst@kernel.org>
 <08ae8d28-3d8c-04e8-bdeb-0117d06c6dc7@de.ibm.com>
 <20200107042401-mutt-send-email-mst@kernel.org>
 <c6795e53-d12c-0709-c2e9-e35d9af1f693@de.ibm.com>
 <20200107065434-mutt-send-email-mst@kernel.org>
 <fe6e7e90-3004-eb7a-9ed8-b53a7667959f@de.ibm.com>
 <20200120012724-mutt-send-email-mst@kernel.org>
 <2a63b15f-8cf5-5868-550c-42e2cfd92c60@de.ibm.com>
 <b6e32f58e5d85ac5cc3141e9155fb140ae5cd580.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6e32f58e5d85ac5cc3141e9155fb140ae5cd580.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 03:22:39PM +0100, eperezma@redhat.com wrote:
> Hi Christian.
> 
> Could you try this patch on top of ("38ced0208491 vhost: use batched version by default")?
> 
> It will not solve your first random crash but it should help with the lost of network connectivity.
> 
> Please let me know how does it goes.
> 
> Thanks!
> 
> >From 99f0f543f3939dbe803988c9153a95616ccccacd Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
> Date: Thu, 6 Feb 2020 15:13:42 +0100
> Subject: [PATCH] vhost: filter valid vhost descriptors flags
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Previous commit copy _NEXT flag, and it complains if a copied descriptor
> contains it.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  drivers/vhost/vhost.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 27ae5b4872a0..56c5253056ee 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2125,6 +2125,8 @@ static void pop_split_desc(struct vhost_virtqueue *vq)
>  	--vq->ndescs;
>  }
>  
> +#define VHOST_DESC_FLAGS (VRING_DESC_F_INDIRECT | VRING_DESC_F_WRITE | \
> +			  VRING_DESC_F_NEXT)
>  static int push_split_desc(struct vhost_virtqueue *vq, struct vring_desc *desc, u16 id)
>  {
>  	struct vhost_desc *h;
> @@ -2134,7 +2136,7 @@ static int push_split_desc(struct vhost_virtqueue *vq, struct vring_desc *desc,
>  	h = &vq->descs[vq->ndescs++];
>  	h->addr = vhost64_to_cpu(vq, desc->addr);
>  	h->len = vhost32_to_cpu(vq, desc->len);
> -	h->flags = vhost16_to_cpu(vq, desc->flags);
> +	h->flags = vhost16_to_cpu(vq, desc->flags) & VHOST_DESC_FLAGS;
>  	h->id = id;
>  
>  	return 0;



> @@ -2343,7 +2345,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  		struct vhost_desc *desc = &vq->descs[i];
>  		int access;
>  
> -		if (desc->flags & ~(VRING_DESC_F_INDIRECT | VRING_DESC_F_WRITE)) {
> +		if (desc->flags & ~VHOST_DESC_FLAGS) {
>  			vq_err(vq, "Unexpected flags: 0x%x at descriptor id 0x%x\n",
>  			       desc->flags, desc->id);
>  			ret = -EINVAL;
> -- 
> 2.18.1

Thanks for catching this!

Do we need the 1st chunk though?

It seems preferable to just muck with flags in 1 place, when we
validate them ...

> 
> On Wed, 2020-01-22 at 20:32 +0100, Christian Borntraeger wrote:
> > 
> > On 20.01.20 07:27, Michael S. Tsirkin wrote:
> > > On Tue, Jan 07, 2020 at 01:16:50PM +0100, Christian Borntraeger wrote:
> > > > On 07.01.20 12:55, Michael S. Tsirkin wrote:
> > > > 
> > > > > I pushed batched-v3 - same head but bisect should work now.
> > > > > 
> > > > 
> > > > With 
> > > > commit 38ced0208491103b50f1056f0d1c8f28e2e13d08 (HEAD)
> > > > Author:     Michael S. Tsirkin <mst@redhat.com>
> > > > AuthorDate: Wed Dec 11 12:19:26 2019 -0500
> > > > Commit:     Michael S. Tsirkin <mst@redhat.com>
> > > > CommitDate: Tue Jan 7 06:52:42 2020 -0500
> > > > 
> > > >     vhost: use batched version by default
> > > > 
> > > > 
> > > > I have exactly one successful ping and then the network inside the guest is broken (no packet
> > > > anymore).
> > > 
> > > Does anything appear in host's dmesg when this happens?
> > 
> > I think there was nothing, but I am not sure. I would need to redo the test if this is important to know.
> > 
> > > 
> > > > So you could consider this commit broken (but in a different way and also without any
> > > > guest reboot necessary).
> > > > 
> > > > 
> > > > bisect log:
> > > > git bisect start
> > > > # bad: [d2f6175f52062ee51ee69754a6925608213475d2] vhost: use vhost_desc instead of vhost_log
> > > > git bisect bad d2f6175f52062ee51ee69754a6925608213475d2
> > > > # good: [d1281e3a562ec6a08f944a876481dd043ba739b9] virtio-blk: remove VIRTIO_BLK_F_SCSI support
> > > > git bisect good d1281e3a562ec6a08f944a876481dd043ba739b9
> > > > # good: [fac7c0f46996e32d996f5c46121df24a6b95ec3b] vhost: option to fetch descriptors through an independent
> > > > struct
> > > > git bisect good fac7c0f46996e32d996f5c46121df24a6b95ec3b
> > > > # bad: [539eb9d738f048cd7be61f404e8f9c7d9d2ff3cc] vhost: batching fetches
> > > > git bisect bad 539eb9d738f048cd7be61f404e8f9c7d9d2ff3cc


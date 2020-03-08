Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A29C18E5B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 07:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C5620663
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 07:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epTEvCJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgCHH6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 03:58:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39198 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbgCHH6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 03:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583654293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/iQ3FcNLQi6DjD/zqwYipJZvlLCEPpHUkTbLpJbck20=;
        b=epTEvCJ+aneXSiVlVbGQ849E1QJeGlzYPTRzxYVUQz1VULvtHylB0W8hXzDxaak+Y/9HTQ
        II6HbsbvMnGcsztRfuj6K0xQPvF1E6+Wu9m1g1tofS8iPWufJNQBcJvQua7xBOPbpvY3ZM
        RLdM/bDH51PrQvMjiRr5sR1GEHGPmRI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-unkFEO4OPzClP2pYeqgl8Q-1; Sun, 08 Mar 2020 03:58:11 -0400
X-MC-Unique: unkFEO4OPzClP2pYeqgl8Q-1
Received: by mail-qk1-f199.google.com with SMTP id z124so4962349qkd.20
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 23:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/iQ3FcNLQi6DjD/zqwYipJZvlLCEPpHUkTbLpJbck20=;
        b=DCrOEkGGXkmEHRi5sWZ1KC4IZTB81+OscsLiSGR4koO2xzOl80vPIhp44WvEOPoxEJ
         LjbVP51WNtbkIxpTqSOtnCN8VeubIjyks/q1v7WCDolUshbOkkOi91MmfS2ME6RcpHHK
         dQ5g86YNdZiKbn/bULvpc4AzXsQMXeIOuRs/TerNWq4baLokNqPd++idKBhOMttMjMEE
         UpF26skXyTRA1GbFZUrBFhNXyy7WxzvHwub2sKLwd/LXoTJY1TH6QDkA+xXPNIVJDn0t
         jn+tig0yGy6Jje8Lwl5OGTdpFBuEFH2t+3rHvqy4PLSWHUYTjBjt29igNqAPm/xddejb
         R5ZQ==
X-Gm-Message-State: ANhLgQ0Ujgs9J3Wrg3E9qjABD2JkeTmrEtt64G8suFFlTXts1mlRTESg
        CmndWSL95Dy/4GmMTYgELuTu+qajfAPJCejnBAU6lnOS8dSteHF8TYeOtderFRJVOzGr8GZv6NQ
        1z5RF3BH4wh7/D9/t69e5/XSA
X-Received: by 2002:a0c:fc46:: with SMTP id w6mr10078462qvp.46.1583654290653;
        Sat, 07 Mar 2020 23:58:10 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvvApe3sCEXq2f20G7j5KtC2UjY5EK9LLdWQ6XZXZsCsV5yGgnxLOyL/CYD4IMH7RPUgWBaWA==
X-Received: by 2002:a0c:fc46:: with SMTP id w6mr10078456qvp.46.1583654290419;
        Sat, 07 Mar 2020 23:58:10 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id f128sm20670117qke.54.2020.03.07.23.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 23:58:09 -0800 (PST)
Date:   Sun, 8 Mar 2020 03:58:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Suman Anna <s-anna@ti.com>
Cc:     Jason Wang <jasowang@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: Fix mem leak with vring_new_virtqueue()
Message-ID: <20200308035751-mutt-send-email-mst@kernel.org>
References: <20200224212643.30672-1-s-anna@ti.com>
 <b622c831-9adb-b9af-dd4a-21605bc124a8@redhat.com>
 <0ace3a3b-cf2f-7977-5337-f74f530afbe1@ti.com>
 <1ce2bee4-64ed-f630-2695-8e8b9b8e27c1@redhat.com>
 <a4335428-e29e-d567-b18b-3c144020a726@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4335428-e29e-d567-b18b-3c144020a726@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 06:27:53PM -0600, Suman Anna wrote:
> On 2/25/20 9:13 PM, Jason Wang wrote:
> > 
> > On 2020/2/26 上午12:51, Suman Anna wrote:
> >> Hi Jason,
> >>
> >> On 2/24/20 11:39 PM, Jason Wang wrote:
> >>> On 2020/2/25 上午5:26, Suman Anna wrote:
> >>>> The functions vring_new_virtqueue() and __vring_new_virtqueue() are
> >>>> used
> >>>> with split rings, and any allocations within these functions are
> >>>> managed
> >>>> outside of the .we_own_ring flag. The commit cbeedb72b97a
> >>>> ("virtio_ring:
> >>>> allocate desc state for split ring separately") allocates the desc
> >>>> state
> >>>> within the __vring_new_virtqueue() but frees it only when the
> >>>> .we_own_ring
> >>>> flag is set. This leads to a memory leak when freeing such allocated
> >>>> virtqueues with the vring_del_virtqueue() function.
> >>>>
> >>>> Fix this by moving the desc_state free code outside the flag and only
> >>>> for split rings. Issue was discovered during testing with remoteproc
> >>>> and virtio_rpmsg.
> >>>>
> >>>> Fixes: cbeedb72b97a ("virtio_ring: allocate desc state for split ring
> >>>> separately")
> >>>> Signed-off-by: Suman Anna<s-anna@ti.com>
> >>>> ---
> >>>>    drivers/virtio/virtio_ring.c | 4 ++--
> >>>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/virtio/virtio_ring.c
> >>>> b/drivers/virtio/virtio_ring.c
> >>>> index 867c7ebd3f10..58b96baa8d48 100644
> >>>> --- a/drivers/virtio/virtio_ring.c
> >>>> +++ b/drivers/virtio/virtio_ring.c
> >>>> @@ -2203,10 +2203,10 @@ void vring_del_virtqueue(struct virtqueue *_vq)
> >>>>                         vq->split.queue_size_in_bytes,
> >>>>                         vq->split.vring.desc,
> >>>>                         vq->split.queue_dma_addr);
> >>>> -
> >>>> -            kfree(vq->split.desc_state);
> >>>>            }
> >>>>        }
> >>>> +    if (!vq->packed_ring)
> >>>> +        kfree(vq->split.desc_state);
> >>> Nitpick, it looks to me it would be more clear if we just free
> >>> desc_state unconditionally here (and remove the kfree for packed above).
> >> OK, are you sure you want that to be folded into this patch? It looks to
> >> me a separate cleanup/consolidation patch, and packed desc_state does
> >> not suffer this memleak, and need not be backported into stable kernels.
> >>
> >> regards
> >> Suman
> > 
> > 
> > Though it's just a small tweak, I'm fine for leaving it for future.
> > 
> > So
> > 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > 
> 
> Mike,
> Ping on this. I don't see the patch in -next yet. Can we get this into
> the current -rc please?
> 
> regards
> Suman

Yes will queue it shortly, thanks!


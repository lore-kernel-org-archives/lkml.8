Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CBBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F7C206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="KhJANJU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgFJJyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:54:41 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:33629 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726134AbgFJJyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:54:40 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id ixRJjgJMuCKzeixRMjw3Ui; Wed, 10 Jun 2020 11:54:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1591782877; bh=UKKC4lsJxXul3tVWpUH4LyGRd0yXx/B0dewcMqePNYI=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=KhJANJU5KLyLUVSaqnVwzXSx1GLZ+e77NX/312I+8A0xJG57sTACT8PBzPT9WwbMB
         iINX/YaWFV6rQxxnkjexpMMNdEF/CavpoVpudi+AF69CLnIbYW8DtdzWhGpSqYMGVW
         tW45nrDBEqkmqtCAIynxaWx3TTvagTqy0BjXVpjNvqs0Cr+DSdtM6HOm8iX57V2vA8
         31/+oOM9PMPKfNqxHaKjTzrnNVJbqEEuwwYQIJ10FdBv3/gXODph20aSJ1C5tL7Lm1
         1YJCzC/K7oMuCcaW/sj0Mx4itXdpaf8sU1WU6vfDNFX1JAY0O246t8PfLBakSu+Sp+
         uH5tZ/mj/YO5g==
Subject: Re: [PATCH] videobuf2: always re-init queue memory consistency
 attribute
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200609060417.8066-1-sergey.senozhatsky@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <d1ebdb9b-ceea-3582-831d-7cef5134d8f9@xs4all.nl>
Date:   Wed, 10 Jun 2020 11:54:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200609060417.8066-1-sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCug7zR+tx/WAQIH6jZfw/PBBpdB7WovrawVS0qZHcF/kFdNeSohTNdE55yzvLs97LFmRERZmZSCZworChSvX3f0ONgRem9Xb2RVd/cz3KqHp85jWYL7
 /w+ccgar+3XIB/Xsmqr4HQqoWN+liSmraHeBozl6HZFnLrwSBTiIW9FLYR470XwJeJqjOx3yclIyJLYNoJLoR4REoch8UT6B6AiR23Ej+Uyd2qHkQZ2CzXPV
 FeQss9oZ6o0c8rTiXWI+IbjSrREbXxk70nQcsPMqPFFcUnFmmSin5ezZ8XOO4s5ijAtgH1jjktXUlELFLRhUMA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On 09/06/2020 08:04, Sergey Senozhatsky wrote:
> We need a combination of two factors in order to permit modification
> of queue's memory consistency attribute in set_queue_consistency():
>   (1) queue should allow user-space cache hints
>   (2) queue should be used for MMAP-ed I/O
> 
> Therefore the code in videobuf2 core looks as follows:
> 
> 	q->memory = req->memory;
> 	set_queue_consistency(q, consistent);
> 
> This works when we do something like this (suppose that queue allows
> cache hints)
> 
> 	reqbufs.memory = V4L2_MEMORY_DMABUF;
> 	reqbufs.flags = 0;
> 	doioctl(node, VIDIOC_REQBUFS, &reqbufs);
> 
> 	reqbufs.memory = V4L2_MEMORY_MMAP;
> 	reqbufs.flags = V4L2_FLAG_MEMORY_NON_CONSISTENT;
> 	doioctl(node, VIDIOC_REQBUFS, &reqbufs);
> 
> However, this doesn't work the other way around
> 
> 	reqbufs.memory = V4L2_MEMORY_MMAP;
> 	reqbufs.flags = V4L2_FLAG_MEMORY_NON_CONSISTENT;
> 	doioctl(node, VIDIOC_REQBUFS, &reqbufs);
> 
> 	reqbufs.memory = V4L2_MEMORY_DMABUF;
> 	reqbufs.flags = 0;
> 	doioctl(node, VIDIOC_REQBUFS, &reqbufs);
> 
> because __vb2_queue_free() doesn't clear queue's ->dma_attrs
> once its don't freeing queue buffers, and by the time we call
> set_queue_consistency() the queue is DMABUF so (2) is false
> and we never clear the stale consistency attribute.
> 
> Re-implement set_queue_consistency() - it must always clear
> queue's non-consistency attr and set it only if (1) and (2).
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 7e081716b8da..37d0186ba330 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -704,12 +704,11 @@ EXPORT_SYMBOL(vb2_verify_memory_type);
>  
>  static void set_queue_consistency(struct vb2_queue *q, bool consistent_mem)
>  {
> +	q->dma_attrs &= ~DMA_ATTR_NON_CONSISTENT;
> +
>  	if (!vb2_queue_allows_cache_hints(q))
>  		return;
> -
> -	if (consistent_mem)
> -		q->dma_attrs &= ~DMA_ATTR_NON_CONSISTENT;
> -	else
> +	if (!consistent_mem)
>  		q->dma_attrs |= DMA_ATTR_NON_CONSISTENT;
>  }
>  
> 

Is it OK with you if I fold this patch into the original patch series and make a
new PR for it? I prefer to have a series merged without a bug, rather than fixing
it in a final patch.

Regards,

	Hans

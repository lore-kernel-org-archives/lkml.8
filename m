Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021EBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33782072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdoDIF+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgFKLlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:41:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47473 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726684AbgFKLlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591875679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N+hOhqTQBMwp4AmRlzbOHmDQ8McxlMKMKGqAqlXUfCE=;
        b=CdoDIF+KrNGLpI3MM+KrTsH4w1jjysPL1hgIWrKYkGgqYg0rpc1AfrGoClBWNlU/vza56w
        WgX0J7vgrUeneyOa3oPrYMdY73p1ftRX0ytn/uVwemitHjywqpci6ERPXGeVESL7f8tXi/
        dFBQcG8pIRrFkeJvV3T9cNF0Cl9RAM4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-5jpjiH5ONKu3TbMDdC771g-1; Thu, 11 Jun 2020 07:41:18 -0400
X-MC-Unique: 5jpjiH5ONKu3TbMDdC771g-1
Received: by mail-wm1-f70.google.com with SMTP id h6so1019969wmb.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N+hOhqTQBMwp4AmRlzbOHmDQ8McxlMKMKGqAqlXUfCE=;
        b=lZ3Cr6iQSx5rSt1jn8izFmCeM/IDLNq3OXyDahU6GMGk7X9nzmiru1EKeOi2mp/PPG
         HY7DeVZl6hMyfI8XWXztIqOU8AR8WckQ0DxpqhunAJPKy642EoKODDp9t9Kbk4smxjr4
         2jLbFB9qKxemA6xirf0UAIOuN3+A4HaZqWDf2zILaV3O+O/DpsLLBEL9AaN5lBuOCZs/
         NF1+HOZ0yWcmpTeNBIfet13/Hav59VUdj1XK+8YVlQpfq545KeN7ap+SMkDK4Beon7XV
         21UzzTip0JoFWdpsMRidgu4CE+Wxaa0IDA9krUR9ZWzfRp7V7f5fL+wFHYWU8hkvzBjA
         VvzQ==
X-Gm-Message-State: AOAM531PaiZ3fHpljkg5v44PaDf6/NMrJ7RjegmDaRUM1820jQ9ynLkA
        qGq2Qw/tHJi6l8DGE42Q5UM+Vy3CADltfQub8vJ4b0LBhvyRwkXzazBwsB2JR7414avqqaWaBDQ
        AnTAwEBgVkd6FRy1P0Ck++7b4
X-Received: by 2002:a7b:c40e:: with SMTP id k14mr8259481wmi.59.1591875676951;
        Thu, 11 Jun 2020 04:41:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkpzm1AHXvvYbOTpCzrh8Us+16Cfza99czVInZxHNWwmzLaKoW7HIE1UmlxalWp27taecVCA==
X-Received: by 2002:a7b:c40e:: with SMTP id k14mr8259469wmi.59.1591875676754;
        Thu, 11 Jun 2020 04:41:16 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
        by smtp.gmail.com with ESMTPSA id g3sm5069764wrb.46.2020.06.11.04.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 04:41:16 -0700 (PDT)
Date:   Thu, 11 Jun 2020 07:41:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        teawater <teawaterz@linux.alibaba.com>
Subject: Re: [PATCH v1] virtio-mem: add memory via add_memory_driver_managed()
Message-ID: <20200611073943-mutt-send-email-mst@kernel.org>
References: <20200611071744-mutt-send-email-mst@kernel.org>
 <613382D2-5F4D-4A32-AC8E-E1D03240036F@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <613382D2-5F4D-4A32-AC8E-E1D03240036F@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 01:33:04PM +0200, David Hildenbrand wrote:
> 
> 
>     Am 11.06.2020 um 13:18 schrieb Michael S. Tsirkin <mst@redhat.com>:
> 
> 
>     On Thu, Jun 11, 2020 at 01:00:24PM +0200, David Hildenbrand wrote:
> 
>                 I'd like to have this patch in 5.8, with the initial merge of
>                 virtio-mem
> 
>                 if possible (so the user space representation of virtio-mem
>                 added memory
> 
>                 resources won't change anymore).
> 
>            
> 
>             So my plan is to rebase on top of -rc1 and merge this for rc2 then.
> 
>             I don't like rebase on top of tip as the results are sometimes kind
>             of
> 
>             random.
> 
>        
> 
>         Right, I just wanted to get this out early so we can discuss how to
>         proceed.
> 
>        
> 
>             And let's add a Fixes: tag as well, this way people will remember
>             to
> 
>             pick this.
> 
>             Makes sense?
> 
>        
> 
>         Yes, it's somehow a fix (for kexec). So
> 
>        
> 
>         Fixes: 5f1f79bbc9e26 ("virtio-mem: Paravirtualized memory hotplug")
> 
>        
> 
>         I can respin after -rc1 with the commit id fixed as noted by Pankaj.
> 
>         Just let me know what you prefer.
> 
>        
> 
>         Thanks!
> 
>    
>     Some once this commit is in Linus' tree, please ping me.
> 
> 
> It already is as mentioned, only the id was wrong.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=
> 7b7b27214bba1966772f9213cd2d8e5d67f8487f

OK I pushed this into next based on tip. Let's see what happens.


> 
>    
> 
>         --
> 
>         Thanks,
> 
>        
> 
>         David / dhildenb
> 
>    
> 


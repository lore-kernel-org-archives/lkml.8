Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA61C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E212082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2Qwcsqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgBKOs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:48:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48142 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729041AbgBKOsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581432534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7nfesydZoKg7wB4eAKrBh2n+G/3uidxo6nvSZCLKjmc=;
        b=G2Qwcsqe2pTU2JCLflby/hBLZNmxuLyRDhFfyOVESFDIfoAjmRyc9gGemYFLG0MVfoX1Rw
        Lh+bnh3s109m57H0Py88/SK7/w+33Taz/om1t5PNyNHui2zaga2wx1VCv7AqUY6uBmriFc
        N1EfLSZHX3MLwWjhAXyxJpvnA4K8Juo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-MQiLjUbIMJCI0Afqd4Sa1A-1; Tue, 11 Feb 2020 09:48:52 -0500
X-MC-Unique: MQiLjUbIMJCI0Afqd4Sa1A-1
Received: by mail-qv1-f69.google.com with SMTP id d7so7280332qvq.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 06:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7nfesydZoKg7wB4eAKrBh2n+G/3uidxo6nvSZCLKjmc=;
        b=b2iywpT8QxQqzLaSaDN/4bg9GdEsBYMuxZiYpopNY/7aOCEIM8UJ2/nV2cB7Jt2GZD
         wCw0MMI5gNmi0oAC9HyDeTqIohkMKl32r/ZrRtSL8KYrkUTSrL/BzoNPGIjaU0E5cE5d
         Cux8ZA74RjDKk3wp5HwrCetRwKu1VPK5TymuBJItgIt52Fim8oHsjV/TUtQdLRTUigeP
         lrmPH8hYrXtJXQrdS+eLodEXcRMFpugncXbToYFOYcxIj8C3aCdeI/AWiJvYyzWnDv8U
         RHxML55eJKu9lyFiYKc703n2ZVF1knxzEvgd0ZtgEy7wMp3nb7MN7KG7nNJHEuWK/6X5
         mwHw==
X-Gm-Message-State: APjAAAVQbqLF3vucV0+hc4uYS5c14LpSgkLazol7eCv8IOJoLgQOZQ7b
        TxQS7S/VUn8FJjrx/+GnC0mbOxbJlFOb28CWqvWyvuNobWVdOfDKjdwR9UU+fi1SdSuANh+Qmc4
        i6SMYx0cjH3ItSPNNy/p66c0q
X-Received: by 2002:a37:903:: with SMTP id 3mr3033669qkj.388.1581432532236;
        Tue, 11 Feb 2020 06:48:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUijSiSAKNmsG0wLQ4U4khGmkyoOv0nfwK5grGPQCYnR4o3HHFiCAQ1Fz9hORrM7QHvkhP8g==
X-Received: by 2002:a37:903:: with SMTP id 3mr3033633qkj.388.1581432531928;
        Tue, 11 Feb 2020 06:48:51 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id p18sm2137225qkp.47.2020.02.11.06.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 06:48:51 -0800 (PST)
Date:   Tue, 11 Feb 2020 09:48:44 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, vbabka@suse.cz,
        yang.zhang.wz@gmail.com, nitesh@redhat.com, konrad.wilk@oracle.com,
        pagupta@redhat.com, riel@surriel.com, lcapitulino@redhat.com,
        dave.hansen@intel.com, wei.w.wang@intel.com, aarcange@redhat.com,
        pbonzini@redhat.com, dan.j.williams@intel.com,
        alexander.h.duyck@linux.intel.com, osalvador@suse.de
Subject: Re: [PATCH v16.1 6/9] virtio-balloon: Add support for providing free
 page reports to host
Message-ID: <20200211094357-mutt-send-email-mst@kernel.org>
References: <20200122173040.6142.39116.stgit@localhost.localdomain>
 <20200122174347.6142.92803.stgit@localhost.localdomain>
 <b8cbf72d-55a7-4a58-6d08-b0ac5fa86e82@redhat.com>
 <20200211063441-mutt-send-email-mst@kernel.org>
 <ada0ec83-8e7d-abb3-7053-0ec2bf2a9aa5@redhat.com>
 <20200211090052-mutt-send-email-mst@kernel.org>
 <d6b481fb-6c72-455d-f8e4-600a8677c7a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6b481fb-6c72-455d-f8e4-600a8677c7a8@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 03:31:18PM +0100, David Hildenbrand wrote:
> On 11.02.20 15:07, Michael S. Tsirkin wrote:
> > On Tue, Feb 11, 2020 at 01:19:31PM +0100, David Hildenbrand wrote:
> >>>>
> >>>> Did you see the discussion regarding unifying handling of
> >>>> inflate/deflate/free_page_hinting_free_page_reporting, requested by
> >>>> Michael? I think free page reporting is special and shall be left alone.
> >>>
> >>> Not sure what do you mean by "left alone here". Could you clarify?
> >>
> >> Don't try to unify handling like I proposed below, because it's
> >> semantics are special.
> >>
> >>>
> >>>> VIRTIO_BALLOON_F_REPORTING is nothing but a more advanced inflate, right
> >>>> (sg, inflate based on size - not "virtio pages")?
> >>>
> >>>
> >>> Not exactly - it's also initiated by guest as opposed to host, and
> >>> not guided by the ballon size request set by the host.
> >>
> >> True, but AFAIKS you could use existing INFLATE/DEFLATE in a similar
> >> way. There is no way for the hypervisor to nack a request. The balloon
> >> size is not glued to inflate/deflate requests. The guests manually
> >> updates it.
> > 
> > Hmm how isn't it? num_pages is the only way to inflate/deflate.
> 
> Usually, guests are nice and respond to num_pages changes in an
> appropriate way, except:
> - Triggering deflate: Unload the driver. Suspend/hibernate. OOM.
>   (+ Reboot, although that's special)
> - Triggering inflate + deflate: Simple balloon compaction / page
>   migration.


These are all real situations but balloon always has been best effort.


> But that's not what I meant.
> 
> "actual" is updated by the guest, not by the host. So the "actual
> balloon size" is set by the guest. It's not glued to inflation/deflation
> requests. "num_pages" is the host request.

Well the expectation is that as long as guest has ample
available memory, when num_pages changes then
guest starts sending inflate/deflate requests,
until actual matches num_pages.

If it does not match, and we wait and it still doesn't,
then something unusual happened. People do depend on that
behaviour.

> AFAIKs, the guest could inflate/deflate (esp. temporarily) and
> communicate via "actual" the actual balloon size as he sees it.

OK so you want hinted but unused pages counted, and reported
in "actual"? That's a vmexit before each page use ...



> > Spec also says:
> > The device is driven either by the receipt of a configuration change notification, or by changing guest memory
> > needs, such as performing memory compaction or responding to out of memory conditions.
> > 
> > so ignoring compaction/oom (later is under-specified, not a good example
> > to follow) yes inflate/deflate are tied to host specified configuration
> Yes, "num_pages" is the host request. But I'd say the statement (esp.
> "the device is driven by") in the spec is rather weak. It does not
> explicitly state when inflation/deflation is allowed IMHO.

Right since it's all best effort anyway.


> -- 
> Thanks,
> 
> David / dhildenb


Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E99C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B9B2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBHJqhmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbgCaOSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:18:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45490 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730358AbgCaOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585664304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=utmX18W31kXsBfpUq9t9FaLAztm0XHtfHqqaTLE/HnI=;
        b=XBHJqhmJ9gt3z9d0xW/V0OvEtkCHLfO0qfArN4ka7CADl/cKsYVy+35QKs1pAUdAH+/tex
        Sz74YLDoGUbV38II4mbZkMXcNf2vhxE3zgE2opesY8U55i2lju93dwi7jiRkx9Q3nqrHY4
        ms5H28iZF8rrvqGzdBwYNObpSQQHA5E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-YrKa-dW0Pz-TdNtHJEeMgw-1; Tue, 31 Mar 2020 10:18:22 -0400
X-MC-Unique: YrKa-dW0Pz-TdNtHJEeMgw-1
Received: by mail-wr1-f69.google.com with SMTP id v17so8980002wro.21
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=utmX18W31kXsBfpUq9t9FaLAztm0XHtfHqqaTLE/HnI=;
        b=cXi1HBJd/wZ1EqNAD/pOx9siFJ5gAwfVay3zDzHs3wxard+eOb0LSoaWPXqeZOwfex
         BloXM0a0Z9iKFgIXzkG9kVmhOvDs+UhfyPWI/nu9BTV2K5/YXmX7IGVVhOtQcoxeZOMj
         k7JAUhgx1vbBTQ+9nBZVQB1yNu6p8nC/toFgwW36oMmTpteOLkZoA4ltGZXxPOi7a14/
         QERayw2qFJw512EIOHTWxu8Kr5kvkYJM5E+doWw4YMbCIGj5/b24HNTikkWaKHbKCeL/
         +BtbkzHi1KBVxi44AhCKFCQlP0wKHcuIcgBV71G/M4IY4OV/WaLZ6+MGacvv9wVR9Cvl
         QIOg==
X-Gm-Message-State: ANhLgQ0yodIwpo4e09Meg/QGpbyzXWooYTYSaRxWSMTGyC9Vxind3DJi
        KcM6GaUM2+EJd/9ZwlwhiRQdgapcSUbvQO35RqHJeFpq5UFNWybYVP/7mnwcGh0n/pSVEcEYx/R
        DDAvWLGld5M7CO79T/KYigu8h
X-Received: by 2002:adf:904a:: with SMTP id h68mr19456927wrh.291.1585664301564;
        Tue, 31 Mar 2020 07:18:21 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtmKByeMbL7IF4Va4byN+91sp3eGql6iIZ+hxW44PDFMJBJ+l8uaRXS9tqFA+dHHnZNvwqR7w==
X-Received: by 2002:adf:904a:: with SMTP id h68mr19456901wrh.291.1585664301366;
        Tue, 31 Mar 2020 07:18:21 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id z19sm28466709wrg.28.2020.03.31.07.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:18:20 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:18:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Hui Zhu <teawater@gmail.com>, jasowang@redhat.com,
        akpm@linux-foundation.org, pagupta@redhat.com,
        mojha@codeaurora.org, namit@vmware.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        Hui Zhu <teawaterz@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Message-ID: <20200331101117-mutt-send-email-mst@kernel.org>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <20200331093300-mutt-send-email-mst@kernel.org>
 <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
 <20200331100359-mutt-send-email-mst@kernel.org>
 <85f699d4-459a-a319-0a8f-96c87d345c49@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85f699d4-459a-a319-0a8f-96c87d345c49@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 04:09:59PM +0200, David Hildenbrand wrote:

...

> >>>>>>>>>>> So if we want to address this, IMHO this calls for a new API.
> >>>>>>>>>>> Along the lines of
> >>>>>>>>>>>
> >>>>>>>>>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
> >>>>>>>>>>>                    unsigned int max_order, unsigned int *order)
> >>>>>>>>>>>
> >>>>>>>>>>> the idea would then be to return at a number of pages in the given
> >>>>>>>>>>> range.
> >>>>>>>>>>>
> >>>>>>>>>>> What do you think? Want to try implementing that?

..

> I expect the whole "steal huge pages from your guest" to be problematic,
> as I already mentioned to Alex. This needs a performance evaluation.
> 
> This all smells like a lot of workload dependent fine-tuning. :)


So that's why I proposed the API above.

The idea is that *if we are allocating a huge page anyway*,
rather than break it up let's send it whole to the device.
If we have smaller pages, return smaller pages.

That seems like it would always be an improvement, whatever the
workload.

-- 
MST


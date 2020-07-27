Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D281C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7EC120729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXwoh2Er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbgG0SlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:41:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58137 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728424AbgG0SlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595875268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sXW4wIH6TKVJpwsY/Gv5v2EmllUcRHvd/yXgwriXB10=;
        b=HXwoh2Er7QvidkCkD13MofqQUSVFQM+BP9oV/tBAJBBENknu5ah1veDa9dGVqoC8R/4hvn
        qf9SY3yf7rUitMN3vDkdRRNkwOgEoWfLay9BV6CNy15EwLjctsGM+m6ipyDJff82V2Gnlb
        hLwyYWTuz8JHp79EyqAl1ufXRwG6/js=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-teTdsiu6NcCTsZ5b6CfZJA-1; Mon, 27 Jul 2020 14:41:00 -0400
X-MC-Unique: teTdsiu6NcCTsZ5b6CfZJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB74A1DE2;
        Mon, 27 Jul 2020 18:40:59 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-13.rdu2.redhat.com [10.10.115.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AFAD10013C4;
        Mon, 27 Jul 2020 18:40:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A4750220264; Mon, 27 Jul 2020 14:40:53 -0400 (EDT)
Date:   Mon, 27 Jul 2020 14:40:53 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>, pbonzini@redhat.com,
        sean.j.christopherson@intel.com
Subject: Re: [PATCH v4] kvm,x86: Exit to user space in case page fault error
Message-ID: <20200727184053.GB39559@redhat.com>
References: <20200720211359.GF502563@redhat.com>
 <20200727135603.GA39559@redhat.com>
 <87ft9dlz2b.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft9dlz2b.fsf@vitty.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 06:09:32PM +0200, Vitaly Kuznetsov wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > On Mon, Jul 20, 2020 at 05:13:59PM -0400, Vivek Goyal wrote:
> >> Page fault error handling behavior in kvm seems little inconsistent when
> >> page fault reports error. If we are doing fault synchronously
> >> then we capture error (-EFAULT) returned by __gfn_to_pfn_memslot() and
> >> exit to user space and qemu reports error, "error: kvm run failed Bad address".
> >
> > Hi Vitaly,
> >
> > A gentle reminder. How does this patch look now?
> >
> 
> Sorry, I even reviewd it but never replied. It looks good to me!
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks Vitaly.

Paolo, what do you think about this patch. Do you have concerns with
this. Can this be merged.

Thanks
Vivek


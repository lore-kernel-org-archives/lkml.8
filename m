Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A23C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338D5207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrI4x+Z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgIJFpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbgIJFo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599716694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aQiUYsh8TgXp4sQmZDKLYBoyRpNdR2/1b88YWG5P7nM=;
        b=SrI4x+Z2kgRxWFEUr4vo+lGfcYPtd8npaDr3GNESOQZw1vXrF+LPg/AjQj4N5/48HdBSku
        XvKNlficDP5t+wtwUH9B1uI77Js+mCVw08adsjNCNBTJTYrAHBWC2GS9zIJVG6UXKTB6tB
        0KdjD3CiFvoNYLXMMf2cYyTRgrZ81Xg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-LSrp4Z1OPJ2Fgl8fllR4Vg-1; Thu, 10 Sep 2020 01:44:49 -0400
X-MC-Unique: LSrp4Z1OPJ2Fgl8fllR4Vg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFB991017DC3;
        Thu, 10 Sep 2020 05:44:47 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C59E8838A0;
        Thu, 10 Sep 2020 05:44:43 +0000 (UTC)
Date:   Thu, 10 Sep 2020 07:44:40 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     Steven Price <steven.price@arm.com>,
        Peter Maydell <Peter.Maydell@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        qemu-devel@nongnu.org,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
Message-ID: <20200910054440.pvnzk7p7riiy45e2@kamzik.brq.redhat.com>
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
 <5cb1d7ed-54a5-4337-6c3d-2e3e7df89f17@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb1d7ed-54a5-4337-6c3d-2e3e7df89f17@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 06:45:33PM -0700, Richard Henderson wrote:
> On 9/9/20 8:25 AM, Andrew Jones wrote:
> >>  * Provide a KVM-specific method to extract the tags from guest memory.
> >>    This might also have benefits in terms of providing an easy way to
> >>    read bulk tag data from guest memory (since the LDGM instruction
> >>    isn't available at EL0).
> > 
> > Maybe we need a new version of KVM_GET_DIRTY_LOG that also provides
> > the tags for all addresses of each dirty page.
> 
> KVM_GET_DIRTY_LOG just provides one bit per dirty page, no?  Then VMM copies
> the data out from its local address to guest memory.
> 
> There'd be no difference with or without tags, afaik.  It's just about how VMM
> copies the data, with or without tags.

Right, as long as it's fast enough to do

  for_each_dirty_page(page, dirty_log)
    for (i = 0; i < host-page-size/16; i += 16)
      append_tag(LDG(page + i))

to get all the tags for each dirty page. I understood it would be faster
to use LDGM, but we'd need a new ioctl for that. So I was proposing we
just piggyback on a new dirty-log ioctl instead.

Thanks,
drew 


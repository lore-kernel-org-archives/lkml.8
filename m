Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77B6C2BB54
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C039720768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEPqwTCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgDHSXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:23:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51764 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730743AbgDHSXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586370227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hqTq2Wy3TNDTzfSsOcRzLQkDhw37DQsS+GCpZMUDZFo=;
        b=eEPqwTCRBo1Et90qpZ2uWEcLfaRYwP9J7Lb7wybHtfxWpjJl0m+LbWyRvaNVooCCJTDhSq
        YZsYXsAcZlet3WKjLhj1yqRbx06EfUe8+cYPVRS1lNmPh/mQ5JgjlXSvFIiLglcnWYy2Vw
        ZticrKC+wqPv+q12vvvWv1aVzPDxKP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-XsFltCapNOamuqjPPB_lXg-1; Wed, 08 Apr 2020 14:23:41 -0400
X-MC-Unique: XsFltCapNOamuqjPPB_lXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9ED88017F4;
        Wed,  8 Apr 2020 18:23:39 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-85.rdu2.redhat.com [10.10.115.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFCA09A253;
        Wed,  8 Apr 2020 18:23:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 169B92202B8; Wed,  8 Apr 2020 14:23:39 -0400 (EDT)
Date:   Wed, 8 Apr 2020 14:23:39 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
Message-ID: <20200408182339.GC93547@redhat.com>
References: <877dyqkj3h.fsf@nanos.tec.linutronix.de>
 <F2BD5266-A9E5-41C8-AC64-CC33EB401B37@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2BD5266-A9E5-41C8-AC64-CC33EB401B37@amacapital.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 09:48:02PM -0700, Andy Lutomirski wrote:

[..]
> It would be nifty if the host also told the guest what the guest virtual address was if the host knows it.

It will be good to know and send guest virtual address as well. While
sending SIGBUS to guest user space, information about which access
triggered SIGBUS will be useful.

I thought GUEST_LINEAR_ADDRESS provides guest virtual address if
EPT_VIOLATION_GLA_VALID bit is set. And it seems to work for my
simple test case. But when I try to read intel SDM, section "27.2" VM
exits, EPT violations, I am not so sure.

Somebody who understands this better, can you please help me understand
what exactly GUEST_LINEAR_ADDRESS is supposed to contain during
EPT violation. I assumed it is guest virtual address and added a
patch in my RFC patch series.

https://lore.kernel.org/kvm/20200331194011.24834-3-vgoyal@redhat.com/

But I might have misunderstood it.

Vivek


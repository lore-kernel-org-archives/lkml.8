Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0096C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FAB2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cy98NK3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392499AbgAXUgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:36:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31888 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725747AbgAXUgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 15:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579898207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wYPFnForP5DW9b9y/S2cEuNSkYqUwYPt/8FCorq3d2E=;
        b=Cy98NK3UM+mhmZey+M3OAvqPFNFGq/J4jLMYppMT8sL4o1/B05ngS2ANjFwfq07Drr/4hh
        MpwVfMs796g27v/H0PWVtDBy/59bS/hNP4vX/tMorNc+U9pTq3LmWsG1ghNRM7Gw/lBXF3
        uTKbVzq1r5wBFkOAEDzEu2ZXx+ukK7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-SakrKCg8Pc2g8uEbqAzK0w-1; Fri, 24 Jan 2020 15:36:45 -0500
X-MC-Unique: SakrKCg8Pc2g8uEbqAzK0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03E91800D41;
        Fri, 24 Jan 2020 20:36:44 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-59.gru2.redhat.com [10.97.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C05F4867E3;
        Fri, 24 Jan 2020 20:36:43 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 2755C418CC03; Fri, 24 Jan 2020 17:36:30 -0300 (-03)
Date:   Fri, 24 Jan 2020 17:36:30 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 0/2] KVM: x86: do not mix raw and monotonic clocks in
 kvmclock
Message-ID: <20200124203630.GA28074@fuller.cnet>
References: <1579702953-24184-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579702953-24184-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 03:22:31PM +0100, Paolo Bonzini wrote:
> Commit 53fafdbb8b21f ("KVM: x86: switch KVMCLOCK base to monotonic raw
> clock") changed kvmclock to use tkr_raw instead of tkr_mono.  However,
> the default kvmclock_offset for the VM was still based on the monotonic
> clock and, if the raw clock drifted enough from the monotonic clock,
> this could cause a negative system_time to be written to the guest's
> struct pvclock.  RHEL5 does not like it and (if it boots fast enough to
> observe a negative time value) it hangs.
> 
> This series fixes the issue by using the raw clock everywhere.
> 
> (And this, ladies and gentlemen, is why I was not applying patches to
> the KVM tree.  I saw this before Christmas and could only reproduce it
> today, since it requires almost 2 weeks of uptime to reproduce on my
> machine.  Of course, once you have the reproducer the fix is relatively
> easy to come up with).
> 
> Paolo
> 
> Paolo Bonzini (2):
>   KVM: x86: reorganize pvclock_gtod_data members
>   KVM: x86: use raw clock values consistently
> 
>  arch/x86/kvm/x86.c | 67 ++++++++++++++++++++++++++++--------------------------
>  1 file changed, 35 insertions(+), 32 deletions(-)
> 
> -- 
> 1.8.3.1

Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>

BTW, should switch both masterclock and non-masterclock cases
to raw clock base. Do you see any problem with that? 

Using the same reasoning as raw clock for master, ntpd in 
the guest should correct the difference.

Could probably simplify things.


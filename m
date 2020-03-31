Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5220AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4B3206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dl5FUrwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgCaHtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:49:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21146 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729925AbgCaHtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 03:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585640955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WQidleZHioAbMw3jPUbXbSj/Imf6yrz9eifvO/T2QX4=;
        b=dl5FUrwuvjf0mn6n6GuT4t1HMF99tkIQrSTBRjph37nvuYkrbs9u73kK5Uu6nO40poApRr
        l/Pl9eIVMCtB3gkgOfWXk4w140y+3Y2LXV693yUjoYR9LMOPTntYpIzVIW+GPBH79puceV
        kszxMlfUL9mY/kI7bnOli0+g+YPduC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-VP2st1JzOUyUPktB7CCMwg-1; Tue, 31 Mar 2020 03:49:12 -0400
X-MC-Unique: VP2st1JzOUyUPktB7CCMwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 317101083E84;
        Tue, 31 Mar 2020 07:49:11 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A77B10016EB;
        Tue, 31 Mar 2020 07:49:06 +0000 (UTC)
Date:   Tue, 31 Mar 2020 09:49:03 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     Wainer dos Santos Moschetta <wainersm@redhat.com>,
        kvm@vger.kernel.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: kvm: Update .gitignore with missing binaries
Message-ID: <20200331074903.lwqjkwyinfw2avzg@kamzik.brq.redhat.com>
References: <20200330211922.24290-1-wainersm@redhat.com>
 <49982d4c-ab12-28e6-d0f2-695c8781b26d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49982d4c-ab12-28e6-d0f2-695c8781b26d@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 09:09:17AM +0200, Janosch Frank wrote:
> On 3/30/20 11:19 PM, Wainer dos Santos Moschetta wrote:
> > Updated .gitignore to ignore x86_64/svm_vmcall_test and
> > s390x/resets test binaries.
> > 
> > Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> 
> Oh, didn't know I needed to do that...
> Thanks for fixing this up.

I've already sent these, and they've been merged to kvm/queue.

> 
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> 
> > ---
> >  tools/testing/selftests/kvm/.gitignore | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> > index 30072c3f52fb..489b9cf9eed5 100644
> > --- a/tools/testing/selftests/kvm/.gitignore
> > +++ b/tools/testing/selftests/kvm/.gitignore
> > @@ -1,3 +1,4 @@
> > +/s390x/resets
> >  /s390x/sync_regs_test
> >  /s390x/memop
> >  /x86_64/cr4_cpuid_sync_test
> > @@ -8,6 +9,7 @@
> >  /x86_64/set_sregs_test
> >  /x86_64/smm_test
> >  /x86_64/state_test
> > +/x86_64/svm_vmcall_test
> >  /x86_64/sync_regs_test
> >  /x86_64/vmx_close_while_nested_test
> >  /x86_64/vmx_dirty_log_test
> > 
> 
> 




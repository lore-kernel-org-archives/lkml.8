Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67F3C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CCB20719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4ZrWVhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgDGIdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:33:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27829 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725883AbgDGIdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 04:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586248386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tq+OpIRxnn+Zk8S9fkUt7kbbJEzkzq8nr2igicyRqKM=;
        b=i4ZrWVhxy7nsHVQUf/hVfUjMn+5ueqkvQKDOEHfriUpnHNjuYZC/EKjWnOGpEUiN/pGewF
        ScYgaSxqU47hcJlutboFB+C453yr4slu5dwdDN+JxHQM6Yd3PNyZGg4RVEwQp9avn3AKhd
        ocInM8yeGTuz9jDeNiylY4Ml7zmxFlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-9m_XtjzwNRWLGIgdO_C1CA-1; Tue, 07 Apr 2020 04:33:02 -0400
X-MC-Unique: 9m_XtjzwNRWLGIgdO_C1CA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9638818FF663;
        Tue,  7 Apr 2020 08:33:01 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C54BD60BE1;
        Tue,  7 Apr 2020 08:32:54 +0000 (UTC)
Date:   Tue, 7 Apr 2020 10:32:51 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests: kvm: Add mem_slot_test test
Message-ID: <20200407083251.3zgjscwhldcm5hce@kamzik.brq.redhat.com>
References: <20200403172428.15574-1-wainersm@redhat.com>
 <20200403172428.15574-3-wainersm@redhat.com>
 <20200404073240.grcsylznemd3pmxz@kamzik.brq.redhat.com>
 <64a47faa-74f5-60ad-9b74-8c295072c719@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a47faa-74f5-60ad-9b74-8c295072c719@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 02:10:53PM -0300, Wainer dos Santos Moschetta wrote:
> 
> On 4/4/20 4:32 AM, Andrew Jones wrote:
> > On Fri, Apr 03, 2020 at 02:24:28PM -0300, Wainer dos Santos Moschetta wrote:
> > > This patch introduces the mem_slot_test test which checks
> > > an VM can have added memory slots up to the limit defined in
> > > KVM_CAP_NR_MEMSLOTS. Then attempt to add one more slot to
> > > verify it fails as expected.
> > > 
> > > Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> > > ---
> > >   tools/testing/selftests/kvm/.gitignore      |  1 +
> > >   tools/testing/selftests/kvm/Makefile        |  3 +
> > >   tools/testing/selftests/kvm/mem_slot_test.c | 85 +++++++++++++++++++++
> > >   3 files changed, 89 insertions(+)
> > >   create mode 100644 tools/testing/selftests/kvm/mem_slot_test.c
> > > 
> > > diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> > > index 16877c3daabf..232f24d6931a 100644
> > > --- a/tools/testing/selftests/kvm/.gitignore
> > > +++ b/tools/testing/selftests/kvm/.gitignore
> > > @@ -22,3 +22,4 @@
> > >   /dirty_log_test
> > >   /kvm_create_max_vcpus
> > >   /steal_time
> > > +/mem_slot_test
> > > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> > > index 712a2ddd2a27..69b44178f48b 100644
> > > --- a/tools/testing/selftests/kvm/Makefile
> > > +++ b/tools/testing/selftests/kvm/Makefile
> > > @@ -33,12 +33,14 @@ TEST_GEN_PROGS_x86_64 += demand_paging_test
> > >   TEST_GEN_PROGS_x86_64 += dirty_log_test
> > >   TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
> > >   TEST_GEN_PROGS_x86_64 += steal_time
> > > +TEST_GEN_PROGS_x86_64 += mem_slot_test
> > >   TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
> > >   TEST_GEN_PROGS_aarch64 += demand_paging_test
> > >   TEST_GEN_PROGS_aarch64 += dirty_log_test
> > >   TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
> > >   TEST_GEN_PROGS_aarch64 += steal_time
> > > +TEST_GEN_PROGS_aarch64 += mem_slot_test
> > kvm selftests has a bad case of OCD when it comes to lists of tests. In
> > the .gitignore and the Makefile we keep our tests in alphabetical order.
> > Maybe we should stop, because it's a bit annoying to maintain, but my
> > personal OCD won't allow it to be on my watch. Please fix the above
> > three lists.
> 
> I will fix it on v3.
> 
> Kind of related... has ever been discussed a naming convention for kvm
> selftests? It would allow the use of regex on both .gitignore and
> Makefile...and bye-bye those sorted lists.

It's never been discussed that I know of. Feel free to send an RFC if
you'd like to kick off the discussion :-)

Thanks,
drew


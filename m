Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F12C18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4936206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDAhEOXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387884AbgDBJAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:00:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48910 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgDBJAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585818044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WLbI8tl/lGeAZC2ZqPQOvymWN2MF7fjTbT3WDjZTIW4=;
        b=EDAhEOXC31VIGGCEsGR8Rkv0qgGHpcQO9Y5KVC0WddQCZ/oO/gNB2Vct23a7xoy9J/BYke
        QdBpqPhachHvpnhqzB8aIIRgvaYjLi+g49Xn7QGfkasbOMPyklsrCcR7pE3jLWhobgZkkb
        CNoZ32lUxBQeV/tfb85CsJUYJYwYdbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-ViIzXaFRMCuH1SC4nYcA3g-1; Thu, 02 Apr 2020 05:00:42 -0400
X-MC-Unique: ViIzXaFRMCuH1SC4nYcA3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EA7518A551F;
        Thu,  2 Apr 2020 09:00:41 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D79BE5E037;
        Thu,  2 Apr 2020 09:00:32 +0000 (UTC)
Date:   Thu, 2 Apr 2020 11:00:29 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        david@redhat.com
Subject: Re: [PATCH 2/2] selftests: kvm: Add mem_slot_test test
Message-ID: <20200402090029.pc6w6iqikgthflhq@kamzik.brq.redhat.com>
References: <20200330204310.21736-1-wainersm@redhat.com>
 <20200330204310.21736-3-wainersm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330204310.21736-3-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 05:43:10PM -0300, Wainer dos Santos Moschetta wrote:
> This patch introduces the mem_slot_test test which checks
> an VM can have added memory slots up to the limit defined in
> KVM_CAP_NR_MEMSLOTS. Then attempt to add one more slot to
> verify it fails as expected.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  tools/testing/selftests/kvm/.gitignore      |  1 +
>  tools/testing/selftests/kvm/Makefile        |  3 +
>  tools/testing/selftests/kvm/mem_slot_test.c | 92 +++++++++++++++++++++
>  3 files changed, 96 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/mem_slot_test.c
>

BTW, in kvm/queue we also now have

x86_64/set_memory_region_test.c

I wonder if we shouldn't try to make x86_64/set_memory_region_test.c
arch-neutral and then integrate this new test with it.

Thanks,
drew


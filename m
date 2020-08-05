Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B13C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732A02076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeTK1eXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgHEGhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:37:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35898 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbgHEGhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596609433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=62Tw1BBsMzGMC/Ik8n+g/03qKyYodUE+BoWaAV0f2HI=;
        b=BeTK1eXOwqT2HCvJEOELRXi5yhzyTagJnLzb4aDNRXRxuE5TgTf6UkuI/+JwhcDGFfDsK1
        9EpeZYhNZAt689kTKlcOPWSBG9j6a7N8HZ7tV70RwaC2YvrFd8fgvPG0xgFuIbMwmGrCrK
        OfOpf9WLPeN1lOhV5GUuo3bPFP03dt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-cx6-diCwOs2Uy8z-OL4piA-1; Wed, 05 Aug 2020 02:37:09 -0400
X-MC-Unique: cx6-diCwOs2Uy8z-OL4piA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2142480183C;
        Wed,  5 Aug 2020 06:37:08 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-0.pek2.redhat.com [10.72.13.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E474710013D7;
        Wed,  5 Aug 2020 06:37:01 +0000 (UTC)
Date:   Wed, 5 Aug 2020 14:36:58 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, bp@alien8.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, bhe@redhat.com, k-hagio@ab.jp.nec.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] x86/kexec_file: Fix some corners bugs and improve
 the crash_exclude_mem_range()
Message-ID: <20200805063658.GA22086@dhcp-128-65.nay.redhat.com>
References: <20200804044933.1973-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804044933.1973-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lianbo,

Added Andrew in cc.
On 08/04/20 at 12:49pm, Lianbo Jiang wrote:
> This series includes the following patches, it fixes some corners bugs
> and improves the crash_exclude_mem_range().
> 
> [1] [PATCH 1/3] x86/crash: Correct the address boundary of function
>     parameters
> [2] [PATCH 2/3] kexec: Improve the crash_exclude_mem_range() to handle
>     the overlapping ranges
> [3] [PATCH 3/3] kexec_file: correctly output debugging information for
>     the PT_LOAD elf header
> 
> Lianbo Jiang (3):
>   x86/crash: Correct the address boundary of function parameters
>   kexec: Improve the crash_exclude_mem_range() to handle the overlapping
>     ranges
>   kexec_file: correctly output debugging information for the PT_LOAD elf
>     header
> 
>  arch/x86/kernel/crash.c |  2 +-
>  kernel/kexec_file.c     | 33 ++++++++++++++++++++++-----------
>  2 files changed, 23 insertions(+), 12 deletions(-)
> 
> -- 
> 2.17.1

Looks good, thanks for the patches

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave


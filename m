Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8071BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4826720734
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1RpiQFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgFPKte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:49:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44835 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbgFPKt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592304567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=1H0luCJODbtQ42YgYv0yeAzbAXL/psZsh9fUX+jVH3w=;
        b=U1RpiQFkBhOIm4GadxJbcvDtFTNpL/ghl1874VdxoGcb/smX2iF9LfrqWZ+lF8ltSgAnuT
        jGZRqxUZeiATEKHmbfrSnSosbagr+qu2Al+7zxBotdPhWYtUW/XrqId1MB16W589m/bQZE
        0w5/C03Y7fUKXiEfZ28QI5QEtePTw8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-dkMoe5--OaCYt8sZF_1gtA-1; Tue, 16 Jun 2020 06:49:24 -0400
X-MC-Unique: dkMoe5--OaCYt8sZF_1gtA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21C62846375;
        Tue, 16 Jun 2020 10:49:23 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-128.ams2.redhat.com [10.36.114.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AB2B768DC;
        Tue, 16 Jun 2020 10:49:19 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH] x86: pmu: Test full-width counter writes
 support
To:     Like Xu <like.xu@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200529074347.124619-1-like.xu@linux.intel.com>
 <20200529074347.124619-4-like.xu@linux.intel.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b1a5472b-f7d0-82b0-e753-dabf81254488@redhat.com>
Date:   Tue, 16 Jun 2020 12:49:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200529074347.124619-4-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2020 09.43, Like Xu wrote:
> When the full-width writes capability is set, use the alternative MSR
> range to write larger sign counter values (up to GP counter width).
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  lib/x86/msr.h |   1 +
>  x86/pmu.c     | 125 ++++++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 102 insertions(+), 24 deletions(-)
[...]
> @@ -452,6 +468,66 @@ static void check_running_counter_wrmsr(void)
>  	report_prefix_pop();
>  }
>  
> +static void check_counters(void)
> +{
> +	check_gp_counters();
> +	check_fixed_counters();
> +	check_rdpmc();
> +	check_counters_many();
> +	check_counter_overflow();
> +	check_gp_counter_cmask();
> +	check_running_counter_wrmsr();
> +}
> +
> +static void do_unsupported_width_counter_write(void *index)
> +{
> +	wrmsr(MSR_IA32_PMC0 + *((int *) index), 0xffffff0123456789ull);
> +}
> +
> +static void  check_gp_counters_write_width(void)
> +{
> +	u64 val_64 = 0xffffff0123456789ull;
> +	u64 val_32 = val_64 & ((1ul << 32) - 1);
 Hi,

this broke compilation on 32-bit hosts:

 https://travis-ci.com/github/huth/kvm-unit-tests/jobs/349654654#L710

Fix should be easy, I guess - either use 1ull or specify the mask
0xffffffff directly.

 Thomas


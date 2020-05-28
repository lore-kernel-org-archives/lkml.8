Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299C5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03AAE208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WC9iOvNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgE1GPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:15:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20423 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727895AbgE1GPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590646503;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4HlwVLTYjSh4OXGx2V1FosENazDNDDnLDE+J78PlVsQ=;
        b=WC9iOvNSL7NXYxFrDXtU+PTqxW1sKCknvURnpHGwnVNd3NNx++ZJaZu5heLUXDsQkhDlD+
        cunFLPiBMRPY77C1JNSevbci9vmguRMsjY1Ha8moFKdpuMBdmJV71qQe+ahsDiRGYfgXzg
        u/yLUoadqf1z53dbk/1th8ogHYL3Eh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-Jyx1kD06MQi5z-b6o7S42A-1; Thu, 28 May 2020 02:14:59 -0400
X-MC-Unique: Jyx1kD06MQi5z-b6o7S42A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23FF0100CCC0;
        Thu, 28 May 2020 06:14:58 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-130.bne.redhat.com [10.64.54.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D8E9E19D82;
        Thu, 28 May 2020 06:14:55 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH RFCv2 9/9] arm64: Support async page fault
To:     Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-10-gshan@redhat.com>
 <81adf013-3de7-23e6-7648-8aec821b033c@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <a6addc25-29af-3690-8392-efa5e8381e98@redhat.com>
Date:   Thu, 28 May 2020 16:14:52 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <81adf013-3de7-23e6-7648-8aec821b033c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

On 5/27/20 4:48 PM, Paolo Bonzini wrote:
> I definitely appreciate the work, but this is repeating most of the
> mistakes done in the x86 implementation.  In particular:
> 
> - the page ready signal can be done as an interrupt, rather than an
> exception.  This is because "page ready" can be handled asynchronously,
> in contrast to "page not present" which must be done on the same
> instruction that triggers it.  You can refer to the recent series from
> Vitaly Kuznetsov that switched "page ready" to an interrupt.
> 

Yeah, page ready can be handled asynchronously. I think it would be
nice for x86/arm64 to share same design. x86 has 256 vectors and it
seems 0xec is picked for the purpose. However, arm64 doesn't have so
many (interrupt/exception) vectors and PPI might be appropriate for
the purpose if I'm correct, because it has same INTD for all CPUs.
 From this point, it's similar to x86's vector. There are 16 PPIs, which
are in range of 16 to 31, and we might reserve one for this. According
to GICv3/v4 spec, 22 - 30 have been assigned.

> - the page not present is reusing the memory abort exception, and
> there's really no reason to do so.  I think it would be best if ARM
> could reserve one ESR exception code for the hypervisor.  Mark, any
> ideas how to proceed here?
> 

Well, a subclass of ESR exception code, whose DFSC (Data Fault Status
Code) is 0x34, was taken for the purpose in RFCv1. The code is IMPDEF
one and Mark suggested not to do so. I agree the page not present needs a
separately subclass of exception. With that, there will be less conflicts
and complexity. However, the question is which subclass or DFSC code I should
used for the purpose.

> - for x86 we're also thinking of initiating the page fault from the
> exception handler, rather than doing so from the hypervisor before
> injecting the exception.  If ARM leads the way here, we would do our
> best to share code when x86 does the same.
> 

Sorry, Paolo, I don't follow your idea here. Could you please provide
more details?

> - do not bother with using KVM_ASYNC_PF_SEND_ALWAYS, it's a fringe case
> that adds a lot of complexity.
> 

Yeah, I don't consider it so far.

> Also, please include me on further iterations of the series.
> 

Sure.

Thanks,
Gavin

[...]


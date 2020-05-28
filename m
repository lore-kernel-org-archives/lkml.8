Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5548BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251292074B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbvJi97G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437343AbgE1XDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:03:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58807 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391479AbgE1XDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590706990;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qUIox5FhQJ2z08jhZB7sfNniyrJZwWCLCZ4Ajtdwh7I=;
        b=KbvJi97G0mAEKEK9mXcnqTYPiXH/5BFY7FE8720lC3/HlqMkiKeWaH/yDT1jO4mC0FcxUv
        15B5jDxDVW39ZJOrAquu4DA1bVydrnwhZxjkS7j23/fRVfwY2Ij4OxExESHLK414wnBlqO
        ViXuznoBGuOEnwEeo7lsbuV07g3B4gU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-9_wHkkfkNRKqvFNP88Dgeg-1; Thu, 28 May 2020 19:03:06 -0400
X-MC-Unique: 9_wHkkfkNRKqvFNP88Dgeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCE351005510;
        Thu, 28 May 2020 23:03:04 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-130.bne.redhat.com [10.64.54.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 421C860C80;
        Thu, 28 May 2020 23:03:01 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH RFCv2 9/9] arm64: Support async page fault
To:     Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-10-gshan@redhat.com>
 <81adf013-3de7-23e6-7648-8aec821b033c@redhat.com>
 <a6addc25-29af-3690-8392-efa5e8381e98@redhat.com>
 <8ab64c6a-582b-691d-79ab-21cdc0455cd3@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <6a4a82a4-af01-98c2-c854-9199f55f7bd3@redhat.com>
Date:   Fri, 29 May 2020 09:02:58 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <8ab64c6a-582b-691d-79ab-21cdc0455cd3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

On 5/28/20 8:48 PM, Paolo Bonzini wrote:
> On 28/05/20 08:14, Gavin Shan wrote:
>>> - for x86 we're also thinking of initiating the page fault from the
>>> exception handler, rather than doing so from the hypervisor before
>>> injecting the exception.  If ARM leads the way here, we would do our
>>> best to share code when x86 does the same.
>>
>> Sorry, Paolo, I don't follow your idea here. Could you please provide
>> more details?
> 
> The idea is to inject stage2 page faults into the guest even before the
> host starts populates the page.  The guest then invokes a hypercall,
> telling the host to populate the page table and inject the 'page ready'
> event (interrupt) when it's done.
> 
> For x86 the advantage is that the processor can take care of raising the
> stage2 page fault in the guest, so it's faster.
> 
I think there might be too much overhead if the page can be populated
quickly by host. For example, it's fast to populate the pages if swapin
isn't involved.

If I'm correct enough, it seems arm64 doesn't have similar mechanism,
routing stage2 page fault to guest.

Thanks,
Gavin


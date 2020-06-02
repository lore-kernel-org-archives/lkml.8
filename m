Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B083C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC6F206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y63W1x+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgFBFoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:44:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56768 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725298AbgFBFoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591076693;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bCo6Hs1XvKVZ/we8zlozkhnglL2Do2YvAix/0i2LEXM=;
        b=Y63W1x+jPASWT5dLtyK5KW30WZOC1GJJa8JS06G1AQ8rd9SaB6n6Ba29gFHIC68LRk5XXy
        g2SJa4uKMislkCTuJGk9/GPoDTGc2xWNnWDPHhOddVLsi2p0XOogH+l+TXpAYJ5HKB7NQX
        3+qoljhYnpwtl7RXlXHVtH/zL1vE5d0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-1OLmskEZNhOBtfnAOikoPA-1; Tue, 02 Jun 2020 01:44:49 -0400
X-MC-Unique: 1OLmskEZNhOBtfnAOikoPA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40DBC835B40;
        Tue,  2 Jun 2020 05:44:48 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-70.bne.redhat.com [10.64.54.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D7375D9C9;
        Tue,  2 Jun 2020 05:44:45 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH RFCv2 9/9] arm64: Support async page fault
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-10-gshan@redhat.com>
 <81adf013-3de7-23e6-7648-8aec821b033c@redhat.com>
 <a6addc25-29af-3690-8392-efa5e8381e98@redhat.com>
 <8ab64c6a-582b-691d-79ab-21cdc0455cd3@redhat.com>
 <6a4a82a4-af01-98c2-c854-9199f55f7bd3@redhat.com>
 <6965aaf641a23fab64fbe2ceeb790272@kernel.org>
 <d0bfb944-b50a-608a-7dcc-5a409cdc4524@redhat.com>
 <4337cca152df47c93d96e092189a0e36@kernel.org>
 <5c72c597-732e-7dbf-d056-665674ec1792@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <fca52ea1-294a-6011-45f1-d0df30069800@redhat.com>
Date:   Tue, 2 Jun 2020 15:44:42 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <5c72c597-732e-7dbf-d056-665674ec1792@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Paolo,

On 6/1/20 7:21 PM, Paolo Bonzini wrote:
> On 31/05/20 14:44, Marc Zyngier wrote:
>>>
>>> Is there an ARM-approved way to reuse the S2 fault syndromes to detect
>>> async page faults?
>>
>> It would mean being able to set an ESR_EL2 register value into ESR_EL1,
>> and there is nothing in the architecture that would allow that,
> 
> I understand that this is not what you want to do and I'm not proposing
> it, but I want to understand this better: _in practice_ do CPUs check
> closely what is written in ESR_EL1?
> 
> In any case, the only way to implement this, it seems to me, would be a
> completely paravirtualized exception vector that doesn't use ESR at all.
> 
> On the other hand, for the page ready (interrupt) side assigning a PPI
> seems complicated but doable.
> 

Marc suggested to use SDEI in another reply. I think it might be the
appropriate way to deliver page-not-present. To some extent, it could
be regarded as exception, which doesn't use ESR at all. It matches with
what Paolo is thinking of: paravirtualized exception vector that doesn't
use ESR at all. However, it seems it's not supported in kvm-arm yet. So
I assume it needs to be developed from scratch. Marc, could you please
help to confirm? Thanks in advance.

I agree with Paolo PPI (interrupt) might be the best way to deliver
page-ready currently. I don't think SDEI is suitable because there
are no big difference between SDEI and currently used DABT injection
to some extent. With SDEI, We will have the issues we are facing.
For example, some critical code section isn't safe to receive SDEI
if I'm correct.


Thanks,
Gavin

[...]


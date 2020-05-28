Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5C3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB5B21475
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590649415;
	bh=ZtNo65ZO/BvERi9MMlIXBIaMhPiClNvDO1mjkdv5Dys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=grh+eRAE8STHV3lhuA1Ogr7CgG1902OyNA/GLTRUHt7TgMRq7TgJEotA90V4qTmP7
	 047l4ug8P12DCpgYjrV+/6N5EUH6nlN1dKDhzjh2t/Yder73XSTVHfh9NY7VIWdHAk
	 BdDVrd6Bi3lUTNr2NbTiL14+fg52LL/kO6kUEGZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgE1HDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE1HDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:03:34 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70CA7207E8;
        Thu, 28 May 2020 07:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590649413;
        bh=ZtNo65ZO/BvERi9MMlIXBIaMhPiClNvDO1mjkdv5Dys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1AOG1xkXdnsZ9IG28U7sF9NTcFaiTh98GAGqe+2S59ULxSEHjhqtKOYqqEs17leD5
         JVGHliieyAl+2NWtSQiAK8ZWhX0nfdsm0tpLKP/yJVQcDJshmm9b7hdGzewJ/sOLPL
         SuPpwsw8yBraLdUMaiYR2pWz2hUNzEFnrljEya7M=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jeCZf-00FuSQ-8Q; Thu, 28 May 2020 08:03:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 May 2020 08:03:31 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFCv2 9/9] arm64: Support async page fault
In-Reply-To: <a6addc25-29af-3690-8392-efa5e8381e98@redhat.com>
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-10-gshan@redhat.com>
 <81adf013-3de7-23e6-7648-8aec821b033c@redhat.com>
 <a6addc25-29af-3690-8392-efa5e8381e98@redhat.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <8b09c298fab15e2629c65e8ee98a8a29@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gshan@redhat.com, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, shan.gavin@gmail.com, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-28 07:14, Gavin Shan wrote:
> Hi Paolo,
> 
> On 5/27/20 4:48 PM, Paolo Bonzini wrote:
>> I definitely appreciate the work, but this is repeating most of the
>> mistakes done in the x86 implementation.  In particular:
>> 
>> - the page ready signal can be done as an interrupt, rather than an
>> exception.  This is because "page ready" can be handled 
>> asynchronously,
>> in contrast to "page not present" which must be done on the same
>> instruction that triggers it.  You can refer to the recent series from
>> Vitaly Kuznetsov that switched "page ready" to an interrupt.
>> 
> 
> Yeah, page ready can be handled asynchronously. I think it would be
> nice for x86/arm64 to share same design. x86 has 256 vectors and it
> seems 0xec is picked for the purpose. However, arm64 doesn't have so
> many (interrupt/exception) vectors and PPI might be appropriate for
> the purpose if I'm correct, because it has same INTD for all CPUs.
> From this point, it's similar to x86's vector. There are 16 PPIs, which
> are in range of 16 to 31, and we might reserve one for this. According
> to GICv3/v4 spec, 22 - 30 have been assigned.

The assignment of the PPIs is completely implementation defined,
and is not part of the architecture (and certainly not in the
GICv3/v4 spec). SBSA makes some statements as to the way they *could*
be assigned, but that's in no way enforced. This allocation is entirely
controlled by userspace, which would need to configure tell KVM
which PPI to use on a per-VM basis.

You would then need to describe the PPI assignment through firmware
(both DT and ACPI) so that the guest kernel can know what PPI the
hypervisor would be signalling on.

It is also not very future proof should we move to a different
interrupt architecture.

> 
>> - the page not present is reusing the memory abort exception, and
>> there's really no reason to do so.  I think it would be best if ARM
>> could reserve one ESR exception code for the hypervisor.  Mark, any
>> ideas how to proceed here?
>> 
> 
> Well, a subclass of ESR exception code, whose DFSC (Data Fault Status
> Code) is 0x34, was taken for the purpose in RFCv1. The code is IMPDEF
> one and Mark suggested not to do so. I agree the page not present needs 
> a
> separately subclass of exception. With that, there will be less 
> conflicts
> and complexity. However, the question is which subclass or DFSC code I 
> should
> used for the purpose.

The current state of the architecture doesn't seem to leave much leeway 
in
terms of SW creativity here. You just can't allocate your own ISS 
encoding
without risking a clash with future revisions of the architecture.
It isn't even clear whether the value you put would stick in ESR_EL1
if it isn't a valid value for this CPU (see the definition of 'Reserved'
in the ARM ARM).

Allocating such a syndrome would require from ARM:

- the guarantee that no existing implementation, irrespective of the
   implementer, can cope with the ISS encoding of your choice,

- the written promise in the architecture that some EC/ISS values
   are reserved for SW, and that promise to apply retrospectively.

This is somewhat unlikely to happen.

         M.
-- 
Jazz is not dead. It just smells funny...

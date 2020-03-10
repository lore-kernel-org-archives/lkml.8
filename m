Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F226C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A5E2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846219;
	bh=CiF2e4Gu3MUdh7Lg3zur4QzwVBU4lRXnHY3VzJVyY/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=odVlw183oBoSHI/R3kc9Yn4lq/r5uLU3Iwapo96mJ1NXH/c5RC/FZle2/8k18D1/s
	 eYopxmeo/SCY2YUGUyvxHmmYScEolb5qd7P7HGuCJicjMo8i5WwOpoZmZ/6xxgSfrU
	 Wl7I0V0o1EHGdC0R4Jxg7kVSKGgmg6VCE0NaQJ8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbgCJNQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:16:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgCJNQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:16:56 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9503E24693;
        Tue, 10 Mar 2020 13:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583846215;
        bh=CiF2e4Gu3MUdh7Lg3zur4QzwVBU4lRXnHY3VzJVyY/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dyd17xpVF0JxkmyH3agz6PA0jQ9JY+cKzy37NP2xJREQyR1k4eYVBwOMm3QBwZafZ
         78doEykwC9a3jiy++aeUHd2sjMmBr52uxv6lUDfQzWrsO5rzavgL7Be86zUEPOKaZw
         rwwyMfDKk9vYKGWvUHcwjyAXo+h3EcV1GpDqMlbg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jBekf-00Bb9d-VK; Tue, 10 Mar 2020 13:16:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Mar 2020 13:16:53 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     zhukeqian <zhukeqian1@huawei.com>
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jay Zhou <jianjay.zhou@huawei.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [RFC] KVM: arm64: support enabling dirty log graually in small
 chunks
In-Reply-To: <64925c8b-af3d-beb5-bc9b-66ef1e47f92d@huawei.com>
References: <20200309085727.1106-1-zhukeqian1@huawei.com>
 <4b85699ec1d354cc73f5302560231f86@misterjones.org>
 <64925c8b-af3d-beb5-bc9b-66ef1e47f92d@huawei.com>
Message-ID: <a642a79ea9190542a9098e4c9dc5a9f2@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: zhukeqian1@huawei.com, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jianjay.zhou@huawei.com, sean.j.christopherson@intel.com, pbonzini@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-10 08:26, zhukeqian wrote:
> Hi Marc,
> 
> On 2020/3/9 19:45, Marc Zyngier wrote:
>> Kegian,

[...]

>> Is there a userspace counterpart to it?
>> 
> As this KVM/x86 related changes have not been merged to mainline
> kernel, some little modification is needed on mainline Qemu.

Could you please point me to these changes?

> As I tested this patch on a 128GB RAM Linux VM with no huge pages, the
> time of enabling dirty log will decrease obviously.

I'm not sure how realistic that is. Not having huge pages tends to lead
to pretty bad performance in general...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

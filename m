Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03C9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C054C20E65
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590564049;
	bh=xe0XCZfpz88ojVoEgE66/wE6fHWWqAyThRQDs0+/Qqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=eXeLN2UGTxyq8N1V8mgItsW/2TiB0dpc0doN+A1+2pDQES/3MisTFnL4WT+C88S6e
	 cvP7tfxTQsXRXYewsaUp8T010yA7x3ODrgx9rDaBGrLR7PQvGOZTvKEXY+ALTmgZHf
	 wzKqJyWnt0pfa7Sz6onazi8nuZFd3yH9TD4+KMb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgE0HUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbgE0HUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:20:48 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A6AF20C56;
        Wed, 27 May 2020 07:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590564047;
        bh=xe0XCZfpz88ojVoEgE66/wE6fHWWqAyThRQDs0+/Qqs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WABS5Dro923F6hOOT4JBJX+vEWtTfPyhmyPMpL17+pe7WBLFPyN1uqVWT8Yn2Efr9
         DBxfD2NPeacMwXgyDSaPXEiU3Hu3ZK2XxKea8S1z3IvQOKtyQtZm3BNal+JZ+UjWof
         n4fDU940Js3kYZ7JYZ7CjmuUcxWBu3JqG9D+mJQQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jdqMn-00Fcxl-OC; Wed, 27 May 2020 08:20:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 May 2020 08:20:45 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, drjones@redhat.com, eric.auger@redhat.com,
        aarcange@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH RFCv2 3/9] kvm/arm64: Rename kvm_vcpu_get_hsr() to
 kvm_vcpu_get_esr()
In-Reply-To: <2e4dd03f-656a-c32b-5e87-ca28583999ef@redhat.com>
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-4-gshan@redhat.com>
 <20200526104249.GB1363@C02TD0UTHF1T.local>
 <2e4dd03f-656a-c32b-5e87-ca28583999ef@redhat.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <359dad5546a428ea963781f2728e70bf@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gshan@redhat.com, mark.rutland@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com, suzuki.poulose@arm.com, drjones@redhat.com, eric.auger@redhat.com, aarcange@redhat.com, shan.gavin@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-27 03:43, Gavin Shan wrote:
> Hi Mark,
> 
> On 5/26/20 8:42 PM, Mark Rutland wrote:
>> On Fri, May 08, 2020 at 01:29:13PM +1000, Gavin Shan wrote:
>>> Since kvm/arm32 was removed, this renames kvm_vcpu_get_hsr() to
>>> kvm_vcpu_get_esr() to it a bit more self-explaining because the
>>> functions returns ESR instead of HSR on aarch64. This shouldn't
>>> cause any functional changes.
>>> 
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> 
>> I think that this would be a nice cleanup on its own, and could be 
>> taken
>> independently of the rest of this series if it were rebased and sent 
>> as
>> a single patch.
>> 
> 
> Yeah, I'll see how PATCH[3,4,5] can be posted independently
> as part of the preparatory work, which is suggested by you
> in another reply.
> 
> By the way, I assume the cleanup patches are good enough to
> target 5.8.rc1/rc2 if you agree.

It's fine to base them on -rc1 or -rc2. They will not be merged
before 5.9 though.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

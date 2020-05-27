Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E1AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300E4208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590565712;
	bh=o2RNuuLOPzIUQugqXI2pXs40dw3MxypX2JaA7iDkwY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TCfg8X7LR4jP6FLtJBBQAuq821DyzhH1mA3s9A4W+CADHsr/gROVYYDyr5fdeTXcy
	 mcIeZhOpCW+YeFOOfm1WvK95KNip6ISfU7Dxkk/PDoqFVcuNpdo0Nb9j2nYlwVst24
	 ok/hwd0b8KEXVIFCyaTd8a/pmQLqLEolaSa5izxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbgE0Hsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387423AbgE0Hs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:48:29 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23590207CB;
        Wed, 27 May 2020 07:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590565709;
        bh=o2RNuuLOPzIUQugqXI2pXs40dw3MxypX2JaA7iDkwY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pni6+ov8tRzZ5DYViPK8gJK1/JIpPkaSWj18F4PfL9wWknwOagXXMykJH5HcwlvDQ
         x3IiBKDcFTUwwSCMybSkdY/4dptm9ehSXmDPIAHI+/XDgYY1Knn4OLNEjNFyJBSJnJ
         20ZlhzylGziKft32Jn5ApIezyaR0yfrkfHQwD5Sw=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jdqnb-00FdJT-Gw; Wed, 27 May 2020 08:48:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 May 2020 08:48:27 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, will@kernel.org, catalin.marinas@arm.com,
        james.morse@arm.com, suzuki.poulose@arm.com, drjones@redhat.com,
        eric.auger@redhat.com, aarcange@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH RFCv2 0/9] kvm/arm64: Support Async Page Fault
In-Reply-To: <987785b2-2533-c3d8-8f6a-4193aa82d502@redhat.com>
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200526130927.GH1363@C02TD0UTHF1T.local>
 <987785b2-2533-c3d8-8f6a-4193aa82d502@redhat.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <ae0f32fa338969d25dc3da56292e35ed@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gshan@redhat.com, mark.rutland@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com, suzuki.poulose@arm.com, drjones@redhat.com, eric.auger@redhat.com, aarcange@redhat.com, shan.gavin@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-27 03:39, Gavin Shan wrote:
> Hi Mark,

[...]

>> Can you run tests with a real workload? For example, a kernel build
>> inside the VM?
>> 
> 
> Yeah, I agree it's far from a realistic workload. However, it's the 
> test case
> which was suggested when async page fault was proposed from day one, 
> according
> to the following document. On the page#34, you can see the benchmark, 
> which is
> similar to what we're doing.
> 
> https://www.linux-kvm.org/images/a/ac/2010-forum-Async-page-faults.pdf

My own question is whether this even makes any sense 10 years later.

The HW has massively changed, and this adds a whole lot of complexity
to both the hypervisor and the guest. It also plays very ugly games
with the exception model, which doesn't give me the warm fuzzy feeling
that it's going to be great.

> Ok. I will test with the workload to build kernel or another better one 
> to
> represent the case.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

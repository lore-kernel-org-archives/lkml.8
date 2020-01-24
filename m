Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9E6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404BE20838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579872879;
	bh=7L3LQxwcMn0sL99Kg9Iw/6y7YYRrD0myNYQr201fsnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XSE1QzDxniScAw+oGGUfqHFF90F5z/B5rcBNfXB8dim5sZ+sZQs7NlUjJwCCk6Poq
	 A2e3nUWmsAv4Wovg9ldy6MlcPOmQhrPHWejczfmZGrGUEQDO7+8t17dw5A4E5GakCy
	 RFzSvVCTqlbWZwJR/ecftGO6+iQtoOT56UrvF3wc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389890AbgAXNei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 08:34:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388262AbgAXNei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:34:38 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D6A2087E;
        Fri, 24 Jan 2020 13:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579872877;
        bh=7L3LQxwcMn0sL99Kg9Iw/6y7YYRrD0myNYQr201fsnk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0C+Q1CJKCYngonwYHsFw0cvUJaGwCYR31GdsPpHgLdcp/LB8OLUFNNDmAHxHHGpIS
         SWhInojOa2FB8a+OAO/a+YkLO9er7YMVTdy13fyo6MxGzveKs+gGtIqazSMn7xXyHh
         jGcMTIIkXJyvx5FXhwLAP8xmJPXwPSNy6dpASKT4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1iuz6Z-001Bnc-HH; Fri, 24 Jan 2020 13:34:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 24 Jan 2020 13:34:35 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        kvmarm@lists.cs.columbia.edu, kernel-team@android.com
Subject: Re: [PATCH v2 0/1] arm/arm64: add support for folded p4d page tables
In-Reply-To: <20200124122053.GA150292@google.com>
References: <20200113111323.10463-1-rppt@kernel.org>
 <20200122185017.GA17321@willie-the-truck>
 <cb6357040bd5d9fa061a8d3bd96fb571@kernel.org>
 <20200124122053.GA150292@google.com>
Message-ID: <af9e7292f723f808406510f437d5b0eb@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qperret@google.com, will@kernel.org, rppt@kernel.org, anshuman.khandual@arm.com, catalin.marinas@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, rppt@linux.ibm.com, kvmarm@lists.cs.columbia.edu, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On 2020-01-24 12:20, Quentin Perret wrote:
> Hi Marc,
> 
> On Wednesday 22 Jan 2020 at 18:56:38 (+0000), Marc Zyngier wrote:
>> But maybe this is the reason we've all been waiting for, for which we
>> sacrifice 32bit KVM host on the altar of progress, and finally move 
>> along.
>> 
>> Will and I are the only known users, and that'd be a good incentive to
>> experience some if this 64bit goodness... ;-)

[future work for which 32bit support gets in the way]

> This would a be perfectly reasonable and acceptable overhead if this 
> had
> to be done to keep 32bit KVM host support for a real user community, 
> but
> since it doesn't seem to exist (?), fighting with the above options
> feels like a lot of wasted efforts. (Note: I am not implying that Will
> and you are not real persons, but well, you see what I mean ;-)).

I don't disagree at all. To be honest, I've been on the cusp of getting
rid of it for a while, for multiple reasons:

- It has no users (as you noticed)
- It is hardly tested (a consequence of the above)
- It isn't feature complete (no debug, no PMU)
- It doesn't follow any of the evolution of the architecture (a more
   generic feature of the 32bit port, probably because people run their
   64bit-capable cores in 64bit mode)
- It is becoming a mess of empty stubs

The maintenance aspect hasn't been a real problem so far. Even the NV
support is only about 200 lines of stubs. But what you have in mind is
going to be much more invasive, and I wouldn't want an unused feature to
get in the way.

What I may end-up doing is to send a RFC series to remove the 32bit host
support from the tree during in the 5.6 cycle, targeting 5.7. If someone
shouts loudly during that time frame, we keep it and you'll have to work
around it. If nobody cares, then dropping it is the right thing to do.

Would that be OK with you?

         M.
-- 
Jazz is not dead. It just smells funny...

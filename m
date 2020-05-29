Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D72C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6F22074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590745308;
	bh=7656s4eYWhYzzAhobQ/p864RjB2diU/xpekCGE7YNZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=C+LX0WZmQ4EmyPUh52haSdpIZwVBh9zBO5bGU6ysORCwADI00D45X6Facj/6Bo5Uc
	 8iXJpUEReNsBon9dfB03j9e+vw65EUNRs+99tdTiFXh4IZXqFuKsFRCZpqSXYaxQq/
	 LJcrpCQonmC0yQeMSDmqjq/hLDZYmy2RBAc/UtVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgE2Jlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgE2Jlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:41:47 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8050720810;
        Fri, 29 May 2020 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590745306;
        bh=7656s4eYWhYzzAhobQ/p864RjB2diU/xpekCGE7YNZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VQmr+kTgz6xT6jL5yWNdjI6CmqoEcxAQUP7Yjg5gfK3TvAVPbNdb45ezQRJ9TGm5G
         TYEBNnIFHaH7aClx19eT+daZr2aERlM073SlgHsQTree3AC6yibKxy1OhiiSgkbohN
         obMAXKU++5wiqUu1N0nZETdr3VtZjSVNHuHPj2mA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jebWK-00GEXJ-Vz; Fri, 29 May 2020 10:41:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 29 May 2020 10:41:44 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFCv2 9/9] arm64: Support async page fault
In-Reply-To: <6a4a82a4-af01-98c2-c854-9199f55f7bd3@redhat.com>
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-10-gshan@redhat.com>
 <81adf013-3de7-23e6-7648-8aec821b033c@redhat.com>
 <a6addc25-29af-3690-8392-efa5e8381e98@redhat.com>
 <8ab64c6a-582b-691d-79ab-21cdc0455cd3@redhat.com>
 <6a4a82a4-af01-98c2-c854-9199f55f7bd3@redhat.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <6965aaf641a23fab64fbe2ceeb790272@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gshan@redhat.com, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, shan.gavin@gmail.com, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-29 00:02, Gavin Shan wrote:
> Hi Paolo,
> 
> On 5/28/20 8:48 PM, Paolo Bonzini wrote:
>> On 28/05/20 08:14, Gavin Shan wrote:
>>>> - for x86 we're also thinking of initiating the page fault from the
>>>> exception handler, rather than doing so from the hypervisor before
>>>> injecting the exception.  If ARM leads the way here, we would do our
>>>> best to share code when x86 does the same.
>>> 
>>> Sorry, Paolo, I don't follow your idea here. Could you please provide
>>> more details?
>> 
>> The idea is to inject stage2 page faults into the guest even before 
>> the
>> host starts populates the page.  The guest then invokes a hypercall,
>> telling the host to populate the page table and inject the 'page 
>> ready'
>> event (interrupt) when it's done.
>> 
>> For x86 the advantage is that the processor can take care of raising 
>> the
>> stage2 page fault in the guest, so it's faster.
>> 
> I think there might be too much overhead if the page can be populated
> quickly by host. For example, it's fast to populate the pages if swapin
> isn't involved.
> 
> If I'm correct enough, it seems arm64 doesn't have similar mechanism,
> routing stage2 page fault to guest.

Indeed, this isn't a thing on arm64. Exception caused by a S2 fault are
always routed to EL2.

         M.
-- 
Jazz is not dead. It just smells funny...

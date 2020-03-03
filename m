Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FBAC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F8E214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583256842;
	bh=iPOYluEY+ZO1uyD5kIymeUNRinPpcpWzEsgkKtWHXKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Uaa2xDt0K9OIynMB9RL+Qztk6EDyy8fuLOBAjvFMB5YRWKqyq3KWtT4ncmL2nH12O
	 2FobfJC+Ui1Dce9GORdpV+4iNMRk+lzG1H9bK/RVnhjVuNe0foNP5yuFG/P/uYJmst
	 QUE7dEFZxNOod7SUobKlqvQ2qnOvirdUw0so/oIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbgCCReB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:34:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:47176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730440AbgCCReB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:34:01 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA97A2146E;
        Tue,  3 Mar 2020 17:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583256839;
        bh=iPOYluEY+ZO1uyD5kIymeUNRinPpcpWzEsgkKtWHXKk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PssTJb+5WAlQiBvvTwCxPLcnNVAQWPTDSLFFFkPWblU0Tw3d2NnBnuKJhMGo2iJ4/
         udmQSQKATNt7HuovAY5BY+JsaxblFdHhEW6mvR8mZgogCM+29GHHS7gJeFvKnHGXD+
         WvRlzPNtr7KjGCMKufGhmxLDK4SNmIVSspxzoR48=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j9BQc-009jyt-0c; Tue, 03 Mar 2020 17:33:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Mar 2020 17:33:57 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Fix MSI reservation allocation
In-Reply-To: <f0fc18a5-17a9-4c53-052b-00272bbd2691@arm.com>
References: <20200303115154.32263-1-maz@kernel.org>
 <f0fc18a5-17a9-4c53-052b-00272bbd2691@arm.com>
Message-ID: <dd29d82badfa11f7c0c80563d1b38804@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, jroedel@suse.de, eric.auger@redhat.com, will@kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-03 17:23, Robin Murphy wrote:
> On 03/03/2020 11:51 am, Marc Zyngier wrote:
>> The way cookie_init_hw_msi_region() allocates the iommu_dma_msi_page
>> structures doesn't match the way iommu_put_dma_cookie() frees them.
>> 
>> The former performs a single allocation of all the required 
>> structures,
>> while the latter tries to free them one at a time. It doesn't quite
>> work for the main use case (the GICv3 ITS where the range is 64kB)
>> when the base ganule size is 4kB.
>> 
>> This leads to a nice slab corruption on teardown, which is easily
>> observable by simply creating a VF on a SRIOV-capable device, and
>> tearing it down immediately (no need to even make use of it).
>> 
>> Fix it by allocating iommu_dma_msi_page structures one at a time.
> 
> Bleh, you know you're supposed to be using 64K pages on those things, 
> right? :P

lalalala... ;-)

[...]

>> +		if (!msi_page) {
>> +			ret = -ENOMEM;
> 
> I think we can just return here and skip the cleanup below - by the
> time we get here the cookie itself has already been allocated and
> initialised, so even if iommu_dma_init_domain() fails someone else has
> already accepted the responsibility of calling iommu_put_dma_cookie()
> at some point later, which will clean up properly.

Ah, that's a very good point. I'll refresh the patch with a simplified
error handling.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

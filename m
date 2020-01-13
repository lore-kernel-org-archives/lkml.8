Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13836C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D336621744
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578933637;
	bh=sCmFCwYbsvnNPm2PkRZEhJA1442m+QaJCHhH5zkDbgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NO3JEied9/Rc3iGRN30mrxjPmVpTc/wDeYOZuaB3ytp2B6NSgXR6b0uzlBWGSZooB
	 tVnLxLSomhsPN8jTfEzWhFnVo35L5yKkSZ9WlgXB9qkKN5mVYo/4IZD+1X7pekP2ud
	 WgHU5g5MdAQbl3mhwRukQCSjhGwHgSbbJVITzztw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgAMQkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbgAMQkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:40:36 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6A1C21569;
        Mon, 13 Jan 2020 16:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578933635;
        bh=sCmFCwYbsvnNPm2PkRZEhJA1442m+QaJCHhH5zkDbgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJR9K9bFdFK7SVbODxkwPKvqlChV/1xoJ/6AECR8oQ/b9Ga67JCoa2iqvC7O6ZkjW
         PjIz4V4LSComMuz2EKx/7aDA0KTg0oKFTGG6EyftvOZMW4d2Xl2VGEDVI1U+gd7197
         1qodocFPpKwz//GfBSb6NyziIq0TLQlWIVj0dBJc=
Date:   Mon, 13 Jan 2020 16:40:29 +0000
From:   Will Deacon <will@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mark.rutland@arm.com, peterz@infradead.org,
        catalin.marinas@arm.com, takahiro.akashi@linaro.org,
        james.morse@arm.com, hidehiro.kawai.ez@hitachi.com,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, x86@kernel.org, dzickus@redhat.com,
        ehabkost@redhat.com, linux@armlinux.org.uk, davem@davemloft.net,
        sparclinux@vger.kernel.org, hch@infradead.org
Subject: Re: [RFC PATCH v3 00/12] Unify SMP stop generic logic to common code
Message-ID: <20200113164029.GE4458@willie-the-truck>
References: <20191219121905.26905-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219121905.26905-1-cristian.marussi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 12:18:53PM +0000, Cristian Marussi wrote:
> the logic underlying SMP stop and kexec crash procedures, beside containing
> some arch-specific bits, is mostly generic and common across all archs:
> despite this fact, such logic is now scattered across all architectures and
> on some of them is flawed, in such a way that, under some specific
> conditions, you can end up with a CPU left still running after a panic and
> possibly lost across a subsequent kexec crash reboot. [1]

Is this still the case even after 20bb759a66be ("panic: ensure preemption is
disabled during panic()")?

Will

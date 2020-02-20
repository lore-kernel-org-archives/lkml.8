Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0158C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7274C208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd03US2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgBTOuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:50:52 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33908 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgBTOuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:50:51 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so27784969oig.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 06:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YCUtEJ53m7ECqKK3AgOl0cehXlRW5Bi+qbeZF5u/cGo=;
        b=Gd03US2pURX3tpufgzIPcsHuU48CBvPuzbG655N2Rz5c8F5EN+JlwQ/u7fwPId6h+x
         4avt70bXWtqp5kBm/zeBhactVQPHjBYvvjBQNQHHvh8e1LjTYa/hY7ZnnnHOJaSwBhVN
         fGz7P6w3RiKO3Ah2aRV3b8idbHoM18Dy/IU9gBB58IBVnT1kuN527PmePh2f+PiRQR49
         xIqlYaHSB/0U/XlCNevbLJ5DonSQCqnYTXeLeW7wG86TVQshq7jdvOAnN7zeB40cHas3
         pPDL90ukHRvLiGpP2fZstQy40PJhSwSRtfizQp0ZioDoSfzwWOGnGtjVW0F/f8LnsRhZ
         9oqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=YCUtEJ53m7ECqKK3AgOl0cehXlRW5Bi+qbeZF5u/cGo=;
        b=dXgDVQleqD4tq65as0j74itmACSKRceWuM9L2SbmjyEN0KZOVS59dpUMtNY4KO4619
         aZ1A4iKTCu3jJLkN2qOrQ46MtuObcFDfBEFQS1iBd9TKCDs6mm8y2AOwOdHWvBNMllkV
         z+v95rCZxe3uuuuu4VPhHzp2L6EgR7uqj52QzEsl1B8qqjHBROn4zxF60U1lPLJ+HgAL
         3TXHeqd+12dOjI6+khFGTk5lLBYUyUjc6aAuqHmRTwg0uRBNjz44ojPBulvSAYjbO6ak
         msNbn62DgNgbtsXqQqxBVXUehUCs3877btPC9InVaR76Thh0/CQYBkUHnMXX1vhIwSIT
         iBLg==
X-Gm-Message-State: APjAAAXgs8u/pfrvsOba6ZgleUmKGaHs4qkLi3iWb9M85SePXGhd3moB
        iAJJwXzQT27Pml0YrfG1/A==
X-Google-Smtp-Source: APXvYqz8I33kaCgp3GTwzmzy/RMDIMTxVe9rD7G20HB79+/6QsGE8/hYgj8DFw8sqYbzLba7cziyNg==
X-Received: by 2002:a05:6808:18:: with SMTP id u24mr2347495oic.10.1582210250197;
        Thu, 20 Feb 2020 06:50:50 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id m2sm1171204oim.13.2020.02.20.06.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 06:50:49 -0800 (PST)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:9129:b2b8:445c:a4ff])
        by serve.minyard.net (Postfix) with ESMTPSA id 3AEFA18000D;
        Thu, 20 Feb 2020 14:50:49 +0000 (UTC)
Date:   Thu, 20 Feb 2020 08:50:48 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Corey Minyard <cminyard@mvista.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64:kgdb: Fix kernel single-stepping
Message-ID: <20200220145048.GH3704@minyard.net>
Reply-To: minyard@acm.org
References: <20200219152403.3495-1-minyard@acm.org>
 <1416dca51b52dff349923184f41d48e8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1416dca51b52dff349923184f41d48e8@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 02:21:36PM +0000, Marc Zyngier wrote:
> On 2020-02-19 15:24, minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> 
> [...]
> 
> > After studying the EL0 handling for this, I realized an issue with using
> > MDSCR to check if single step is enabled: it can be expensive on a VM.
> > So check the task flag first to see if single step is enabled.  Then
> > check MDSCR if the task flag is set.
> 
> Very tangential remark: I'd really like people *not* to try and optimize
> Linux based on the behaviour of a hypervisor. In general, reading a
> system register is fast, and the fact that it traps on a given hypervisor
> at some point may not be true in the future, nor be a valid assumption
> across hypervisors.

Normally I would agree, but I based this upon git commit
https://github.com/torvalds/linux/commit/2a2830703a2371b47f7b50b1d35cb15dc0e2b717
which seemed to say that it was a significant enough factor to do in the
EL0 case.

-corey

> 
>         M.
> -- 
> Jazz is not dead. It just smells funny...

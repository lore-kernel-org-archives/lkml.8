Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB52CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD56206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594020671;
	bh=uHuTSC0nl2sx5Pf93LTnYxsHKu75RgJ9SFC/wM8O4TU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HyR9mOLq07DwYkQalOHgpfkj73SbyCDYtAdxZidPssbLJJdGjf9UWtc76dQkTj00L
	 G3j5X3jwydU3drg51NhcAxut1+go4TkJGoC4qAIpvDLDWEn9ruJ0ehSfiLpL42O50F
	 8fI8Mw2tHrZ2N/iezsjPjNlYULmVjH6DSTfZ4vic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgGFHbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 03:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbgGFHbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 03:31:00 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69044206CD;
        Mon,  6 Jul 2020 07:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594020659;
        bh=uHuTSC0nl2sx5Pf93LTnYxsHKu75RgJ9SFC/wM8O4TU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mba3IC609v4YUrKBwbA7rMRlxeIG8NWpKtXmzqmyDFzgYM4noII3fy99UsGJYkFOp
         wgdqyGqEmHxX2BbV0n+HhR7uHQ5o6tFuSFiklBDsIV4NwaG/R0Fu/R1WEddRU9taHv
         Ik5HEJYwfy0rK5CfK13MPKaLh8qD12hdxQKYC3nU=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jsLac-009OCX-0t; Mon, 06 Jul 2020 08:30:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Jul 2020 08:30:57 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v5 00/14] irqchip: Fix potential resource leaks
In-Reply-To: <1593998365-25910-1-git-send-email-yangtiezhu@loongson.cn>
References: <1593998365-25910-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <ab1cd9280c7892a0230945ef5ff0880c@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yangtiezhu@loongson.cn, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, Markus.Elfring@web.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-06 02:19, Tiezhu Yang wrote:
> When I test the irqchip code of Loongson, I read the related code of 
> other
> chips in drivers/irqchip and I find some potential resource leaks in 
> the
> error path, I think it is better to fix them.
> 
> v2:
>   - Split the first patch into a new patch series which
>     includes small patches and add "Fixes" tag
>   - Use "goto" label to handle error path in some patches
> 
> v3:
>   - Add missed variable "ret" in the patch #5 and #13
> 
> v4:
>   - Modify the commit message of each patch suggested by Markus Elfring
>   - Make "irq_domain_remove(root_domain)" under CONFIG_SMP in patch #3
>   - Add a return statement before goto label in patch #4
> 
> v5:
>   - Modify the commit messages and do some code cleanups

Please stop replying to Markus Elfring, and give people who actually
care a chance to review this code. Elfring will keep asking you to make
absolutely pointless changes until you are blue in the face

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

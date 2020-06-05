Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC278C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4BCB207DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591351055;
	bh=rfylPv3H3z+tdHudrRYNXqWRsJ0KNJa9SUb7O3OTitY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Av/rUGlpbWjIXCNynBS7H/UIgh+4hJy2OfMt8eyK4aXYZq6UsU70w6FoNDobY2sb4
	 HRJffOhS9iT3mCkRUSBHfEq+eHFay5DH5PcpBQHTvKXu6W15UHp4AOI9XQ3nHAgiXe
	 NAb91Rsf4BHhOZ9QgQjWmEetJWKBy8kO8sdz7Rvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgFEJ5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgFEJ5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:57:34 -0400
Received: from linux-8ccs (p57a23121.dip0.t-ipconnect.de [87.162.49.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFD892075B;
        Fri,  5 Jun 2020 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591351054;
        bh=rfylPv3H3z+tdHudrRYNXqWRsJ0KNJa9SUb7O3OTitY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBpyFHAekvsx8ocPNLR08b4BRt+CfNiYu38/QyeB7Y2IbyRiq7RGh1WSuyRFIDxxT
         sDc/jsOvoYluHCAuJM4aJkLCyjSonF700qSuQ9BQcA/DV5O9kDLvroZkVKIOLylLzN
         brDigqZNGBQF5CSgqIYgnHjRrL54oRpcfryFqXL4=
Date:   Fri, 5 Jun 2020 11:57:29 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] kernel/modules: fix build without
 ARCH_HAS_STRICT_MODULE_RWX
Message-ID: <20200605095729.GB24474@linux-8ccs>
References: <20200604210115.16826-1-jcmvbkbc@gmail.com>
 <alpine.LSU.2.21.2006050949210.10354@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LSU.2.21.2006050949210.10354@pobox.suse.cz>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miroslav Benes [05/06/20 09:50 +0200]:
>Hi,
>
>On Thu, 4 Jun 2020, Max Filippov wrote:
>
>> On configurations with CONFIG_ARCH_HAS_STRICT_MODULE_RWX disabled kernel
>> build fails with the following message:
>>
>>   kernel/module.c:3593:2: error: implicit declaration of function
>>   ‘module_enable_ro’;
>>
>> Add empty module_enable_ro definition to fix the build.
>>
>> Fixes: e6eff4376e28 ("module: Make module_enable_ro() static again")
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>
>I think the problem should disappear once Jessica sends her pull request
>for modules tree.

Yep, the pull request was sent today. So this should get resolved in
the next day or two.

Thanks,

Jessica

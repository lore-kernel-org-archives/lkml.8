Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B562EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 10:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AD020732
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 10:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgDKK1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 06:27:39 -0400
Received: from ciao.gmane.io ([159.69.161.202]:58464 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgDKK1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 06:27:38 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1jNDMP-000BAw-BD
        for linux-kernel@vger.kernel.org; Sat, 11 Apr 2020 12:27:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
Date:   Sat, 11 Apr 2020 12:27:32 +0200
Message-ID: <0b05744d-7379-fa23-5070-c09fd10db45d@wanadoo.fr>
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
 <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
 <6e52383e-100d-b016-32c2-6fb54938b6fe@wanadoo.fr>
 <c9fd4bc75812fed4799c2fb87b452b809a7e9a7a.camel@perches.com>
 <db2730700ab3eb7008413a1e7bba94ca7c49a031.camel@perches.com>
 <26b49cf5-453b-9a81-b045-fdc99c42fcf8@wanadoo.fr>
 <159680bb287fc43bb2129d3b731e15931bd9979c.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <159680bb287fc43bb2129d3b731e15931bd9979c.camel@perches.com>
Content-Language: en-US
Cc:     kernel-janitors@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200411102732.tNHDVCSBpm7N2RmoArbsIEemQPlsp5h4m_nhQdxDubs@z>

Le 11/04/2020 à 12:17, Joe Perches a écrit :
> On Sat, 2020-04-11 at 09:12 +0200, Christophe JAILLET wrote:
>> 	./scripts/checkpatch.pl -f drivers/soc/kendryte/k210-sysctl.c
>>
>> is missing line 189, even if it looks like a construction correctly spotted in some other files:
>> 	if (foo) {
>> 		dev_err(...);
>> 		...
>> 	};
> Hi Christophe, many thanks for doing more testing
>
> Are you sure about this one?  I get:
>
> $ ./scripts/checkpatch.pl -f drivers/soc/kendryte/k210-sysctl.c
> WARNING: Possible missing '\n' at the end of a logging message format string
> #189: FILE: drivers/soc/kendryte/k210-sysctl.c:189:
> +		dev_err(&pdev->dev, "failed to register clk");
No, this one is correctly spotted.
(I added the missing \n, then ran checkpatch.pl, then wondered why it 
was not spotting the issue!)

CJ



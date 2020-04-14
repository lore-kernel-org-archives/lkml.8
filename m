Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8A0C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B82A206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437447AbgDNJLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:11:42 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:5120 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437407AbgDNJLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:11:32 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5e957e3387b-4fa4f; Tue, 14 Apr 2020 17:11:15 +0800 (CST)
X-RM-TRANSID: 2eec5e957e3387b-4fa4f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.21.224] (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85e957e33267-d28c6;
        Tue, 14 Apr 2020 17:11:15 +0800 (CST)
X-RM-TRANSID: 2ee85e957e33267-d28c6
Subject: Re: [PATCH] usb: gadget: fsl: Fix a wrong judgment in fsl_udc_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200410015832.8012-1-tangbin@cmss.chinamobile.com>
 <be8cd229-884a-40e6-3363-7c4680a51b30@web.de>
 <0b718268-d330-dfc1-aca3-3dd3203363d7@cmss.chinamobile.com>
 <20200414083036.GC14722@kadam>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <f712918c-2f61-0ba5-2ba8-b5ca3cce9a35@cmss.chinamobile.com>
Date:   Tue, 14 Apr 2020 17:13:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414083036.GC14722@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2020/4/14 16:30, Dan Carpenter wrote:
> On Fri, Apr 10, 2020 at 04:05:06PM +0800, Tang Bin wrote:
>>>
>>>> Thus it must be fixed.
>>> Wording alternative:
>>>     Thus adjust the error detection and corresponding exception handling.
>> Got it.
> Wow...
>
> No, don't listen to Markus when it comes to writing commit messages.
> You couldn't find worse advice anywhere.  :P

I'm actively waiting for a reply from the maintainer. Thank you very much.

Tang Bin





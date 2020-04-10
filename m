Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85704C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 09:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F0B206F7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 09:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJJO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 05:14:26 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:8825 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgDJJO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 05:14:26 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65e9038cea20-02a24; Fri, 10 Apr 2020 17:13:51 +0800 (CST)
X-RM-TRANSID: 2ee65e9038cea20-02a24
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.21.224] (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85e9038ce8b0-29025;
        Fri, 10 Apr 2020 17:13:51 +0800 (CST)
X-RM-TRANSID: 2ee85e9038ce8b0-29025
Subject: Re: usb: gadget: fsl: Fix a wrong judgment in fsl_udc_probe()
To:     Markus Elfring <Markus.Elfring@web.de>, linux-usb@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <20200410015832.8012-1-tangbin@cmss.chinamobile.com>
 <be8cd229-884a-40e6-3363-7c4680a51b30@web.de>
 <0b718268-d330-dfc1-aca3-3dd3203363d7@cmss.chinamobile.com>
 <aa7006c9-8b83-5f30-86a6-8d60d290f824@web.de>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <a4738b42-b297-766c-56bf-94a91bc82767@cmss.chinamobile.com>
Date:   Fri, 10 Apr 2020 17:15:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <aa7006c9-8b83-5f30-86a6-8d60d290f824@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus:

On 2020/4/10 16:30, Markus Elfring wrote:
>> Hardware experiments show that the negative return value is not just "-EPROBE_DEFER".
> How much will this specific error code influence our understanding
> of the discussed software situation?
>
 From my superficial knowledge, I think we should not  think about it 
too complicated. The return value is just zero or negative, and for 
these negative return value, such as 
"-ENODEV"、"-ENXIO"、"-ENOENT"、“EPROBE_DEFER”，may be the same 
effect。But“-EPROBE_DEFER”has another  importment function: Driver 
requested deferred probing，which is used in cases where the dependency 
resource is not ready during the driver initialization process.
>>>> +        ret = udc_controller->irq ? : -ENODEV;
>>> Will it be clearer to specify values for all cases in such a conditional operator
>>> (instead of leaving one case empty)?
>> I don't know what you mean of "instead of leaving one case empty".
> I suggest to reconsider also the proposed specification “… ? : …”.

What you mean is the way I'm written？

I have provided two ways of patching, both functional can be verified on 
hardware.

Thanks for your patience.

Tang Bin




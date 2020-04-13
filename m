Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473FFC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7CB2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgDMLzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:55:06 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:40736 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgDMLzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 07:55:04 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35e94530be9e-3a131; Mon, 13 Apr 2020 19:54:51 +0800 (CST)
X-RM-TRANSID: 2ee35e94530be9e-3a131
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.21.224] (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35e94530b271-c5fbd;
        Mon, 13 Apr 2020 19:54:51 +0800 (CST)
X-RM-TRANSID: 2ee35e94530b271-c5fbd
Subject: Re: [PATCH v3]ipmi:bt-bmc:Avoid unnecessary judgement
To:     minyard@acm.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20200408115958.2848-1-tangbin@cmss.chinamobile.com>
 <20200413113225.GB3587@minyard.net>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <47c06465-9ae5-42c2-ca00-5c666521bbde@cmss.chinamobile.com>
Date:   Mon, 13 Apr 2020 19:56:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200413113225.GB3587@minyard.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Corey:

On 2020/4/13 19:32, Corey Minyard wrote:
> On Wed, Apr 08, 2020 at 07:59:58PM +0800, Tang Bin wrote:
>> bt_bmc_probe() is only called with an openfirmware platform device.
>> Therefore there is no need to check that the passed in device is NULL or
>> that it has an openfirmware node.
> I waited until after the merge window closed, this is queued for 5.8.
Can I consider that the patch will be applied in 5.8？
>   I
> changed the title to be "Avoid unnecessary check".
You have modified it, which means I don't need to submit a new patch？
>   "Judgement",
> although technically correct, has a legal or moral connotation.

I'm sorry, I won't use that word again.


Thanks for your instruction.

Tang Bin

>



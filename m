Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F54C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AEA72071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgHXJhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:37:18 -0400
Received: from goliath.siemens.de ([192.35.17.28]:39727 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgHXJhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:37:11 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 07O9arbw001563
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 11:36:54 +0200
Received: from [167.87.131.75] ([167.87.131.75])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07O9aoeD028000;
        Mon, 24 Aug 2020 11:36:51 +0200
Subject: Re: [PATCH v3] usb-serial:cp210x: add support to software flow
 control
To:     "Wang, Sheng Long (EXT) (RC-CN DI FA R&D SW)" 
        <shenglong.wang.ext@siemens.com>, Johan Hovold <johan@kernel.org>
Cc:     Sheng Long Wang <china_shenglong@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200820075240.13321-1-china_shenglong@163.com>
 <97836b78-740b-cf70-4803-27305b6e0a4d@siemens.com>
 <20200824090948.GC21288@localhost>
 <f21d4cc8b12d4ec6870623472ca7df09@siemens.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <faddf44e-db1d-46e5-b6db-88168b0cc808@siemens.com>
Date:   Mon, 24 Aug 2020 11:36:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f21d4cc8b12d4ec6870623472ca7df09@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.20 11:28, Wang, Sheng Long (EXT) (RC-CN DI FA R&D SW) wrote:
> Hi Johan,
> 
>     Thanks for your reminding. I am adjusting patch according to the latest Linux Master branch.

Use git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git, branch
is likely usb-linus, as Johan requested - just in case there is another
conflict due to a patch not yet in Linux master but in that tree.

> 
> With best regards,
> Wang Sheng Long
> Siemens Ltd., China
> RC-CN DI FA R&D SW
> Tianyuan road No.99
> 611731 CHENGDU, China
> Mobil: +86 15281074996
> mailto:shenglong.wang.ext@siemens.com
> 
> 
> 
> -----Original Message-----
> From: Johan Hovold <johan@kernel.org> 
> Sent: Monday, August 24, 2020 5:10 PM
> To: Kiszka, Jan (CT RDA IOT SES-DE) <jan.kiszka@siemens.com>
> Cc: Sheng Long Wang <china_shenglong@163.com>; Wang, Sheng Long (EXT) (RC-CN DI FA R&D SW) <shenglong.wang.ext@siemens.com>; johan@kernel.org; gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3] usb-serial:cp210x: add support to software flow control
> 
> On Fri, Aug 21, 2020 at 07:32:58AM +0200, Jan Kiszka wrote:
>> On 20.08.20 09:52, Sheng Long Wang wrote:
>>> From: Wang Sheng Long <shenglong.wang.ext@siemens.com>
>>>
>>> When data is transmitted between two serial ports, the phenomenon of 
>>> data loss often occurs. The two kinds of flow control commonly used 
>>> in serial communication are hardware flow control and software flow 
>>> control.
>>>
>>> In serial communication, If you only use RX/TX/GND Pins, you can't 
>>> do hardware flow. So we often used software flow control and prevent 
>>> data loss. The user sets the software flow control through the 
>>> application program, and the application program sets the software 
>>> flow control mode for the serial port chip through the driver.
>>>
>>> For the cp210 serial port chip, its driver lacks the software flow 
>>> control setting code, so the user cannot set the software flow 
>>> control function through the application program. This adds the 
>>> missing software flow control.
>>>
>>> Signed-off-by: Wang Sheng Long <shenglong.wang.ext@siemens.com>
>>>
>>> Changes in v3:
>>> -fixed code style, It mainly adjusts the code style acccording  to 
>>> kernel specification.
>>
>> Patch does not apply. You forgot to rebase over latest tty/tty-next or 
>> linux master.
> 
> That should be the usb-next branch of the usb-serial tree:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/
> 
> or linux-next (or, currently, Linus's master branch).
> 
> You can use "scripts/get_maintainer.sh --scm" to determine which tree to base your work against.

Thanks for correcting! But it's scripts/get_maintainer.pl. ;)

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

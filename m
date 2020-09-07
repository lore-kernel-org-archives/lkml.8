Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A439C2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258F62067C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgIGK35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:29:57 -0400
Received: from mail.netline.ch ([148.251.143.178]:60670 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbgIGK33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:29:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 0C0B02A6042;
        Mon,  7 Sep 2020 12:29:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id qXTjMtX9lbI6; Mon,  7 Sep 2020 12:29:24 +0200 (CEST)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch [188.63.174.212])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id CE6672A6016;
        Mon,  7 Sep 2020 12:29:23 +0200 (CEST)
Received: from [::1]
        by thor with esmtp (Exim 4.94)
        (envelope-from <michel@daenzer.net>)
        id 1kFEOw-000Lc5-KY; Mon, 07 Sep 2020 12:29:22 +0200
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20200806072256.585705-1-vaibhavgupta40@gmail.com>
 <20200907075559.GN2352366@phenom.ffwll.local>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v1 0/2] video: fbdev: radeonfb: PCI PM framework upgrade
 and fix-ups.
Message-ID: <5ea9e575-e2ba-1f12-4894-3c0d271ea294@daenzer.net>
Date:   Mon, 7 Sep 2020 12:29:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200907075559.GN2352366@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-07 9:55 a.m., Daniel Vetter wrote:
> On Thu, Aug 06, 2020 at 12:52:54PM +0530, Vaibhav Gupta wrote:
>> Linux Kernel Mentee: Remove Legacy Power Management.
>>
>> The original goal of the patch series is to upgrade the power management
>> framework of radeonfb fbdev driver. This has been done by upgrading .suspend()
>> and .resume() callbacks.
>>
>> The upgrade makes sure that the involvement of PCI Core does not change the
>> order of operations executed in a driver. Thus, does not change its behavior.
>>
>> During this process, it was found that "#if defined(CONFIG_PM)" at line 1434 is
>> redundant. This was introduced in the commit
>> 42ddb453a0cd ("radeon: Conditionally compile PM code").
> 
> I do wonder whether it wouldn't be better to just outright delete these,
> we have the drm radeon driver for pretty much all the same hardware ...

In contrast to radeonfb, the radeon driver doesn't support 
suspend-to-RAM on Apple PowerPC notebooks.


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer

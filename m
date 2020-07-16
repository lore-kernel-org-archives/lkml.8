Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2289CC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E1620760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGPI5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:57:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43170 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgGPI5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:57:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 7143826103D
Subject: Re: mainline/master bisection: baseline.dmesg.crit on
 qemu_arm-vexpress-a15
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     kernelci-results@groups.io,
        Andre Przywara <andre.przywara@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
        linux-kernel@vger.kernel.org
References: <5f0288aa.1c69fb81.b1c2a.eea4@mx.google.com>
 <20200706124951.GA32234@bogus>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <b7d63093-a1a8-fbc1-6673-040d6ba8cc8d@collabora.com>
Date:   Thu, 16 Jul 2020 09:57:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706124951.GA32234@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2020 13:49, Sudeep Holla wrote:
> Hi,
> 
> On Sun, Jul 05, 2020 at 07:12:58PM -0700, kernelci.org bot wrote:
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>> * This automated bisection report was sent to you on the basis  *
>> * that you may be involved with the breaking commit it has      *
>> * found.  No manual investigation has been done to verify it,   *
>> * and the root cause of the problem may be somewhere else.      *
>> *                                                               *
>> * If you do send a fix, please include this trailer:            *
>> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
>> *                                                               *
>> * Hope this helps!                                              *
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>
> 
> Andre test and replied to one of the similar but earlier reports.
> Unless we get some response to that, we can't proceed and we can't
> do much other than ignoring these reports. Please respond to Andre's
> queries.


Sorry I missed your email, the regression is still there.  I'll
reply to André.

Guillaume

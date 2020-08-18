Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1709DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F0A205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgHRLbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:31:15 -0400
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:50904 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgHRLaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:30:35 -0400
X-Greylist: delayed 1272 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Aug 2020 07:30:31 EDT
Received: from [188.210.212.0] (helo=[192.168.0.104])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1k7zUO-0005sK-8K; Tue, 18 Aug 2020 12:09:12 +0100
Subject: Re: [PATCH 0/3] pinctrl: mcp23s08: Fixups for mcp23x17
To:     Rob Herring <robh@kernel.org>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200814100357.209340-1-thomas.preston@codethink.co.uk>
 <26d33248-c07b-db2c-2989-3ca14aea7896@codethink.co.uk>
 <20200817192957.GA1401599@bogus>
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <13c56cdc-ecb4-6590-7233-887397f1cd97@codethink.co.uk>
Date:   Tue, 18 Aug 2020 12:09:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817192957.GA1401599@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2020 20:29, Rob Herring wrote:
> On Fri, Aug 14, 2020 at 02:56:54PM +0100, Thomas Preston wrote:
>> Actually I think I'm wrong about the interrupt-controller changes in patches
>> 0002 and 0003.
> 
> You are. Looking at the datasheet, the GPIOs have interrupt capability.
> GPIO controllers are typically both an interrupt client and provider.

Thanks for the clarification.

I still think the patch 0001 is required. The precious and volatile 
ranges are broken.

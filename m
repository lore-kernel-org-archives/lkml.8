Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF28EC55193
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11F820767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qoRB/9oJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgDXEHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:07:52 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51220 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgDXEHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 00:07:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03O47i22007631;
        Thu, 23 Apr 2020 23:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587701264;
        bh=r0VQhpcVVLm0AmBAqscHMq+TasKplRJuuypRi/yC9XU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qoRB/9oJnnOANc+kZL8dEmok7vTtymOZfgtjjkbpknH/hQQrB6p3vDjkBC+WXo1Yr
         iZidyAtWt+Xruajxf3RHZWY1sQPjLgIspCy1rS/XatCGHk3D39xojUkasXxu8nINd0
         As+hOFI+6DuoFGpyDTH65/WRc3SqFMh53wmNFO/Y=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03O47iv0131019;
        Thu, 23 Apr 2020 23:07:44 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Apr 2020 23:07:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Apr 2020 23:07:44 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03O47dn0120610;
        Thu, 23 Apr 2020 23:07:40 -0500
Subject: Re: [RESEND x2][PATCH v2] phy: qcom-qusb2: Re add
 "qcom,sdm845-qusb2-phy" compat string
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20200421041815.1808-1-john.stultz@linaro.org>
 <CALAqxLUHLqoYAZRvF1HjHhOJPdztYh9oz=L0kEuYun7y6fBzGA@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <62be69b1-8349-aa16-b5d6-dcacbc4eb05c@ti.com>
Date:   Fri, 24 Apr 2020 09:37:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLUHLqoYAZRvF1HjHhOJPdztYh9oz=L0kEuYun7y6fBzGA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 4/24/2020 9:35 AM, John Stultz wrote:
> On Mon, Apr 20, 2020 at 9:18 PM John Stultz <john.stultz@linaro.org> wrote:
>>
>> This patch fixes a regression in 5.7-rc1+
>>
>> In commit 8fe75cd4cddf ("phy: qcom-qusb2: Add generic QUSB2 V2
>> PHY support"), the change was made to add "qcom,qusb2-v2-phy"
>> as a generic compat string. However the change also removed
>> the "qcom,sdm845-qusb2-phy" compat string, which is documented
>> in the binding and already in use.
>>
>> This patch re-adds the "qcom,sdm845-qusb2-phy" compat string
>> which allows the driver to continue to work with existing dts
>> entries such as found on the db845c.
> 
> I hate to be a bother on this, but I'd really like to see this
> regression resolved.  This fix missed rc1 and rc2, and it would be a
> shame to miss rc3 too.
> 
> Do I have the right folks on the cc for this?

Yes, I'll be merging this. Sorry for the delay.

Regards
Kishon

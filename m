Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535CFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360EB20732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="lgMvVrQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgFVRrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:47:22 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:25494 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729605AbgFVRrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:47:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592848041; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=RdP8Coca9hXqgxUVPdVNLur18MQ21Zv0dAHtp2pVhLs=; b=lgMvVrQJeGIWiZwDTk8cyTRnZ0/eV3Wl4gQVRgCTCkFPZ+19nvZ7sJe7yZWRguDMrrY20CGt
 kRBiKdbvKvUmc5F8vNQv5M7bTY2vqMvILxi8WpQobM05a5fJbOdUtWtPgAJB/irWg/HAWkO5
 H4TUbzgwSbWg97fPDEyao2jlWE8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5ef0ee9fad153efa347caef2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 17:47:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4A2F1C433A0; Mon, 22 Jun 2020 17:47:11 +0000 (UTC)
Received: from [10.110.87.234] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7603AC433C8;
        Mon, 22 Jun 2020 17:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7603AC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v3 2/6] dt-bindings: usb: Add Qualcomm PMIC type C
 controller dt-binding
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jack Pham <jackp@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Jun Li <lijun.kernel@gmail.com>
References: <20200617180209.5636-1-wcheng@codeaurora.org>
 <20200617180209.5636-3-wcheng@codeaurora.org>
 <CAL_Jsq+fhXWGJvYxUDygd6hKs3dc8GKxKCz_Q+_C1AjK0J0N+w@mail.gmail.com>
 <fb448691-2bda-ada6-799f-ee389e647710@codeaurora.org>
 <CAL_JsqLGWY_bBUzr6r0czxH32vvDnsR6=MzS=zH4tJ-5PEobZw@mail.gmail.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <9414034c-3f71-bdc1-bda2-6b3dc7758003@codeaurora.org>
Date:   Mon, 22 Jun 2020 10:47:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLGWY_bBUzr6r0czxH32vvDnsR6=MzS=zH4tJ-5PEobZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/2020 3:23 PM, Rob Herring wrote:
> On Thu, Jun 18, 2020 at 2:09 PM Wesley Cheng <wcheng@codeaurora.org> wrote:
>>
>>
>> On 6/18/2020 11:33 AM, Rob Herring wrote:
>>> On Wed, Jun 17, 2020 at 12:02 PM Wesley Cheng <wcheng@codeaurora.org> wrote:
>>>
>>> You are duplicating everything in usb-connector.yaml. You should have
>>> a $ref to it.
>>>
>>
>> Hi Rob,
>>
>> Sure, I will add a reference to that doc.
>>
>>>
>>> This is wrong. The connector binding says port 0 is the connection the
>>> USB HS controller.
>>>
>>> What's a type C mux node? Is there a binding for that? There's an
>>> ongoing discussion with the CrOS folks on how to describe Alt mode
>>> mux/switches.
>>
>> I reviewed the connector binding previously, and couldn't seem to come
>> up with a model which fit a design where the type C controller (ie the
>> entity which does the CC orientation and role detection) does not have
>> the SS lane mux included.  The SS lane mux is the HW which handles the
>> selection of the SS lanes to utilize based on cable orientation.
> 
> The intent was the controller would be the parent node of the connector.
> 

Hi Rob,

Correct, I agree with that point, and in the changes uploaded, the QCOM
PMIC type C controller will be the parent node for the connector.

> How the SS lane mux is represented is what needs to be figured out. I
> don't know what that looks like, but it needs to be something that
> works for multiple designs. Ideally, that's an extension of the
> existing 'usb-c-connector' binding, but if there's good reasons to
> redesign it that can happen.
> 
> Rob
> 

We probably wouldn't need to redesign it, but maybe if we can remove the
connector port assignments requirement, it would allow for some
flexibility.  From my knowledge, I don't think any driver is actually
utilizing or checking the port number assignments, so there isn't a
limitation on what could be defined in there.

Here's a simplified diagram of the FUSB302 reference design from the
data sheet.  The I2C bus is just for CSR access to the FUSB302.

				   _______		 _______
                            ______|FUSB302|		|SOC	|
			   |	  |Type C |		|	|
			   |      |Cntrl  |__I2C_______	|	|
			   |	  |_______|		|	|
 ___                       |       			|	|
|   |______ CC1/2 _________|				|	|
|   |______ HS DP/DM __________________________________	|	|
|   |							|	|
				   ________		|	|
|   |______ SS RX/TX1 ____________|FUSB304 |__SS RX/TX_	|	|
|   |______ SS RX/TX2 ____________|USB Mux |		|_______|
|   |                             |________|
|   |
|___|


Otherwise, we can just simply add another port definition for external
SS lane muxes if possible.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C524C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D06206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgFEH5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 03:57:23 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:33573 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbgFEH5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 03:57:18 -0400
Received: from [78.134.115.170] (port=39060 helo=[192.168.77.62])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jh7E1-000D4t-Ql; Fri, 05 Jun 2020 09:57:13 +0200
Subject: Re: [RFC 1/4] regulator: lp87565: enable voltage regardless of ENx
 pin
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>
References: <20200603200319.16184-1-luca@lucaceresoli.net>
 <20200603200319.16184-2-luca@lucaceresoli.net>
 <20200604110759.GB6644@sirena.org.uk>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <247eef95-9f7a-c1cd-245c-05304b02e4da@lucaceresoli.net>
Date:   Fri, 5 Jun 2020 09:57:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604110759.GB6644@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 04/06/20 13:07, Mark Brown wrote:
> On Wed, Jun 03, 2020 at 10:03:16PM +0200, Luca Ceresoli wrote:
> 
>> I suspect the only solution that allows to configure the EN_PIN_CTRLn bits
>> correctly in all the possible hardware setups would be to tell in device
>> tree / board info whether each enable pin is connected or not (which is a
>> hardware _fact_) and which ENx pin should control which regulator output
>> (which is a policy). But it would make this simple driver considerably more
>> complex.
> 
>> Any suggestion about the correct way to handle this situation would be
>> greatly appreciated.
> 
> We can tell if we've got a software controlled GPIO connected, if we
> have then we should ensure that it continues to take effect.

Ideally yes, but it would be made more complex by the chip flexibility:
it's possible to choose which enable pin should drive each output.

For example this configuration is supported by the chip:

- BUCK0 is on if EN_BUCK0 high AND pin EN0 is active
- BUCK1 is on if EN_BUCK1 high AND pin EN0 is active
- BUCK2 is on if EN_BUCK2 high AND pin EN1 is active
- BUCK3 is on if EN_BUCK3 high (no pin used)
- pin EN2 is used as a GPIO (LP875xx acts as an I2C GPIO expander)

So it would be absolutely OK to describe in DT that EN0 and EN1 connect
the SoC to the LP875xx and that EN2 is connected to something else.

But describing in DT the association between enable pins and buck
outputs would be more a configuration than hardware description IMO.

And I'm not even considering the case where the enable pins are be
connected to something else, out of the SoC control, but still meant to
be used to control the buck output.

> That
> should just be a single register write at startup from the sounds of it.

Exactly, each buck output has a register containing the bits involved in
this discussion.

> Otherwise yeah, just ignoring that there's a possibility of a GPIO we
> don't know about seems sensible.

Thanks,
-- 
Luca

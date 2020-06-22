Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B226C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B072076A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgFVUn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:43:29 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:59037 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728311AbgFVUn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:43:28 -0400
Received: from [37.163.98.205] (port=42654 helo=[192.168.43.3])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jnTHn-00060t-Ja; Mon, 22 Jun 2020 22:43:24 +0200
Subject: Re: [PATCH v2 2/4] dt-bindings: mfd: lp87565: convert to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Axel Lin <axel.lin@ingics.com>
References: <20200617131145.15696-1-luca@lucaceresoli.net>
 <20200617131145.15696-3-luca@lucaceresoli.net>
 <20200617171116.GA2321816@bogus>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <8de53388-684a-42ad-3502-5322c80bfd22@lucaceresoli.net>
Date:   Mon, 22 Jun 2020 22:43:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617171116.GA2321816@bogus>
Content-Type: text/plain; charset=utf-8
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

Hi Rob,

On 17/06/20 19:11, Rob Herring wrote:
> On Wed, 17 Jun 2020 15:11:43 +0200, Luca Ceresoli wrote:
>> The definition of "xxx-in-supply" was generic, thus define in detail the
>> possible cases for each chip variant.
>>
>> Also document that the only possible I2C slave address is 0x60 as per the
>> datasheet and fix the second example accordingly.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>>
>> ---
>>
>> Changes in v2:
>>  - this patch replaces patch "regulator: lp87565: dt: remove duplicated
>>    section" in RFC,v1 (Rob Herring)
>>  - use capital letters consistently (Lee Jones)
>>  - replace "regulator" -> "mfd" in subject line (Lee Jones)
>>  - replace "dt:" suffix with "dt-bindings:" prefix in subject line
>> ---
>>  .../devicetree/bindings/mfd/lp87565.txt       |  79 -----------
>>  .../devicetree/bindings/mfd/ti,lp875xx.yaml   | 134 ++++++++++++++++++
>>  2 files changed, 134 insertions(+), 79 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
>>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp875xx.yaml
>>
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Error: Documentation/devicetree/bindings/mfd/ti,lp875xx.example.dts:20.9-14 syntax error
> FATAL ERROR: Unable to parse input tree
> scripts/Makefile.lib:315: recipe for target 'Documentation/devicetree/bindings/mfd/ti,lp875xx.example.dt.yaml' failed
> make[1]: *** [Documentation/devicetree/bindings/mfd/ti,lp875xx.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> Makefile:1347: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2

Apologies, v3 incoming with these fixed (and dt_binding_check run in its
entirety this time).

Thanks,
-- 
Luca

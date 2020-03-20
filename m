Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7839AC43332
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5062E20409
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qQN54ML1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgCTJbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:31:34 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34212 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgCTJbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:31:32 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02K9VQFN012302;
        Fri, 20 Mar 2020 04:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584696686;
        bh=KQmoqh9mgTESw16TTxpzd8iXS+b+Uiyj7E0qjX+WhS8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qQN54ML1xrErkmup4pW50gsVV9LxL3ikZaBLIRM+J+4Zb3tUQqhv++8+lOwIb+SgH
         or2QBHG3d+Z44IaN+BLyo0OsJGmnWg5YDi0UH0rgi28dNqSPiHCdGHangCpWIH5UDU
         c6p+FJH9cWqQDzEiVL2TTJcvPO+PpvNa1xvGO2GQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02K9VQFR130683
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Mar 2020 04:31:26 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Mar 2020 04:31:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Mar 2020 04:31:26 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02K9VNxq018507;
        Fri, 20 Mar 2020 04:31:24 -0500
Subject: Re: [PATCH 2/3] bindings: sound: Add documentation for TI j721e EVM
 (CPB and IVI)
To:     Rob Herring <robh@kernel.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200319092815.3776-1-peter.ujfalusi@ti.com>
 <20200319092815.3776-3-peter.ujfalusi@ti.com> <20200320002112.GA10030@bogus>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <412ff8fd-bab2-39b0-5885-82823981655b@ti.com>
Date:   Fri, 20 Mar 2020 11:31:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200320002112.GA10030@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

On 20/03/2020 2.21, Rob Herring wrote:
> On Thu, 19 Mar 2020 11:28:14 +0200, Peter Ujfalusi wrote:
>> The audio support on the Common Processor Board board is using
>> pcm3168a codec connected to McASP10 serializers in parallel setup.
>>
>> The Infotainment board plugs into the Common Processor Board, the support
>> of the extension board is extending the CPB audio support by adding
>> the two codecs on the expansion board.
>>
>> The audio support on the Infotainment Expansion Board consists of McASP0
>> connected to two pcm3168a codecs with dedicated set of serializers to each.
>> The SCKI for pcm3168a is sourced from j721e AUDIO_REFCLK0 pin.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  .../bindings/sound/ti,j721e-cpb-audio.yaml    |  93 +++++++++++
>>  .../sound/ti,j721e-cpb-ivi-audio.yaml         | 145 ++++++++++++++++++
>>  2 files changed, 238 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
>>  create mode 100644 Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml: $id: relative path/filename doesn't match actual path or filename
> 	expected: http://devicetree.org/schemas/sound/ti,j721e-cpb-ivi-audio.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml: duplicate '$id' value 'http://devicetree.org/schemas/sound/ti,j721e-cpb-audio.yaml#'
> Error: Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.example.dts:21.23-24 syntax error
> FATAL ERROR: Unable to parse input tree
> scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.example.dt.yaml' failed
> make[1]: *** [Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> Makefile:1262: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2

I made copy-paste error (two) when creating the cpb-ivi yaml and forgot
to re-run the dt_binding_check

Fixed up and verified that the build is clean now.

> See https://patchwork.ozlabs.org/patch/1258054
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC669C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7DEC20709
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q6yeAQHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgERNwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:52:40 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53806 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgERNwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:52:39 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04IDqaEg093419;
        Mon, 18 May 2020 08:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589809956;
        bh=ohNomjpX2jlXjHsOEhCw1otQL6nnOMvbjIC7M/uFEWI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=q6yeAQHiNJlrVLJhmsRg70SuIC/hKeb3qrJQ52g1P93rNIwtVRdl8oLgJ74ZA3Phx
         47pbdIgRiwlKNcz057uC1xUyhFC4LEnrppAaKE2ToXjJTJaKnj+D9pF/3vYpt1Mt8X
         e9gxx0tUHNfKGx9paex5JQHKBFH2yfarx0eK+O7U=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04IDqaik087945
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 May 2020 08:52:36 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 18
 May 2020 08:52:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 18 May 2020 08:52:33 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04IDqU8O013260;
        Mon, 18 May 2020 08:52:30 -0500
Subject: Re: [PATCH] phy: cadence: sierra: Fix for USB3 U1/U2 state
To:     Roger Quadros <rogerq@ti.com>, Sanket Parmar <sparmar@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <vkoul@kernel.org>,
        <sjakhade@cadence.com>, <kurahul@cadence.com>,
        <pawell@cadence.com>, <jpawar@cadence.com>, <nsekhar@ti.com>
References: <1589804053-14302-1-git-send-email-sparmar@cadence.com>
 <9c5b4f54-18bc-97d6-6baf-68f007303b17@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <27ad6e64-5819-662c-4361-dfeda77c6b1a@ti.com>
Date:   Mon, 18 May 2020 19:22:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <9c5b4f54-18bc-97d6-6baf-68f007303b17@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/2020 5:59 PM, Roger Quadros wrote:
> 
> 
> On 18/05/2020 15:14, Sanket Parmar wrote:
>> Updated values of USB3 related Sierra PHY registers.
>> This change fixes USB3 device disconnect issue observed
>> while enternig U1/U2 state.
>>
>> Signed-off-by: Sanket Parmar <sparmar@cadence.com>
> 
> Reviewed-by: Roger Quadros <rogerq@ti.com>

merged, thanks!

-Kishon
> 
>> ---
>>   drivers/phy/cadence/phy-cadence-sierra.c | 27 ++++++++++++++-------------
>>   1 file changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c
>> b/drivers/phy/cadence/phy-cadence-sierra.c
>> index a5c08e5..faed652 100644
>> --- a/drivers/phy/cadence/phy-cadence-sierra.c
>> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
>> @@ -685,10 +685,10 @@ static struct cdns_reg_pairs
>> cdns_usb_cmn_regs_ext_ssc[] = {
>>   static struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[] = {
>>       {0xFE0A, SIERRA_DET_STANDEC_A_PREG},
>>       {0x000F, SIERRA_DET_STANDEC_B_PREG},
>> -    {0x00A5, SIERRA_DET_STANDEC_C_PREG},
>> +    {0x55A5, SIERRA_DET_STANDEC_C_PREG},
>>       {0x69ad, SIERRA_DET_STANDEC_D_PREG},
>>       {0x0241, SIERRA_DET_STANDEC_E_PREG},
>> -    {0x0010, SIERRA_PSM_LANECAL_DLY_A1_RESETS_PREG},
>> +    {0x0110, SIERRA_PSM_LANECAL_DLY_A1_RESETS_PREG},
>>       {0x0014, SIERRA_PSM_A0IN_TMR_PREG},
>>       {0xCF00, SIERRA_PSM_DIAG_PREG},
>>       {0x001F, SIERRA_PSC_TX_A0_PREG},
>> @@ -696,7 +696,7 @@ static struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[] = {
>>       {0x0003, SIERRA_PSC_TX_A2_PREG},
>>       {0x0003, SIERRA_PSC_TX_A3_PREG},
>>       {0x0FFF, SIERRA_PSC_RX_A0_PREG},
>> -    {0x0619, SIERRA_PSC_RX_A1_PREG},
>> +    {0x0003, SIERRA_PSC_RX_A1_PREG},
>>       {0x0003, SIERRA_PSC_RX_A2_PREG},
>>       {0x0001, SIERRA_PSC_RX_A3_PREG},
>>       {0x0001, SIERRA_PLLCTRL_SUBRATE_PREG},
>> @@ -705,19 +705,19 @@ static struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[]
>> = {
>>       {0x00CA, SIERRA_CLKPATH_BIASTRIM_PREG},
>>       {0x2512, SIERRA_DFE_BIASTRIM_PREG},
>>       {0x0000, SIERRA_DRVCTRL_ATTEN_PREG},
>> -    {0x873E, SIERRA_CLKPATHCTRL_TMR_PREG},
>> -    {0x03CF, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
>> -    {0x01CE, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
>> +    {0x823E, SIERRA_CLKPATHCTRL_TMR_PREG},
>> +    {0x078F, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
>> +    {0x078F, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
>>       {0x7B3C, SIERRA_CREQ_CCLKDET_MODE01_PREG},
>> -    {0x033F, SIERRA_RX_CTLE_MAINTENANCE_PREG},
>> +    {0x023C, SIERRA_RX_CTLE_MAINTENANCE_PREG},
>>       {0x3232, SIERRA_CREQ_FSMCLK_SEL_PREG},
>>       {0x0000, SIERRA_CREQ_EQ_CTRL_PREG},
>> -    {0x8000, SIERRA_CREQ_SPARE_PREG},
>> +    {0x0000, SIERRA_CREQ_SPARE_PREG},
>>       {0xCC44, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG},
>> -    {0x8453, SIERRA_CTLELUT_CTRL_PREG},
>> -    {0x4110, SIERRA_DFE_ECMP_RATESEL_PREG},
>> -    {0x4110, SIERRA_DFE_SMP_RATESEL_PREG},
>> -    {0x0002, SIERRA_DEQ_PHALIGN_CTRL},
>> +    {0x8452, SIERRA_CTLELUT_CTRL_PREG},
>> +    {0x4121, SIERRA_DFE_ECMP_RATESEL_PREG},
>> +    {0x4121, SIERRA_DFE_SMP_RATESEL_PREG},
>> +    {0x0003, SIERRA_DEQ_PHALIGN_CTRL},
>>       {0x3200, SIERRA_DEQ_CONCUR_CTRL1_PREG},
>>       {0x5064, SIERRA_DEQ_CONCUR_CTRL2_PREG},
>>       {0x0030, SIERRA_DEQ_EPIPWR_CTRL2_PREG},
>> @@ -725,7 +725,7 @@ static struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[] = {
>>       {0x5A5A, SIERRA_DEQ_ERRCMP_CTRL_PREG},
>>       {0x02F5, SIERRA_DEQ_OFFSET_CTRL_PREG},
>>       {0x02F5, SIERRA_DEQ_GAIN_CTRL_PREG},
>> -    {0x9A8A, SIERRA_DEQ_VGATUNE_CTRL_PREG},
>> +    {0x9999, SIERRA_DEQ_VGATUNE_CTRL_PREG},
>>       {0x0014, SIERRA_DEQ_GLUT0},
>>       {0x0014, SIERRA_DEQ_GLUT1},
>>       {0x0014, SIERRA_DEQ_GLUT2},
>> @@ -772,6 +772,7 @@ static struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[] = {
>>       {0x000F, SIERRA_LFPSFILT_NS_PREG},
>>       {0x0009, SIERRA_LFPSFILT_RD_PREG},
>>       {0x0001, SIERRA_LFPSFILT_MP_PREG},
>> +    {0x6013, SIERRA_SIGDET_SUPPORT_PREG},
>>       {0x8013, SIERRA_SDFILT_H2L_A_PREG},
>>       {0x8009, SIERRA_SDFILT_L2H_PREG},
>>       {0x0024, SIERRA_RXBUFFER_CTLECTRL_PREG},
>>
> 

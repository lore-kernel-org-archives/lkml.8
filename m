Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3EAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643CA206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xqLnGdoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgC3OlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:41:10 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:32863 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgC3OlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:41:10 -0400
Received: by mail-qv1-f68.google.com with SMTP id p19so9022358qve.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rDcplkrNOR8fTQWpkrvvkQU2hQvD6/9jr9hYg71oITo=;
        b=xqLnGdoHaTXp/62rSjJP1YmIXik/97SKipfrMDfHH9wmc/lpdcRAmuiljz5i/kuu3u
         +xsoTKciWKFf3M0E8nuc3mQVdW7nQiIx2m4+Kx9aWQZNUJz8WoLvdD104COjmECOjZi2
         DRCdByeHmIFviu13F/M/dGMh5XsY2WTkxNPlvHN7X42DIE1gXbQY6qDWY7yZ3rNNTIRG
         tn+I27ueDtEKBd54V6MCSuJQmL/8FNHWFSjFlKOvpWq53TcdeeK2Jtl+voFb1C/Mk29j
         x1xceu3u4jb9bhqbNw7ROPmLjHMF1CFTY5MZ8e8kXFCmbLtYEALZAv/G2Wh8Xd64w0Gp
         WDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rDcplkrNOR8fTQWpkrvvkQU2hQvD6/9jr9hYg71oITo=;
        b=qMtorMNl7vHeDKSMSCwOs4Mjv3b+90KoCZf0cLZEqxO6eM0WtzqJVlbU4iufuD+hO9
         KjNlRlqCiU374fDXraSsCTzAMnPKgk0YtkXfsvwJnSDvWv8joXskgQx+031HPavR9Wad
         fhjc2Mwvr8D5pM/ucoF0yLD5L+5uo1GQVNSF+JHHbLWmebj94dNFmuP0beutDSNDj5mH
         SQCN+xXnqCHF00wrtblVt9acHu0kNS5mWlvVExP11CKmApNSEFU0IaTK60ZqS0RytdZY
         tnWQNxhzuvhqSoI2QQo081sEXijpq42HeW/ZqqToowhsck5gQTM9V0z6TOMUnNYv3N7U
         wAjQ==
X-Gm-Message-State: ANhLgQ1X3nP6Y3SeAZa5nAhIxfcAWK6sEPHN1vIZu4YMG6NAffMoCz1J
        ZmOwi+3Enbz9baJ5c7pcpry2rJmmVJw=
X-Google-Smtp-Source: ADFU+vu3RH0WRUmQbpyjKeSWfs7vBOo3n+yCX9ak4+Gl6Tjcz4DthxSw0tHEkMnHiAp4GrdHCJsJ+A==
X-Received: by 2002:a05:6214:a8f:: with SMTP id ev15mr12216022qvb.81.1585579266839;
        Mon, 30 Mar 2020 07:41:06 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id v1sm11280407qtc.30.2020.03.30.07.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 07:41:05 -0700 (PDT)
Subject: Re: [Patch v5 2/6] soc: qcom: rpmhpd: Introduce function to retrieve
 power domain performance state count
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, agross@kernel.org, robh@kernel.org,
        amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200320014107.26087-1-thara.gopinath@linaro.org>
 <20200320014107.26087-3-thara.gopinath@linaro.org>
 <20200327221545.GF5063@builder>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <1714f51c-1566-2756-ff43-5ee9b427e89c@linaro.org>
Date:   Mon, 30 Mar 2020 10:41:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200327221545.GF5063@builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/20 6:15 PM, Bjorn Andersson wrote:
> On Thu 19 Mar 18:41 PDT 2020, Thara Gopinath wrote:
> 
>> Populate .get_performace_state_count in genpd ops to retrieve the count of
>> performance states supported by a rpmh power domain.
>>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>   drivers/soc/qcom/rpmhpd.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
>> index 4d264d0672c4..7142409a3b77 100644
>> --- a/drivers/soc/qcom/rpmhpd.c
>> +++ b/drivers/soc/qcom/rpmhpd.c
>> @@ -341,6 +341,13 @@ static unsigned int rpmhpd_get_performance_state(struct generic_pm_domain *genpd
>>   	return dev_pm_opp_get_level(opp);
>>   }
>>   
>> +static int rpmhpd_performance_states_count(struct generic_pm_domain *domain)
>> +{
>> +	struct rpmhpd *pd = domain_to_rpmhpd(domain);
>> +
>> +	return pd->level_count;
>> +}
>> +
>>   static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
>>   {
>>   	int i;
>> @@ -429,6 +436,8 @@ static int rpmhpd_probe(struct platform_device *pdev)
>>   		rpmhpds[i]->pd.power_on = rpmhpd_power_on;
>>   		rpmhpds[i]->pd.set_performance_state = rpmhpd_set_performance_state;
>>   		rpmhpds[i]->pd.opp_to_performance_state = rpmhpd_get_performance_state;
>> +		rpmhpds[i]->pd.get_performance_state_count =
>> +					rpmhpd_performance_states_count;
> 
> I would prefer if you ignore the 80-char limit here and leave the line
> unwrapped.

Hi Bjorn,

Thanks for the reviews. I will fix this  in the next version.

> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Regards,
> Bjorn
> 
>>   		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
>>   
>>   		data->domains[i] = &rpmhpds[i]->pd;
>> -- 
>> 2.20.1
>>

-- 
Warm Regards
Thara

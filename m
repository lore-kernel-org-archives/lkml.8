Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97576C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F1C206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjFW+gce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFSIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:08:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36346 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgCFSIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 13:08:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id d9so1439444pgu.3;
        Fri, 06 Mar 2020 10:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uRRhoIexAhvoOgXcqq8b6k7wac3zPyn43UDEJ9y4pGA=;
        b=sjFW+gcecu4XZ6aJ447DsrKmCqUI0zgVQeNBvdQv/hO5MP7ciuCp1MKx9M1IqRzVE2
         YrA/7UWDzx8472Y4QSf6uTjO0JIISYSAfiL8CsjPes/g7wXNeksu8vD30r7vuK2jckrX
         N4jY0L32w8ia8XhsZf+Q4M52YmACcmzSPnGvexWFkPC0yKtmvyK1IzN36j1yIN0kw5X9
         oOi6z908IIIIN0x7OzF7aCCjfzVJSpRrBsP4yzi/e75f78VUmaPxF6uHuHofiLfWGnEC
         lgsrTEkHyiPT3sl/5PrEN8+wAn4HwK4NOoGwwAJedHvZxetXEz3XRSHR0S/UFSg3Om2q
         4rWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uRRhoIexAhvoOgXcqq8b6k7wac3zPyn43UDEJ9y4pGA=;
        b=WVc9S6LxcsBN7s9YFp+NpEHpw+OWYjqj0OZSp4dRYTF2GNmzmOJGE5PK2Bl51qPjte
         rB1uNnMKLenJY46aFuY+NjjZ+cQGYl8yFC1h3vHOpc7uMjR4xi4IFm08NUUu4WiqY0nV
         dkZgL+DOLwg7gfEpiq3jg2okdvnLg22o2K8jdCy/Qfbn3qokV+JGq3nlwOj9jVuYINfy
         OgDEs7I6SrNjGMmIBRYTQJbEVxeyK0SyOisICMAWt1K6zwDz0DAtK4UwqNF5HToMbkA8
         j9nFgAkYh159bq6uYxsNP7WfZS4upptuBNHUXpwHfllUHcyxgS2BAzDHThzrR3IE6A+h
         gqNQ==
X-Gm-Message-State: ANhLgQ1JtTbDXqiQbtu8JFPvAQa4+9izogxgFs50VaC14TMKpPjP18G0
        xgLmwkGrxi8wdaBZ76g2c+Sc4EkO
X-Google-Smtp-Source: ADFU+vugFTSbG5KIJpgnnDcXPrPNxziAQAk2LyVAOTkN4qjlJnLJk15YosTEENl8Gk4T4ptV61Hwow==
X-Received: by 2002:a65:644c:: with SMTP id s12mr4404813pgv.165.1583518087733;
        Fri, 06 Mar 2020 10:08:07 -0800 (PST)
Received: from [10.67.48.239] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f4sm982055pfn.116.2020.03.06.10.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 10:08:07 -0800 (PST)
Subject: Re: [PATCH V4 2/2] firmware: arm_scmi: add smc/hvc transport
To:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <1583201219-15839-1-git-send-email-peng.fan@nxp.com>
 <1583201219-15839-3-git-send-email-peng.fan@nxp.com>
 <20200304103954.GA25004@bogus>
 <AM0PR04MB4481A6DB7339C22A848DAFC988E50@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <AM0PR04MB44814B71E92C02956F4BED4588E50@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200304170319.GB44525@bogus>
 <AM0PR04MB4481B90D03D1F68573B05BE088E20@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200305160613.GA53631@bogus>
 <d9734fd6-f855-296b-3a0b-ffc45ed0e3cb@gmail.com>
 <AM0PR04MB448167BD133BF57E548F2F0588E30@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200306123442.GA47929@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 G10n8gCguORqNGMsVRxrlLs7/himep7MrCc=
Message-ID: <7e4eee97-3ce7-a421-b08e-54092213dc7c@gmail.com>
Date:   Fri, 6 Mar 2020 10:08:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306123442.GA47929@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/20 6:23 AM, Sudeep Holla wrote:
> On Fri, Mar 06, 2020 at 08:07:19AM +0000, Peng Fan wrote:
>>> Subject: Re: [PATCH V4 2/2] firmware: arm_scmi: add smc/hvc transport
>>>
>>> On 3/5/20 8:06 AM, Sudeep Holla wrote:
>>>> On Thu, Mar 05, 2020 at 11:25:35AM +0000, Peng Fan wrote:
>>>>
>>>> [...]
>>>>
>>>>>>
>>>>>> Yes, this may fix the issue. However I would like to know if we need
>>>>>> to support multiple channels/shared memory simultaneously. It is
>>>>>> fair requirement and may need some work which should be fine.
>>>>>
>>>>> Do you have any suggestions? Currently I have not worked out an good
>>>>> solution.
>>>>>
>>>>
>>>> TBH, I haven't given it a much thought. I would like to know if people
>>>> are happy with just one SMC channel for SCMI or do they need more ?
>>>> If they need it, we can try to solve it. Otherwise, what you have will
>>>> suffice IMO.
>>>
>>> On our platforms we have one channel/shared memory area/mailbox
>>> instance for all standard SCMI protocols, and we have a separate
>>> channel/shared memory area/mailbox driver instance for a proprietary one.
>>> They happen to have difference throughput requirements, hence the split.
>>>
> 
> OK, when you refer proprietary protocol, do you mean outside the scope of
> SCMI ? The reason I ask is SCMI allows vendor specific protocols and if
> you are using other channel for that, it still make sense to add
> multi-channel support here.

Sorry this was not clear, I meant a protocol ID which is in the 0x80 -
0xFF range. We are using one pair of channels (rx and tx) plus shared
memory area for the standard SCMI protocol numbers, and we have another
pair of rx/tx channels and shared memory area for this vendor specific
protocol.

Maybe providing the Device Tree entries would be clearer, so this is
what it looks like (this is the output from the bootloader generated
Device Tree):


/       brcm_scmi_mailbox@0 {
                #mbox-cells = <0x1>;
                compatible = "brcm,brcmstb-mbox";
                status = "disabled";
                linux,phandle = <0xe>;
                phandle = <0xe>;
        };

        brcm_scmi@0 {
                compatible = "arm,scmi";
                mboxes = <0xe 0x0 0xe 0x1>;
                mbox-names = "tx", "rx";
                shmem = <0xf>;
                status = "disabled";
                #address-cells = <0x1>;
                #size-cells = <0x0>;

                protocol@13 {
                        reg = <0x13>;
                };

                protocol@14 {
                        reg = <0x14>;
                        #clock-cells = <0x1>;
                        linux,phandle = <0x3>;
                        phandle = <0x3>;
                };

                protocol@15 {
                        reg = <0x15>;
                        #sensor-cells = <0x1>;
                        #thermal-sensor-cells = <0x1>;
                        linux,phandle = <0x12>;
                        phandle = <0x12>;
                };

                protocol@80 {
                        reg = <0x80>;
                };
        };

        brcm_scmi_mailbox@1 {
                #mbox-cells = <0x1>;
                compatible = "brcm,brcmstb-mbox";
                status = "disabled";
                linux,phandle = <0x10>;
                phandle = <0x10>;
        };

        brcm_scmi@1 {
                compatible = "arm,scmi";
                mboxes = <0x10 0x0 0x10 0x1>;
                mbox-names = "tx", "rx";
                shmem = <0x11>;
                status = "disabled";
                #address-cells = <0x1>;
                #size-cells = <0x0>;

                protocol@82 {
                        reg = <0x82>;
                };
        };


> 
>>> If I read Peng's submission correctly, it seems to me that the usage model
>>> described before is still fine.
>>
>> Thanks.
>>
>> Sudeep,
>>
>> Then should I repost with the global mutex added?
>>
> 
> Sure, you can send the updated. I will think about adding support for more
> than one channel and send a patch on top of it if I get around it.
> 
> Note that I sent PR for v5.7 last earlier this week, so this will be for v5.8
> 
> --
> Regards,
> Sudeep
> 


-- 
Florian

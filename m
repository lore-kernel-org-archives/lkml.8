Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9996DC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 09:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A482068E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 09:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsRAAWnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgEEJBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 05:01:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23255 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725766AbgEEJBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 05:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588669292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IPhCYjiTeLLHCTtCaxs/pLqAuH9T1e39OMm2M2JFXk8=;
        b=OsRAAWnkZX8Kkd2h8BzYOMFFLDqI84L1tMEHzUxA8sUmBaMKLsT5amBLEPAokjATvU6xI8
        zth92NfZr5y69Ify57tBuo62L+COHppHPNpqpzJg/E+NyeqW3pd5W2pVwOCydbIYRIBBgr
        skUZj/oJOBweLVYAocUdb3Kivc3IRMU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-Xsm7mxYTPKmFyqMkxKczqQ-1; Tue, 05 May 2020 05:01:31 -0400
X-MC-Unique: Xsm7mxYTPKmFyqMkxKczqQ-1
Received: by mail-wr1-f70.google.com with SMTP id 30so875797wrp.22
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 02:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IPhCYjiTeLLHCTtCaxs/pLqAuH9T1e39OMm2M2JFXk8=;
        b=q8tbS1WWqO2wKiACilV97bD4F8tDSPzAYMCXotx9Y18WtI0vHc51dJxNamG0+VX5ef
         o73h1BHoI+JdPyRklWtP/tjwbHQixJ6gJjYwrrjoelptort2gAqrwkT0bJfhpyb5ejJ3
         Td4zVrkFPKmCIxy3lGbGKi8XdWydj6V9gQ/8BvvB1s65cHW0LJkLwFl1ioBnFxKIiSyk
         U+lYyypxdDyz6y6YxUphvXkNoa/Ll4GAbaN1f7pJZOFPvqNKppZ2Dp69Ai6ILud/+CM7
         I5t0gqznSpm/t0t6oAlPFXLEK0qOrAlfeT0LPXSDRk2OFfZIQfFgzJutCLrrAGwutlK4
         fhtQ==
X-Gm-Message-State: AGi0PuZrPwuWMepXPPh50a1nn9O1gRmGuNJFWogTc1bIOD3Trxd4oc5d
        WQEdcMSEmBdTbjDVp+VWlbfD7Fd6AzBS9TEtGCZA1GkI3wJpp1pUMI8NiNPU5oKRiYD8JOch5VM
        lgNaq9+olP4OY2+5bm1sIgCZn
X-Received: by 2002:a1c:b757:: with SMTP id h84mr2126106wmf.188.1588669290229;
        Tue, 05 May 2020 02:01:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ0INk+InK9oVb+xfbvS9taXyigMNvZ3z550//uQsEFsFbakL6B8y+lyoZkcehjy9V66+kaaQ==
X-Received: by 2002:a1c:b757:: with SMTP id h84mr2126081wmf.188.1588669289992;
        Tue, 05 May 2020 02:01:29 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id q8sm2262727wrp.58.2020.05.05.02.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 02:01:28 -0700 (PDT)
Subject: Re: [PATCH] Add support for Vinga Twizzle J116 Silead touchscreen
To:     Randy Dunlap <rdunlap@infradead.org>, Andrew Dunai <a@dun.ai>,
        linux-kernel@vger.kernel.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
References: <20200504164514.18641-1-a@dun.ai>
 <72bd44ab-98a8-0cdc-b7e6-104a69ca3643@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f4aeeb2c-32c4-e2a8-193e-2b4d892da4db@redhat.com>
Date:   Tue, 5 May 2020 11:01:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <72bd44ab-98a8-0cdc-b7e6-104a69ca3643@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/4/20 8:20 PM, Randy Dunlap wrote:
> Hi,
> 
> Usually you need to send patches to a maintainer who could then
> merge/apply them.

 From a code point-of-view this looks good to me.

Andrew, if you can resend this to the proper folks (including me)
with a proper Signed-off-by (*), then this should be ready for merging.

Regards,

Hans


*) that might have already been there, but it wasn't present in
the part quoted by Randy



> On 5/4/20 9:45 AM, Andrew Dunai wrote:
>> ---
>>   drivers/platform/x86/touchscreen_dmi.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
>> index 93177e6e5..a3ab19ab0 100644
>> --- a/drivers/platform/x86/touchscreen_dmi.c
>> +++ b/drivers/platform/x86/touchscreen_dmi.c
>> @@ -640,6 +640,20 @@ static const struct ts_dmi_data trekstor_surftab_wintron70_data = {
>>   	.properties	= trekstor_surftab_wintron70_props,
>>   };
>>   
>> +static const struct property_entry vinga_twizzle_j116_props[] = {
>> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 1920),
>> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
>> +	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-vinga-twizzle_j116.fw"),
>> +	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
>> +	PROPERTY_ENTRY_BOOL("silead,home-button"),
>> +	{ }
>> +};
>> +
>> +static const struct ts_dmi_data vinga_twizzle_j116_data = {
>> +	.acpi_name	= "MSSL1680:00",
>> +	.properties	= vinga_twizzle_j116_props,
>> +};
>> +
>>   /* NOTE: Please keep this table sorted alphabetically */
>>   static const struct dmi_system_id touchscreen_dmi_table[] = {
>>   	{
>> @@ -1054,6 +1068,13 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>>   			DMI_MATCH(DMI_PRODUCT_NAME, "Y8W81"),
>>   		},
>>   	},
>> +	{
>> +		/* Vinga Twizzle J116 */
>> +		.driver_data = (void *)&vinga_twizzle_j116_data,
>> +		.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "VINGA Twizzle J116"),
>> +		},
>> +	},
>>   	{ },
>>   };
>>   
>>
> 
> thanks.
> 


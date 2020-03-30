Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51922C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280DB2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TisMD6pc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgC3SmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:42:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42181 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgC3SmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:42:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15so22937331wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8XRhKogyecKsSV4qW1x8hTrVeQGUH4iCc/CcjgU9mck=;
        b=TisMD6pc6Nd4x3AkXj4VNDomK/Xtj35nFvmaVY4nv5rIDfxx33N2APlyiTAHrAV+VP
         zs3VrrOhOHSW+aVcm+6AvKmp98Pt+z0Y8y5UmKhv4JeMiSxNUTUO5Ix8BJb+XZJyzhGB
         oTMdBAs918AYZFoFmsY4UszXjdtDqyW5zEtiBETWyWNgj4TMCM+QPTIZU4rLIfzexAGa
         BY5Ma5FjSYgeqDmOcliXyrw/KopFnuxwxjlhy3tD3YYxS6PHFG3OiL0Uyn3gJhNNc/k1
         ljVqKTfWz0UZ7WX1nu+jqrMgspXlghGq2KicbbSiNAaNwix6NK5IiT33+wtJOyIhAV5Y
         LYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8XRhKogyecKsSV4qW1x8hTrVeQGUH4iCc/CcjgU9mck=;
        b=aCA+gSQlH5KuvA3TCfRVAIlhlCqZUFcx4H+aiipELZkJI5Ek01+w0Civ2Vudhed3/I
         JnuhKPqHuYF7XSu+g6iG4GPiSsmQbGy8a5LUFRTNyDgNg1TGmHmexrHT98OxsNafPEHN
         FjlTF5oIhlEP3m8WR5SmLfqhW11pOHtfIlm5KqGoQT9Lj0ML6D7wgmXtnPL+7fbl2IMW
         kUdKcl+ieOX3GNE555Dowfl0ytaZz2dI3ro99ofG1JMBOex59uDXDmZMG05nA6NR+p62
         fXNdhqEY17gMQv8kWkn2/wLdlG/WWBmaE9hq2ZO0JCcfp/TzXRCpA3TUEv8nihLd7Ngs
         cneQ==
X-Gm-Message-State: ANhLgQ275N7W2QCpSYjNHWm/j3Qjy7d+qs1xkebXPOjTXukmeNLWk6Zi
        9bcddxocZ90tVdvttLMYmXumwibY
X-Google-Smtp-Source: ADFU+vvyblRcuB/8qGRcZ3vhqfycuOq1xwgm01TAbEu5m3oAn9STi5PDPJAm79E//bCc1ncE13UYNw==
X-Received: by 2002:adf:fb0a:: with SMTP id c10mr16054757wrr.272.1585593731920;
        Mon, 30 Mar 2020 11:42:11 -0700 (PDT)
Received: from [192.168.43.227] (188.29.165.144.threembb.co.uk. [188.29.165.144])
        by smtp.gmail.com with ESMTPSA id z12sm24608045wrt.27.2020.03.30.11.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 11:42:11 -0700 (PDT)
Subject: Re: [Outreachy kernel] [PATCH v4] staging: vt6656: add error code
 handling to unused variable
To:     Stefano Brivio <sbrivio@redhat.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Julia Lawall <julia.lawall@inria.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200330164530.2919-1-jbwyatt4@gmail.com>
 <20200330191439.3bfcb658@elisabeth>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Message-ID: <c2e96efe-64d7-61d7-0c4f-58b318b47a68@gmail.com>
Date:   Mon, 30 Mar 2020 19:42:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200330191439.3bfcb658@elisabeth>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2020 18:14, Stefano Brivio wrote:
> On Mon, 30 Mar 2020 09:45:30 -0700
> "John B. Wyatt IV" <jbwyatt4@gmail.com> wrote:
> 
>> Add error code handling to unused 'ret' variable that was never used.
>> Return an error code from functions called within vnt_radio_power_on.
>>
>> Issue reported by coccinelle (coccicheck).
>>
>> Suggested-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
>> Suggested-by: Stefano Brivio <sbrivio@redhat.com>
>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>> Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
>> Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
>> ---
>> v4: Move Suggested-by: Julia Lawall above seperator line.
> 
> Actually, as Julia didn't suggest this patch, the place where you had
> this in v3 was the right one.
---snip
>>   
>>   	switch (priv->rf_type) {
>>   	case RF_AL2230:
>> @@ -734,14 +738,14 @@ int vnt_radio_power_on(struct vnt_private *priv)
>>   	case RF_VT3226:
>>   	case RF_VT3226D0:
>>   	case RF_VT3342A0:
>> -		vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
>> -				    (SOFTPWRCTL_SWPE2 | SOFTPWRCTL_SWPE3));
>> +		ret = vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
>> +					 (SOFTPWRCTL_SWPE2 | SOFTPWRCTL_SWPE3));
> 
> 
> Another thing that should be considered in this function is to restore
> the previous hardware state on failures, but I think the way you're
> handling this is possibly the safest, without hardware to test on.
> 
This section of hardware is controlled by mac80211 as is most of the driver.

Users can turn the wireless off then on again to try again but to date 
this is not known to fail with the hardware I have used.

No problems with hardware with this patch.

Tested-by: Malcolm Priestley <tvboxspy@gmail.com>




Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14B3C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADFD2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJBjrMd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgCXNlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:41:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39569 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgCXNlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:41:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id a9so3499675wmj.4;
        Tue, 24 Mar 2020 06:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uAuhnpcorA/aoHo7Ikv4cyMAQQ+803f7lVgbulzW1FA=;
        b=AJBjrMd/1WefHvD9tC2VIx2ZOHNAhs5ei/dRqGhoQ+xHhEWFzRtAPXIF+2EQSCNsil
         IYP+NCFB54M8Siyg2oE1SZncCp/zDRSKgZd3BgdVOrJxkbaZ9LzI+YF2VBPXuQXGirKP
         d1hV0URs2NnrTFFCiZdmR/XvsyJiQefUroToumZlA1Ovq/lxiGOY9gm1kUNxTPAQ/Ble
         hEKrfSfcVL6rJg65U9dShGBKaFs/OCfBjQoq0Zv/bOTU1ornTJspd7nlkZTDr6TL38mx
         fl6miirZIwnVmc/f2+hMuFa7bxRd9GzqCWXxy3XfkZQjkcZEoZGhJmgttRXQejYnJYTI
         roHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uAuhnpcorA/aoHo7Ikv4cyMAQQ+803f7lVgbulzW1FA=;
        b=rhoJ7MFv+Ryx5lonnPulRWVaR5DWGzzygN6zCSprawmxA02iFrWXUxFC8kT0dbTsUT
         +TxnzLCPh+/DIg2PATDGn/3zfZMHmR6XlGbMZfhW7In2cPT5t/Gd6vsfCEElYJtbEnEf
         rcTW3QqpfaUO+GpyJASH3RgbILpcPzvjcQfhhxKQzMsMUycR8JkLCOvlPI1hdXFHtUbY
         YmyhKSRaSriXd+V9sqt0lIt34fe+nvsIHWb5gszPRj4c+IKRzBQZL4t9UOVDPBeAXTaL
         bZVRTHn12X1PIYlamH0DNWmpZl2P//Yk+iKLt3l5m/m5I8D+4zDpauxYBPkc69X2HC8Y
         OGdQ==
X-Gm-Message-State: ANhLgQ3ZwKsSRk9bD6dSLrS4NqNKtx2UPz655o9e157jDIXNssnIB+xi
        RhuNGZge0HwOBu+RM/2tPEgKRlN3
X-Google-Smtp-Source: ADFU+vvFoLChVg+kcqF5i+tj7Rhdcb7vjdP06Fu8Z1e/SDrcul0CpOiMUPThAQcr3KXGQ/qMa93EEA==
X-Received: by 2002:a1c:ba06:: with SMTP id k6mr5507351wmf.136.1585057308561;
        Tue, 24 Mar 2020 06:41:48 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f9sm29768962wro.47.2020.03.24.06.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 06:41:47 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] dt-bindings: sound: convert rockchip spdif
 bindings to yaml
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, heiko@sntech.de, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200324123155.11858-1-jbx6244@gmail.com>
 <20200324133506.GC7039@sirena.org.uk>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <d1225b12-b3d1-3cc7-be0b-8f834e8b08ce@gmail.com>
Date:   Tue, 24 Mar 2020 14:41:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200324133506.GC7039@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Today I send 2 sets. One for I2S and one for SPDIF.
'power-domains' is added in respons to robh answer to rockchip,vop.txt
conversion.

>> Hi,
>>
>> Question for robh:
>>
>> In the old txt situation we add/describe only properties that are used
>> by the driver/hardware itself. With yaml it also filters things in a
>> node that are used by other drivers like:
>>
>> assigned-clocks:
>> assigned-clock-rates:
>> power-domains:
>>
>> Should we add or not?
> 
> Yes, only pinctrl properties are automatically added.
> 
> We could change 'assigned-clocks', but for now I think they should be 
> added.
> 
> Rob


On 3/24/20 2:35 PM, Mark Brown wrote:
> On Tue, Mar 24, 2020 at 01:31:53PM +0100, Johan Jonker wrote:
>> Current dts files with 'spdif' nodes are manually verified.
>> In order to automate this process rockchip-spdif.txt
>> has to be converted to yaml.
> 
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>> Changed V2:
>>   dmas and dma-names layout
> 
> This is the second v2 you've sent of this today - it adds these but
> drops Rob's ack?
> 


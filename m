Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA73C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E702087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfBDKCIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgBCQ0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:26:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41773 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbgBCQ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:26:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so15302739ljc.8;
        Mon, 03 Feb 2020 08:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nipj/cxzSXajSeH/pNRriKao/+feW9WqUQbThjwnQuk=;
        b=dfBDKCIh6kq4KivMuNKwO9Dub+A9DsCYd3GXV9IVUNwPpJ9GMDBmq8vQddES0RX+s2
         YINM3Crm4ORBw54telWxF/D1rh5gUB9NqgOC+3JxMPAWCsEeH2TUVDVupWGd2djOgX6R
         IXvAwWJTzNUutgVH/tp/vYF001elX9YNVr1PBxvFLejQcAZOQ9CgNOG/WoEonvFIsuMi
         Ii9wFrlEaCl4aP1H4RzquBLeIa1+VHiVGDrIhRvQoSFpg6PebWHfIOZhyJFFyqQKaFGT
         pmsgiGcGJlS97t6rs7QrN70zjLobQCHeNNgGsHc+H7tCxzXMj5U2jIdgmFLmdWzuJ/cZ
         xbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nipj/cxzSXajSeH/pNRriKao/+feW9WqUQbThjwnQuk=;
        b=f6g9lfKHs0QvU5QMElakU0iVqEEOPVvvFHvDxR10OTn+oYK9arLyAAJy+k7P68CLu2
         xXI8HX90CAzkCR4hZcbRNmGsLZTXsW9PS4O7OmYht1B3tIZyXSn03uU9YSCOVJ+5a5W7
         ZWo/2/2KzIjQFTWT/Gr1Uv1b/vtxk6hGGsO6oU4NST+hGVzeaDxVJqRq+ugtpXKMyy9C
         Z4JNwOEtZDFI4Z58cSig8DykxjKWetT07nkoVA+2o3t6bUBG3tdLGJzufyGup5QeST6X
         jdzOSV7XcsvzncQnAH8ury8maAryVFBR+lfkU773fTaGPyvt2QH7RSt8oR85C4MaDodL
         +LMg==
X-Gm-Message-State: APjAAAWjLtI+qlNzrGTZ95mdFUoZhH8X7SkazYxwtTvMLg2neG8QKCxs
        JfAWJoVwoPXYflnFyBhsaNgg9m8k
X-Google-Smtp-Source: APXvYqxnIgvFbNfj+L3K+M0hDUSPPCAAsx8IZCA9VLlq3Wd8OOJ3JiUFYhco4qUWH9fB7mgth5mIOg==
X-Received: by 2002:a2e:9090:: with SMTP id l16mr14584028ljg.281.1580747165772;
        Mon, 03 Feb 2020 08:26:05 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id 5sm10015424lju.69.2020.02.03.08.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 08:26:05 -0800 (PST)
Subject: Re: [PATCH v1] usb: phy: tegra: Add clarifying comments about the
 shared registers
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200202224259.29187-1-digetx@gmail.com>
 <20200203112818.GA3506060@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5a8d6489-e8ce-5a6e-3e23-8de97c3bad76@gmail.com>
Date:   Mon, 3 Feb 2020 19:26:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200203112818.GA3506060@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.02.2020 14:28, Thierry Reding пишет:
> On Mon, Feb 03, 2020 at 01:42:59AM +0300, Dmitry Osipenko wrote:
>> Tools like Coccinelle may erroneously recommend to use the
>> devm_platform_ioremap_resource() API for the registers mapping because
>> these tools are not aware about the implementation details of the driver.
>> Let's add a clarifying comments to the code, which should help to stop
>> future attempts to break the driver.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/usb/phy/phy-tegra-usb.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
>> index 037e8eee737d..6153cc35aba0 100644
>> --- a/drivers/usb/phy/phy-tegra-usb.c
>> +++ b/drivers/usb/phy/phy-tegra-usb.c
>> @@ -969,6 +969,10 @@ static int utmi_phy_probe(struct tegra_usb_phy *tegra_phy,
>>  		return  -ENXIO;
>>  	}
>>  
>> +	/*
>> +	 * Note that UTMI pad registers are shared by all PHYs, therefore
>> +	 * devm_platform_ioremap_resource() can't be used here.
>> +	 */
>>  	tegra_phy->pad_regs = devm_ioremap(&pdev->dev, res->start,
>>  					   resource_size(res));
>>  	if (!tegra_phy->pad_regs) {
>> @@ -1087,6 +1091,10 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
>>  		return  -ENXIO;
>>  	}
>>  
>> +	/*
>> +	 * Note that PHY and USB controller are using shared registers,
>> +	 * therefore devm_platform_ioremap_resource() can't be used here.
>> +	 */
>>  	tegra_phy->regs = devm_ioremap(&pdev->dev, res->start,
>>  				       resource_size(res));
>>  	if (!tegra_phy->regs) {
> 
> I'm not sure it's really going to stop *all* attempts. But at least for
> people that go through the trouble of reading the comments, yes, this
> should do the trick, so:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>

Will see, thanks :)

Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A248C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 347002054F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dNu0FNMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgHaUlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:41:14 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19703 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgHaUlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:41:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d605b0000>; Mon, 31 Aug 2020 13:40:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 13:41:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 31 Aug 2020 13:41:13 -0700
Received: from [10.2.173.243] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 20:41:12 +0000
Subject: Re: [PATCH v4 3/4] dt-bindings: media: imx274: Move clock and
 supplies to required properties
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <hverkuil@xs4all.nl>, <luca@lucaceresoli.net>,
        <leonl@leopardimaging.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1598903558-9691-1-git-send-email-skomatineni@nvidia.com>
 <1598903558-9691-4-git-send-email-skomatineni@nvidia.com>
 <20200831201757.GC844@valkosipuli.retiisi.org.uk>
 <5c341ed9-6077-e935-de50-ff9f5f17edcf@nvidia.com>
Message-ID: <e0fe49a4-f52c-91d7-bdbf-e0026f61a432@nvidia.com>
Date:   Mon, 31 Aug 2020 13:41:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5c341ed9-6077-e935-de50-ff9f5f17edcf@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598906459; bh=0PRiVPO6ujz6K0EzzICGEoJlqFT3wY1llIkCkcKabOk=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=dNu0FNMqGvwUxuU+6smkqkTH9slTE+L6FiUt7uqfL9s2SF8FDel9KUAWOA16elrVz
         FdBTNMRklx+1sEZ56LfN9mIJh6lOeIJAAw752zyk4mLEkWu2vEE1yWKd1b+fG+QKPD
         g3zEV9vDTWlE5wOYeOIKVhtYqCVo/j33vhyfgpCcXrD2tn4WE9VgRovXNTLHeA3XjW
         1FhvWAaoUUW+VA1leUeQmTFUUm/Pc90ReROc5rTJkLZszOBhSfNhv63gmaOD4+r+4I
         ZdO+dnX8c1PKnt+5IHw+bwOMEp439Avb3+QbpeERK5iK+P2joQbnJEX5gLTZQkmRHj
         0jd4jGSZmfZYg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/20 1:37 PM, Sowjanya Komatineni wrote:
>
> On 8/31/20 1:17 PM, Sakari Ailus wrote:
>> Hi Sowjanya,
>>
>> On Mon, Aug 31, 2020 at 12:52:37PM -0700, Sowjanya Komatineni wrote:
>>> Clock and supplies are external to IMX274 sensor and are dependent
>>> on camera module design.
>>>
>>> So, this patch moves them to required properties.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>> =C2=A0 Documentation/devicetree/bindings/media/i2c/imx274.txt | 6 +++--=
-
>>> =C2=A0 1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/i2c/imx274.txt=20
>>> b/Documentation/devicetree/bindings/media/i2c/imx274.txt
>>> index d0a5c899..b43bed6 100644
>>> --- a/Documentation/devicetree/bindings/media/i2c/imx274.txt
>>> +++ b/Documentation/devicetree/bindings/media/i2c/imx274.txt
>>> @@ -10,15 +10,15 @@ at 1440 Mbps.
>>> =C2=A0 Required Properties:
>>> =C2=A0 - compatible: value should be "sony,imx274" for imx274 sensor
>>> =C2=A0 - reg: I2C bus address of the device
>>> -
>>> -Optional Properties:
>>> -- reset-gpios: Sensor reset GPIO
>>> =C2=A0 - clocks: Reference to the input clock.
>>> =C2=A0 - clock-names: Should be "inck".
>>> =C2=A0 - vana-supply: Sensor 2.8v analog supply.
>>> =C2=A0 - vdig-supply: Sensor 1.8v digital core supply.
>>> =C2=A0 - vddl-supply: Sensor digital IO 1.2v supply.
>> If these have been optional in the past I don't think we can start
>> requiring them now.
>>
>> The framework will just give the driver a dummy regulator if one isn't
>> found.
> These were added recently with my patches. So I hope should be ok to=20
> make them required as they are external to sensor

Also made them required as they are external to sensor and also to use=20
bulk_enable/disable APIs, devm_regulator_bulk_get()

does not use OPTIONAL_GET.

>>
>>> =C2=A0 +Optional Properties:
>>> +- reset-gpios: Sensor reset GPIO
>>> +
>>> =C2=A0 The imx274 device node should contain one 'port' child node with
>>> =C2=A0 an 'endpoint' subnode. For further reading on port node refer to
>>> Documentation/devicetree/bindings/media/video-interfaces.txt.

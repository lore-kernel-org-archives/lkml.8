Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED062C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55C52469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6znWTYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgB1N2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:28:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46488 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgB1N2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:28:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id j7so2879989wrp.13;
        Fri, 28 Feb 2020 05:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NrHT7T88RoyQjD1urqyZZ0aRh9a3eutzKOCuX5K1yeY=;
        b=j6znWTYLAzRRvkNdjZ9zjIGXFuDM7tFBO5sd5AZONq1ZAuvPhGMFHHQOAoP61wNFNI
         mNHtRD/kP22UvMXlJ5U3VoD1aUGzx6sA9covL0XoeczLGAAjioSJiDDNcQC4NskJXa6q
         0EFE3AyjZ/CkTqKnG23nCGcNxYr4hN0h+3Z6ZnqPkULjB6NGlS0UIKjC1FZm8taT0yTZ
         qEhmjFrXYy3BYHOU3YFz9EzKp63awNX/eiyDNLZcfi3ZZVdeM5B6PwIZzbFriEQPT8zv
         ZIgCDKgj2COpOcdpjZ8iZDxOlFRZNROL9pmbfA8xT5yHobnGvQ0uIRxTTMHafZufC2m5
         +tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NrHT7T88RoyQjD1urqyZZ0aRh9a3eutzKOCuX5K1yeY=;
        b=Cbc70BVQ/PKBosUkN5UtwqX8R5D4dksQz9/1GwL2UTZCGMltJIdxJJfwrFhgxJY7Ll
         UXoq/mwMFSmCAuKHcb57bM2PBWuTBqe878/N3NPoc8AVIlkY+xT0vepcLfeZ/bXKdfKr
         DnuvnVTssdlOakgdMNMeh6GTBPobFSXYmmfqy8drYUElhK7WesB/NpBA67aFN9IghsAe
         UWqA4DBpCXgFrEbBcXA2cIqMP11uqQ3+ndZY/9TxssKb+ZBACmy33xCaNtZlFSei5Arm
         t2zfk0AfeNWEpEkMLNryERvon7L8TXkvXF/0EoOxg3sbU7QQjWS4xHSTUOcp68iWROlF
         ci1Q==
X-Gm-Message-State: APjAAAVlseQfpcmyTK7QqT9dQW8GvfH2FpzKUnnn2r3br1g4T48fxAai
        9PdDKBNMfwaF7PjSgApCZ8A=
X-Google-Smtp-Source: APXvYqzcazyu+zLUhQgdULQfW0b/6JUEwzdAx/yhhMPyZiEnDR8uFexywppZaicqNefTUid2wvto4g==
X-Received: by 2002:a5d:5609:: with SMTP id l9mr4697197wrv.48.1582896518952;
        Fri, 28 Feb 2020 05:28:38 -0800 (PST)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q9sm12906735wrx.18.2020.02.28.05.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 05:28:38 -0800 (PST)
Subject: Re: [PATCH 3/4] dt-bindings: arm: fix Rockchip rk3399-evb bindings
To:     Robin Murphy <robin.murphy@arm.com>, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20200228061436.13506-1-jbx6244@gmail.com>
 <20200228061436.13506-3-jbx6244@gmail.com>
 <78b8b53f-2e2a-3804-41fb-bb2610947ca2@arm.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <229c3511-d99d-8bac-6241-0088c5fc13ef@gmail.com>
Date:   Fri, 28 Feb 2020 14:28:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <78b8b53f-2e2a-3804-41fb-bb2610947ca2@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

When I look at the review process of rk3399-evb.dts
it is mentioned here:

https://lore.kernel.org/patchwork/patch/672327/

>> +	model = "Rockchip RK3399 Evaluation Board";
>> +	compatible = "rockchip,rk3399-evb", "rockchip,rk3399",
>> +		     "google,rk3399evb-rev2", google,rk3399evb-rev1",
>> +		     "google,rk3399evb-rev0" ;
> 
> can you check against which compatibles that coreboot really matches?
> 
> As we said that the evb changed between rev1 and rev2, I would expect the 
> compatible to be something like
> 
> 	compatible = "rockchip,rk3399-evb",  "google,rk3399evb-rev2", 
> 			"rockchip,rk3399";
> 
> leaving out the rev1 and rev0

The consensus in version 4 ends in what is shown in the dts file, so I
changed it in rockchip.yaml. Things from the past maybe can better be
explained by Heiko. Please advise if this patch needs to change and in
what file.

Kind regards,

Johan


On 2/28/20 1:42 PM, Robin Murphy wrote:
> On 28/02/2020 6:14 am, Johan Jonker wrote:
>> A test with the command below gives this error:
>>
>> arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml: /: compatible:
>> ['rockchip,rk3399-evb', 'rockchip,rk3399', 'google,rk3399evb-rev2']
>> is not valid under any of the given schemas
>>
>> Fix this error by adding 'google,rk3399evb-rev2' to the compatible
>> property in rockchip.yaml
>>
>> make ARCH=arm64 dtbs_check
>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/rockchip.yaml
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>   Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> index d303790f5..6c6e8273e 100644
>> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> @@ -509,6 +509,7 @@ properties:
>>           items:
>>             - const: rockchip,rk3399-evb
>>             - const: rockchip,rk3399
>> +          - const: google,rk3399evb-rev2
> 
> This looks wrong - the board can't reasonably be a *more* general match
> than the SoC. If this is supposed to represent a specific variant of the
> basic EVB design then it should come before "rockchip,rk3399-evb" (and
> possibly be optional if other variants also exist).
> 
> Robin.
> 
>>           - description: Rockchip RK3399 Sapphire standalone
>>           items:
>>


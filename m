Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491ECC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6D8206E7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCLI6H4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbgIGRnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbgIGRnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:43:12 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0B8C061573;
        Mon,  7 Sep 2020 10:43:11 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gr14so18027249ejb.1;
        Mon, 07 Sep 2020 10:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mSurHpBmqEWBODMaG3W5ioJJMxOeKfAOUJKlwr4m2NU=;
        b=iCLI6H4J7QZe980J+0V8cA+UCVCnRmDVw/E2/oIPS0ymSLmrheKXQ/OCmg/2P78uOV
         rS/9HUIfvcD+EdsjOnC+5sWs3LUYCQN4NLk681u5gLlH2t4kBflkgkaMvAXkVIOfJhNd
         nqge6kfWdiZDgbfxureKmnEO9oVHx7Ig/EhQlEW0PunuRXF25LHJeL+8jzMtpkCWw3zh
         7u/WRwuunD+eShHQjt/3Iwas4NHNAbdSbyXbeAhYReyYxSya0SSfnN40LdeoXMGEAB5u
         lbUFYruK2DqKkHUOMvUobAnOBb1zg+aEJlyJidCyNP8PqdMvOuQfNfBIfTMoJlxM1XDX
         yfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mSurHpBmqEWBODMaG3W5ioJJMxOeKfAOUJKlwr4m2NU=;
        b=mMCzIU065tgMmduaf/5guBWIAKXvTnC9v5ZUahHCwqBQfDShGZFqfwEvOoI9ch+WdF
         VZvLkFNU0v8pSD9jTwxWuJRWdxjDrL6FUOuoxjoARzmyUrH/BSyue166u2+HNDeShJP6
         PAqzSafMa/cUZjkGTM2QsSBBsMMGmF8kzGMOSzAvjMQaa5BBhuZw4lUFPQNNFqRBtgwp
         XRPeaaI+zdeNgPRB/33WzYBimQ3D5RtSRm1C5oMrikOzZAggAbYqFJSIzs6NUC3j2Jgr
         W3XgAVxEZKdFcqPgNsImaeNYimFKUc8NkSceeTWtYk5xfwVxGHYqhp1O72o7swe4293i
         9Pow==
X-Gm-Message-State: AOAM532iLRa4QuX5Zuf9JjcGw6aSfMGLTYvNvU0O0VIVlNmg0ExCZDFz
        5s0TvSS1Vam9ene3VXzH3eStbmKY7SPeYA==
X-Google-Smtp-Source: ABdhPJwrE/HR1BoZfbLhIcPMGkII8grsVkg5ttN7riJDB+qlyOJd19aGhtNHj3R86SHyT+D9TGrmIg==
X-Received: by 2002:a17:906:390d:: with SMTP id f13mr21620989eje.86.1599500590132;
        Mon, 07 Sep 2020 10:43:10 -0700 (PDT)
Received: from bcbook.internal (a89-183-24-75.net-htp.de. [89.183.24.75])
        by smtp.gmail.com with ESMTPSA id c8sm15921923ejp.30.2020.09.07.10.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 10:43:09 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch
 aliases
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200907112718.5994-1-pali@kernel.org>
 <3ec54259-4bfe-8462-e8d5-083fc009707a@gmail.com>
 <20200907172303.GA3254313@lunn.ch> <20200907173534.aoupftjkxgcftfqo@pali>
From:   Andre Heider <a.heider@gmail.com>
Message-ID: <f8cce9af-372b-f2bc-ea09-e1516367cb90@gmail.com>
Date:   Mon, 7 Sep 2020 19:43:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200907173534.aoupftjkxgcftfqo@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2020 19:35, Pali Rohár wrote:
> On Monday 07 September 2020 19:23:03 Andrew Lunn wrote:
>>> My dts-foo is a little rusty, but now that you labeled the ports in the
>>> .dtsi, can this whole "switch0" block reduced to something like:
>>>
>>> &switch0port1 {
>>> 	label = "lan1";
>>> };
>>>
>>> &switch0port3 {
>>> 	label = "wan";
>>> };
>>
>> Probably yes.
>>
>> But that is definitely too much for stable.
> 
> Yes, this suggested change is not for stable, but looks like a nice
> cleanup. So it could be done in followup patch.
> 
> Andre, are you going to prepare and test this followup change?

I can prep the patch if you like, but the suggested cleanup only affects 
the v7 dts files. I don't have that hardware version to test it, so 
could only send an untested patch.

Regards,
Andre


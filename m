Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4BCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351B220826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iR3pZfkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgEUP4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgEUP4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:56:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8B7C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:56:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so2910740wru.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uLCMRTyOXjE9erVUxBDc3PTKU9Yt55p8AR+4yWGIsbg=;
        b=iR3pZfkKbiToIz1N7ufbr2Ugkp9DSrnwW2AOdbebzNhEOZ7YdsnlO9drTxWjtbxpfL
         BuXCNhnKsSaB+XWrfXNOIWyGeT19lgVwoEqDobqhDWNIabOOj65L55nGxewmeylThkmR
         lFBgxEJsbafCqXo1njqHmm7SsBEHYG30/1s7aPy1O+04VDrALmmv/vDzJxohtyxo8lqb
         Vjrv71oCYP4DHJo+dJbZiV/lLn/QvPEMPda0hMvOE3IfPQgJMtBfvYHNYFKZDDCRPD4U
         2eKE7djjuKS49cG4Db9rPchi+xDoEEtjuLW6PoN42cTLWcKlBWtiCi33inM1sQW7EhQn
         0azQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uLCMRTyOXjE9erVUxBDc3PTKU9Yt55p8AR+4yWGIsbg=;
        b=nsu8Njdhcvz50K1m18SuXd9Q/n6lh1ll8yHEFQSjhdh2IgbDo+YWv0ipD/LdxRZPrE
         lPuZpfzAWA/9GsINGgjylbBMPGO4sBsAgdROTkzNF5DKqSg2irUviGR+OpeKv9Pn4w3L
         FqydWtSbYyN3OEcNyj2XNv9v+FyLDrP1uyjNvM8VMzgoIxkE3sH3stGKPKtLO5xE0eGA
         cJtAzHbgptkQpw4Z1vPY7GGvAroo+BxHYH+KWFSJbncGvzR7WLw5Z0HyFCdFHl/TWFls
         JttcQi+hE8FBNqzPHKWqUdrKusF/eXwUNJQVo6AiXmNaiEMUYY+eDmFu7XU1k2K3piLq
         N5+Q==
X-Gm-Message-State: AOAM532Qz5ZB/l0N8Hh2DSsvIx/LVPjs/nBGvMFYtM9pzzhb/vXWlMve
        zvLD0gGC44I7oMVxGRjgxiS98g==
X-Google-Smtp-Source: ABdhPJxrMTmt7fxRkq9YsSfm7JKgRhRnDtp9kr90marbvWZjRQ6V/3vd0FugA1b6W6TJcs6AhSlm1g==
X-Received: by 2002:a5d:4c49:: with SMTP id n9mr2020191wrt.266.1590076551258;
        Thu, 21 May 2020 08:55:51 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id m3sm6778597wrn.96.2020.05.21.08.55.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 08:55:50 -0700 (PDT)
Subject: Re: [RFC v1 2/3] drivers: nvmem: Add driver for QTI qfprom-efuse
 support
To:     Doug Anderson <dianders@chromium.org>
Cc:     "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
 <1589307480-27508-3-git-send-email-rbokka@codeaurora.org>
 <ffaccce7-95c0-2f95-ad3b-55f1da42eaee@linaro.org>
 <14e1fa51-066c-6e1b-01a4-2103612de9e9@codeaurora.org>
 <d5902226-21b3-7941-6405-688d7a115142@linaro.org>
 <b80aaca0-0594-e04b-5320-b5b3c4478161@codeaurora.org>
 <d76e4eb2-fa6a-0b76-3912-83bce678bc96@linaro.org>
 <CAD=FV=XW7GymV_pr_0SvUPWwL6WnPhqMq-crq-RbR_us3-ShNA@mail.gmail.com>
 <9864496c-b066-3fe8-5608-bd9af69663f4@linaro.org>
 <CAD=FV=UbZPQ74COXJbOikq9Wcx1UvtuMuMA+nqkx44uySoqggg@mail.gmail.com>
 <99f07eaa-d072-f391-098e-e6f7a50a1960@linaro.org>
 <CAD=FV=W+UES1f3reMhvPPUho5FbaZXdU-2jkRaPcbBEzDWT+WQ@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9ecb5790-47fe-583b-6fc3-8f4f3ce7860e@linaro.org>
Date:   Thu, 21 May 2020 16:55:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=W+UES1f3reMhvPPUho5FbaZXdU-2jkRaPcbBEzDWT+WQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/05/2020 16:10, Doug Anderson wrote:
>> On 20/05/2020 23:48, Doug Anderson wrote:
>>>> Is this only applicable for corrected address space?
>>> I guess I was proposing a two dts-node / two drive approach here.
>>>
>>> dts node #1:just covers the memory range for accessing the FEC-corrected data
>>> driver #1: read-only and reads the FEC-corrected data
>>>
>>> dts node #2: covers the memory range that's_not_  the FEC-corrected
>>> memory range.
>>> driver #2: read-write.  reading reads uncorrected data
>>>
>>> Does that seem sane?
>> I see your point but it does not make sense to have two node for same thing.
> OK, so that sounds as if we want to go with the proposal where we
> "deprecate the old driver and/or bindings and say that there really
> should just be one node and one driver".
> 
> Would this be acceptable to you?
> 
> 1. Officially mark the old bindings as deprecated.

Possibly Yes for some reasons below!

> 
> 2. Leave the old driver there to support the old deprecated bindings,
> at least until everyone can be transferred over.  There seem to be
> quite a few existing users of "qcom,qfprom" and we're supposed to make
> an attempt at keeping the old device trees working, at least for a
> little while.  Once everyone is transferred over we could decide to
> delete the old driver.
we could consider "qcom,qfrom" to be only passing corrected address 
space. Till we transition users to new bindings!

> 
Yes.

> 3. We will have a totally new driver here.
No, we should still be using the same driver. But the exiting driver 
seems to incorrect and is need of fixing.

Having a look at the memory map for old SoCs like msm8996 and msm8916 
shows that memory map that was passed to qfprom driver is corrected 
address space. Writes will not obviously work!

This should also be true with sdm845 or sc7180

That needs to be fixed first!

> 
> 4. A given device tree will_not_  be allowed to have both
> "qcom,qfprom" specified and "qcom,SOC-qfprom" specified.  ...and by
> "qcom,SOC-qfprom" I mean that SOC should be replaced by the SoC name,
> so "qcom,sc7180-qfprom" or "qcom,sdm845-qfprom".  So once you switch
> to the new node it replaces the old node.

Secondly, this IP is clearly an integral part of Secure Control Block, 
which clearly has versioning information.

Versioning information should be part of compatible string in msm8996 it 
should be "qcom,qfprom-5.1.0"
for msm8916 it should be "qcom,qfprom-4.0.0" this translates to 
"qcom,qfprom-<MAJOR-NUMBER>-<MINOR-NUMBER>-<STEP>"

Thirdly we should be able to have common read for all these as they tend 
to just read from corrected address space.

Offsets to corrected address space seems to always constant across SoCs too.

platform specific device tree nodes should also be able to specify 
"read-only" property to not allow writes on to this raw area.

Does this make sense ?

Thanks,
srini
> 
> 
>> Isn't the raw address space reads used to for blowing and checking the
>> fuses if they are blown correctly or not and software usage of these
>> fuses should only be done from correct address space?
>>
>> the read interface to user should be always from corrected address space
>> and write interface should be to raw address space.
> Great.  That sounds right to me.  Presumably the driver could add some
> sort of "debugfs" access to read the raw address space if needed.

Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992ECC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50FAA2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YX6vfIYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgHJRGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgHJRGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:06:19 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C62AC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 10:06:19 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bs17so6949172edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HYUcL16/Yz70HFL7zCRJmggfJFAs+VVD4T3aLaK9Wkk=;
        b=YX6vfIYq9T7HNgV+If83+38Avdto4RdBe+Z4rTmtagpapCoxq5ZWeoop9J0WfCHHC0
         vSb3Si7Neg7oJo5oHMcE1yU3sq7FTzudbI8gA6GENlsojDpHPsi8wmAxy9pstUJt+9MQ
         4r6GrhhopPskcJnWWqMOGfQj5i38X6dVIsXLwF9/LNuMjDeeX7P2D1WroNfRItXXZyuz
         cukQGfRIwmgo1l8/IlU8U5QtXw0p1NxamTH5Mzn3kBOmlo56SJOkaa5CCOUVQPYBAQHZ
         DTluCh1DI9bErm0ZlAIr5oAKqjC6GJSmrcQXlU0otuxScuJLUjwUBliUfnezJIj3qPfH
         Y12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HYUcL16/Yz70HFL7zCRJmggfJFAs+VVD4T3aLaK9Wkk=;
        b=AwtF+2fPS6xKuKDhFOd3i/FcWudycdUPCXqo1ilpVyvNfvnuZd+zFQ3bY17/ldEmDy
         /0mpXzUNKjADXaABh+rFb1HoiL2hXa2tNoRA5pqlS0Zuc+Gd+ojd9qvJUaP+eqE9U+dW
         XRWIoBoaGJgxfSydRJSuo3VNlpZPLIAEMw/otyQBJc1hP4aOq2ytJFcNk16e9EhlevpS
         W8FMpxxkvEnMWIB3cJZbsRKdVEAcf153/rsJ0aEP3Wcp/U15l0xIlk+CwXiTVSmmTfsH
         XduwPHn58y7L3PCFFOBI5dSKpBqig6s9qNSXCbW+zbzrM4DXjPkWcEByGe9P/TmqRmSa
         dvDA==
X-Gm-Message-State: AOAM530ZaUiVLln8slJY4b1CHpTnVSVIZb5n8CgTIIPVrQYDcwIRRMdD
        kuJ6/od7N05st9QRHzz5QeLPBw==
X-Google-Smtp-Source: ABdhPJw/29rOog79iXPvSo0+27lwd4BvlCLyxqWTS/rslRvXzoD8/jENQK4sw74w11vjI55AbMFRNA==
X-Received: by 2002:aa7:c74f:: with SMTP id c15mr22371423eds.331.1597079176357;
        Mon, 10 Aug 2020 10:06:16 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id ov10sm13263985ejb.6.2020.08.10.10.06.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Aug 2020 10:06:15 -0700 (PDT)
Subject: Re: [GIT PULL] sound updates for 5.9
To:     John Stultz <john.stultz@linaro.org>, Takashi Iwai <tiwai@suse.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
References: <s5hbljocbxl.wl-tiwai@suse.de>
 <CANcMJZCPPOOmKyRMKYRe5sRsqf-rrO6wXK5BPVwFrAPLZOEyMg@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4f3ead7e-992e-edec-e7b4-31566fc5e583@linaro.org>
Date:   Mon, 10 Aug 2020 18:06:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANcMJZCPPOOmKyRMKYRe5sRsqf-rrO6wXK5BPVwFrAPLZOEyMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,
Thanks for reporting this.

On 08/08/2020 01:23, John Stultz wrote:
> q6routing remoteproc-adsp:glink-edge:apr:apr-service@8:routing: ASoC:
> error at soc_component_read_no_lock on
> remoteproc-adsp:glink-edge:apr:: -5

This is an -EIO error which is reported when the ASoC component driver 
does not have both regmap and read callback and someone is trying to 
read a register!

In q6routing case all the dapm widgets reuse reg field in 
snd_soc_dapm_widget to store offset information or routing table indexs 
or some DSP related id and so on... These are not real registers.

I think the core is trying to read the state of these widgets during 
startup, Which will fail in qdsp6 case as we do not have any regmap or 
read callback associated with this ASoC component.

Previously we never had chance to see these messages so we did not 
implement any dummy read callback.

Adding a dummy callback to q6routing and q6afe-dai ASoC component will 
fix this issue at-least in Qualcomm case!

thanks,
srini




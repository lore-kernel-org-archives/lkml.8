Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE96AC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A08CB206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0/93ttU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgDURRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725870AbgDURRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:17:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70C7C061A41;
        Tue, 21 Apr 2020 10:17:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hi11so1612477pjb.3;
        Tue, 21 Apr 2020 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/HKitW2kvA7NHe9STw8mIlU1852n1EZbQydCMbj93Q8=;
        b=F0/93ttU6tdpNY4LNdtyJOF1kA7lixfPb3/t0yc+UyNI7ZKzOG7CgjBknfOmtTkIzi
         YFl8Hql3mb2+lXJuCjIK9iuq/51Sl7n6AFy2kQZy7pzzOw1A9D20nd9WSrvj+MPsV183
         1yne5YvmW9iYHzkQ5y1klcg/TFu1fAKqR1IE1IkRN2LYdY9bnhjRownwroPe9lSwhCYN
         3ZkD2eK6JONdPqRFr8zqhqqj/evY4ezDBX6Iwpmzxeke3b4LrNz8h8u0Sxky9XMK4ITa
         tN/YQq2VU7FgutJKm/jabmsKeA+xeh7EdjIN06WSW8J140+Cvb5VfL1cOpQVgXOcoF/b
         MsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/HKitW2kvA7NHe9STw8mIlU1852n1EZbQydCMbj93Q8=;
        b=P6JR92fo8SqNKrzI0p8oXdmbdDYSgFCSlavuDcZsKbz5hJ3W6FevK76ztuLRcw1zjY
         AC4+xxhq6RcHpxgwkvMcIkjm7SI0cBLuJqRiYmWjTXf4BC2QfcVplhvN2Nnl7z6qesny
         q2KiIsHPCobL5iF/muJk3UHiV/1+FjBVDbhqLm7GaDHR8/uJCLW+gTyzfJ4ColuPCsDU
         0KYNQ3Rm1KUSnxi0cinpmPtIpvCWfSus/KUhtV8gi6GNflC/XFalz3E//paBSlvSFUrw
         eus0UQdRkefFAJ8MQwzm/EI1MvAbSQe3xuGaoPeq9AtGSTmfYxlzis7LjRuLT3iHq+Ni
         AUYw==
X-Gm-Message-State: AGi0PuZMW66VugQPXGHVWfCCpzD55Y5lJhw8fLbyudKmQvJkUncJ04Ut
        n8t6hqe8tvZLNYgfVSVH+rLKt+zU
X-Google-Smtp-Source: APiQypJo0hMKzUEitYOqZn2X4OfIYIrqQuOTFElZiiZQvGihQoIdzKswDgQoa9GRPAUvQiqD4I8oDw==
X-Received: by 2002:a17:90a:343:: with SMTP id 3mr6902685pjf.178.1587489431881;
        Tue, 21 Apr 2020 10:17:11 -0700 (PDT)
Received: from [10.230.188.26] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z190sm1416790pfb.1.2020.04.21.10.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 10:17:10 -0700 (PDT)
Subject: Re: [Patch v3 1/9] spi: bcm-qspi: Handle clock probe deferral
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
 <20200420190853.45614-2-kdasu.kdev@gmail.com>
 <158748156553.18089.8164001089518853868.b4-ty@kernel.org>
 <2d810e4f-5f05-4257-59a8-882ae790ecd1@gmail.com>
 <20200421171558.GE4540@sirena.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0d91f426-e767-2e69-bcb7-ddc4d7611861@gmail.com>
Date:   Tue, 21 Apr 2020 10:17:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421171558.GE4540@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/2020 10:15 AM, Mark Brown wrote:
> On Tue, Apr 21, 2020 at 10:11:52AM -0700, Florian Fainelli wrote:
> 
>>> Applied to
> 
>>>      https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7
> 
>> It would be nice if the URL could be clickable, e.g.:
> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-5.7
> 
> That then doesn't work with git itself unfortunately, someone's got to
> loose out :/
> 

Could you provide both links with a market at the front, e.g.:

Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 
for-5.7
CGIT URL: 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-5.7
-- 
Florian

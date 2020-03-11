Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97625C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61271208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDJG0GZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgCKBse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:48:34 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33806 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgCKBsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:48:33 -0400
Received: by mail-io1-f67.google.com with SMTP id h131so285953iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 18:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YZOvj5Z6BfnkZ7YZwPQIpuVc7cl2w2qzUU1f/5XLsYg=;
        b=hDJG0GZzwKhaXh8NjD+uNxuhdOrChRpsq7jcVKcbTzwzMWvLKBjkNQiU+slFuoIW0M
         bJ0G7zpiNiRoRpEMk5meg88ZC3YpbWmTTBWPdwgXCc+1NxEmJis7AJEdn1/zsA5gFMTL
         ER4N05u3T+bRCfLzp1AMDN2rfMPA/71x2ggWeXbjCc9M2VlNd0kd6CB94gGqom4naqfi
         0eVv1eja5gb3qITKOC1nscKyEzTuz3niRaJllv4cgkrgbjrVreD96cvqc8auUMwBll4j
         O4d4KTpspJCMJ4eSQpLwbMIq8YzuWmw+uMxQqomgCCtONFyrA0UcPEt0Cn4J39fynwZ7
         kUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YZOvj5Z6BfnkZ7YZwPQIpuVc7cl2w2qzUU1f/5XLsYg=;
        b=TvmeJ0MpzNBxdgIU32GSWUMn/hEk+iSA7jnMA6hE5imVRyPSnLqFzCuQ2gUPtayoom
         E4RGyJfhYi+NhLhZUp3UxpVO06s9WQ4rEXkAGmwx1+jd1Q868DhKFVBVH724b2DiQpaH
         Metlz+nFnrRrpLXEwa672NInpiD/+VdnBLjhDfCtKf1dD9GKNO1nQnx9PuhpC7tJjpWB
         qtPMhiwdacmzKuxShzS/E4wDkjSh9RpxxsYeTvk7nHl3Z0fOEncXcWRO/SzUZ6OiyHLj
         wFurqQsbzGxPl8qlCjZSZ3Gz+9TUxtx+TZW3kKd8ha3OIR87tbOwnBzFfoGVA6mGnMkm
         uwhA==
X-Gm-Message-State: ANhLgQ2FG7KO2MGqq2fUHvMlXgjrc2BoflWZMNCZpLYyOUTV3sJlnefP
        3m/QAVHvPVXTNOOar6LVxwwqKt53JG4=
X-Google-Smtp-Source: ADFU+vvphl4v3/+nIUg7d0ljdy63Yxh/FE0BuHduJQLQ8ckr0O76XymzgxI9dAzCMhgiGD0GTzkbZA==
X-Received: by 2002:a5d:9b12:: with SMTP id y18mr818519ion.176.1583891313108;
        Tue, 10 Mar 2020 18:48:33 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id y11sm17158348ilm.22.2020.03.10.18.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 18:48:32 -0700 (PDT)
Subject: Re: [PATCH v2] bitfield.h: add FIELD_MAX() and field_max()
To:     Jakub Kicinski <kuba@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20200306042302.17602-1-elder@linaro.org>
 <20200310212938.GA17565@ubuntu-m2-xlarge-x86>
 <20200310145825.6ddb3797@kicinski-fedora-PC1C0HJN>
From:   Alex Elder <elder@linaro.org>
Message-ID: <bc50d249-60ab-767d-ae0c-02629483df34@linaro.org>
Date:   Tue, 10 Mar 2020 20:48:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310145825.6ddb3797@kicinski-fedora-PC1C0HJN>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/20 4:58 PM, Jakub Kicinski wrote:
> On Tue, 10 Mar 2020 14:29:38 -0700 Nathan Chancellor wrote:
>> Without this patch, the IPA driver that was picked up a couple of days
>> ago does not build...
> 
> 😳 
> 
> Yes please, Alex could you repost ASAP with [PATCH net-next] subject
> and CC netdev to get it into the netdev patchwork?
> 
> Please also make IPA:
> 
> 	depends on (ARCH_QCOM || COMPILE_TEST) && 64BIT && NET
> 
> Otherwise it's really hard to make sure the code builds.

Sorry all.  I have been on vacation the last few days and only now
saw this.

I will put this together shortly.

					-Alex


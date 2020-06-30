Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20BBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 01:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF1A2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 01:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJHrQSYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgF3BDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 21:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgF3BD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 21:03:28 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DF1C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 18:03:28 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id a12so19248127ion.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 18:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aUKINyRCcoVQnAAUj66cT/hdbbLTmUEKaTLIk1C+bzY=;
        b=WJHrQSYEfA4X5EFmtDe9jbFY9aZT+nTWxDMZmLz0AUJd15mGOahtGNLjk99YVgkTH9
         s7wnYkYxZHIC/XH1BgzLNVOwdfmGbH2dziAeeT4RMpwQLqTc3Pm9ynDKXP/ZKJKfzlEM
         8nzFjlzMGmqsQsv5gkLAnHGFSckgHoMIiB0lGhkafhJu7/cZaL+7HZ98ZvCsvjGv+YnQ
         rphuYOZuh7qKZEwcSy4Yvil11mSh5dYO+8UIXVVzTMfzv2Mt/hHf9GC8Dni3ISp8IGE+
         5QEzlxRacR+HWGiur2eobXSrbwsN2JQYEN8QhSaOjmRRK6GAxVFI5RbOKHYJP95dmc6o
         Lruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aUKINyRCcoVQnAAUj66cT/hdbbLTmUEKaTLIk1C+bzY=;
        b=r8ZKHRj02IVuwL0DlaxcuDzV1GwT3ibMpJRNPyUgcBueY12cQpoHU7/i+Wib/gdeq5
         eoyeL+4PAYbo3Lz1w4SKK2Rxl1ccHtvrWlpCmSQ4khCNUQ4hA3puJKmCm4dWc2F8QIPm
         LVUNvQ8AbX+ysRU3kU+BJnvd+iPCbJZeUiiq6yZvufIp1B7pfiynOT4CXdyUB1jvEY14
         X2tXSLZYQRzTbf1rko7gdQS0J2AaMhweKzZRmXI96SUZSqIq2xE49zVT5FR1kv4zbPnD
         Ekig2WcvVwt0udZPh2CK11uvRulUTFl7B7+06I5B7AQ8yEpYKpFL4KtdZcYdTXYVZ15V
         /f0w==
X-Gm-Message-State: AOAM530/R0o56JAQJotdtLULVudlb/u9yiO9QNROKlyuCggvaus4QBQB
        j1tltJCPtmIxNGivQbOAiuUTZjnghyo=
X-Google-Smtp-Source: ABdhPJwentt0cKMDEsu9rT9oUSTBpWdmkqFUmo628dp6U8zA96yEiANErt1telr45qCiv8IDu94fBw==
X-Received: by 2002:a6b:661a:: with SMTP id a26mr19625657ioc.197.1593479007622;
        Mon, 29 Jun 2020 18:03:27 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id v13sm715255iox.12.2020.06.29.18.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 18:03:27 -0700 (PDT)
Subject: Re: [PATCH net-next 1/3] net: ipa: always report GSI state errors
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200629213738.1180618-1-elder@linaro.org>
 <20200629213738.1180618-2-elder@linaro.org>
 <20200629170912.39188c5b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <6b5baacc-3ae0-e801-1db7-d40dae560094@linaro.org>
Date:   Mon, 29 Jun 2020 20:03:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629170912.39188c5b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/20 7:09 PM, Jakub Kicinski wrote:
> On Mon, 29 Jun 2020 16:37:36 -0500 Alex Elder wrote:
>> We check the state of an event ring or channel both before and after
>> any GSI command issued that will change that state.  In most--but
>> not all--cases, if the state is something different than expected we
>> report an error message.
>>
>> Add error messages where missing, so that all unexpected states
>> provide information about what went wrong.  Drop the parentheses
>> around the state value shown in all cases.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
> 
> nit:

Sorry about that.  I'll fix this and run checkpatch on v2.

Thanks for your quick review.
					-Alex

> CHECK: Alignment should match open parenthesis
> #105: FILE: drivers/net/ipa/gsi.c:1673:
> +		dev_warn(dev,
> +			"limiting to %u channels; hardware supports %u\n",
> 
> CHECK: Alignment should match open parenthesis
> #120: FILE: drivers/net/ipa/gsi.c:1685:
> +		dev_warn(dev,
> +			"limiting to %u event rings; hardware supports %u\n",
> 


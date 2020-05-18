Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB992C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68182065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="SW4u/tpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgERPD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgERPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:03:56 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07D0C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 08:03:56 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k18so10962003ion.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zhBCLV6Pq+PIRNumJDFC+hT6dCYyurG69WuSPlFC+DE=;
        b=SW4u/tpYmJKb5hF00ZiUK7OHKeHyg8BR91taO3uS78PK3g2ArFVd9a62KZv6xuy8ox
         /kg1mA67VfJUMDPBwmNigfm8eIhITbGuopGqaY1CWn85xlwmQVq71zmFMKFTU6s06wDW
         ycU30OfwVZ0ye2/wpGID46Ev86K9JMmJHXpTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zhBCLV6Pq+PIRNumJDFC+hT6dCYyurG69WuSPlFC+DE=;
        b=DjBi7mFsFW93xRZE25a3FvulmirdPcxibuji3/CR/IX9qG5Mhgrxp4xr+wc68axlZI
         AL2FuiuSURDh+AbbPQM+fxjThDhOVaoIHl7bHOWhBiOxI3gp5dOgc9K2L8sLanekPXB+
         hAddpRpjFyTLNuYtdpNbzi845oZ/qL3wNxHth5gl9C6li1nH68XeaxApXsFgO76iBiRW
         +dNFwds2vuRFM6vNh2y+5xe0JEuSfTfcxINb/Qof2DoUMXh+IOVnypnxdNWVvQgAVyZH
         Uot7kAgKDfT4ectVvhEQjd1d+9/0jAemCRrssW4tmMeCT9ijn4AICvnj+rxMpnyTqvZ6
         vXMw==
X-Gm-Message-State: AOAM533QgdS6w6fBnzwkktQhincbv/y8chWJ1tIFWLB7xGEMrcqfG/AI
        a105a5JaP+qF8Ipg945sHJA7YA==
X-Google-Smtp-Source: ABdhPJxXUsQQZxuy+jef26vC22p6/tcVRbzM2T2as9hfXdqTCjcvfVhSyuoK9CHzA97x4Kv81uabHg==
X-Received: by 2002:a02:a895:: with SMTP id l21mr15553885jam.82.1589814234911;
        Mon, 18 May 2020 08:03:54 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id q4sm4383395ilk.12.2020.05.18.08.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 08:03:54 -0700 (PDT)
Subject: Re: [PATCH] drivers: ipa: use devm_kzalloc for simplicity
To:     David Miller <davem@davemloft.net>, kuba@kernel.org
Cc:     wenhu.wang@vivo.com, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
References: <20200514035520.2162-1-wenhu.wang@vivo.com>
 <20200514101516.0b2ccda2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200514.124700.630104670938763588.davem@davemloft.net>
From:   Alex Elder <elder@ieee.org>
Message-ID: <a13b6985-98d6-5996-1ef7-6d64cdd75c15@ieee.org>
Date:   Mon, 18 May 2020 10:03:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514.124700.630104670938763588.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/20 2:47 PM, David Miller wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Thu, 14 May 2020 10:15:16 -0700
> 
>> On Wed, 13 May 2020 20:55:20 -0700 Wang Wenhu wrote:
>>> Make a substitution of kzalloc with devm_kzalloc to simplify the
>>> ipa_probe() process.
>>>
>>> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
>>
>> The code is perfectly fine as is. What problem are you trying to solve?
> 
> I agree, these kinds of transformations are kind of excessive.

I have considered using the devm_*() functions, but if I were to
make such a switch it would be done comprehensively, throughout
the driver.  It is not something I plan to do in the near term
though.

					-Alex

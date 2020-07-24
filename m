Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F45CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 283322065E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="D9i2ZHiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgGXVpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgGXVpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:45:23 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347A4C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:45:23 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id s21so8403277ilk.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YZGD4OodDleZ/Yxr9/TUm5yXUoLz2XAGYdSqw9Im1hk=;
        b=D9i2ZHiThHuwK+qViCHANccMkvriE1UbajxhaLuXoQgrdd+KHecfVmrhJ3gXfsvAvF
         430N1y4dm8jwgKy5wrm/GEvNNsATIIk4hxos7joFCASijHp6QKQG9C8DedjfutZdarlZ
         SsaCDprLjV4TdHa/KUr9cymgj2oFF876LhE7f9jjHtFyt3sVvTynypwoA0GfHVV+KX4c
         l7SZZzp1DKcjiwGGjDYpGWMj8sMq7g1DYck0mVjftTGDkvu8dDjhmzF1BYxMlHdKt7/f
         4oQplz8JyWNErMpl+iMiYko/iT11WnrYzab7nyPoGN9dtishcFDzDrotW+dGrR/qFTce
         BzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YZGD4OodDleZ/Yxr9/TUm5yXUoLz2XAGYdSqw9Im1hk=;
        b=WB9j4tZLOwUqkQ5hWExPT1l5vhUbrMdzTIcTDvvsF9bVECW6kxmAnUwAdRzw6g973f
         JkRGjEuHG8H7C76MFtFZOAV9joTCWyPkIx5Erc97xde03ziljHF1GifBg2aFxe4jjFWi
         yt7Q3Z/Aq9gh4t2s0DIeC56IzkVXIwg7D6kP+2bhXKimJLNeF/4JWoOVPGgCPQCZnG/L
         Maqco9mLqP2bLPSUwL5xvrCCylzwqNcRfEDTYPp4xych6FPd7ehI0X68J8/UsViYhkZ7
         9/ybB/2M2+KhO0KXbyua8LdvXsDAJpErhF7Q320G6vvW3pGEe3LLvqYR5ACe6iCDkOsE
         C1Bw==
X-Gm-Message-State: AOAM5302yfEU/GLpICsJN4Dv4siLG2yScTw6knzy7fISXYlh0ZCIdz9a
        aAU9Tm7JOnSwNrd6NJSw0GFqoA==
X-Google-Smtp-Source: ABdhPJwGzfbMpQm1GWIUAQwFmvZbNFYqEvFeTXGKC+Oi6qy3/2yXnVqOXVeJrag63xkz9ibbOkLlxw==
X-Received: by 2002:a92:c792:: with SMTP id c18mr12541365ilk.223.1595627121666;
        Fri, 24 Jul 2020 14:45:21 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:0:4a0f:cfff:fe35:d61b])
        by smtp.googlemail.com with ESMTPSA id f206sm3866369ilh.75.2020.07.24.14.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 14:45:21 -0700 (PDT)
Subject: Re: [PATCH] netlink: add buffer boundary checking
To:     Jacob Keller <jacob.e.keller@intel.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Thomas Graf <tgraf@suug.ch>
References: <20200723182136.2550163-1-salyzyn@android.com>
 <09cd1829-8e41-bef5-ba5e-1c446c166778@gmail.com>
 <8bd7695c-0012-83e9-8a5a-94a40d91d6f6@intel.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <e23f7bec-7675-20f7-8ec9-822c6ac3339f@android.com>
Date:   Fri, 24 Jul 2020 14:45:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8bd7695c-0012-83e9-8a5a-94a40d91d6f6@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/20 2:14 PM, Jacob Keller wrote:
>
> On 7/23/2020 12:35 PM, Eric Dumazet wrote:
>> On 7/23/20 11:21 AM, Mark Salyzyn wrote:
>>> Many of the nla_get_* inlines fail to check attribute's length before
>>> copying the content resulting in possible out-of-boundary accesses.
>>> Adjust the inlines to perform nla_len checking, for the most part
>>> using the nla_memcpy function to faciliate since these are not
>>> necessarily performance critical and do not need a likely fast path.
>>>
>>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>>> Cc: netdev@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: kernel-team@android.com
>>> Cc: "David S. Miller" <davem@davemloft.net>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Thomas Graf <tgraf@suug.ch>
>>> Fixes: bfa83a9e03cf ("[NETLINK]: Type-safe netlink messages/attributes interface")
>>> ---
>>>   include/net/netlink.h | 66 +++++++++++++++++++++++++++++++++++--------
>>>   1 file changed, 54 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/include/net/netlink.h b/include/net/netlink.h
>>> index c0411f14fb53..11c0f153be7c 100644
>>> --- a/include/net/netlink.h
>>> +++ b/include/net/netlink.h
>>> @@ -1538,7 +1538,11 @@ static inline int nla_put_bitfield32(struct sk_buff *skb, int attrtype,
>>>    */
>>>   static inline u32 nla_get_u32(const struct nlattr *nla)
>>>   {
>>> -	return *(u32 *) nla_data(nla);
>>> +	u32 tmp;
>>> +
>>> +	nla_memcpy(&tmp, nla, sizeof(tmp));
>>> +
>>> +	return tmp;
>> I believe this will hide bugs, that syzbot was able to catch.
>>
>> Instead, you could perhaps introduce a CONFIG_DEBUG_NETLINK option,
>> and add a WARN_ON_ONCE(nla_len(nla) < sizeof(u32)) so that we can detect bugs in callers.
>>
>>
> I also think this is a better approach.

We (another engineer here) are looking into that and will get back to 
everyone.

Sincerely -- Mark Salyzyn


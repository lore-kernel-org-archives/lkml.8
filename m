Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A62C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B469A20792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="VKul/k4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGWUNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGWUNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:13:20 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5244C0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:13:20 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i4so7580183iov.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gFizQjOKr5jXpuq3CMiC/MyvKNZKW89IBlFK0gpQRGw=;
        b=VKul/k4WuY4FAW1C7Zu50+qEBB4obEEQCu8NsE1fl1lzAlnzvAEe+y/5mwvIfC12gY
         +b4v81O1fL5ihAXeYryDqD1S7LClzt5tOl6F7RXHywXQE432rtVfBqRxIAm021afhy+t
         IV2JV8HmjQ5phugaXciPaYPsLU2QzN8KOV2Uz7K54J3xlnubg4QuDdy7dmbGKz5s14/7
         UxRDu9Nic6fHVVPP0CctglM4WDRLLfupxvQV9GIIcakwHi5YRzQ0oJLOqrgvJ/gogggm
         FkGaA+YnHEYLb7vk2PGsQ41FX6Rqagp4znv/ea62rIgOLKQdJUwKBPvk0SMmJrw7HG+r
         QGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gFizQjOKr5jXpuq3CMiC/MyvKNZKW89IBlFK0gpQRGw=;
        b=V+3GTnM9i7YlmeTVg6huObVUp3qmoELgQfInzMG3A0z3Z9DEo1WLWcoad9n9j3f0Es
         3+L26mh+gJIa1cAJG31dEurARcGJQWI4KE3ECYsXQF8pIhwCUiWqBB4/fAtJhBbyw24P
         RVMBiV5dkPiSqAU6vII0FpcA7uzYhd7SIk9d/lMV/iIc9anq/z5povOYQFk2rUJbk1O/
         oqR2Z2/YtOXfRz9iRbk6r3S+8/q3YvC6HMijUJ0Pr/jmiwbRaS4hwM6fbBgaxdk5ANex
         ik49TYGaoqFl3MByOxjIy66nDlM3EoM0TD2Q600QxmY8JnpVNO5QSxjGHSDC09YYLdP9
         6Z/Q==
X-Gm-Message-State: AOAM530P02arKaRDekUCOpBUqgUeiyyUPuIaP+MY4EG9J2XJmw8DYLuh
        ZZ8bKE727sV3fJi3Z9mxTSSWig==
X-Google-Smtp-Source: ABdhPJwpKj+HbJPbd8zd5yvfZWDP7GA8HomCKEBfCXBUfQkauTtT0nuk0MCO1SKCpY7YQiNtFSxMbA==
X-Received: by 2002:a5d:97d9:: with SMTP id k25mr6758601ios.42.1595535200007;
        Thu, 23 Jul 2020 13:13:20 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:0:4a0f:cfff:fe35:d61b])
        by smtp.googlemail.com with ESMTPSA id h1sm2045324iob.8.2020.07.23.13.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 13:13:19 -0700 (PDT)
Subject: Re: [PATCH] netlink: add buffer boundary checking
To:     Eric Dumazet <eric.dumazet@gmail.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Thomas Graf <tgraf@suug.ch>
References: <20200723182136.2550163-1-salyzyn@android.com>
 <09cd1829-8e41-bef5-ba5e-1c446c166778@gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <f3d2eedc-23eb-0b45-4c15-15b887e05164@android.com>
Date:   Thu, 23 Jul 2020 13:13:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <09cd1829-8e41-bef5-ba5e-1c446c166778@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/20 12:35 PM, Eric Dumazet wrote:
> I believe this will hide bugs, that syzbot was able to catch.

syzbot failed to catch the problem because of padding u8, u16 and u32 
were all immune because they would go out of bounds into a padded buffer :-(

On 7/23/20 12:19 PM, David Miller wrote:
> Now it is going to be expensive to move several small attributes,
> which is common.  And there's a multiplier when dumping, for example,
> thousands of networking devices, routes, or whatever, and all of their
> attributes in a dump.
So it _is_ performance critical (!)
> If you can document actual out of bounds accesses, let's fix them.  Usually
> contextually the attribute type and size has been validated by the time we
> execute these accessors.

A PoC was written for nl80211_tdls_mgmt supplied no bytes for 
NL80211_ATTR_STATUS_CODE and instrumented code could report back OOB.

I was initially considering pushback because padding bytes were being 
read and considered it harmless. Best way to find out if it is really a 
problem probably was to ask, but as Linus said once 'show me the code' 
and that is just as effective in the asking ;->

My Gut remains to respond WAI unless you'all reading padding is 'bad'

-- Mark


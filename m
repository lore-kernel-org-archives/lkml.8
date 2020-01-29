Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2F3C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE05A206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzyCjLdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgA2S4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:56:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53635 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgA2S4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:56:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id s10so963007wmh.3;
        Wed, 29 Jan 2020 10:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AF+mno6mYz9qIP41mXsPhY+8d+0nQqfFtsqICTMMkM4=;
        b=kzyCjLdcFiEAO63kT2kKmXjCLjnPtogY6x/OrY53eV/0C+tFhthvjCYTK7zD58Ilxd
         T3hxARgD4DlHcPfJ4tso69kH2AFhmOWEeLA2OczFXNTR3nqvvnfLEfmOdRkpZ7LRkfDY
         ALjAi6pD5YYDKI5clCSCUhnjwnv0wQvBNDJ2SfbcTwERWeGqV7UFw4AFTJes0N06YD/L
         go50g4z5Dnnxbaev5jE89hY4YejixzDmhYF2NnWumiSp4mPte7GUzxvB/BT15Z7zP0lz
         LcInPmmyy0d8yIujQONdTyvr2tVMhKY3F2Ms/bg9PH1h5ooLydKCN7zb4G9c1CtiBduR
         IzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AF+mno6mYz9qIP41mXsPhY+8d+0nQqfFtsqICTMMkM4=;
        b=MvrOqvSoUZkzmGy3CPwDLOicAhdg+Hi2+ZDmB7Jw9gOrgUONlrTg2f+WQam3bU3zv6
         zZOQSpLXmtWQYGnfAUXo705uIInyHEoA2CUWtpW0TNH0UOIBzQLCFd7VFMTXb/HdGPuv
         mOjBQclGYkZAhHsMSpPV9tc+9nEvX3E5YczvWVe28zG6Uj73AIYfWkgmDgFeLiHHQoct
         Zr7fjiM8a5JmyXZ+pfUZSrMW/jaqA7IQyz6/Hwpm0gkqcDdz9bodzVP/BuTjqAen3fDk
         uuPwi5RVl42MPwSkcj9PXfrSY/ZunHfvlCuLpzkvG/7uy89YDHuvzCXwkXO3Kp8bWN/n
         AW7g==
X-Gm-Message-State: APjAAAWmwuVLn8K8ihUxIptucUcK98TKaNfuPrfegP59F8CW5zbKiSYY
        4rmRRvvauPJJd4g84CI1C7Q=
X-Google-Smtp-Source: APXvYqxz9qbzM1VD9pn+/zENw9XmqmzRFTxdo+ky/Lu0dCkVrisPEjk3Q/f4/PPfhnZaLZzILAZKGw==
X-Received: by 2002:a1c:65d6:: with SMTP id z205mr657945wmb.38.1580324197331;
        Wed, 29 Jan 2020 10:56:37 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id a6sm3996048wrm.69.2020.01.29.10.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 10:56:36 -0800 (PST)
Subject: Re: [PATCH 3/5] mm/mremap: use pmd_addr_end to calculate next in
 move_page_tables()
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        aneesh.kumar@linux.ibm.com, kirill@shutemov.name,
        yang.shi@linux.alibaba.com, thellstrom@vmware.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200117232254.2792-1-richardw.yang@linux.intel.com>
 <20200117232254.2792-4-richardw.yang@linux.intel.com>
 <7147774a-14e9-4ff3-1548-4565f0d214d5@gmail.com>
 <20200128004301.GD20624@richard>
 <d66bb20e-c0e7-caef-cbbc-aa216c2be7d6@gmail.com>
 <20200128232907.GA11467@richard>
 <27b70b0c-7945-cc85-8321-d9e4b6f17865@gmail.com>
 <20200129002838.GA12835@richard>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d53d1bde-f677-cfa4-3315-24788171c917@gmail.com>
Date:   Wed, 29 Jan 2020 21:56:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200129002838.GA12835@richard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.01.2020 03:28, Wei Yang пишет:
...
>>> I would prepare another patch set to fix this. Would you mind helping me
>>> verify on your platform?
>>
>> Sure, please feel free to CC me on that patch.
> 
> Thanks, you are in the cc list of v2.
> 
> Hope this one works fine on ARM.

Okay, I'll reply to the v2 after some more extensive testing (tomorrow).

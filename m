Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998DAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7231B206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8D3q1L1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgA2RTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:19:05 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39050 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgA2RTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:19:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id o11so176572ljc.6;
        Wed, 29 Jan 2020 09:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gbJtuHtMtIG58qn8sgjSg+QMYd2kq8kiaTQag0/0PO0=;
        b=A8D3q1L1PpHreiid6/UiAVlNngte4w2Qqx/DHTz7AUkVo0S7gnwbwozEjSmASiFPeR
         lynXnsDEAT76TZvuhbyyHHUxMCDtf15SQjVEorIYpnvRpACUel5+WT6APpwQ59xLyLZ7
         SsG5nYT3Q2d3Xq81DjkvR/bngQcq7+a/asgPTTnP2Tp5kVW01NjxDWnSBMXQLqWLzEtd
         mfiDAgzsKSxG08sGtan1wBKgtCvZUxp11MIq2B6wStYeGZ4ZWCiiPYIiYIJOBknXr2oD
         ZzNSk7+Zy7GWbzz2SeacZjzFms0qM/BHzYzhpCvXGUbKbKzB5NA/YfYgw5nOqsP+LRED
         aFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gbJtuHtMtIG58qn8sgjSg+QMYd2kq8kiaTQag0/0PO0=;
        b=QZo+7pPjfQ8Gn/rvk0UWqGOnQSExxdX1D6a/wjMUMuyPZjGggkU6pf9qC6tnU8kHzH
         88u7uq7v7vcDd5Cz7Ig1ovMbN00XTGobRJMQ0QTh1MDsIq/Gw4zjex77eRYRNsKqrO94
         n9l6Duk1EA3dq03wsGE7v+P9J847Bw0zJGCbk12nzNB/hYE5D6YlPGQ1WVW2sxmJ1SaG
         Xx42EcUoW95cGtO6mW+zcUdHCteel4CeiPAkejgUyV3OclIa+eyREnlZWlmBYB1VD7xG
         523bNS1ZlWAI+1GvmJBJb49Vi4b4joJ/2/qBrtN39L0nJVIMHVOUleXMVglhH97ER+hb
         HZmQ==
X-Gm-Message-State: APjAAAXEO+a1UOTcEi8il839svpEkv74tkUZqEGkj34HUcDASSSxJLCC
        MFIeFihjMS3dQ6vKCenBlIg=
X-Google-Smtp-Source: APXvYqxMRqU/Zwg1r0oEOGWXRoLfv6lMbLv4fpRQ/Xo880/4WQEsbhwhBxq8NjNmBpDBa9zt0P+FbQ==
X-Received: by 2002:a2e:9b03:: with SMTP id u3mr93715lji.87.1580318339534;
        Wed, 29 Jan 2020 09:18:59 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id e8sm1577443ljb.45.2020.01.29.09.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 09:18:58 -0800 (PST)
Subject: Re: [PATCH 3/5] mm/mremap: use pmd_addr_end to calculate next in
 move_page_tables()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, dan.j.williams@intel.com,
        aneesh.kumar@linux.ibm.com, kirill@shutemov.name,
        yang.shi@linux.alibaba.com, thellstrom@vmware.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20200117232254.2792-1-richardw.yang@linux.intel.com>
 <20200117232254.2792-4-richardw.yang@linux.intel.com>
 <7147774a-14e9-4ff3-1548-4565f0d214d5@gmail.com>
 <20200126185951.c9246349befcccce210a4ab8@linux-foundation.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b5eb4766-38ba-0153-2844-cc303fe0dc07@gmail.com>
Date:   Wed, 29 Jan 2020 20:18:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200126185951.c9246349befcccce210a4ab8@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

27.01.2020 05:59, Andrew Morton пишет:
> On Sun, 26 Jan 2020 17:47:57 +0300 Dmitry Osipenko <digetx@gmail.com> wrote:
...
>> Hello Wei,
>>
>> Starting with next-20200122, I'm seeing the following in KMSG on NVIDIA
>> Tegra (ARM32):
>>
>>   BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:190
>>
>> and eventually kernel hangs.
>>
>> Git's bisection points to this patch and reverting it helps. Please fix,
>> thanks in advance.
> 
> Thanks.  I had these tagged for 5.7-rc1 anyway, so I'll drop all five
> patches.
> 

Hello Andrew,

FYI, I'm still seeing the offending patches in the today's next-20200129.

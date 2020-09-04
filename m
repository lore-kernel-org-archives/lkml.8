Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692BFC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3349C20748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrkeKOpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgIDDxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbgIDDxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:53:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B6FC061244;
        Thu,  3 Sep 2020 20:53:12 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so3652364pgl.2;
        Thu, 03 Sep 2020 20:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hKioT0wjDTd3HyPaP33TayX+qRWZn7CovAFQRZ/15Ww=;
        b=WrkeKOpLSbJxDXVmyA8s6DCES7y33/VoPusNxlh12V8XVbhCn6FLIWQujlJfM5Zf2J
         60lvZ3ZjeOCFcct2uoED5eOjgSM+yJdPNtcH9JdHIE4QlZsIr7sbDyg/vyFihcDjFwFt
         65lDb+Nyb+YNTN7E5gCFk8FbEIYXyqbaJphxDj/sNiw7kEOh4tx1/ewUXSopDRrUoZmL
         3AN5RiRbfrwjm0YX9G6WqNv966ktq92Vhl9hW5frdqJe20khkiOubc5Akn09KWyW42R+
         n/VhMC+eDVV1JMCeGEJIuXjKFt3K6FHIPd3DlJmyuZGfQmA6siRQKz8lNYEMAiUf3RwS
         mJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hKioT0wjDTd3HyPaP33TayX+qRWZn7CovAFQRZ/15Ww=;
        b=EtInGGTsYgLKLNJv7wSYn/DnGtgSCZg5sHzCiWPQL5uPqgPvAqj/lf3yguRIokMtpZ
         7DtreKISxMs9+LlxMRIrVd/NCcOpjLxLhx81tLIB62T9978OggdoIiHUP/8a1C9qThxr
         MRdW07uZnAkEGDEOHT7shoqq0aao+ulHhTXHieex39GcMbVtiuWZd6Ef3JkjnauGdyYL
         A1OtdQ6LVv2mjSmbwhPApt4quYubTFxR8MqgyUCPC4NAzal0IMbxY3IFwn9d1OTnKLVZ
         nS43T7n4xYDrICkZPKIs0Bd/6N5fRpeVI6M1AZf4W4HSoJsGn8tY7g3EyN/YdoHD/mrI
         j5wA==
X-Gm-Message-State: AOAM530c+dOfGTPLQy7FeEYr0VWNqYb3FZVrMxwQBW9gxg9NoM+BOt37
        EnA+mHdebpbsvdJURsRMjUY=
X-Google-Smtp-Source: ABdhPJzqti3IptrNuUSV13GjWu324l+mciLP0rzdo4Vg7VMbN/JnTv9YYroozlxYfRpDVFnkrgZAfg==
X-Received: by 2002:a62:e404:: with SMTP id r4mr6625289pfh.213.1599191592357;
        Thu, 03 Sep 2020 20:53:12 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x140sm4690544pfc.211.2020.09.03.20.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 20:53:11 -0700 (PDT)
Subject: Re: [PATCH v2 01/11] usb: gadget: bdc: fix improper SPDX comment
 style for header file
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
 <1599189448.11403.33.camel@mhfsdcap03>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4c7e1125-beef-51ae-2784-2850b38cc8e1@gmail.com>
Date:   Thu, 3 Sep 2020 20:53:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <1599189448.11403.33.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/2020 8:17 PM, Chunfeng Yun wrote:
> Hi Florian,
> 
> On Thu, 2020-08-20 at 19:30 +0800, Chunfeng Yun wrote:
>> For C header files Documentation/process/license-rules.rst
>> mandates C-like comments (opposed to C source files where
>> C++ style should be used).
>>
>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>> ---
[snip]
> Would you please take a look at this series?
> I'll drop the patches that not fine with you.

It all looks good to me, thanks and sorry for not responding earlier.
-- 
Florian

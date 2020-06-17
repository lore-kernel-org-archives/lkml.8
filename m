Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CCDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16712212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgFQUlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:41:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45858 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQUlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:41:36 -0400
Received: by mail-lf1-f67.google.com with SMTP id d7so2124251lfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UX4brrjCqXuf8JfyELRrcCYxTPT94k6LBNtVKmVNWAc=;
        b=L0Dp7stU0GlCVX8VqKY80P37tWgdfb/WbqXnOkA8dKjhDhEY0D41EFpDo7DvW5kZsg
         K6gMW0aCjgfd+nS09/ahA4+Lb/ztnDH7xi5HBm0Y2NCTeDRu6rn0D/C5PDnzjVTUzJI4
         YWy8X1vDCs7R6MN9O+Ux4vnjS+wDkCcO/5/ONmYxwERAY/OrDsMAjB4/W8LysI9k29bL
         RAaC1i0Gl8g4w+ov6QKAmo6dHF1ON+n4KLIiCfghc9Yb9zoVBVGLAHdI7gD9e6XggPfV
         hJguLmZR4tx2XQuZ/LRWpkb+VntkvULYb7ToAI7nBub9/N9wsdy4MZT33Yv8b7N+GhUJ
         XuyQ==
X-Gm-Message-State: AOAM5330BoWphRVILI5AbigiIeyou38w4s2ZeFV3/QkgiG5ZxOth7Wwg
        2NBkF6xz5YjoS+VcidZ2/Xk=
X-Google-Smtp-Source: ABdhPJzck+H2VocKCX4hc+bgAWKGo/1Dwc09FY+mXy7j29n/9JXJLOH6cDRNoILwryD91ZWqlxSc4w==
X-Received: by 2002:a19:14e:: with SMTP id 75mr393249lfb.7.1592426493381;
        Wed, 17 Jun 2020 13:41:33 -0700 (PDT)
Received: from [192.168.1.8] ([213.87.137.195])
        by smtp.gmail.com with ESMTPSA id y22sm191346lfh.12.2020.06.17.13.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 13:41:32 -0700 (PDT)
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
References: <20200615130242.11825-1-efremov@linux.com>
 <alpine.DEB.2.22.394.2006172225570.3083@hadrien>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: [Cocci] [PATCH] coccinelle: api: add device_attr_show script
Message-ID: <871aeea8-9b61-5eaa-4b0d-a377ba82c2d0@linux.com>
Date:   Wed, 17 Jun 2020 23:41:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2006172225570.3083@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/20 11:27 PM, Julia Lawall wrote:
> 
> 
> On Mon, 15 Jun 2020, Denis Efremov wrote:
> 
>> According to the documentation[1] show() methods of device attributes
>> should return the number of bytes printed into the buffer. This is
>> the return value of scnprintf(). show() must not use snprintf()
>> when formatting the value to be returned to user space. snprintf()
>> returns the length the resulting string would be, assuming it all
>> fit into the destination array[2]. scnprintf() return the length of
>> the string actually created in buf. If one can guarantee that an
>> overflow will never happen sprintf() can be used otherwise scnprintf().
> 
> The semantic patch looks fine.  Do you have any accepted patches from
> this?

It's not my patches, but:

3f9f8daad342 cpuidle: sysfs: Fix the overlap for showing available governors
117e2cb3eeee sparc: use scnprintf() in show_pciobppath_attr() in vio.c
03a1b56f501e sparc: use scnprintf() in show_pciobppath_attr() in pci.c
3dee04262898 iio: tsl2772: Use scnprintf() for avoiding potential buffer overflow
dbdd24eaac4e edd: Use scnprintf() for avoiding potential buffer overflow
abdd9feb45ed btrfs: sysfs: Use scnprintf() instead of snprintf()
f21431f2de33 thermal: int340x_thermal: Use scnprintf() for avoiding potential buffer overflow
40501c70e3f0 s390/zcrypt: replace snprintf/sprintf with scnprintf
eb3e064b8dd1 s390/zcrypt: Use scnprintf() for avoiding potential buffer overflow
06b522d6de9d video: uvesafb: Use scnprintf() for avoiding potential buffer overflow
bf1b615ad97e video: omapfb: Use scnprintf() for avoiding potential buffer overflow
b40e288bfb53 platform/x86: sony-laptop: Use scnprintf() for avoiding potential buffer overflow
ef21e1750158 ALSA: Use scnprintf() instead of snprintf() for show

and many more

Thanks,
Denis

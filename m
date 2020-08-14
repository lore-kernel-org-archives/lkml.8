Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E698FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C732E20639
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgHNIuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:50:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40097 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgHNIuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:50:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id 185so9112626ljj.7;
        Fri, 14 Aug 2020 01:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EU/l2DgNP5Q3Y33a0vaqppa+eSULahmyXd3lqONrVV8=;
        b=WnJcHDHJO8X0CDhRYuh9QQVVOu/2AGtPN8Dd3PQonKdfnPkZJyVRMW4X0hqlBNzqs3
         PdQ1rLZzc7USwM+iBxhBQQcpOBOgFluEGMDMn+3Ng4CTWLGNxjlFLaxQUPZgPs0E6T6v
         R3MooarLUxW0UFkVT4KbJNK25c7qyUPX7GxGLQE5ewUER4rBEtriwqxdGpfQW0fOHdC8
         BXSR5VxMhzq7i4cLwq6aIgWOEiw4ZhKRtsT7hBqNtF3+RjU0mfsbKBb2eAgW5BvWoCeS
         SSCOtDwC2kZB/d/TOMl4ucPuIXQVU4xCDks1neSMMia3X67EMOkFGDkRSE2E272jtK8n
         oBRw==
X-Gm-Message-State: AOAM53072no2TX3bICnYviW5MzfT6XGregh/YBaLhZrZigVorKAIy1BF
        FfRGrSEmBo38aRXau88o0dh67CTTT1M=
X-Google-Smtp-Source: ABdhPJwSJpFN7geKb23Bu8pumvCmyLFkpxeYjv3mvRyo5OCsnyKTFvV5E3A/G4MROsjszQcv/645pg==
X-Received: by 2002:a2e:9913:: with SMTP id v19mr844004lji.292.1597395036694;
        Fri, 14 Aug 2020 01:50:36 -0700 (PDT)
Received: from [10.68.32.147] (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.gmail.com with ESMTPSA id z18sm1635838lja.55.2020.08.14.01.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 01:50:36 -0700 (PDT)
Reply-To: efremov@linux.com
To:     Markus Elfring <Markus.Elfring@web.de>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Coccinelle <cocci@systeme.lip6.fr>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <ed9a8046-4c21-e849-f68b-9e08991b701d@web.de>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: [PATCH] coccinelle: api: add sprintf() support to
 device_attr_show
Message-ID: <8e76e81f-970b-b1f7-840d-10506dc3311a@linux.com>
Date:   Fri, 14 Aug 2020 11:50:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ed9a8046-4c21-e849-f68b-9e08991b701d@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Markus, I think that CCing new people and spam them with mails they
are obviously not interested in doesn't bring an additional value to
the discussion. linux-kernel and cocci mailing lists are enough
in my opinion. This also will allow us to keep "threaded" mail
order.

On 8/14/20 11:30 AM, Markus Elfring wrote:
>> Interesting enough that with this patch coccinelle starts to skip
>> patch generation in some cases. For example, it skips patch for
>> drivers/base/core.c This is an unexpected result for me.
> 
> Would you like to point questionable differences for such patch hunks out?

Without this patch the script generates:
$ spatch -D patch --no-includes --include-headers --cocci-file scripts/coccinelle/api/device_attr_show.cocci drivers/base/core.c
--- drivers/base/core.c
+++ /tmp/cocci-output-63510-2f17ff-core.c
@@ -1713,7 +1713,7 @@ ssize_t device_show_ulong(struct device
char *buf)
{
struct dev_ext_attribute *ea = to_ext_attr(attr);
-       return snprintf(buf, PAGE_SIZE, "%lx\n", *(unsigned long *)(ea->var));
+       return scnprintf(buf, PAGE_SIZE, "%lx\n", *(unsigned long *)(ea->var));
}
EXPORT_SYMBOL_GPL(device_show_ulong);

@@ -1743,7 +1743,7 @@ ssize_t device_show_int(struct device *d
{
struct dev_ext_attribute *ea = to_ext_attr(attr);

-       return snprintf(buf, PAGE_SIZE, "%d\n", *(int *)(ea->var));
+       return scnprintf(buf, PAGE_SIZE, "%d\n", *(int *)(ea->var));
}
EXPORT_SYMBOL_GPL(device_show_int);

@@ -1764,7 +1764,7 @@ ssize_t device_show_bool(struct device *
{
struct dev_ext_attribute *ea = to_ext_attr(attr);

-       return snprintf(buf, PAGE_SIZE, "%d\n", *(bool *)(ea->var));
+       return scnprintf(buf, PAGE_SIZE, "%d\n", *(bool *)(ea->var));
}
EXPORT_SYMBOL_GPL(device_show_bool);

With this patch it generates nothing. I would expect spatch to generate
a different patch with sprintf instead of scnprintf, because I think 
... is enough to match "*(int *)(ea->var)". Even if it can't match sprintf
pattern it should fallback to scnprintf pattern.

> You propose to use a nested SmPL disjunction for desired adjustments.
> I suggest to start a corresponding case distinction behind
> the key word “return” instead of repeating it three times.

It doesn't work.

Thanks,
Denis

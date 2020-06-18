Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF42C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73CF420776
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgFRMYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:24:50 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:38926 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgFRMYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:24:45 -0400
Received: by mail-lj1-f179.google.com with SMTP id a9so6972777ljn.6;
        Thu, 18 Jun 2020 05:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iV6BEDB1zo0555x4Iuh2YDEJGSgVibiOS7btV2WxH4U=;
        b=JVAjo7/+jQ3jfmQ3OqBwcwu5k6vDtO6stmtJzCSTffaIlv6/seENZrw2zQQXe9JAgF
         v84IxE/5uTTO3VIDga3FqjQ1YezIldYa7o2dJdKLj+SCk5xAP8/gL9gGwRTJ95XZhzBW
         Us8C81rGptgTjqgrTkn7/QflLi6+lLwLAzHIuFE7330inlXIF/weKmXD6EX6u9DRxmS0
         wKvGuGNJNQvkrrJu7uaUaCY+07l0RdrkNDgzhYAOA9Ejum7cp/r/rcxeX3vR+pAly3jL
         rpsAkHmxDSGg/N9yHobBOh6qj+vuidDQJPsI6MOs/MR2xa8x0+RyfHRKbil7wUwIt2uD
         5auA==
X-Gm-Message-State: AOAM532yv0Sjgkuv9UTyooem7Nm6KnQTJC5b0xdopNPxNg4lYlJaHWam
        Dx9skihzU2PTA4P7GUfb+57yXdPYt1UMEQ==
X-Google-Smtp-Source: ABdhPJysIlDWetLGUJ/D+n1RU/qGCWzW/tn4D4uWxefMCU8CC34pxlFubA3hECdMTtnrjaB8HxsFUg==
X-Received: by 2002:a2e:910c:: with SMTP id m12mr2374933ljg.332.1592483082528;
        Thu, 18 Jun 2020 05:24:42 -0700 (PDT)
Received: from [192.168.1.8] ([213.87.137.195])
        by smtp.gmail.com with ESMTPSA id l14sm606137lja.2.2020.06.18.05.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 05:24:42 -0700 (PDT)
To:     Markus Elfring <Markus.Elfring@web.de>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
References: <54ac89f1-5f38-8909-a652-c658a5a1f36b@web.de>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: [PATCH v2] coccinelle: misc: add array_size_dup script to detect
 missed overflow checks
Message-ID: <759d33d2-25a2-f55f-7e3a-7481ab5dd0fc@linux.com>
Date:   Thu, 18 Jun 2020 15:24:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <54ac89f1-5f38-8909-a652-c658a5a1f36b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/18/20 2:34 PM, Markus Elfring wrote:
> Why did you repeat a typo from the previous patch subject?

Where is the typo? I can't handle your suggestions because your mails constantly
break the threads. I just can't find them after due to missed/wrong In-Reply-To
headers. Again, this mail doesn't contain In-Reply-To header and highly likely I
will miss it when I will prepare next version of the patch.


>> +expression subE1 <= as.E1;
>> +expression subE2 <= as.E2;
>> +expression as.E1, as.E2, E3;
> 
> How do you think about to use the following SmPL code variant?
> 
> expression subE1 <= as.E1, subE2 <= as.E2, as.E1, as.E2, E3;

It's less readable and harder to review.

> 
>> +      when != \(&E1\|&E2\|&subE1\|&subE2\)
> 
> I suggest to move the ampersand before the disjunction in such
> SmPL code exclusion specifications.
> 
> +      when != & \(E1 \| E2 \| subE1 \| subE2\)

Ok, I will fix this if there will be next version.

> 
> 
>> +coccilib.report.print_report(p2[0],
>> +f"WARNING: array_size is already used (line {p1[0].line}) to compute \
>> +the same size")
> 
> I would prefer an other code formatting at such places.
> 
> +coccilib.report.print_report(p2[0],
> +                             f"WARNING: array_size is already used (line {p1[0].line}) to compute the same size.")
> 

No. It's pointless to break the line to save 5 chars this way.

I can use instead:

coccilib.report.print_report(p2[0], f"WARNING: array_size is already used (line {p1[0].line}) to compute the same size")

or

msg = f"WARNING: array_size is already used (line {p1[0].line}) to compute the same size"
coccilib.report.print_report(p2[0], msg)

or

coccilib.report.print_report(p2[0],
f"WARNING: array_size is already used (line {p1[0].line}) to compute the same size")

And I prefer the last one if Julia will allow me to use more than 80 chars in print string.

Thanks,
Denis

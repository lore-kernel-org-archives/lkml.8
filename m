Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23857C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8FA21D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAFU/Qi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgATQO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:14:26 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39196 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgATQOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:14:25 -0500
Received: by mail-yw1-f67.google.com with SMTP id h126so52098ywc.6;
        Mon, 20 Jan 2020 08:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yV9E3DsbSTYXQcQn+O/DQs2k8Uat8+dJL8pMY3GWsZA=;
        b=tAFU/Qi3EPWdH9a/74KS3N4Y/71FVg7k8SPfMnFlGdEvviM/oFNDBiq07Ki+Wq3tPT
         6LPtlGupfLx94l/D4PvthFtIMiUkTf1aU26gUp554nr1Dj8wSqE1nElu0OL+q9jDquyQ
         pWvcRR9naN7u4/DvY7j7RBtJVEfqEQO8rykzwpERS2uSzgkZcLW2gHjVuNNTPwh9aRt1
         nqvING837J53jiI2lSZxW9uQ5XYOf7bbS59XIX65FiQA8mlGaEHZ9eBPSsgi6I33Goow
         6P2bwiHU04RWSvMeuvyts+Hot1PeOvCrKgFMsxc9ulBQ4qNjUnBFTrZrXMRyPnM8g1cd
         /f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yV9E3DsbSTYXQcQn+O/DQs2k8Uat8+dJL8pMY3GWsZA=;
        b=UH+heqap1kKkO++mNvcRkxZoQBzNjdOmbPEesyNjZYASpW2l6YvgQB1rHEPjb3dMB3
         /cuDjj+ppW4sfiTDFk9XSUH/rgFAoZoktbtPt2B/mzrinZjkF8N1a1x0tk28loF/QVv6
         y7XyYEYPhS7iH2n7DijQzK2uXKrU/0eqnyOrHlvbrXr9SjFIyamRUmQ2dPeoFfr+i7qe
         CymeqUNUoPINSQu3jmbDvG4bEUyCuOQuYSHa5KDWk31bGc1fhidNPjsC37blw2dMSK1Y
         dyDu9elrDwONKT8qHuQVpmQW7ZfL2Pu6ij49AnPCxn2Ui7VVWLULNkmpfknf/ZTiqLP7
         3Pkg==
X-Gm-Message-State: APjAAAUGIdUn5ODOo3ezu42tVFHrBjs6rs0r0uC81a45V+RXrygFu2ML
        v5wzQLdhZgNHhjfQWQKnf/w=
X-Google-Smtp-Source: APXvYqzKcq61LXJl1UVXoXm5ifoOiv1/KHBi4cvxJUlqFuTqYL/1q7ASSWyHOoN5K4H+4yo0Htc5Yw==
X-Received: by 2002:a0d:c905:: with SMTP id l5mr38346301ywd.44.1579536863988;
        Mon, 20 Jan 2020 08:14:23 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id g5sm16560414ywk.46.2020.01.20.08.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 08:14:23 -0800 (PST)
Subject: Re: [RFC PATCH 0/3] Add device tree build information
To:     Alexandre Torgue <alexandre.torgue@st.com>, robh+dt@kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        david@gibson.dropbear.id.au, sjg@chromium.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, devicetree-compiler@vger.kernel.org
References: <20200113181625.3130-1-alexandre.torgue@st.com>
 <f21ad44d-f119-2035-b4ee-16b3619879af@gmail.com>
 <233e0a5f-d38f-908c-5ca7-66ee87d0fcae@st.com>
 <7cfd0bc0-13fd-98ea-9bfd-6cfbbfd77b6d@gmail.com>
 <220e3aea-b273-417a-69c9-059236c888af@st.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <a1233cd8-e73a-82d7-74bf-69109d1a0a07@gmail.com>
Date:   Mon, 20 Jan 2020 10:14:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <220e3aea-b273-417a-69c9-059236c888af@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/20 4:56 AM, Alexandre Torgue wrote:
> Hi Franck
> 
> On 1/17/20 8:13 PM, Frank Rowand wrote:
>>
>> On 1/16/20 2:19 AM, Alexandre Torgue wrote:
>>> Hi Franck,
>>>
>>> On 1/16/20 3:28 AM, Frank Rowand wrote:
>>>> On 1/13/20 12:16 PM, Alexandre Torgue wrote:
>>>>> Hi,
>>>>>
>>>>> The goal of this series is to add device tree build information in dtb.
>>>>> This information can be dtb build date, where devicetree files come from,
>>>>> who built the dtb ... Actually, same kind of information that you can find
>>>>> in the Linux banner which is printout during kernel boot. Having the same
>>>>> kind of information for device tree is useful for debugging and maintenance.
>>>>>
>>>>> To achieve that a new option "-B" (using an argument) is added to dtc.
>>>>> The argument is a file containing a string with build information
>>>>> (e.g., From Linux 5.5.0-rc1 by alex the Mon Jan 13 18:25:38 CET 2020).
>>>>> DTC use it to append dts file with a new string property "Build-info".
>>>>>
>>>>> of/fdt.c is modified to printout "Build-info" property during Kernel boot and
>>>>> scripts/Makefile.lib is modified to use dtc -B option during kernel make (this
>>>>> last part could be improved for sure).
>>>>
>>>> Please read through the thread at:
>>>>
>>>>     https://lore.kernel.org/linux-arm-kernel/550A42AC.8060104@gmail.com/
>>>>
>>>> which was my attempt to do something similar.
>>>
>>> Yes the idea is the same: get build DTB information like build date,
>>> "who built the DTB" ... The difference seems to be the way to do it.
>>> In my case, I don't want to modify existing dts source files., but I
>>> "just" append them by creating a new property with a string
>>> containing this build information.>
>>> Why your proposition has not been accepted ?
>>
>> Since you are asking this question, I am presuming that you did not
>> read the replies in the thread I referenced.  Please read through
>> the entire thread.  Most of the review comments were objecting to
>> the concept of my proposal.
> 
> Sorry I have been lazy :$. This series is a tiny one compare to
> yours, and adds less dtb information (only git used, who built dtb



> and the date). There are no "dtb versions", and "absolute/relative"
> path which created concerns. One remaining concern is "reproducible

Here is an example of the info from one of my builds:

   From Linux 5.5.0-rc2-dirty by frowand the Mon Jan 20 09:50:58 CST 2020.

The information 'Linux 5.5.0-rc2-dirty' is precisely what was most objected
to in my proposal.

-Frank

> build" but making dtb info optional could respond to it. I continue
> to think that it's useful to get those information (even if it's only
> a string) But before continuing (and find a better technical way to
> do it), I need to know if there are no other obstacles.
> 
> Regards
> Alex
> 
> 
>>
>> -Frank
>>
>>>
>>> Regards
>>> Alex
>>>
>>>>
>>>> -Frank
>>>>
>>>>>
>>>>> Regards
>>>>> Alex
>>>>>
>>>>> Alexandre Torgue (3):
>>>>>     dtc: Add dtb build information option
>>>>>     of: fdt: print dtb build information
>>>>>     scripts: Use -B dtc option to generate dtb build information.
>>>>>
>>>>>    drivers/of/fdt.c           |  9 +++++++
>>>>>    scripts/Makefile.lib       | 11 +++++---
>>>>>    scripts/dtc/dtc.c          | 55 +++++++++++++++++++++++++++++++++-----
>>>>>    scripts/gen_dtb_build_info | 11 ++++++++
>>>>>    4 files changed, 76 insertions(+), 10 deletions(-)
>>>>>    create mode 100755 scripts/gen_dtb_build_info
>>>>>
>>>>
>>>
>>
> 


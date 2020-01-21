Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B508CC33CB8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8746024650
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDAWKBVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgAUDU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 22:20:59 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38285 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbgAUDU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 22:20:58 -0500
Received: by mail-yw1-f65.google.com with SMTP id 10so847183ywv.5;
        Mon, 20 Jan 2020 19:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZaIHc6pqnmPWDx7qq975a0b91T6rwGOHbUAFNlb8Q2w=;
        b=tDAWKBVtK8elIgEhFfQUp6MqFnZDP/ZlYN/O6u1MhHhJ42hzW5+gupCqR/Q8gjdAlK
         tMAWjrNdHg9C31RwDQHYKKGHBogXttELnSM7oDZtPdPUsLtFokmCb+mCsG+fUqeQb1HH
         gtmQjNu0S8i2kFJGBajkbAWtB1UAc/wud5XyNmxxBQ3QVfAF4w07/IWUtGAzy2fFtTCX
         CIohi5hWheiH5SOYQ/44lgWMl4sAl5miBhxf8cw3Fjo0Q8qb5pIV84emuNMulwqTTx3f
         wiJLIFQ2Ryyb9/EgUIJ+2jzbN7FTLQebo/fODbq9YHao7tE3d2k4wsi629e3pEH3yiT3
         Swww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZaIHc6pqnmPWDx7qq975a0b91T6rwGOHbUAFNlb8Q2w=;
        b=ad8nSrsMFFKe7W6Sdxz2oKE3cIFRWRGtER5zmzsJqgn9ogq0CxYLMJQsEMjaPsuhU+
         /nrlbkUXaAJJ3kAWOAMZ6OZlRWPFGSw2mXlXvUw6UNKjTtz21pMq0NwvPnz0D1EtHB8j
         rFe4WpgFR+PohXKuqm2DFj+YDmgEZIAOMJj49vlLGKpWlRMmQg0wricDJcn0IGQ3TbJQ
         QoQfm9nGvwhyXkqwu7tfPTDjJjLAh3NxC1NXJuNT8yNnLzTc04GRy4hOhbAaG+LA4ksf
         NIy9o4TYBHLPRo9hi24Z2cf3BLrUHNi8nA8Nul/P4Viz1y0gj90cuRjROcnpvK7gk6Ra
         YtWA==
X-Gm-Message-State: APjAAAXAWuxykH000zh6S7E0KghIpdQgllNqqAryo/KijUKmMZrJOebv
        9lKamMU/mfMTVT9szdCKA6oS6iX9
X-Google-Smtp-Source: APXvYqyB1kWMVOd1/04k3K1h71X8ksgxeQ4E1l2iPIuc/lLeHnGpI2/h0ku8ccNynm+AndyNqf64mA==
X-Received: by 2002:a81:99d2:: with SMTP id q201mr1841317ywg.158.1579576856922;
        Mon, 20 Jan 2020 19:20:56 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id a23sm16930605ywa.32.2020.01.20.19.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 19:20:56 -0800 (PST)
Subject: Re: [RFC PATCH 0/3] Add device tree build information
To:     Steve McIntyre <steve.mcintyre@linaro.org>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>, robh+dt@kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        david@gibson.dropbear.id.au, sjg@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, devicetree-compiler@vger.kernel.org
References: <20200113181625.3130-1-alexandre.torgue@st.com>
 <f21ad44d-f119-2035-b4ee-16b3619879af@gmail.com>
 <233e0a5f-d38f-908c-5ca7-66ee87d0fcae@st.com>
 <7cfd0bc0-13fd-98ea-9bfd-6cfbbfd77b6d@gmail.com>
 <220e3aea-b273-417a-69c9-059236c888af@st.com>
 <a1233cd8-e73a-82d7-74bf-69109d1a0a07@gmail.com>
 <20200120182837.GO3697@linaro.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <f09ce50c-6721-c9d3-4f27-3f98a2d0b183@gmail.com>
Date:   Mon, 20 Jan 2020 21:20:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200120182837.GO3697@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/20 12:28 PM, Steve McIntyre wrote:
> Hi Frank!
> 
> Thanks for the link back to the previous discussion, it's very
> helpful.
> 
> On Mon, Jan 20, 2020 at 10:14:22AM -0600, Frank Rowand wrote:
>> On 1/20/20 4:56 AM, Alexandre Torgue wrote:
> 
> ...
> 
>>> and the date). There are no "dtb versions", and "absolute/relative"
>>> path which created concerns. One remaining concern is "reproducible
>>
>> Here is an example of the info from one of my builds:
>>
>>   From Linux 5.5.0-rc2-dirty by frowand the Mon Jan 20 09:50:58 CST 2020.
>>
>> The information 'Linux 5.5.0-rc2-dirty' is precisely what was most objected
>> to in my proposal.
> 
> ACK. :-( I'm surprised to see so much push-back on what looks like a
> simple piece of information here.

Me too.


> 
> I've had users *specifically* asking for this kind of identification
> so that they can verify the version of the DTB they're using at
> runtime. Right now it can be a guessing game, which does not help
> people trying to debug problems.
> 
> Cheers,
> 

If the information was reported as debug information via pr_debug(),
would that work for your use case?  Or would the users' kernels
not have debug enabled in the configuration?

-Frank

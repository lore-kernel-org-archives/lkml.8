Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F51C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052EC22527
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URqlkO1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgATSSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:18:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50745 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgATSSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:18:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so304002wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 10:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ueFhoq0888bObMU/MyWNjalID6TVX62BYMUk86CN9sY=;
        b=URqlkO1HRRK4JEksGOMOKBeLeUw2xDoWJkLqihkgtjh2adEvHnEmR5yDIn4unCT45S
         aFI8umb1/wYVs0ip9chXxIwjwYTv8fb+Lo9xbBt67VEjKe71syIiJEjSf+avDIUlgkMm
         nR2TS/uAT9ysoaxOMFy3QHwy/79RTB8MB9eBRgdpfovmPUGEEmNuxqyf6trbybXWs7U5
         6MVZwQ1HJ3tg5qIIDFq+SGn+dJsFh7VKygE4O/gkq9Trlit+pEb6pqGuCWb+a/PO4DdN
         j30va57due0cY8AGVnhpGRp/pSPv9uepqdnyuBhF72i5RG3ZbdrxQY3eRtfEUYeyHjsR
         OOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ueFhoq0888bObMU/MyWNjalID6TVX62BYMUk86CN9sY=;
        b=b6xE1+ncZoGnFEvvnPXgQJiNJKB75vU5gRkujOoy9WYbEvNpoEY7LXwUflRJ+dP9RS
         WC2yB3lLnkSuUCG+2ZO4CX3QtIrbMd82oFu8wU4umXJf9EPsR6Q0A6OxfB/ua2NGl7b0
         davFMOShZx9gDwmRGp+PLHdbKiIsTxChUFYzsJHR8tjtgwL9nPEMAR887JUhHzP5P0pe
         BGGFnRgDqIIGJ9rVuDYbivWm+mo6hrbU0NJ+y1nVyVBytLJuZhyHgwY3yujecd9UOnoB
         9hjvB+uEZGq49QOb4+zYC5RDfPo8pb4Gvns9M4Zql1eWO3TlYSqB033JeHKl38yAM0JU
         q0Ng==
X-Gm-Message-State: APjAAAV4gz9OtStNnpEDAvsdcDWMW6pcf8KBSLxXLM1k95gjmYamCpOY
        TXQHlI3JWVgEsCVMHcVoptmpQQ==
X-Google-Smtp-Source: APXvYqwhBmzOsrIOPrRrZOZmMA2xlzfmjsCTPyWP8T4P9O74PDIhglC7uHXDKLHNFKMef4S3xh3WHQ==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr180451wma.72.1579544283637;
        Mon, 20 Jan 2020 10:18:03 -0800 (PST)
Received: from cheddar.halon.org.uk (cheddar.halon.org.uk. [93.93.131.118])
        by smtp.gmail.com with ESMTPSA id u84sm305253wmg.10.2020.01.20.10.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jan 2020 10:18:02 -0800 (PST)
Received: from bsmtp by cheddar.halon.org.uk with local-bsmtp (Exim 4.89)
        (envelope-from <steve.mcintyre@linaro.org>)
        id 1itbcg-0002Fz-0e; Mon, 20 Jan 2020 18:18:02 +0000
Received: from stemci01 by c30-smcintyre.einval.org with local (Exim 4.92)
        (envelope-from <steve.mcintyre@linaro.org>)
        id 1itbbu-0000zW-8O; Mon, 20 Jan 2020 18:17:14 +0000
Date:   Mon, 20 Jan 2020 18:17:14 +0000
From:   Steve McIntyre <steve.mcintyre@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Devicetree Compiler <devicetree-compiler@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] dtc: Add dtb build information option
Message-ID: <20200120181708.GN3697@linaro.org>
References: <20200113181625.3130-1-alexandre.torgue@st.com>
 <20200113181625.3130-2-alexandre.torgue@st.com>
 <20200116005741.GB54439@umbus>
 <d2594b79-a45d-dcac-3642-90016a1408b8@st.com>
 <20200117090937.GU54439@umbus>
 <CAL_JsqKTsX9efYDMjGahFDxj0cEfzozeNrY1Nq1bECzgOZGqdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKTsX9efYDMjGahFDxj0cEfzozeNrY1Nq1bECzgOZGqdQ@mail.gmail.com>
X-attached: none
User-Agent: Mutt/1.10.1 (2018-07-13)
X-wibble: sender_address steve.mcintyre@linaro.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 08:43:23AM -0600, Rob Herring wrote:
>On Fri, Jan 17, 2020 at 6:26 AM David Gibson
><david@gibson.dropbear.id.au> wrote:

...

>> What might be better would be to have a dtc option which force appends
>> an extra .dts to the mail .dts compiled.  You can then put an overlay
>> template in that file, something like:
>>
>> &{/} {
>>         linux,build-info = /incbin/ "build-info.txt;
>> }
>
>I like this suggestion either as an include another dts file or an
>overlay. The latter could be useful as a way to maintain current dtb
>files while splitting the source files into base and overlay dts
>files.

ACK, that sounds like it could be helpful.

>But no, let's not prepend this with 'linux'. It's not a property
>specific for Linux to consume.

Right. We might be seeing the data coming through from U-Boot (or any
other random bootloader) too.

Cheers,
-- 
Steve McIntyre                                steve.mcintyre@linaro.org
<http://www.linaro.org/> Linaro.org | Open source software for ARM SoCs


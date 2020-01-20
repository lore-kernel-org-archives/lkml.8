Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C580C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0137522527
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnCEvDwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgATS3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:29:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32988 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgATS3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:29:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so546871wrq.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 10:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yIHlrjvTOBvuMpFxI0UYD9+tFFNdXNguPvpgjUnqhD8=;
        b=rnCEvDwoDApbJGuPbGXHyTmTfCOAtLcbDINEzjIPsBiL0I6zRdXgOBRf/u65dYl0BH
         axtA40kBe/RmDUUzNbSTXzR2AdR8dIQbq29rU9iNmi39NtYEj7PBwxCMQLoUQtsLBlnu
         GwpWj8s5B+zNDXG3qIyjkteGklth5fmsS+e54J1EpMMZ8RXmSUso3bry7fXmU3ara/Oh
         +MOBBxJqON6SkNDK94PcyuUwFpNvMonXB8/5TF0OpHEH4TUHyxTRD5ryLQ6rbUqb76QV
         PUUcsplJUyih4E0D/3avUFNyrChquEIyy+KGcwz5bYspkTqaSNj2YL2jC7SIguuhvkDM
         Cr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yIHlrjvTOBvuMpFxI0UYD9+tFFNdXNguPvpgjUnqhD8=;
        b=n/FsTxYkgMYQ7EJC7DT6H+WO4TMM3w4bWBW32cK8GbPwwlPuXf2RjR7Ad1OSeSgjQF
         iyjMcJBo0l2/6nrj3CBPEl4KiiUXOexIJekze1I7Takfdaf59+I5n3inqbD3htjxY9hN
         p/iUSirykkcuQfKuaWerEX0YNm1RQeQGoN08DAcBdr39VDFNDoLjPA2mHhIwLZLsW/Cc
         qSxViBhzSFd8vytpiKi+jhDw3RSE5BjyLEE57fLfLOhf3SRkY2yT9ZyU+ELWJ1CaIF7Z
         Webi9flGmLqMsp4xp/y7Yl93RJyuXf/lZUaaVDb0Ty7eBkwXy496mgYnVmaxiNf3JYkX
         qnKg==
X-Gm-Message-State: APjAAAVcNJ+cQ7G9SOZK8Qq6wWYnsO5Dmquts8WjwZU6+M2EWMHChJmB
        iEZpI83hoxqybaK4KkG8/trIeQ==
X-Google-Smtp-Source: APXvYqxvQK4V8dMtd6ZtRxxVvbyJkdKcCSpZibN3HKJDILdQxrPgvQ7rilAQ8MjYiBi2J1DVEFmdkw==
X-Received: by 2002:adf:e692:: with SMTP id r18mr779306wrm.413.1579544943325;
        Mon, 20 Jan 2020 10:29:03 -0800 (PST)
Received: from cheddar.halon.org.uk (cheddar.halon.org.uk. [93.93.131.118])
        by smtp.gmail.com with ESMTPSA id z11sm50787522wrt.82.2020.01.20.10.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jan 2020 10:29:02 -0800 (PST)
Received: from bsmtp by cheddar.halon.org.uk with local-bsmtp (Exim 4.89)
        (envelope-from <steve.mcintyre@linaro.org>)
        id 1itbnK-0003S9-8x; Mon, 20 Jan 2020 18:29:02 +0000
Received: from stemci01 by c30-smcintyre.einval.org with local (Exim 4.92)
        (envelope-from <steve.mcintyre@linaro.org>)
        id 1itbn4-0001Zh-1f; Mon, 20 Jan 2020 18:28:46 +0000
Date:   Mon, 20 Jan 2020 18:28:46 +0000
From:   Steve McIntyre <steve.mcintyre@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>, robh+dt@kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        david@gibson.dropbear.id.au, sjg@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, devicetree-compiler@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Add device tree build information
Message-ID: <20200120182837.GO3697@linaro.org>
References: <20200113181625.3130-1-alexandre.torgue@st.com>
 <f21ad44d-f119-2035-b4ee-16b3619879af@gmail.com>
 <233e0a5f-d38f-908c-5ca7-66ee87d0fcae@st.com>
 <7cfd0bc0-13fd-98ea-9bfd-6cfbbfd77b6d@gmail.com>
 <220e3aea-b273-417a-69c9-059236c888af@st.com>
 <a1233cd8-e73a-82d7-74bf-69109d1a0a07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1233cd8-e73a-82d7-74bf-69109d1a0a07@gmail.com>
X-attached: none
User-Agent: Mutt/1.10.1 (2018-07-13)
X-wibble: sender_address steve.mcintyre@linaro.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank!

Thanks for the link back to the previous discussion, it's very
helpful.

On Mon, Jan 20, 2020 at 10:14:22AM -0600, Frank Rowand wrote:
>On 1/20/20 4:56 AM, Alexandre Torgue wrote:

...

>> and the date). There are no "dtb versions", and "absolute/relative"
>> path which created concerns. One remaining concern is "reproducible
>
>Here is an example of the info from one of my builds:
>
>   From Linux 5.5.0-rc2-dirty by frowand the Mon Jan 20 09:50:58 CST 2020.
>
>The information 'Linux 5.5.0-rc2-dirty' is precisely what was most objected
>to in my proposal.

ACK. :-( I'm surprised to see so much push-back on what looks like a
simple piece of information here.

I've had users *specifically* asking for this kind of identification
so that they can verify the version of the DTB they're using at
runtime. Right now it can be a guessing game, which does not help
people trying to debug problems.

Cheers,
-- 
Steve McIntyre                                steve.mcintyre@linaro.org
<http://www.linaro.org/> Linaro.org | Open source software for ARM SoCs


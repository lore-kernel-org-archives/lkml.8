Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112F7C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6590206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MYlOh9JC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgANLLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:11:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42529 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANLLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:11:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id s64so6234483pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 03:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XBZrfX8lefbqoC00uqxUIqwNp5iGop4pPam/KdlVaFk=;
        b=MYlOh9JC9NAdMnXM2MBHckOrg9L7PtmZWQR1EHKqZTnAQkUW6ztN4gbv/7cjOS0rqh
         1obsqbOBRJmZNZVXi4CI54+9cSBw/VZoneiX1Zy+OFSNSywEJyW0svuLthCEaei/bXO7
         MKt34QBOOGpz8HBh5a7Kg934lWshPDyRqWrIUXt9FTeasQ6KnagCCDXvN/+6ne09FYqz
         jviGn+mkd04b2qwFGUzHXqnay+kK+hTZ2eLncKPqsdZu7k+Infp4/FPX1/DSOxuQxl00
         rDip6nMi0+8qfTYvf+41v0H/1Ok2L97+7ETuhXhj2lpuMJVu8R4wxAribW8Uso6Wk5BY
         wL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XBZrfX8lefbqoC00uqxUIqwNp5iGop4pPam/KdlVaFk=;
        b=W6M71YIzDfJ9wK+q24TyCi0HikHwtXo1osYoZ2741upXlmudKZnJNu9gBtKhGnjLIi
         va6/ebSAzfc8hw2USsOCluo0Ev1MhsyLvxm9XkZ0nCrWB4bC5PUDx+RKvJOGR67ZJ1M9
         V1hSVe0jnVkRm/AoF0nW3dBDHZZz3TNkXDq6Lf1YkwcRwTGt1fn5qzMrBIvOtUWeIM6L
         BaC72fMwXpn/9ABz4b/cgaWPwTyM/5vwFnGlMb7kvlotaEnmRneffuXbYHOEZ1Q0ttIk
         QzEo1QGnHi4AHYoj3p19zQHBCyy9NKbDx/5/V9vR0qkq/Jr0DkmdNd2ompHd/XLHsdph
         JSHQ==
X-Gm-Message-State: APjAAAXQKWr0ZVC32QLxFrrrqU9vIu5By2DJw5FQZutLx0LnlL4ZV2K7
        hBHiiEW+TY4LzNsZMaetY/8TfQ==
X-Google-Smtp-Source: APXvYqx2MiRaW3twJGGHwRODGbxfq0eTPey+fYvLlQ3hvhqtZgptsPwym4I2ms5HfOar2j8f4QImhQ==
X-Received: by 2002:a62:e912:: with SMTP id j18mr24978532pfh.4.1579000273517;
        Tue, 14 Jan 2020 03:11:13 -0800 (PST)
Received: from localhost ([122.172.140.51])
        by smtp.gmail.com with ESMTPSA id y203sm18478129pfb.65.2020.01.14.03.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 03:11:12 -0800 (PST)
Date:   Tue, 14 Jan 2020 16:41:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        cristian.marussi@arm.com, peng.fan@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20200114111110.jhkj2y47ncp5233r@vireshk-i7>
References: <3f5567ec928e20963d729350e6d674c4acb0c7a0.1578648530.git.viresh.kumar@linaro.org>
 <CAK8P3a1MLyP4ooyEDiBF1fE0BJGocgDmO1f5Qrvn_W5eqahz8g@mail.gmail.com>
 <20200113064156.lt3xxpzygattz3he@vireshk-i7>
 <CAK8P3a2u6s4MAM_9bOqSt5NwVc4XrXs9W36tp-7rWWTXx0+pRg@mail.gmail.com>
 <20200114092615.nvj6mkwkplub5ul7@vireshk-i7>
 <CAK8P3a0jXyJArzQFd+u68iRvXNnXb_oHbWF9-abvvFuqhpi-NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0jXyJArzQFd+u68iRvXNnXb_oHbWF9-abvvFuqhpi-NA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-20, 10:56, Arnd Bergmann wrote:
> My point was that you cannot mix __iomem accesses with pointer
> accesses. As I understood it, the current version uses a pointer to a

The current version is stupid as I misunderstood the whole __iomem
thing and just dropped it :)

> hardware mailbox with structured data, so you have to use ioremap()
> to get a token you can pass into ioread(), but (some of) the new
> transport types would just be backed by regular RAM, on which this
> is not a well-defined operation and you have to use memremap()
> and memcpy() instead.

Okay, I think I understand that a bit now. So here are the things
which I may need to do now:

- Maybe move payload to struct scmi_mailbox structure, as that is the
  transport dependent structure..

- Do ioremap, etc in mailbox.c only instead of driver.c

- Provide more ops in struct scmi_transport_ops to provide read/write
  helpers to the payload and implement the ones based on
  ioread/iowrite in mailbox.c ..

Am I thinking in the right direction now ?

-- 
viresh

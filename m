Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0415EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8A5222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPqGbneU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgBNHIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:08:20 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46881 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbgBNHIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:08:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id k29so4401811pfp.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 23:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AGX06V0phCEf3YxI6JhhSmkdlz6xxdUyRGvXJJa2qtk=;
        b=DPqGbneUvsI+L73crQQPQt3tO1yVSdblb0MK0/hIDrZu7FaKoMlyStVShLSSkm6T5k
         9L9ajw9a4toaKrSlNXBdqFhcXY/RiNclllkcDhd/+fToGTlHkmAyqbvoW6kXj96YR1aS
         lQNI9NTi5nPt/OJKPLutta7fNlMICVbaMmvBhcUNg0unNaFOOy7LxVll3f129vQSyND0
         EeAVt6TFIZhEzzQJGc6KMDaQKX38faWjH6e9egFKKLeJIo6pvn88s8tYglMwAWjKhsnj
         ILvUJlDqjVJPvCr4UB99mojZFnkacTgTYepJ8F99M3oVmK+oVFl6b6wHHyugUWnxH3wV
         j9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AGX06V0phCEf3YxI6JhhSmkdlz6xxdUyRGvXJJa2qtk=;
        b=UgPPct84KCq/0IgrdnM0h8MnD2itb0nBE/Jbr4uV7z79Q8SKRs8f8Cz2/+PwvFp0l3
         ZGtJXcM69cY9jm6u0GRmj3W5EVy4+cwIT+VjUvQhJIAegslArBMn6JzpGiY4ulQkMMPz
         5M/fDLmYDUIpBukPCvT3C/jJBMBQAQScTcRp6i8lQu39nZeCOq9r4MAXdSimJm42B0uc
         GtA2f9WvV6JhYsfh1f4qVVg4RrUr0xooj1//Vs5twPIwCfsDkv3C0W8PZ9/If9zN5pX6
         XZ22q1YZhGUjG5jjCjSX8O4pJ5peciSTGxXXbaeu8RNXkSb6scbs6OixylG2uRGehAn1
         +ijg==
X-Gm-Message-State: APjAAAXMqxc45eXW/y9OxACIbN3QVkDszXVawryVwMlaBAPhiqIk6nAN
        dPHXnN4tyBwLQwU1GaLCXYK5wCOEWA==
X-Google-Smtp-Source: APXvYqwbOYiZD4tRnUhjQRrN88TUVTLhi+HthhAkhvbXQeKHz37o+zyELfK5ulQd47hyXZva4v1mDg==
X-Received: by 2002:a65:5ac7:: with SMTP id d7mr1884648pgt.175.1581664098476;
        Thu, 13 Feb 2020 23:08:18 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:482:690f:50bb:adfb:86f:a4bf])
        by smtp.gmail.com with ESMTPSA id 17sm5670005pfv.142.2020.02.13.23.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 23:08:17 -0800 (PST)
Date:   Fri, 14 Feb 2020 12:38:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     David Miller <davem@davemloft.net>
Cc:     dcbw@redhat.com, kuba@kernel.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvalo@codeaurora.org
Subject: Re: [PATCH 0/2] Migrate QRTR Nameservice to Kernel
Message-ID: <20200214070811.GA5363@Mani-XPS-13-9360>
References: <20200213091427.13435-1-manivannan.sadhasivam@linaro.org>
 <34daecbeb05d31e30ef11574f873553290c29d16.camel@redhat.com>
 <20200213153007.GA26254@mani>
 <20200213.074755.849728173103010425.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213.074755.849728173103010425.davem@davemloft.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Kalle Valo

On Thu, Feb 13, 2020 at 07:47:55AM -0800, David Miller wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Date: Thu, 13 Feb 2020 21:00:08 +0530
> 
> > The primary motivation is to eliminate the need for installing and starting
> > a userspace tool for the basic WiFi usage. This will be critical for the
> > Qualcomm WLAN devices deployed in x86 laptops.
> 
> I can't even remember it ever being the case that wifi would come up without
> the help of a userspace component of some sort to initiate the scan and choose
> and AP to associate with.
> 
> And from that perspective your argument doesn't seem valid at all.

Kalle has some information to share.

Thanks,
Mani

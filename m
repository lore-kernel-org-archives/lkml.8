Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4E2C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4662E20842
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY4r6VIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgAQSqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:46:20 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40631 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQSqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:46:20 -0500
Received: by mail-yb1-f194.google.com with SMTP id l197so4940956ybf.7;
        Fri, 17 Jan 2020 10:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=upiGYbGt4/LTnrmjthjRUd/hQNqIVUczO1R2BQSLGfI=;
        b=KY4r6VIzM+ASfF28p395PqWwDWo1qH3UJln63Un1GQdKyFyhWH8Yvs1nf52LBQUL4B
         nya6HvXndacLywWJA4slAjzFivTcwN/ylU/gh3AAB4M8kQwh6bAwNsKB+4JtsYvtWEmu
         RNcjbn0mJhaPN2dbgu3PkxGB+LyvC83Gb+7s8iFl2Iwr1PMRr3eGwXFZM/BeGuCc5yCU
         tPbD040KWJF8qMy4pZbSJTMrPjvVnsPNP01XDzlHuWIWhSrGiMI20o4qx8E1Dha0AyzE
         3rtGf3ftTCv/qi7jJnaZBy7IIsu572sj+VOZFzfLd6RjvpHf8YrDdJGFa+vuNNaC/qaL
         jpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=upiGYbGt4/LTnrmjthjRUd/hQNqIVUczO1R2BQSLGfI=;
        b=KBn76O7WEJa0uu2D7sOxL7kkq9bg1SMae3IoQ62CzrK7hC8UxP0wGRBCdAKsebY97Q
         jc2P1IGFcygSLzRU/T/GZipIuKS2QC7b19/JZhopVPfi549dX45FZAaQ4EgbVvgRMVg8
         RhQIWkm4B+tHJlmv7HOTdjCMxrMEzCuuVGq47Yr7ZcqLg9ZdVygC3ISiOmW0rZa3HtvM
         YF4d1dvfwbGLNWicb4wS1EQVEgHNG8vv54/G/6uva/eQ3HqdPWSrQl4TsxDD1OUXKLRa
         LeQoJ5QYFlDgvFJV5v7uk8941ksmAKtxkN9q/ag1DLP2Go47icdZ9eHeX6gax730iqqQ
         pUhg==
X-Gm-Message-State: APjAAAWU3iiex96kxEMDTevIyuaUPPUSVa2M6owyvJHqrGxklV6EgaAL
        gYwFf+XN65dL2aI58WSIgyk=
X-Google-Smtp-Source: APXvYqy0w74WsHNKTpINtKaumk26VLINbUlvOmM74GHUgNWc16V11mp9TxxPQaMRVHX+cXOa3z69wQ==
X-Received: by 2002:a25:5887:: with SMTP id m129mr32550513ybb.172.1579286779295;
        Fri, 17 Jan 2020 10:46:19 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d186sm12100098ywe.0.2020.01.17.10.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Jan 2020 10:46:18 -0800 (PST)
Date:   Fri, 17 Jan 2020 10:46:17 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ondrej =?utf-8?Q?=C4=8Cerman?= <ocerman@sda1.eu>
Cc:     linux-hwmon@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH 0/4] hwmon: k10temp driver improvements
Message-ID: <20200117184617.GD13396@roeck-us.net>
References: <20200116141800.9828-1-linux@roeck-us.net>
 <e452614a-5425-e77c-4e2f-2a17ca733b7f@sda1.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e452614a-5425-e77c-4e2f-2a17ca733b7f@sda1.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 10:46:25AM +0100, Ondrej Čerman wrote:
> Dňa 16. 1. 2020 o 15:17 Guenter Roeck napísal(a):
> > This patch series implements various improvements for the k10temp driver.
> > 
> > Patch 1/4 introduces the use of bit operations.
> > 
> > Patch 2/4 converts the driver to use the devm_hwmon_device_register_with_info
> > API. This not only simplifies the code and reduces its size, it also
> > makes the code easier to maintain and enhance.
> > 
> > Patch 3/4 adds support for reporting Core Complex Die (CCD) temperatures
> > on Ryzen 3 (Zen2) CPUs.
> > 
> > Patch 4/4 adds support for reporting core and SoC current and voltage
> > information on Ryzen CPUs.
> > 
> > With all patches in place, output on Ryzen 3900 CPUs looks as follows
> > (with the system under load).
> > 
> > k10temp-pci-00c3
> > Adapter: PCI adapter
> > Vcore:        +1.36 V
> > Vsoc:         +1.18 V
> > Tdie:         +86.8°C  (high = +70.0°C)
> > Tctl:         +86.8°C
> > Tccd1:        +80.0°C
> > Tccd2:        +81.8°C
> > Icore:       +44.14 A
> > Isoc:        +13.83 A
> > 
> > The patch series has only been tested with Ryzen 3900 CPUs. Further test
> > coverage will be necessary before the changes can be applied to the Linux
> > kernel.
> > 
> Hello everyone, I am the author of https://github.com/ocerman/zenpower/ .
> 
> It is nice to see this merged.
> 
> I just want to warn you that there have been reported issues with
> Threadripper CPUs to zenpower issue tracker. Also I think that no-one tested
> EPYC CPUs.
> 
> Most of the stuff I was able to figure out by trial-and-error approach and
> unfortunately because I do not own any Threadripper CPU I was not able to
> test and fix reported problems.
> 
Thanks a lot for the note. The key problem seems to be that Threadripper
doesn't report SoC current and voltage. Is that correct ? If so, that
should be easy to solve.

On a side note, drivers/gpu/drm/amd/include/asic_reg/thm/thm_10_0_offset.h
suggests that two more temperature sensors might be available at 0x0005995C
and 0x00059960 (DIE3_TEMP and SW_TEMP). Have you ever tried that ?

Thanks,
Guenter

Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDF4C3F2D7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 07:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33463246AE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 07:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="J3ec1D4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgB2H6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 02:58:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36059 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgB2H6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 02:58:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id g83so3593685wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 23:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HzZ2Y2pm5PAEWlftw4cbKa1B9fAVv3XxEB+sUScIyQU=;
        b=J3ec1D4Dh8s6WwTbDVxjMrCpttT5gcDb3AczxjNcLjyB9nYLFgNxRSbLCyp7NC+SjS
         Re0J2C5+rDaGle4epklzU3BO4vYfpEDUrpjIGanDswHVIs9kgtnUGq8R8mOqAuEVqkm0
         lsycoNh/ZZNxuiBFI2efrld0DNnWfoH6UZ/3Zhj5bls8twEDV7IpiWm/j7Snj0enPERg
         b1eBAtZYQU+33zY4Umm0rXEZAJqUS4XVvuk4362r+EMDJaKyJmSwj1IHZfh4nEI9HYEh
         1fDcuR3tOk57vgrrs9AGZM6tlsGH7VCOuubGQtBtZFOwFYn0fF/lqBIXuE7F1OlivcxA
         t+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HzZ2Y2pm5PAEWlftw4cbKa1B9fAVv3XxEB+sUScIyQU=;
        b=ag7wxfVgyTCQfBY9QZEJlBRgrSH7o5lmGJxpJMEmvhbWrLLmce9tFE1FhVhGLlvZHW
         VTgDLGNvcsdaufUoKGJ638lCtEHyR7BuwYLFjmQlfjHV5kP4NyRmB+B1EcAjHNSUCiLP
         2xLXVBc94GzNsfOVQRJCvLyG0vU4pYjVwAgpkAIZEmseCENsZpg6KitEm6viGHA2fwLf
         +TPMKvlk0RN7Flzt/rukcjHlFgqDK2F38I2viWySlwQ4R5EAEXwC+kZcRSiBnc5LpKTb
         VG4T5ON7JHUY2+9G68zUWqXD4f/Di7RFIst1/FS1rme6j+N5/TMaRM2LpqH2nvvOcf+f
         AL8Q==
X-Gm-Message-State: APjAAAWKPnfa2UrcFa4zGp8ssEUVPcrHGH7kMPOAh34PdUA8Jg8dyV11
        udfmk5QlEkyYbiJjovuZc+IH0vUF7BQ=
X-Google-Smtp-Source: APXvYqzqdPE6cWTVf4TU7uVvi13E2ChyBt2wLYWvgsiLNwFlXpUu+4JQlLjblRNYhJe6noEjSQH/ZQ==
X-Received: by 2002:a1c:df45:: with SMTP id w66mr8863382wmg.171.1582963085760;
        Fri, 28 Feb 2020 23:58:05 -0800 (PST)
Received: from localhost (ip-89-177-130-96.net.upcbroadband.cz. [89.177.130.96])
        by smtp.gmail.com with ESMTPSA id o15sm16577930wra.83.2020.02.28.23.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 23:58:04 -0800 (PST)
Date:   Sat, 29 Feb 2020 08:58:02 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Serhiy Boiko <serhiy.boiko@plvision.eu>,
        Andrii Savka <andrii.savka@plvision.eu>,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>
Subject: Re: [RFC net-next 2/3] net: marvell: prestera: Add PCI interface
 support
Message-ID: <20200229075802.GO26061@nanopsycho>
References: <20200225163025.9430-1-vadym.kochan@plvision.eu>
 <20200225163025.9430-3-vadym.kochan@plvision.eu>
 <20200227110507.GE26061@nanopsycho>
 <20200228165429.GB8409@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228165429.GB8409@plvision.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 28, 2020 at 05:54:32PM CET, vadym.kochan@plvision.eu wrote:
>Hi Jiri,
>
>On Thu, Feb 27, 2020 at 12:05:07PM +0100, Jiri Pirko wrote:
>> Tue, Feb 25, 2020 at 05:30:55PM CET, vadym.kochan@plvision.eu wrote:
>> >Add PCI interface driver for Prestera Switch ASICs family devices, which
>> >provides:
>> >
>
>[SNIP]
>
>> >+
>> >+module_init(mvsw_pr_pci_init);
>> >+module_exit(mvsw_pr_pci_exit);
>> >+
>> >+MODULE_AUTHOR("Marvell Semi.");
>> 
>> Again, wrong author.
>> 
>
>PLVision developing the driver for Marvell and upstreaming it on behalf
>of Marvell. This is a long term cooperation that aim to expose Marvell
>devices to the Linux community.

Okay. If you grep the code, most of the time, the MODULE_AUTHOR is a
person. That was my point:
/*
 * Author(s), use "Name <email>" or just "Name", for multiple
 * authors use multiple MODULE_AUTHOR() statements/lines.
 */
#define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)

But I see that for example "Intel" uses the company name too. So I guess
it is fine.


>
>[SNIP]
>
>Regards,
>Vadym Kochan

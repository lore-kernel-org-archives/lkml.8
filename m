Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7E6C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3272075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="OKOV+7nD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgAPN4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:56:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54036 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgAPN4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:56:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id m24so3854060wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 05:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TPojsvsruBFkmh5R4Sn2XZhT/gn9UgC49vEV8/Pvqyk=;
        b=OKOV+7nDclQZcHlC42CU/LwNwZwIwaXsbY5Un7nFvh6eGOkX4phM36EChliLcKVD78
         3hZCLEMgeB6A+6mU+WlVGCP6e3kXGZCvznaigQX+XGe/Ar/QCe5gid+xLUEFNmB+GfPz
         nkd5V/dyKioDUmxgIiOuVC7iuSR9uewOUbA9EX3vwS0mATL094PH2NuOJ/KNIKeqXhHm
         pBLlgB1S+yYTrAfbi+piEsik/kr42AUV3VDiAU9H8RcrdnZnTop5qP567HNrIOAMWn8g
         QKnQWkuAZ/eaA1CEQYj1iIBZmI8cLbhqr+95teO2IfHUugB3KFB3qSalGCpWTGUWl6cD
         YjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TPojsvsruBFkmh5R4Sn2XZhT/gn9UgC49vEV8/Pvqyk=;
        b=kHI18sMrTJ6cPkKmbLte8SXL7OqJWAdjUm5mLnsGINc9pys75fCx2io4gWbah2cUaG
         dHpx3tJ44Ygab+7GF0KAkw3rqNQMKlLOKMoU1WCpjWghDWSd/L8c+BqRH9ZVbOAUIROP
         kNhMoNoeNE+2YhOkqtOijR9wOB3E+UvFk2rDfLEWnqT4l0yjNdhbZU5wgULQf9KzUAFt
         ywVD9DX6fXLlCCb3jDPzSxvWcG1H1VqwRGX5R2+4vAFBHSC9zv6JmgwYHytwArySlJrh
         4akrF+NhckOryUt0vFxNlffkGqzHZrI7k85DO6M3NbCcNWlk2ihELEAYVzQ+bnz11wFq
         UPvA==
X-Gm-Message-State: APjAAAWuIGkJlAD0LEx665pxeVpr90EBcjFlqg+OEswIyMdo565StDW9
        M2XT1TJuU58NWM75tBxvgATX3Q==
X-Google-Smtp-Source: APXvYqwoKtV8ypKcPYIpChsk/BEL1BfpInAw53YPmsQP5BcLMFZJCiv9X66zQ81XYiGvcUMyZqXw4g==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr6345016wma.24.1579183012065;
        Thu, 16 Jan 2020 05:56:52 -0800 (PST)
Received: from localhost (ip-78-102-249-43.net.upcbroadband.cz. [78.102.249.43])
        by smtp.gmail.com with ESMTPSA id 60sm30094751wrn.86.2020.01.16.05.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:56:51 -0800 (PST)
Date:   Thu, 16 Jan 2020 14:56:50 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Hongbo Yao <yaohongbo@huawei.com>, chenzhou10@huawei.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mlxsw@mellanox.com
Subject: Re: [PATCH v2 -next] drivers/net: netdevsim depends on INET
Message-ID: <20200116135412.GK2131@nanopsycho>
References: <20200116131404.169423-1-yaohongbo@huawei.com>
 <20200116053137.4b9f9ff9@cakuba.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116053137.4b9f9ff9@cakuba.hsd1.ca.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jan 16, 2020 at 02:31:37PM CET, kuba@kernel.org wrote:
>On Thu, 16 Jan 2020 21:14:04 +0800, Hongbo Yao wrote:
>> If CONFIG_INET is not set and CONFIG_NETDEVSIM=y.
>> Building drivers/net/netdevsim/fib.o will get the following error:
>> 
>> drivers/net/netdevsim/fib.o: In function `nsim_fib4_rt_hw_flags_set':
>> fib.c:(.text+0x12b): undefined reference to `fib_alias_hw_flags_set'
>> drivers/net/netdevsim/fib.o: In function `nsim_fib4_rt_destroy':
>> fib.c:(.text+0xb11): undefined reference to `free_fib_info'
>> 
>> Correct the Kconfig for netdevsim.
>> 
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 48bb9eb47b270("netdevsim: fib: Add dummy implementation for FIB offload")
>
>Looks better :) Still missing a space between the hash and the bracket,
>but:
>
>Acked-by: Jakub Kicinski <kuba@kernel.org>
>
>While at it - does mlxsw have the same problem by any chance?

Looks like it does.

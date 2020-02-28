Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D472C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F67246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="YbN8++Ol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgB1K70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:59:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36241 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1K7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:59:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id g83so512159wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 02:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WQt5CEsDoqa73SqPlFVREQJxNbkoOouU7Almh2gXCJM=;
        b=YbN8++Ol6KY6pUCyDuFWXnVNQ3KTse5GY3KEBvYuTUbZhs7mV8fjLUS9CnP7sPOfZG
         6L/rlK2bjP78AluzYSJGYO6MIt1FvCF9l++Pj/TJqzWoE2vjlbANw8InP2/UwqUqHnfk
         wDKtu1uwAYoIBOuTsipmbj2Sfgkey73OYteMq2v0eWu6pBKvaYhDkL0Pt/B/sRqwtgcQ
         ev+q294LcpHpFZVaapEpj7l5jiPzgkyZ5B2CBX7UTLmwa6afP6o5VSOIKgZ//4tDomKm
         N/N1/+FA3j6ABorW9zXYHAfTbQhQ4OABKQSKbasFfZHZP2ePRgFyhjXaFiFwTlZJ5+Ny
         rymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WQt5CEsDoqa73SqPlFVREQJxNbkoOouU7Almh2gXCJM=;
        b=Kcl5xvaQvTQZFAnt3QGNd1uBoYTVvzgiqAS/tDYY6rs8wXoUJc5v3dRvfC3/nsFHPC
         raeSor4uMW8hAuGGpRvenH5U0O52RwnxE6cyUXFKfZ2t871X7KoXfIuPqMd/HxGLpF0A
         79Uk5k7N4v84MQw92APzRt9NRgnHGjeQjaW3czpBDtuW85yiJCsyR0M8k+ZaprU8lDqy
         kT7UMYQFX2vL5QZGovXOgcpFRlMDO6c1N1gYJkoj6BWL4EYPzLtahkY48958F3xHApjc
         fZaH2Q4TQ03qX4igX5OKwdXGIdduOeaBizZDL5xEIZje9jMTG8gnVRatNkSzXkcfXJys
         FUIQ==
X-Gm-Message-State: APjAAAXQqvkNvO/my6J7B89TGckRhYMPQtCWWE4BP1rOp91FLS+b/Aaw
        WctqXPzCuFxy2Ci8j12vlC3dOZhKGxE=
X-Google-Smtp-Source: APXvYqw9H1lGe++Du754YTZBTiqsONFQz0BbdoQCDCFiTWRt7y78q2BJuyLNLtbB4PG6TWcL4JaNrg==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr4212217wml.173.1582887563093;
        Fri, 28 Feb 2020 02:59:23 -0800 (PST)
Received: from localhost (ip-89-177-130-96.net.upcbroadband.cz. [89.177.130.96])
        by smtp.gmail.com with ESMTPSA id j15sm12361709wrp.9.2020.02.28.02.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 02:59:22 -0800 (PST)
Date:   Fri, 28 Feb 2020 11:59:21 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Serhiy Boiko <serhiy.boiko@plvision.eu>,
        Andrii Savka <andrii.savka@plvision.eu>,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>
Subject: Re: [RFC net-next 1/3] net: marvell: prestera: Add Switchdev driver
 for Prestera family ASIC device 98DX325x (AC3x)
Message-ID: <20200228105921.GJ26061@nanopsycho>
References: <20200225163025.9430-1-vadym.kochan@plvision.eu>
 <20200225163025.9430-2-vadym.kochan@plvision.eu>
 <20200226155423.GC26061@nanopsycho>
 <20200227213150.GA9372@plvision.eu>
 <20200228063451.GH26061@nanopsycho>
 <20200228094446.GA2663@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228094446.GA2663@plvision.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 28, 2020 at 10:44:53AM CET, vadym.kochan@plvision.eu wrote:
>Hi Jiri,
>
>On Fri, Feb 28, 2020 at 07:34:51AM +0100, Jiri Pirko wrote:
>> Thu, Feb 27, 2020 at 10:32:00PM CET, vadym.kochan@plvision.eu wrote:
>> >Hi Jiri,
>> >
>> >On Wed, Feb 26, 2020 at 04:54:23PM +0100, Jiri Pirko wrote:
>> >> Tue, Feb 25, 2020 at 05:30:54PM CET, vadym.kochan@plvision.eu wrote:
>> >> >Marvell Prestera 98DX326x integrates up to 24 ports of 1GbE with 8
>> >> >ports of 10GbE uplinks or 2 ports of 40Gbps stacking for a largely
>> >> >wireless SMB deployment.
>> >> >
>> >> >This driver implementation includes only L1 & basic L2 support.
>> >> >
>> >> >The core Prestera switching logic is implemented in prestera.c, there is
>> >> >an intermediate hw layer between core logic and firmware. It is
>> >> >implemented in prestera_hw.c, the purpose of it is to encapsulate hw
>> >> >related logic, in future there is a plan to support more devices with
>> >> >different HW related configurations.
>> >> >
>> >> >The following Switchdev features are supported:
>> >> >
>> >> >    - VLAN-aware bridge offloading
>> >> >    - VLAN-unaware bridge offloading
>> >> >    - FDB offloading (learning, ageing)
>> >> >    - Switchport configuration
>> >> >
>> >> >Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
>> >> >Signed-off-by: Andrii Savka <andrii.savka@plvision.eu>
>> >> >Signed-off-by: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
>> >> >Signed-off-by: Serhiy Boiko <serhiy.boiko@plvision.eu>
>> >> >Signed-off-by: Serhiy Pshyk <serhiy.pshyk@plvision.eu>
>> >> >Signed-off-by: Taras Chornyi <taras.chornyi@plvision.eu>
>> >> >Signed-off-by: Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>
>> >> >---
>
>[SNIP]
>
>> >> >+#include <linux/kernel.h>
>> >> >+#include <linux/module.h>
>> >> >+#include <linux/list.h>
>> >> >+#include <linux/netdevice.h>
>> >> >+#include <linux/netdev_features.h>
>> >> >+#include <linux/etherdevice.h>
>> >> >+#include <linux/ethtool.h>
>> >> >+#include <linux/jiffies.h>
>> >> >+#include <net/switchdev.h>
>> >> >+
>> >> >+#include "prestera.h"
>> >> >+#include "prestera_hw.h"
>> >> >+#include "prestera_drv_ver.h"
>> >> >+
>> >> >+#define MVSW_PR_MTU_DEFAULT 1536
>> >> >+
>> >> >+#define PORT_STATS_CACHE_TIMEOUT_MS	(msecs_to_jiffies(1000))
>> >> >+#define PORT_STATS_CNT	(sizeof(struct mvsw_pr_port_stats) / sizeof(u64))
>> >> 
>> >> Keep the prefix for all defines withing the file. "PORT_STATS_CNT"
>> >> looks way to generic on the first look.
>> >> 
>> >> 
>> >> >+#define PORT_STATS_IDX(name) \
>> >> >+	(offsetof(struct mvsw_pr_port_stats, name) / sizeof(u64))
>> >> >+#define PORT_STATS_FIELD(name)	\
>> >> >+	[PORT_STATS_IDX(name)] = __stringify(name)
>> >> >+
>> >> >+static struct list_head switches_registered;
>> >> >+
>> >> >+static const char mvsw_driver_kind[] = "prestera_sw";
>> >> 
>> >> Please be consistent. Make your prefixes, name, filenames the same.
>> >> For example:
>> >> prestera_driver_kind[] = "prestera";
>> >> 
>> >> Applied to the whole code.
>> >> 
>> >So you suggested to use prestera_ as a prefix, I dont see a problem
>> >with that, but why not mvsw_pr_ ? So it has the vendor, device name parts
>> 
>> Because of "sw" in the name. You have the directory named "prestera",
>> the modules are named "prestera_*", for the consistency sake the
>> prefixes should be "prestera_". "mvsw_" looks totally unrelated.
>> 
>> 
>
>I understand. If possible I'd like to get rid of long prefix which is if
>to use prestera_xxx. I looked at mlxsw prefix format, and it looks for

mlxsw is a bad example for naming :) We did went along with existing
drivers mlx4 and mlx5. The device name was "SwitchX-2".
In your case, you have nice name of the device, just use it :)


>me that mvpr_ may be OK in this case ? Also it will make funcs/types

"prestera_" would be my first choice. I don't see why to mangle vendor
name into the prefix. Also, you have to count with a possibility that in
the future, this devices will no longer be "Marvell" (if sold). This
happens all the time :)



>name shorter which makes code read easier.
>
>[SNIP]
>
>> >
>> >Regards,
>> >Vadym Kochan
>
>I am sorry that this naming issue took more discussion than should, I
>just want to define it once an never change it, (it is a bit pain to
>rename the whole code with new naming convention :) ).

Sure.


>
>Regards,
>Vadym Kochan

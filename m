Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A745C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F1920787
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgC0DLY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:11:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34851 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgC0DLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:11:23 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jHfOz-0004aP-QZ
        for linux-kernel@vger.kernel.org; Fri, 27 Mar 2020 03:11:22 +0000
Received: by mail-pg1-f200.google.com with SMTP id m25so6748618pgl.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 20:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vcPbgKJFNBF/8OZqL1JZORYE0AqNLU0C16CcoGlMb4U=;
        b=mtVLT8RJT6TBn36CDMIn1mMC/2D1JOWOst+IOLBzjEmAbIMhChjhLo1UQoueH1AjcN
         /G+v8qzOHrw/0sVsNf6nQoevjK1i6YhKBiukVu9WG2WCSyBC9W08x9R14Sy7yhXbTG+s
         iIw5eYZ/01lJshUcQGL2na41dfLgcEtjAJ20a3UMpQGCl3PEhg6i+6wcSj7i3Y6uIY6O
         IVVYzzWUkfsnxTuGOSALibK+FlPztqfEjCoNqNE2vq1jL+KVH8BWpGyhNzwm81jUjRo2
         mMBZS1/3YNyqGWwwn702CZR1rXkUDV4ZEemby/KL0+vxPr80GnEI1dwI2VguM4+KQwRc
         tMyQ==
X-Gm-Message-State: ANhLgQ1X1U/nx/gsh+9rkzUcUHOObp6RE8bA6a82OS0CBiPHGcBOSl8v
        y5dfUYvUalAnZeCfcsiiNmL8iCSsT5r33CXxtpLxPLqvdJN/hflyQe/npJGbxdLxXrzmtYKKBXA
        i+lDoXt31lrSNohHuQJY1On6pIiADKx6qpx3BRetcBw==
X-Received: by 2002:a17:902:8ec1:: with SMTP id x1mr11368398plo.325.1585278680453;
        Thu, 26 Mar 2020 20:11:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs4op9fy3xKomc3EgFRFOTZcnMtRNhP4jpF/07IDEBFVOd2yoJDw5eP5W8jTaXlCj6OKkxZIw==
X-Received: by 2002:a17:902:8ec1:: with SMTP id x1mr11368367plo.325.1585278680067;
        Thu, 26 Mar 2020 20:11:20 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 11sm2844685pfz.91.2020.03.26.20.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 20:11:19 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] ethtool: Report speed and duplex as unknown when device
 is runtime suspended
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <d6c5a1c4-e41f-d239-e0b0-15eba3e78274@gmail.com>
Date:   Fri, 27 Mar 2020 11:11:16 +0800
Cc:     "David S. Miller" <davem@davemloft.net>, kuba@kernel.org,
        alexander.duyck@gmail.com,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Andrew Lunn <andrew@lunn.ch>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <84A954EF-4DF6-4F1C-88CE-9B4C0D1ACE5B@canonical.com>
References: <20200327024552.22170-1-kai.heng.feng@canonical.com>
 <d6c5a1c4-e41f-d239-e0b0-15eba3e78274@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 27, 2020, at 10:56, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> 
> 
> On 3/26/2020 7:45 PM, Kai-Heng Feng wrote:
>> Device like igb gets runtime suspended when there's no link partner. We
>> can't get correct speed under that state:
>> $ cat /sys/class/net/enp3s0/speed
>> 1000
>> 
>> In addition to that, an error can also be spotted in dmesg:
>> [  385.991957] igb 0000:03:00.0 enp3s0: PCIe link lost
>> 
>> Since device can only be runtime suspended when there's no link partner,
>> we can directly report the speed and duplex as unknown.
>> 
>> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>> Cc: Aaron Brown <aaron.f.brown@intel.com>
>> Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> I would push this to the responsibility of the various drivers instead
> of making this part of the standard ethtool implementation.

My original approach [1] is to ask device to runtime resume before calling __ethtool_get_link_ksettings().
Unfortunately it will cause a deadlock if the runtime resume routine wants to hold rtnl_lock.

However, it should be totally fine (and sometimes necessary) to be able to hold rtnl_lock in runtime resume routine as Alexander explained [2].
As suggested, this patch handles the situation directly in __ethtool_get_link_ksettings().

[1] https://lore.kernel.org/lkml/20200207101005.4454-2-kai.heng.feng@canonical.com/
[2] https://lkml.org/lkml/2020/3/26/989

Kai-Heng

> -- 
> Florian


Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EFDC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB892084D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgDUEuW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 00:50:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36597 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgDUEuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 00:50:21 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jQkrS-0005jV-HD
        for linux-kernel@vger.kernel.org; Tue, 21 Apr 2020 04:50:18 +0000
Received: by mail-pf1-f200.google.com with SMTP id a5so12152105pfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 21:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iS1UqusYi3xL6rontdMWpTi7+P7gRt1tPUDk5laBrGI=;
        b=XLqHg8paK9hGyreGx00xNeWeTKkk0Z2KF9k7sne8gp2OEaOhy8s2bfZSk+VY/4UFDn
         95tSz2m6kgnFby20F+MULohgMv1u6Kmm0YVXR2uxf+JbNZGB8QxcpTbT68NLv/b2wrcp
         4GOnIqD46yN4lgD1f67dBisAd2NYuP7GWFAuSnaEmHxsXrXq4NTbXJoLkmosbu2/4uki
         1qtK/xyWmzb+ZKdaFuCp445R+vLGkJpTBbKZzEQunLTUBdwWduYkVG5dh38feFkriJiC
         oDCu6F4e51ieg61Hs5fbWUV0A+/vR87UeokNEE+kk0woQYg/CYw1oyLgCmiUkztHEQK2
         WzOQ==
X-Gm-Message-State: AGi0PuZ951bW/6qR19ZcvtN7eY6ySXURMx84rY3MeO+nBwl4xRnGnvtm
        ka16o35HipQKs3QX0zUYOgNcNd+VT7R3J83LaKZ7gOBaysQLcsNWiAhUfVjIimbHhnnyQ+SNHRj
        JGgbkDrg1WoU2lirxYB+ol2y3KF8pbfW/V0kTy99XCA==
X-Received: by 2002:a17:90a:f0d0:: with SMTP id fa16mr3510960pjb.33.1587444616958;
        Mon, 20 Apr 2020 21:50:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypKfsgLW5biYAE7aJIxYYYswHrd1wjHYn1DgSe813w7otCrIz5NawzqPd2rFsLGlvqqwbtuFfg==
X-Received: by 2002:a17:90a:f0d0:: with SMTP id fa16mr3510934pjb.33.1587444616480;
        Mon, 20 Apr 2020 21:50:16 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id o1sm1007174pjs.39.2020.04.20.21.50.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 21:50:15 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [Intel-wired-lan] [PATCH 1/1] e1000e: Disable s0ix flow for X1
 Carbon 7th
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <DM6PR11MB2890E32FBCE91DF33D252087BCD40@DM6PR11MB2890.namprd11.prod.outlook.com>
Date:   Tue, 21 Apr 2020 12:50:12 +0800
Cc:     "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B58AFDD4-7153-40A0-88E0-5490EF2919A2@canonical.com>
References: <20200319052629.7282-1-kai.heng.feng@canonical.com>
 <DM6PR11MB2890E32FBCE91DF33D252087BCD40@DM6PR11MB2890.namprd11.prod.outlook.com>
To:     "Brown, Aaron F" <aaron.f.brown@intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Apr 21, 2020, at 04:27, Brown, Aaron F <aaron.f.brown@intel.com> wrote:
> 
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Kai-
>> Heng Feng
>> Sent: Wednesday, March 18, 2020 10:26 PM
>> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
>> Cc: open list:NETWORKING DRIVERS <netdev@vger.kernel.org>; Kai-Heng Feng
>> <kai.heng.feng@canonical.com>; moderated list:INTEL ETHERNET DRIVERS
>> <intel-wired-lan@lists.osuosl.org>; David S. Miller <davem@davemloft.net>;
>> open list <linux-kernel@vger.kernel.org>
>> Subject: [Intel-wired-lan] [PATCH 1/1] e1000e: Disable s0ix flow for X1 Carbon
>> 7th
>> 
>> The s0ix flow makes X1 Carbon 7th can only run S2Idle for only once.
>> 
>> Temporarily disable it until Intel found a solution.
>> 
>> Link: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-
>> 20200316/019222.html
>> BugLink: https://bugs.launchpad.net/bugs/1865570
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/net/ethernet/intel/e1000e/netdev.c | 16 ++++++++++++++--
>> 1 file changed, 14 insertions(+), 2 deletions(-)
> 
> I do not have access to the "X1 Carbon 7th" this patch targets, but from a regression perspective against a number of other e1000e based parts:

This patch can be superseded by "e1000e: bump up timeout to wait when ME un-configure ULP mode". 
So it's better to drop this patch in favor of a more generic solution.

Kai-Heng

> Tested-by: Aaron Brown <aaron.f.brown@intel.com>


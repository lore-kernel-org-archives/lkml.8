Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06445C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 06:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85E7206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 06:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgCYGkA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 02:40:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44461 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYGj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 02:39:59 -0400
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jGzhk-0007W1-Nh
        for linux-kernel@vger.kernel.org; Wed, 25 Mar 2020 06:39:56 +0000
Received: by mail-pj1-f69.google.com with SMTP id q10so907177pja.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 23:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iWtwzKqHnxSyWlleZtW4ct9mSZDNGZzNr3hrg6PDj8Y=;
        b=GZXCNcs84IHPueszL082GsYiVnCLrpqye9Gwu+qCfgMJ/U3qGG5eQ7hJCefP96eqxm
         B0+blozJ+JxpGTr5QGMC+Iqvpw4r2E1oQ1BOCVkHwGRelmX37L9tJKVYR82fvyGx3Eoh
         RuBx/NpHrw+9F8beesm+I+xV35Hu/0Qj+4o4+xOZfUxHeLJyEmTbnWpM5p6TC6t1prF6
         F8H9V+TIA94kufuOmqlf8rGouT3IRrRma/Tr/QeO6hfnqFEAnIs8fs84MYKbhZBt8L2A
         HVgqbIOZmTDd8tH8b8LDnbUrKcPHfMvPouN9jSVDVCz/hZeU7x9dMJ6js8bqS1JLYn4s
         apiA==
X-Gm-Message-State: ANhLgQ13bDMLtyDILMrXMC12PAuWB2EdNCGaZ+lhxRLJhkc50oZ3zskQ
        NiHFrfGJwbup+MMln+sV8mM1dXUx7Uo4VNXyVNG+XM6dQ/RzP9SAp1Waxo5ryC49wxVevL41mXe
        Qrz9F0G2meS6kVuPUZkM3cmE5UbdOeKi1oPPRRESBHQ==
X-Received: by 2002:a17:90b:3653:: with SMTP id nh19mr149400pjb.154.1585118395361;
        Tue, 24 Mar 2020 23:39:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtDCyUBDVvdOTPlz+d8xy5xLrtQ01jfAkPuGHdyrUmuN5as73UJTMJivR3g7I3qrCzNEoprkQ==
X-Received: by 2002:a17:90b:3653:: with SMTP id nh19mr149376pjb.154.1585118394965;
        Tue, 24 Mar 2020 23:39:54 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id e126sm17474185pfa.122.2020.03.24.23.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 23:39:54 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] e1000e: bump up timeout to wait when ME un-configure ULP
 mode
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <2c765c59-556e-266b-4d0d-a4602db94476@intel.com>
Date:   Wed, 25 Mar 2020 14:39:51 +0800
Cc:     Aaron Ma <aaron.ma@canonical.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        David Miller <davem@davemloft.net>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Lifshits, Vitaly" <vitaly.lifshits@intel.com>, rex.tsai@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <206441A5-70CF-4F34-93B2-90F4A846BF4E@canonical.com>
References: <20200323191639.48826-1-aaron.ma@canonical.com>
 <EC4F7F0B-90F8-4325-B170-84C65D8BBBB8@canonical.com>
 <2c765c59-556e-266b-4d0d-a4602db94476@intel.com>
To:     "Neftin, Sasha" <sasha.neftin@intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

> On Mar 25, 2020, at 14:36, Neftin, Sasha <sasha.neftin@intel.com> wrote:
> 
> On 3/25/2020 06:17, Kai-Heng Feng wrote:
>> Hi Aaron,
>>> On Mar 24, 2020, at 03:16, Aaron Ma <aaron.ma@canonical.com> wrote:
>>> 
>>> ME takes 2+ seconds to un-configure ULP mode done after resume
>>> from s2idle on some ThinkPad laptops.
>>> Without enough wait, reset and re-init will fail with error.
>> Thanks, this patch solves the issue. We can drop the DMI quirk in favor of this patch.
>>> 
>>> Fixes: f15bb6dde738cc8fa0 ("e1000e: Add support for S0ix")
>>> BugLink: https://bugs.launchpad.net/bugs/1865570
>>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>>> ---
>>> drivers/net/ethernet/intel/e1000e/ich8lan.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>> index b4135c50e905..147b15a2f8b3 100644
>>> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>> @@ -1240,9 +1240,9 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
>>> 			ew32(H2ME, mac_reg);
>>> 		}
>>> 
>>> -		/* Poll up to 300msec for ME to clear ULP_CFG_DONE. */
>>> +		/* Poll up to 2.5sec for ME to clear ULP_CFG_DONE. */
>>> 		while (er32(FWSM) & E1000_FWSM_ULP_CFG_DONE) {
>>> -			if (i++ == 30) {
>>> +			if (i++ == 250) {
>>> 				ret_val = -E1000_ERR_PHY;
>>> 				goto out;
>>> 			}
>> The return value was not caught by the caller, so the error ends up unnoticed.
>> Maybe let the caller check the return value of e1000_disable_ulp_lpt_lp()?
>> Kai-Heng
> Hello Kai-Heng and Aaron,
> I a bit confused. In our previous conversation you told ME not running.

Yes I can confirm Intel AMT is disabled BIOS menu. I think Intel AMT is ME in this context?

How do I check if it's really disabled under Linux?

Kai-Heng

> let me shimming in. Increasing delay won't be solve the problem and just mask it. We need to understand why ME take too much time. What is problem with this specific system?
> So, basically no ME system should works for you.
> 
> Meanwhile I prefer keep DMI quirk.
> Thanks,
> Sasha
>>> -- 
>>> 2.17.1


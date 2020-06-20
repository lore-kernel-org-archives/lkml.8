Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9F8C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 17:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4630A23F38
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 17:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="1/qa6n46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgFTRsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 13:48:52 -0400
Received: from vps01.wiesinger.com ([46.36.37.179]:55908 "EHLO
        vps01.wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgFTRsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 13:48:51 -0400
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jun 2020 13:48:50 EDT
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
        by vps01.wiesinger.com (Postfix) with ESMTPS id 926C89F354;
        Sat, 20 Jun 2020 19:39:34 +0200 (CEST)
Received: from [192.168.32.150] (bgld-ip-150.intern [192.168.32.150])
        (authenticated bits=0)
        by wiesinger.com (8.15.2/8.15.2) with ESMTPSA id 05KHdWgB3943637
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 20 Jun 2020 19:39:33 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 05KHdWgB3943637
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
        s=default; t=1592674773;
        bh=zRIYqPWh3tap6pOFRwtw5nCeOhiwLSysRXfYdbvWm3M=;
        h=From:Subject:To:Date:From;
        b=1/qa6n46fj/cbAfPrPEPQntw53/jgwFRKm0ZEHVM8Lj8myrzQZciG3K0JueDUrFPz
         aF82tU+JcunzWnYNBrR8G5RnxeItq2gP72rwZGgyA8B4r/HHdvWaxfAI+tQDAPn128
         /IUBGHdZSWgEf6lga+pMjV2NKxCV9i0QdxaYisbyklfWVHJKmcl2q+NbyUXf1IJkms
         jMnWnzb35vuq35ddi3ymEi6lgFl6wTnX3uhEw6v35hvV6fXIXRMsA+0O+MNdEvYoHl
         fp8b+iWsdEnrUjoSfCuFnVA1YNvuWMg8zkyidtQf+cy2sJzvlbeQ5dYQ8T3JiED1PQ
         vXEJjd+7g8pgXjjtzERGaVbdnsRd7E+B2hnJYIwtcmvi9JL9zjlpwSaDx8oTMEeycD
         5+00dFXEgRf+jA/GjSfpJNPcnbwfQM3G9Gt9/F6ax5eEFvp6qtcDRRh4CjmiHE/qF7
         Fq9LDPQM6sWAJgGEUXtqtImB4PJiT3ELJME4JmhF38kUTlJ8TH/+atIeBLcjXAwOOB
         n2Ik9pL53b2ZB2yo77GvEAsl324KfoQRw5IBEQqgEreeh+N112WeYJ798ZPGaGkZVz
         ugzXNBYSBLy5ke/aTwvyGYtVUg7aexf/dfXmpHqyj5UhHg0TBAE963pXBlE+nofmkf
         GBoDCsLxdBLUmTGoW4PUuP3k=
From:   Gerhard Wiesinger <lists@wiesinger.com>
Subject: Banana Pi-R1 - kernel 5.6.0 and later broken - b43 DSA
To:     arm@lists.fedoraproject.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, filbar@centrum.cz
Message-ID: <912a58ac-6f81-ba22-c79e-f2bf902dae2e@wiesinger.com>
Date:   Sat, 20 Jun 2020 19:39:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having troubles with the Banana Pi-R1 router with newer kernels. No 
config changes, config works well since a lot of lernel updates ...
Banana Pi-R1 is configured via systemd-networkd and uses the DSA 
(Distributed Switch Architecture) with b53 switch. No visible difference 
in interfaces, vlan config, bridge config, etc. Looks like actual 
configuration in the switch in the hardware is broken.

# OK: Last good known version (booting that version is also ok)
Linux bpi 5.5.18-200.fc31.armv7hl #1 SMP Fri Apr 17 17:25:00 UTC 2020 
armv7l armv7l armv7l GNU/Linux

# NOK: no network
Linux bpi 5.6.8-200.fc31.armv7hl #1 SMP Wed Apr 29 19:05:06 UTC 2020 
armv7l armv7l armv7l GNU/Linux

# NOK: no network
Linux bpi 5.6.0-300.fc32.armv7hl #1 SMP Mon Mar 30 16:37:50 UTC 2020 
armv7l armv7l armv7l GNU/Linux

# NOK: no network
Linux bpi 5.6.19-200.fc31.armv7hl #1 SMP Wed Jun 17 17:10:22 UTC 2020 
armv7l armv7l armv7l GNU/Linux

# NOK: no network
Linux bpi 5.7.4-200.fc32.armv7hl #1 SMP Fri Jun 19 00:52:22 UTC 2020 
armv7l armv7l armv7l GNU/Linux


Saw that there were a lot of changes in the near past in the b53 driver:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/net/dsa/b53?h=v5.8-rc1+


Any ideas?

Thnx.

Ciao,
Gerhard


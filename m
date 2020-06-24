Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF994C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38C92082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406271AbgFXTzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:55:02 -0400
Received: from mta-out1.inet.fi ([62.71.2.226]:55532 "EHLO julia1.inet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406135AbgFXTzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:55:01 -0400
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrudekjedgudefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfenuceurghilhhouhhtmecufedttdenucenucfjughrpefvhffukffffgggtgfgsehtkeertddtfeejnecuhfhrohhmpefklhhkkhgrucfrrhhushhiuceoihhlkhhkrgdrphhruhhsihesphhprdhinhgvthdrfhhiqeenucggtffrrghtthgvrhhnpefhiefgheeufeetudeugfeugfevfffhgfeuieeiffffjedvieejtdeuhfeiudevtdenucfkphepkeegrddvhedurdduleegrdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdehngdpihhnvghtpeekgedrvdehuddrudelgedrudeigedpmhgrihhlfhhrohhmpeeophhruhhsihhlqddusehmsghogidrihhnvghtrdhfihequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
Received: from [192.168.1.105] (84.251.194.164) by julia1.inet.fi (9.0.019.26-1) (authenticated as prusil-1)
        id 5EF1FB310006D180 for linux-kernel@vger.kernel.org; Wed, 24 Jun 2020 22:54:55 +0300
To:     linux-kernel@vger.kernel.org
From:   Ilkka Prusi <ilkka.prusi@pp.inet.fi>
Subject: amdgpu: *ERROR* Waiting for fences timed out!
Message-ID: <2b1aec0a-2a39-7f93-4b1e-e23b57f109db@pp.inet.fi>
Date:   Wed, 24 Jun 2020 22:54:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got this error in kernel log from desktop freeze, it still responded 
to SysRq and system could be killed but desktop was unusable. I assume 
this might explain some problems I have seen on this computer before.

I assume that preceding segfault has no meaning here but included it anyway.

System has:

- Linux version 5.7.6 (gcc version 9.3.0 (Debian 9.3.0-14), GNU ld (GNU 
Binutils for Debian) 2.34) #2 SMP PREEMPT

- AMD Ryzen 7 2700 (Family 17h (Models 00h-0fh))

- [AMD/ATI] Vega 10 XL/XT [Radeon RX Vega 56/64] (rev c3)

- DMI: TUF B450-PLUS GAMING, BIOS 2008 12/06/2019

[  568.338593][ T4434] vivaldi-bin[4434]: segfault at 0 ip 
00005637c63f3f12 sp 00007fffa3766d00 error 4 in 
vivaldi-bin[5637c1c5a000+7823000]
[  568.338601][ T4434] Code: ff ff 48 89 de e8 5e 92 74 fe 80 bd 97 fe 
ff ff 00 79 0c 48 8b bd 80 fe ff ff e8 49 aa 21 fe 0f 28 05 92 88 b4 fa 
0f 29 45 c0 <49> 8b 4d 00 48 8d 15 e3 2e 1b 03 48 89 c8 48 29 d0 48 c1 
c8 04 48
[ 3303.068482][  T186] [drm:amdgpu_dm_commit_planes.constprop.0 
[amdgpu]] *ERROR* Waiting for fences timed out!
[ 3303.068619][  T184] [drm:amdgpu_dm_commit_planes.constprop.0 
[amdgpu]] *ERROR* Waiting for fences timed out!
[ 3303.068748][T23486] [drm:amdgpu_dm_commit_planes.constprop.0 
[amdgpu]] *ERROR* Waiting for fences timed out!


--

  - Ilkka Prusi



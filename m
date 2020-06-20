Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C95C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 19:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA91F24658
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 19:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="PUKr6fjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgFTThO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 15:37:14 -0400
Received: from vps01.wiesinger.com ([46.36.37.179]:56248 "EHLO
        vps01.wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgFTThN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 15:37:13 -0400
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
        by vps01.wiesinger.com (Postfix) with ESMTPS id 7FA5A9F354;
        Sat, 20 Jun 2020 21:37:09 +0200 (CEST)
Received: from [192.168.32.150] (bgld-ip-150.intern [192.168.32.150])
        (authenticated bits=0)
        by wiesinger.com (8.15.2/8.15.2) with ESMTPSA id 05KJb4on3954896
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 20 Jun 2020 21:37:07 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 05KJb4on3954896
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
        s=default; t=1592681828;
        bh=SW/dytyEj+ukv1qkiSmlCQX3/Xped17tKFeDWtpJVQY=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=PUKr6fjpNWh9ndO/VvgwFJTqQ5SK3on4mA/wDIY+B/ZAgXQVXqY3eu4F8FSula7Wa
         dvtfwiHOiS81PhJCJv1ll0rvvy9Tu5Bi+P1uVl4ll3Eh2YTg8UaphktRpeQCi10Fd/
         ZG2R28nTyXvhNXe3GeWCudVQCP8Emm0g0dl8FgaFOpENIKBPH1XA5nU9XmubifFRxO
         xflrxlmYxi4FFCAEdXhygVeGJBwC5jJFYmfThz+Da6fPSJrfIS3S3iPFf6dmkrSDEC
         MF1a6a6fWUf+qLaE7WgkhVRA6urbQSSPWJYMiawGcB3/v8PfSUqX4fPNw9fdICJKa3
         v5mHlqi9VhK9c+W4HOqoxPVCjBNlV3VT2YctAm6O8/aO++zkxN/+GUQUO8sq2/oJHH
         GTd4Ya/yeKeupzm/8ziQLQQrdItDNWA/etdWcIp9BKYwV6z/HTB14dPIlHtF2PoKQj
         aS+p0yMgq8qUPYbVf2cbbcRZA84x74RFR5ie7WZi6rC4XqrBltvmvW9xumN6FwRYWV
         ykFcwd2WVBzrOwt4vq81+OiaavPhx5w3bmwXeSPjoIlPPYYvoYLILV060s9LcCCjNp
         BcThwxkG/mW6XJzFoZa9L8RlWDyeEsFt8F70RrEbOBVTpzc9cnLTh+pnefQHHD/iMW
         S/xgO5ECO68si6z8OdLncb5o=
Subject: Re: Banana Pi-R1 - kernel 5.6.0 and later broken - b43 DSA
To:     Florian Fainelli <f.fainelli@gmail.com>,
        arm@lists.fedoraproject.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>, filbar@centrum.cz
References: <912a58ac-6f81-ba22-c79e-f2bf902dae2e@wiesinger.com>
 <12ed4a27-7773-98c4-c8ba-f9b0d53a5b5f@gmail.com>
From:   Gerhard Wiesinger <lists@wiesinger.com>
Message-ID: <6495b781-03a1-c655-90b2-71fe984ef02f@wiesinger.com>
Date:   Sat, 20 Jun 2020 21:37:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <12ed4a27-7773-98c4-c8ba-f9b0d53a5b5f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Florian,

On 20.06.2020 21:13, Florian Fainelli wrote:
> Hi,
>
> On 6/20/2020 10:39 AM, Gerhard Wiesinger wrote:
> Can you share your network configuration again with me? 

Find the network config below.


>> # OK: Last good known version (booting that version is also ok)
>> Linux bpi 5.5.18-200.fc31.armv7hl #1 SMP Fri Apr 17 17:25:00 UTC 2020
>> armv7l armv7l armv7l GNU/Linux
> OK, I suspect what has changed is this commit:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8fab459e69abfd04a66d76423d18ba853fced4ab
>
> which, if I remember your configuration correctly means that you now
> have proper DSA interfaces and so all of the wan, lan1-lan4 interfaces
> can now run a proper networking stack unlike before where you had to do
> this via the DSA master network device (eth0). This also means that you
> should run your DHCP server/client on the bridge master network device now.

Yes, config should be a proper DSA config, see also below. IP config is 
only on brlan and brwan.

Do the changes need a config change?
e.g. net: dsa: b53: Ensure the default VID is untagged
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/dsa/b53?id=d965a5432d4c3e6b9c3d2bc1d4a800013bbf76f6


Thnx.


Ciao,
Gerhard

Config:

brctl show
bridge name     bridge id               STP enabled     interfaces
brlan           8000.AAAAAAAAAAAA       no              lan.101
brlansw         8000.BBBBBBBBBBBB       no              lan1
                                                         lan2
                                                         lan3
                                                         lan4
brwan           8000.CCCCCCCCCCCC       no              wan.102
brwansw         8000.DDDDDDDDDDDD       no              wan

================================================================================

= /etc/systemd/network/30-autogen-eth0.network
================================================================================
[Match]
Name=eth0

[Network]
VLAN=lan.101
VLAN=wan.102
================================================================================
= /etc/systemd/network/40-autogen-lan.101.netdev
================================================================================
[NetDev]
Name=lan.101
Kind=vlan

[VLAN]
Id=101
================================================================================
= /etc/systemd/network/40-autogen-wan.102.netdev
================================================================================
[NetDev]
Name=wan.102
Kind=vlan

[VLAN]
Id=102
================================================================================
= /etc/systemd/network/50-autogen-brlan.netdev
================================================================================
[NetDev]
Name=brlan
Kind=bridge

[Bridge]
DefaultPVID=none
VLANFiltering=false
STP=false
================================================================================
= /etc/systemd/network/50-autogen-brlansw.netdev
================================================================================
[NetDev]
Name=brlansw
Kind=bridge

[Bridge]
DefaultPVID=none
VLANFiltering=true
STP=false
================================================================================
= /etc/systemd/network/50-autogen-brwan.netdev
================================================================================
[NetDev]
Name=brwan
Kind=bridge

[Bridge]
DefaultPVID=none
VLANFiltering=false
STP=false
================================================================================
= /etc/systemd/network/50-autogen-brwansw.netdev
================================================================================
[NetDev]
Name=brwansw
Kind=bridge

[Bridge]
DefaultPVID=none
VLANFiltering=true
STP=false
================================================================================
= /etc/systemd/network/60-autogen-brlan-lan.101.network
================================================================================
[Match]
Name=lan.101

[Network]
Bridge=brlan
================================================================================
= /etc/systemd/network/60-autogen-brlansw-lan1.network
================================================================================
[Match]
Name=lan1

[Network]
Bridge=brlansw

[BridgeVLAN]
VLAN=101
EgressUntagged=101
PVID=101
================================================================================
= /etc/systemd/network/60-autogen-brlansw-lan2.network
================================================================================
[Match]
Name=lan2

[Network]
Bridge=brlansw

[BridgeVLAN]
VLAN=101
EgressUntagged=101
PVID=101
================================================================================
= /etc/systemd/network/60-autogen-brlansw-lan3.network
================================================================================
[Match]
Name=lan3

[Network]
Bridge=brlansw

[BridgeVLAN]
VLAN=101
EgressUntagged=101
PVID=101
================================================================================
= /etc/systemd/network/60-autogen-brlansw-lan4.network
================================================================================
[Match]
Name=lan4

[Network]
Bridge=brlansw

[BridgeVLAN]
VLAN=101
EgressUntagged=101
PVID=101
================================================================================
= /etc/systemd/network/60-autogen-brwansw-wan.102.network
================================================================================
[Match]
Name=wan.102

[Network]
Bridge=brwansw
================================================================================
= /etc/systemd/network/60-autogen-brwansw-wan.network
================================================================================
[Match]
Name=wan

[Network]
Bridge=brwansw

[BridgeVLAN]
VLAN=102
EgressUntagged=102
PVID=102
================================================================================
= /etc/systemd/network/60-autogen-brwan-wan.102.network
================================================================================
[Match]
Name=wan.102

[Network]
Bridge=brwan
================================================================================
= /etc/systemd/network/61-autogen-brlan.network
================================================================================
[Match]
Name=brlan

[Network]
Address=192.168.39.2/24
Gateway=192.168.39.1
DNS=192.168.39.1
Domains=mydomain
================================================================================
= /etc/systemd/network/61-autogen-brwan.network
================================================================================
[Match]
Name=brwan

[Network]
Address=192.168.1.1/24


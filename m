Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DBDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1848206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBZ2JqO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgDHBUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:20:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56623 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726417AbgDHBUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 21:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586308799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yynh6enpaQOt1XUlAWveegHSiUBm2+b0w4JqLXxNInA=;
        b=QBZ2JqO1rE73UdK5+lZKBShYWCU+ms8I6Vs5tt+hQh13Otgm420kQ+gWRCEwyo4rLMUwC1
        eM4KgDHr24RlPo+Ek2kWeGOHVAfyhvfaarlj72A71m30eYcvcsO42IEDLm12owzBnsd17l
        iprqPDNepAhAiJaky4FxeXBtWf+H9Do=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-fOaWOFhZOByPhUr63tCrwA-1; Tue, 07 Apr 2020 21:19:57 -0400
X-MC-Unique: fOaWOFhZOByPhUr63tCrwA-1
Received: by mail-wr1-f69.google.com with SMTP id h95so3128081wrh.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 18:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Yynh6enpaQOt1XUlAWveegHSiUBm2+b0w4JqLXxNInA=;
        b=a1eIzfEjwfUKqMDl74QpR9pyVqyxwPrRtkAItfu6BdtGW321xR5uQ2kM3UEjSjYpJl
         9RxWbmC79FjWEy+yBIa4u6xqSi5B0Ssi1s9DANT7glllJfMPrvUUnOYyTz8Ifb3LXI7/
         4HXKowj1BulLTPmKNS7RtMhwG4XPBRb5LAVwFB3h+XK6RedOZcg1rX3eY3AbFC2gWuBh
         Z5V6/QsPBPOg6WFpiDK2I9vjZ2tdvaQF2gXveTCD565pPv06m+uJhRngnH5+qDTcVkZi
         /yRPbl9dVzYgyPfHyOIoVxTBhJxLzpkYNg/URhOU9+mZk4pHlrGpY3X+HFb/xhGKo/BG
         FZfw==
X-Gm-Message-State: AGi0PubwvV61UUvM/91hy/5bjlWkJCdwgbVfFTKjTb5UGjb0PQg55vFu
        ueAXPBewxc8aQmP7/svt6YhsONmVOmYuLZ+eKNm7GQq1khRbUmibUCxZVlu140Fy3pjZw6acbB7
        acaSr4PEUD9B8VH7n3Z03aY6y
X-Received: by 2002:a1c:ac8a:: with SMTP id v132mr1914449wme.62.1586308795918;
        Tue, 07 Apr 2020 18:19:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypLaQ8jm+WBVI/QXXC3y/wecnYYtN4bnsLufT0M1q3rnm9XPOgt4HbcYJI5WGFbrJD6qA1XOcQ==
X-Received: by 2002:a1c:ac8a:: with SMTP id v132mr1914429wme.62.1586308795574;
        Tue, 07 Apr 2020 18:19:55 -0700 (PDT)
Received: from turbo.teknoraver.net (net-93-148-149-154.cust.vodafonedsl.it. [93.148.149.154])
        by smtp.gmail.com with ESMTPSA id u7sm5080682wmg.41.2020.04.07.18.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 18:19:55 -0700 (PDT)
Date:   Wed, 8 Apr 2020 03:19:52 +0200
From:   Matteo Croce <mcroce@redhat.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     davem@davemloft.net, andrew@lunn.ch, josua@solid-run.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH v3 0/2] net: mvmdio: avoid error message for optional
 IRQ
Message-ID: <20200408031952.1d8dd01b@turbo.teknoraver.net>
In-Reply-To: <20200316074907.21879-1-chris.packham@alliedtelesis.co.nz>
References: <20200316074907.21879-1-chris.packham@alliedtelesis.co.nz>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Mar 2020 20:49:05 +1300
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> I've gone ahead an sent a revert. This is the same as the original v1
> except I've added Andrew's review to the commit message.
> 
> Chris Packham (2):
>   Revert "net: mvmdio: avoid error message for optional IRQ"
>   net: mvmdio: avoid error message for optional IRQ
> 
>  drivers/net/ethernet/marvell/mvmdio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Hi all,

I have a Macchiatobin board and the 10G port stopped working in net-next.
I suspect that these two patches could be involved.
The phy is correctly detected now (I mean no errors and the device is
registered) but no traffic can be sent or received:

root@macchiatobin:~# dmesg |grep -i -e phy -e mvpp2
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd081]
[    0.000000] arch_timer: cp15 timer(s) running at 25.00MHz (phys).
[    0.062798] libphy: Fixed MDIO Bus: probed
[    1.132552] armada8k-pcie f2600000.pcie: Phy link never came up
[    2.553464] libphy: orion_mdio_bus: probed
[    2.558045] libphy: orion_mdio_bus: probed
[    2.564037] mvpp2 f2000000.ethernet: using 8 per-cpu buffers
[    2.588754] mvpp2 f2000000.ethernet eth0: Using random mac address 1e:a6:ce:39:8d:22
[    2.599980] mvpp2 f4000000.ethernet: using 8 per-cpu buffers
[    2.623293] mvpp2 f4000000.ethernet eth1: Using random mac address aa:ad:b5:91:8c:1e
[    2.626535] mvpp2 f4000000.ethernet eth2: Using random mac address 6e:39:fb:74:09:6e
[    2.629600] mvpp2 f4000000.ethernet eth3: Using random mac address 16:ec:bf:9e:11:0f
[    2.952063] mvpp2 f4000000.ethernet eth2: PHY [f212a200.mdio-mii:00] driver [Marvell 88E1510] (irq=POLL)
[    2.953251] mvpp2 f4000000.ethernet eth2: configuring for phy/sgmii link mode
[    7.122899] mvpp2 f4000000.ethernet eth2: Link is Up - 1Gbps/Full - flow control rx/tx
[   25.727756] mvpp2 f2000000.ethernet eth0: PHY [f212a600.mdio-mii:00] driver [mv88x3310] (irq=POLL)
[   25.746711] mvpp2 f2000000.ethernet eth0: configuring for phy/10gbase-r link mode
[   27.842712] mvpp2 f2000000.ethernet eth0: Link is Up - 10Gbps/Full - flow control off


The only way to have it working is to unplug the power, boot an old
kernel, e.g. 5.3.0:

root@macchiatobin:~# dmesg |grep -i -e phy -e mvpp2
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd081]
[    0.000000] arch_timer: cp15 timer(s) running at 25.00MHz (phys).
[    0.083647] libphy: Fixed MDIO Bus: probed
[    0.152788] armada8k-pcie f2600000.pcie: Failed to initialize PHY(s) (-22)
[    1.429643] libphy: orion_mdio_bus: probed
[    1.439109] libphy: orion_mdio_bus: probed
[    1.450989] mvpp2 f2000000.ethernet eth0: Using random mac address 5a:09:5f:97:aa:cc
[    1.476692] mvpp2 f4000000.ethernet eth1: Using random mac address f2:e2:c1:77:fa:23
[    1.479688] mvpp2 f4000000.ethernet eth2: Using random mac address b2:33:c0:2f:da:ba
[    1.482296] mvpp2 f4000000.ethernet eth3: Using random mac address 6a:38:79:2e:96:8c
[    1.814163] mvpp2 f4000000.ethernet eth2: PHY [f212a200.mdio-mii:00] driver [Marvell 88E1510]
[    1.814170] mvpp2 f4000000.ethernet eth2: phy: setting supported 00,00000000,000066ef advertising 00,00000000,000066ef
[    1.826025] mvpp2 f4000000.ethernet eth2: configuring for phy/sgmii link mode
[    1.826030] mvpp2 f4000000.ethernet eth2: phylink_mac_config: mode=phy/sgmii/Unknown/Unknown adv=00,00000000,000066ef pause=10 link=0 an=1
[    1.827683] mvpp2 f4000000.ethernet eth2: phy link down sgmii/1Gbps/Half
[    6.002304] mvpp2 f4000000.ethernet eth2: phy link up sgmii/1Gbps/Full
[    6.002313] mvpp2 f4000000.ethernet eth2: phylink_mac_config: mode=phy/sgmii/1Gbps/Full adv=00,00000000,00000000 pause=0f link=1 an=0
[    6.002332] mvpp2 f4000000.ethernet eth2: Link is Up - 1Gbps/Full - flow control rx/tx
[   33.186689] mvpp2 f2000000.ethernet eth0: PHY [f212a600.mdio-mii:00] driver [mv88x3310]
[   33.194739] mvpp2 f2000000.ethernet eth0: phy: setting supported 00,00008000,0000706f advertising 00,00008000,0000706f
[   33.218029] mvpp2 f2000000.ethernet eth0: configuring for phy/10gbase-kr link mode
[   33.225637] mvpp2 f2000000.ethernet eth0: phylink_mac_config: mode=phy/10gbase-kr/Unknown/Unknown adv=00,00008000,0000706f pause=10 link=0 an=1
[   33.241341] mvpp2 f2000000.ethernet eth0: phy link down 10gbase-kr/Unknown/Unknown
[   35.362160] mvpp2 f2000000.ethernet eth0: phy link up 10gbase-kr/10Gbps/Full
[   35.369243] mvpp2 f2000000.ethernet eth0: phylink_mac_config: mode=phy/10gbase-kr/10Gbps/Full adv=00,00000000,00000000 pause=00 link=1 an=0
[   35.381836] mvpp2 f2000000.ethernet eth0: Link is Up - 10Gbps/Full - flow control off


And then do a soft reboot to net-next which works.
By rebooting the board multiple times it works, until I unplug the power.

Any hint?
Bye,

-- 
Matteo Croce
per aspera ad upstream


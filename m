Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7E9C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CBC2208CA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sv0jBOSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgEIANt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 20:13:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32629 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728493AbgEIANr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 20:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588983226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZhMKYaxcr11NMRkCgTBjG7GpLbTFZxzwIgvmF68ljDw=;
        b=Sv0jBOSAyOqQ+aXqJ+FSQz4fnEp+6fxUun63p6CIMZUg6fDfflJhAZ1L3lxiE+zdkRYH8r
        O5wMrkUAlC0OJJ/k4XdljVXriiKlhzivBLv52Kd+R8lr4bHzjpehygA5Tr9J5GEzdG1fLp
        MC7ioT/YNNYL0MpFSv2QSfVUsgDBdrU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-LGrxMzoiOamt2ZVTSQchzA-1; Fri, 08 May 2020 20:13:34 -0400
X-MC-Unique: LGrxMzoiOamt2ZVTSQchzA-1
Received: by mail-ej1-f70.google.com with SMTP id bz19so1341539ejc.18
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 17:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZhMKYaxcr11NMRkCgTBjG7GpLbTFZxzwIgvmF68ljDw=;
        b=j8/TKdG77bn3tBXgZS59NLfeq3a3atHAm6lffK6bfc1/AlVH3eTaV0L8Mpgt0z5M2I
         TS/DfNXMf8Qg2I+UoTh9WVf9QpMqd0i0CmsQyMdmSaGtDYZBe5OEPpn0azQxaZ5SYsPP
         nKJtxCojUH/9Zr/566GARtzcOqDWqG6Gj8hPr1vnWE0+2ZS/p+yGHsVXEqrZGh/kcFCK
         4lFYZs7FfEY2BY3k2qFLnjrtq92q0krdpmDrhSSqqYljTM+oNxjR7M0/Rrscba9/Rzmg
         klNMjp6MoeqgwMBrc06uE6YnlztnK4erDLT828Pt3ovgUQehZYk5BnHtdqE4uoQ5JvY8
         gGPg==
X-Gm-Message-State: AGi0PuauxbKn7QtV1BuzsihFVdyY4s25ZzpSTSt5NdNXIzGDc7oX/hYw
        iS+n/xdnkNox5iMIkYk4pq1RH5nL//Ulc7SuT7rKMHdu8d4svU9DQ0gevnMpvkvWc3f55LaBLHb
        NKYdJ6HVsahCERIUeDAmNun0uG01ruahflb1pDOKk
X-Received: by 2002:a17:906:328c:: with SMTP id 12mr3850930ejw.69.1588983213651;
        Fri, 08 May 2020 17:13:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypJqN+TFhvtZqdkdpPo6lJw1R9Pu/We69ZDkgECDwa6VM+i564ZjE0uPtDGVAOi0WNgy1fVhvrOMu14Ja9Aja74=
X-Received: by 2002:a17:906:328c:: with SMTP id 12mr3850919ejw.69.1588983213332;
 Fri, 08 May 2020 17:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190524100554.8606-1-maxime.chevallier@bootlin.com>
 <20190524100554.8606-4-maxime.chevallier@bootlin.com> <CAGnkfhzsx_uEPkZQC-_-_NamTigD8J0WgcDioqMLSHVFa3V6GQ@mail.gmail.com>
 <20200423170003.GT25745@shell.armlinux.org.uk>
In-Reply-To: <20200423170003.GT25745@shell.armlinux.org.uk>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Sat, 9 May 2020 02:12:57 +0200
Message-ID: <CAGnkfhwOavaeUjcm4_+TG-xLxQA519o+fR8hxBCCfSy3qpcYhQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] net: mvpp2: cls: Use RSS contexts to handle
 RSS tables
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 7:00 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Apr 14, 2020 at 01:43:02AM +0200, Matteo Croce wrote:
> > On Tue, Apr 14, 2020 at 1:21 AM Maxime Chevallier
> > <maxime.chevallier@bootlin.com> wrote:
> > >
> > > The PPv2 controller has 8 RSS tables that are shared across all ports on
> > > a given PPv2 instance. The previous implementation allocated one table
> > > per port, leaving others unused.
> > >
> > > By using RSS contexts, we can make use of multiple RSS tables per
> > > port, one being the default table (always id 0), the other ones being
> > > used as destinations for flow steering, in the same way as rx rings.
> > >
> > > This commit introduces RSS contexts management in the PPv2 driver. We
> > > always reserve one table per port, allocated when the port is probed.
> > >
> > > The global table list is stored in the struct mvpp2, as it's a global
> > > resource. Each port then maintains a list of indices in that global
> > > table, that way each port can have it's own numbering scheme starting
> > > from 0.
> > >
> > > One limitation that seems unavoidable is that the hashing parameters are
> > > shared across all RSS contexts for a given port. Hashing parameters for
> > > ctx 0 will be applied to all contexts.
> > >
> > > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> >
> > Hi all,
> >
> > I noticed that enabling rxhash blocks the RX on my Macchiatobin. It
> > works fine with the 10G ports (the RX rate goes 4x up) but it
> > completely kills the gigabit interface.
> >
> > # 10G port
> > root@macchiatobin:~# iperf3 -c 192.168.0.2
> > Connecting to host 192.168.0.2, port 5201
> > [  5] local 192.168.0.1 port 42394 connected to 192.168.0.2 port 5201
> > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > [  5]   0.00-1.00   sec   941 MBytes  7.89 Gbits/sec  4030    250 KBytes
> > [  5]   1.00-2.00   sec   933 MBytes  7.82 Gbits/sec  4393    240 KBytes
> > root@macchiatobin:~# ethtool -K eth0 rxhash on
> > root@macchiatobin:~# iperf3 -c 192.168.0.2
> > Connecting to host 192.168.0.2, port 5201
> > [  5] local 192.168.0.1 port 42398 connected to 192.168.0.2 port 5201
> > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > [  5]   0.00-1.00   sec   860 MBytes  7.21 Gbits/sec  428    410 KBytes
> > [  5]   1.00-2.00   sec   859 MBytes  7.20 Gbits/sec  185    563 KBytes
> >
> > # gigabit port
> > root@macchiatobin:~# iperf3 -c turbo
> > Connecting to host turbo, port 5201
> > [  5] local 192.168.85.42 port 45144 connected to 192.168.85.6 port 5201
> > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > [  5]   0.00-1.00   sec   113 MBytes   948 Mbits/sec    0    407 KBytes
> > [  5]   1.00-2.00   sec   112 MBytes   942 Mbits/sec    0    428 KBytes
> > root@macchiatobin:~# ethtool -K eth2 rxhash on
> > root@macchiatobin:~# iperf3 -c turbo
> > iperf3: error - unable to connect to server: Resource temporarily unavailable
> >
> > I've bisected and it seems that this commit causes the issue. I tried
> > to revert it on nex-next as a second test, but the code has changed a
> > lot much since, generating too much conflicts.
> > Can you have a look into this?
>
> This behaviour on eth2 is confirmed here on v5.6.  Turning on rxhash
> appears to prevent eth2 working.
>
> Maxime, please look into this regression, thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
>

Hi,

What do you think about temporarily disabling it like this?

--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5775,7 +5775,8 @@ static int mvpp2_port_probe(struct platform_device *pdev,
                            NETIF_F_HW_VLAN_CTAG_FILTER;

        if (mvpp22_rss_is_supported()) {
-               dev->hw_features |= NETIF_F_RXHASH;
+               if (port->phy_interface != PHY_INTERFACE_MODE_SGMII)
+                       dev->hw_features |= NETIF_F_RXHASH;
                dev->features |= NETIF_F_NTUPLE;
        }


David, is this "workaround" too bad to get accepted?

Bye,

--
Matteo Croce
per aspera ad upstream


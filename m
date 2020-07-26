Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E8FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A69F20715
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Yp1ISqCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgGZJqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgGZJqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:46:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB60C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 02:46:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f1so11458219wro.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 02:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HQ/IWfLT3mq5cvefu9vsO8j/vu7mJElveg8ExLzFSq4=;
        b=Yp1ISqCqPjLzOGigDU3wGEPVdHtEU9EELwYtGraV3aP4dSYRCE7EG3AluxlbrAFMeL
         2ikm8LqiYr8ETCdYrxdo3+W0ov6Mpy1D2qlU3UkaCV25nIK5fXFNzzCJiJ/RxZl72KS1
         Ssivs3GpdfXWHtmEnVa6/WShKBZdoNgSLFl4InEbkhgYVoOaNLJ2GL6QbogDFbMoBOJf
         I4q3qwsMBw2feZagxUAqXBixfwLkiU2zoZH0aHRW59J7Shtn7+fbYK8ljMAi4nR7lmiD
         BCPH71qkv++KbRFsKqxLkRx7ePZzxRDh5wCs2awMPhr5tSxwa2js0hKW4tbGDzVN/ES5
         cyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HQ/IWfLT3mq5cvefu9vsO8j/vu7mJElveg8ExLzFSq4=;
        b=cck2xrh2jDERB6QG9KZrNCPnRb1is2fLyliDLyi6nvjfsPuT4R1YbSItWec+hZIw3r
         vZxgrgVni4XGF84dG88cdHkdFEp9eG/5iHYoATkkI8lkpWGp6W2IAcXPyr58ym2BU3bf
         ZldZGIWr7WXiR9iSXnAPjJh22rLJGld66WIUmuouQvjPjsfRrhDskITZkJgOCxPGYJ9/
         fPbcWDN5cGLv1OIh4THb04Jo5tAo2AIZd35LRD4xWKXqCBbzUxZAHFBK4zzRPXkUmTEv
         VQoPet/4VzNL/O7nlFkgjtYdVlY0LHLHkKLILDp7mz0pCcKpztHoPowtNN8Re90O1rxz
         8IkQ==
X-Gm-Message-State: AOAM531hMhDBfOWT5Gjq7swqkiDHRL5DnMIA0W0xWFGkLdZGWnSvHYMP
        iWeL4TCfaGln6I4bw7ncS0PrXw==
X-Google-Smtp-Source: ABdhPJwxzESIZx5RqrcS487WEPuX23LLzaYS8I3Mph8QE4IavHOTM/EAbjKmH3W16NNw2GoWMYh2jA==
X-Received: by 2002:adf:f8d0:: with SMTP id f16mr8319563wrq.66.1595756788685;
        Sun, 26 Jul 2020 02:46:28 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id o9sm7570528wrs.1.2020.07.26.02.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 02:46:28 -0700 (PDT)
Date:   Sun, 26 Jul 2020 11:46:27 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Serhiy Boiko <serhiy.boiko@plvision.eu>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Andrii Savka <andrii.savka@plvision.eu>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mickey Rachamim <mickeyr@marvell.com>
Subject: Re: [net-next v3 4/6] net: marvell: prestera: Add ethtool interface
 support
Message-ID: <20200726094627.GG2216@nanopsycho>
References: <20200725150651.17029-1-vadym.kochan@plvision.eu>
 <20200725150651.17029-5-vadym.kochan@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725150651.17029-5-vadym.kochan@plvision.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Jul 25, 2020 at 05:06:49PM CEST, vadym.kochan@plvision.eu wrote:
>The ethtool API provides support for the configuration of the following
>features: speed and duplex, auto-negotiation, MDI-x, forward error
>correction, port media type. The API also provides information about the
>port status, hardware and software statistic. The following limitation
>exists:
>
>    - port media type should be configured before speed setting
>    - ethtool -m option is not supported
>    - ethtool -p option is not supported
>    - ethtool -r option is supported for RJ45 port only
>    - the following combination of parameters is not supported:
>
>          ethtool -s sw1pX port XX autoneg on
>
>    - forward error correction feature is supported only on SFP ports, 10G
>      speed
>
>    - auto-negotiation and MDI-x features are not supported on
>      Copper-to-Fiber SFP module
>
>Signed-off-by: Andrii Savka <andrii.savka@plvision.eu>
>Signed-off-by: Serhiy Boiko <serhiy.boiko@plvision.eu>
>Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
>---

[...]

	
>+
>+void prestera_ethtool_get_stats(struct net_device *dev,
>+				struct ethtool_stats *stats, u64 *data)
>+{
>+	struct prestera_port *port = netdev_priv(dev);
>+	struct prestera_port_stats *port_stats;
>+
>+	port_stats = &port->cached_hw_stats.stats;
>+
>+	memcpy((u8 *)data, port_stats, sizeof(*port_stats));

Avoid the needless cast.


[...]
	
	
>+static const struct ethtool_ops ethtool_ops = {
>+	.get_drvinfo = prestera_ethtool_get_drvinfo,
>+	.get_link_ksettings = prestera_ethtool_get_link_ksettings,
>+	.set_link_ksettings = prestera_ethtool_set_link_ksettings,
>+	.get_fecparam = prestera_ethtool_get_fecparam,
>+	.set_fecparam = prestera_ethtool_set_fecparam,
>+	.get_sset_count = prestera_ethtool_get_sset_count,
>+	.get_strings = prestera_ethtool_get_strings,
>+	.get_ethtool_stats = prestera_ethtool_get_stats,
>+	.get_link = ethtool_op_get_link,
>+	.nway_reset = prestera_ethtool_nway_reset
>+};

Have the struct in prestera_ethtool.c and export just the struct instead
of all the callbacks.


>+
> static int prestera_port_create(struct prestera_switch *sw, u32 id)
> {
> 	struct prestera_port *port;
>@@ -235,6 +266,7 @@ static int prestera_port_create(struct prestera_switch *sw, u32 id)
> 
> 	dev->features |= NETIF_F_NETNS_LOCAL;
> 	dev->netdev_ops = &netdev_ops;
>+	dev->ethtool_ops = &ethtool_ops;
> 
> 	netif_carrier_off(dev);
> 
>-- 
>2.17.1
>

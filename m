Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BBEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006A020679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="ebsBmXcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgFCOgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgFCOgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:36:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12046C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 07:36:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q11so2649690wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pl3xDnNmt1VQENcPAj+d3FJJVE2TWWyVWxTE2VGNl20=;
        b=ebsBmXcJKaW/yR42AsepxbZW/pr/LYJzRJKFJ0qCvO/qb3T75kr+kuoII+cb0LqWvK
         yTbj0P560zdX1jvYQ3U7/gfSKpOSogASuLAvb6ca8uM2zuAznJGLHw8Q1ZSWud6mrdZS
         2ksKDtiqL07scaq/cyC9aURjOTB0gRp2GWTOOn1EoyTNNmVmM7353iL492ED3Z9fvn31
         5qQrHhGQnEZuodlPNy6qZsuXAnr6kDo0L9F/SXVz9iXMZPFEYP2CE61HxTg+8CZ2ZXIk
         lwDRdnWG5SDpZUMqNPFC0CWISkOUKKYL7BLua0/sixpUAJ7aM/1laR0ZLKjYeejxbBob
         Vi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pl3xDnNmt1VQENcPAj+d3FJJVE2TWWyVWxTE2VGNl20=;
        b=WyWWj74K6B4wfCTQH/lgZJLdoG7uaoTc+/W7/gm9BJwcmJq2wHZ4TSZ7Ru1J8DuOVM
         6qHRs6QZRzqiT0nSVAzecmN2xSGTi4tOV6PKXRR7xuE/hmu/FLxk60Bk8uwt+GjxCm+b
         tYLJm2J2Orm1fvvFUMv8ZTGMt0X8X/BaiMipIJGh1U5Jl8ZjrZAv2gGFbMvyT816JgJp
         2xGvuIw9qnsITxvGsXnEdGKNcoTZVWpkvZIvVnAGgXYNKvtdFdWe4TuC4LOgw0IIHBD4
         X43+GuKI0s9kphJAjO2um54r2b4UpgySsBwUatUdJxwhyhDFwAl8tqjwc6szJz9mgL0R
         +UIA==
X-Gm-Message-State: AOAM530WgJRaQFOo2Bw6K52rXEJAT+yAFc/E/G4xM3svJ7Orxs8fFaJ8
        jrNiAF18Wty0QXzZHfno+tHZwg==
X-Google-Smtp-Source: ABdhPJyMb5U3ggl5KDn66BeTGb2QgmEVbyyru5dmqQeyyCdB/WWCY7uGGgPTbJlL4GItXeBfgSOj+w==
X-Received: by 2002:a5d:608d:: with SMTP id w13mr30920857wrt.298.1591195008863;
        Wed, 03 Jun 2020 07:36:48 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id a81sm3587325wmd.25.2020.06.03.07.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 07:36:48 -0700 (PDT)
Date:   Wed, 3 Jun 2020 16:36:47 +0200
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
Subject: Re: [net-next 1/6] net: marvell: prestera: Add driver for Prestera
 family ASIC devices
Message-ID: <20200603143647.GC2274@nanopsycho.orion>
References: <20200528151245.7592-1-vadym.kochan@plvision.eu>
 <20200528151245.7592-2-vadym.kochan@plvision.eu>
 <20200603142944.GA5892@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603142944.GA5892@nanopsycho.orion>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jun 03, 2020 at 04:29:44PM CEST, jiri@resnulli.us wrote:
>Thu, May 28, 2020 at 05:12:40PM CEST, vadym.kochan@plvision.eu wrote:
>
>[...]
>
>>+static int prestera_port_create(struct prestera_switch *sw, u32 id)
>>+{
>>+	struct prestera_port *port;
>>+	struct net_device *dev;
>>+	int err;
>>+
>>+	dev = alloc_etherdev(sizeof(*port));
>>+	if (!dev)
>>+		return -ENOMEM;
>>+
>>+	port = netdev_priv(dev);
>>+
>>+	port->dev = dev;
>>+	port->id = id;
>>+	port->sw = sw;
>>+
>>+	err = prestera_hw_port_info_get(port, &port->fp_id,
>>+					&port->hw_id, &port->dev_id);
>>+	if (err) {
>>+		dev_err(prestera_dev(sw), "Failed to get port(%u) info\n", id);
>>+		goto err_port_init;
>>+	}
>>+
>>+	dev->features |= NETIF_F_NETNS_LOCAL;
>>+	dev->netdev_ops = &netdev_ops;
>>+
>>+	netif_carrier_off(dev);
>
>No need.

Actually, it is. Sorry :)


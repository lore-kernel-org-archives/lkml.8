Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855E8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C0F21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB99fEq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFQRus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgFQRuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:50:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30EEC06174E;
        Wed, 17 Jun 2020 10:50:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n2so1261915pld.13;
        Wed, 17 Jun 2020 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yq5diRbDBw+gHc4daVhmcbcjOe/hThspefbSOXHvc/o=;
        b=GB99fEq1WUI+17sQydTWiqAwh1What9uVtEGQ1SGUtO/yRGfz4Y8w8/ZsmtLKFDTe+
         U8aZEy+G93h+NyzrjT6L5NHY2LC2GLgRu0lHpXpMN/eSoPIkBIdwCUoWLP0i1twI/oNB
         R7dNHYbfr7wx7hNQLBA70tLSl/V7XOZuyUtXuHicr46iSNNQRdK97nUjdwwM2GUFCOuZ
         8T0RT/95FLThnifKXYycJxw3/zbWgm+/vMM4sx9o0CoUVX67aTCYb5GuDjgOqE363n7S
         2PWRoxYDl0AsIfTlISnPnuYWdrUBdUzrdztzkrLRe5U4OUc4XBeP1BQl21UMkvRy2FuN
         Io0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yq5diRbDBw+gHc4daVhmcbcjOe/hThspefbSOXHvc/o=;
        b=e0Bwfe/ZqLKG5vOYg+3CjFHNRcYxsF8D5JXOgFmzLBBuw4WQgpArFB1ch2NGgnbAbT
         33/hm1rQfdhZujjQDmZIzJFlRkXZilaD3xB+Y1nZn5Hdk8GWzzuNyCYCi6Bilbw2usiL
         mjXwGJ/T0eHvcqyyl9YBo7thleHzKTVZv0L2vtKVkV0hnuuo3y4+EEz754Xbd6CuW+Yn
         OQvu5XQ1kqpCuTI0NUJAo15lTGQnsexiCKyGffhTuxMyGfI+R62NqYSNHB/PX7yMy6Ma
         iXMrfACWNzuQ4Srm1+ajVIp+a9DVrNoMuBlYOTmeDHCuBN0O6RCcw2wui4h43sqZi2w2
         E95A==
X-Gm-Message-State: AOAM533IWv8TCGxK0dOQ/dnKnS0ZuqPXBcqJfwTLniEXFCuPcyFM8bwo
        ETkTuZQR09EDu6gFnWxKIa4=
X-Google-Smtp-Source: ABdhPJxJsXaYyyAkpxhwqgEkin/mFk413zD16kOL2VYcRORcsF9dvVp9o168M6l+ItwoHAWbCydShA==
X-Received: by 2002:a17:90a:b013:: with SMTP id x19mr176218pjq.229.1592416244290;
        Wed, 17 Jun 2020 10:50:44 -0700 (PDT)
Received: from localhost ([144.34.193.30])
        by smtp.gmail.com with ESMTPSA id o206sm443655pfd.179.2020.06.17.10.50.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jun 2020 10:50:43 -0700 (PDT)
Date:   Thu, 18 Jun 2020 01:50:39 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kevin Groeneveld <kgroeneveld@gmail.com>
Subject: Re: [PATCH net v1] net: phy: smsc: fix printing too many logs
Message-ID: <20200617175039.GA18631@nuc8i5>
References: <20200617153340.17371-1-zhengdejin5@gmail.com>
 <20200617161925.GE205574@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617161925.GE205574@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 06:19:25PM +0200, Andrew Lunn wrote:
> On Wed, Jun 17, 2020 at 11:33:40PM +0800, Dejin Zheng wrote:
> > Commit 7ae7ad2f11ef47 ("net: phy: smsc: use phy_read_poll_timeout()
> > to simplify the code") will print a lot of logs as follows when Ethernet
> > cable is not connected:
> > 
> > [    4.473105] SMSC LAN8710/LAN8720 2188000.ethernet-1:00: lan87xx_read_status failed: -110
> > 
> > So fix it by read_poll_timeout().
> 
> Do you have a more detailed explanation of what is going on here?
> 
> After a lot of thought, i think i can see how this happens. But the
> commit message should really spell out why this is the correct fix.
>
Hi Andrew:

Kevin report a bug for me in link[1], I check the Commit 7ae7ad2f11ef47
("net: phy: smsc: use phy_read_poll_timeout() to simplify the code") and
found it change the original behavior in smsc driver. It does not has
any error message whether it is timeout or phy_read fails, but this Commit
will changed it and will print some error messages by
phy_read_poll_timeout() when it is timeout or phy_read fails. so use the
read_poll_timeout() to replace phy_read_poll_timeout() to fix this
issue. the read_poll_timeout() does not print any log when it goes
wrong.

the original codes is that:

	/* Wait max 640 ms to detect energy */
	for (i = 0; i < 64; i++) {
	        /* Sleep to allow link test pulses to be sent */
	        msleep(10);
	        rc = phy_read(phydev, MII_LAN83C185_CTRL_STATUS);
	        if (rc < 0)
	                return rc;
	        if (rc & MII_LAN83C185_ENERGYON)
	                break;
	}

Commit 7ae7ad2f11ef47 modify it as this:

	phy_read_poll_timeout(phydev, MII_LAN83C185_CTRL_STATUS,
	                      rc & MII_LAN83C185_ENERGYON, 10000,
	                      640000, true);
	if (rc < 0)
	        return rc;

the phy_read_poll_timeout() will print a error log by phydev_err()
when timeout or rc < 0. read_poll_timeout() just return timeout
error and does not print any error log.

#define phy_read_poll_timeout(phydev, regnum, val, cond, sleep_us, \
                                timeout_us, sleep_before_read) \
({ \
        int __ret = read_poll_timeout(phy_read, val, (cond) || val < 0, \
                sleep_us, timeout_us, sleep_before_read, phydev, regnum); \
        if (val <  0) \
                __ret = val; \
        if (__ret) \
                phydev_err(phydev, "%s failed: %d\n", __func__, __ret); \
        __ret; \
})

So use read_poll_timeout Use read_poll_timeout() to be consistent with the
original code.

link[1]: https://lkml.org/lkml/2020/6/1/1408

> Thanks
> 	Andrew

Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD434C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D9A217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="sE3Ikb6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgBEJT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:19:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50565 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbgBEJT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:19:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so1586327wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 01:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6H/QyNyNq+1Ik65EkQjZHjIndEH5TkQN3D2YteDfGc=;
        b=sE3Ikb6jgOuFcgMeTx0GoZkIya67lOK3J14E4lVh+7TRNq2YtEuTzpShgNVGt7W2he
         XWTiyhwSrZ9qJSooLWHlgIbGW3ypux6Hd6TOVfD1+cXo2fvCjkwf8YKncexg5vFk8tVe
         AiqGb3pi3v1A6Qz8hBJfGYuzeolAinTsdh7Rg2zs8cvdQsP5gYJl0ym51i+hJTaGO8aK
         mKcLxKcJIfOIr1Uq1yjVUnEWN27a5qOWyyA6QjAvEq89wYSyKkItjpsDtgntEhaVERm7
         1GUIGL4EKzPgPc7sJJLeyOE35GcqvmSQrLYqbewKVULPfkKskjrll/8OnHSQTCsQEbM5
         8aJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6H/QyNyNq+1Ik65EkQjZHjIndEH5TkQN3D2YteDfGc=;
        b=UQjle9WMyXUOdFv9gJ/VTktqJ7fLHD8piAUjmn8/7xpvBa75aJvuViq1VAKqSeqtp3
         HSsvJxSh1+wXBoeA8FZdNX3FmFa3BxhJTvHmmUyxJ/9xBiCYmDdYTn5J6Vvgv080dJGr
         a9XjNir8TkzJoB55iaegp/JprzHI9tR1LBApd3CAy4VatNyHZKJr6Fc+cijkQ4gIs9CM
         GugPB8ws0q7j90T09oKpBsZDnPFrX1stmZlfs1KX1mMFygdZ2AI4/Kz7DUarIuxy0REg
         08xzrvMxziHEfbd8QU/+/aPO8ikrNdQ1RAan4PAADo+IWGiyxwTxxmgoQq44ib6rNVD5
         jB1Q==
X-Gm-Message-State: APjAAAXlua4/rcYKG/Xp5vW5k+7JUmWSB6zlYINy45F10kx6DGYNxWGS
        GLogUPtelTM6Viv+NNpcgLsksA==
X-Google-Smtp-Source: APXvYqyFg48GgOSm1+SP3QTQA6KD8OCD6dLT7Yoc8jB8I6QtYSHQJpgGmv13B6djBo6hafQ2SjeqXw==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr4494858wml.71.1580894365966;
        Wed, 05 Feb 2020 01:19:25 -0800 (PST)
Received: from shemminger-XPS-13-9360 ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id d204sm7254710wmd.30.2020.02.05.01.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 01:19:25 -0800 (PST)
Date:   Wed, 5 Feb 2020 01:19:23 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, davem@davemloft.ne,
        mkubecek@suse.cz, jeffrey.t.kirsher@intel.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Jouni Hogander <jouni.hogander@unikie.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        Wang Hai <wanghai26@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Li RongQing <lirongqing@baidu.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] net-sysfs: Ensure begin/complete are called in
 speed_show() and duplex_show()
Message-ID: <20200205011923.536bf3c7@shemminger-XPS-13-9360>
In-Reply-To: <20200205090638.GS10400@smile.fi.intel.com>
References: <20200205081616.18378-1-kai.heng.feng@canonical.com>
        <20200205081616.18378-2-kai.heng.feng@canonical.com>
        <20200205090638.GS10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2020 11:06:38 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Feb 05, 2020 at 04:16:16PM +0800, Kai-Heng Feng wrote:
> > Device like igb gets runtime suspended when there's no link partner. We
> > can't get correct speed under that state:
> > $ cat /sys/class/net/enp3s0/speed
> > 1000
> > 
> > In addition to that, an error can also be spotted in dmesg:
> > [  385.991957] igb 0000:03:00.0 enp3s0: PCIe link lost
> > 
> > It's because the igb device doesn't get runtime resumed before calling
> > get_link_ksettings().
> > 
> > So let's use a new helper to call begin() and complete() like what
> > dev_ethtool() does, to runtime resume/suspend or power up/down the
> > device properly.
> > 
> > Once this fix is in place, igb can show the speed correctly without link
> > partner:
> > $ cat /sys/class/net/enp3s0/speed
> > -1  
> 
> What is the meaning of -1? Does it tells us "Hey, something is bad in hardware
> I can't tell you the speed" or does it imply anything else?
> 
> Wouldn't be better to report 0?
> 
> Where is the documentation part of this ABI change?
> 

The speed value of -1 is defined in ethtool.h as:

#define SPEED_UNKNOWN		-1




Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11738C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 03:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36E024673
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 03:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Wd/Zd7AS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbgARDH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 22:07:58 -0500
Received: from m12-11.163.com ([220.181.12.11]:57785 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgARDH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 22:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=yoURl
        r+iXRZmV29G1EPstRBDQ8HNCEnr1ZMOsXdCGr8=; b=Wd/Zd7ASRA9F5iAa2S47t
        aQwBd//JKwmUB9xliocQgpP3ThsRWS6MI0w7mka9LPHi3Ihnm4oOtofSBDU9ZP8o
        QsioiuA0yzqgCvVrbyBV6m81yGZ9UWwqaFMl4560DPTofan5gzTkLUt4yf0hF0IX
        NaqgHfSHWKMfxG013mPkoA=
Received: from localhost (unknown [39.155.185.116])
        by smtp7 (Coremail) with SMTP id C8CowACnnZpbdiJesvSiHg--.65366S3;
        Sat, 18 Jan 2020 11:07:35 +0800 (CST)
Date:   Sat, 18 Jan 2020 11:09:17 +0800
From:   Tao Zhou <t1zhou@163.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/cputime: remove irqtime_account_idle_ticks
Message-ID: <20200118030917.GA5351@geo.homenetwork>
References: <1579144650-161327-1-git-send-email-alex.shi@linux.alibaba.com>
 <5c95e93d-c44c-b19e-62c0-b7c45c60e9e0@linux.alibaba.com>
 <20200118003207.GA4067@geo.homenetwork>
 <a9c6fa27-e0e3-7559-949d-93fcc1c0a1bb@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9c6fa27-e0e3-7559-949d-93fcc1c0a1bb@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: C8CowACnnZpbdiJesvSiHg--.65366S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr47Aw45Gw4xuFykCF43Awb_yoWfGFb_Zr
        n8CF1DWr1kJrs7Awn7trW0qF4qga1jyryFqwn0qF9xt3saka4fC3Z8twn5ZFs5JF48AFW5
        Xws5Aa9IvwnFyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUYLqXPUUUUU==
X-Originating-IP: [39.155.185.116]
X-CM-SenderInfo: vwr2x0rx6rljoofrz/xtbBdgOullUMMAMdxAAAs+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 10:04:12AM +0800, Alex Shi wrote:
> 
> 
> 在 2020/1/18 上午8:32, Tao Zhou 写道:
> > On Thu, Jan 16, 2020 at 11:44:28AM +0800, Alex Shi wrote:
> >>
> >>
> >> 在 2020/1/16 上午11:17, Alex Shi 写道:
> >>> irqtime_account_idle_ticks just add longer call path w/o enough meaning.
> >>> We don't bother remove this function to simply code and reduce a
> >>> bit object size of kernel.
> >>
> >> Sorry, above commit log need to revise as following:
> >>
> >> irqtime_account_idle_ticks just add longer call path w/o enough meaning.
> >> We'd better to remove this function to simply code and reduce a bit object
> >> size of kernel.
> > 
> > Looks good and better to me.
> 
> Thanks! 
> 
> Why not reply to lkml openly? :)

Sorry, I want to.
The mail can not send if dest/cc include 'linux-kernel@vger.kernel.org'
No VPN from me. I will try another mail address. Any advice?


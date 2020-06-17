Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397F1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 229D020888
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgFQOyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:54:40 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:11871 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbgFQOyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:54:39 -0400
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
        by smtp.ispras.ru (Postfix) with ESMTP id 735F8203BF;
        Wed, 17 Jun 2020 17:54:36 +0300 (MSK)
Date:   Wed, 17 Jun 2020 17:54:36 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Jacky Hu <hengqing.hu@gmail.com>
cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, yazen.ghannam@amd.com,
        bp@alien8.de, clemens@ladisch.de
Subject: Re: [PATCH] hwmon: (k10temp) Add AMD family 17h model 60h probe
In-Reply-To: <20200617071927.GA398128@i716>
Message-ID: <alpine.LNX.2.20.13.2006171739010.31660@monopod.intra.ispras.ru>
References: <20200616180940.GN13515@zn.tnic> <20200617013255.391975-1-hengqing.hu@gmail.com> <20200617034028.GA1614@roeck-us.net> <20200617071927.GA398128@i716>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've already said in my patch submission (which was Cc'ed to LKML,
linux-edac and linux-hwmon so you should have been able to find it):

>> It appears SMU offsets for reading current/voltage and CCD temperature
>> have changed for this generation (reads from currently used offsets
>> yield zeros), so those features cannot be enabled so trivially.

In https://github.com/FlyGoat/ryzen_nb_smu/issues/3 there some
reverse-engineered info that indicates that for Renoir, SMU region has been
moved to 0x6F000. Its layout also changed, as far as I can tell.

(also, please ask yourself if you want to offer the maintainers an apology)

Alexander

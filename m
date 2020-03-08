Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825CBC10F25
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 02:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A19206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 02:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgCHCNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 21:13:41 -0500
Received: from hua.moonlit-rail.com ([45.79.167.250]:49556 "EHLO
        hua.moonlit-rail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgCHCNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 21:13:40 -0500
Received: from 209-6-248-230.s2276.c3-0.wrx-ubr1.sbo-wrx.ma.cable.rcncustomer.com ([209.6.248.230] helo=boston.moonlit-rail.com)
        by hua.moonlit-rail.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux-1993@moonlit-rail.com>)
        id 1jAlRk-0005cF-8y
        for linux-kernel@vger.kernel.org; Sat, 07 Mar 2020 21:13:40 -0500
Received: from springdale.moonlit-rail.com ([192.168.71.35])
        by boston.moonlit-rail.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <linux-1993@moonlit-rail.com>)
        id 1jAlRj-0006yv-JI; Sat, 07 Mar 2020 21:13:39 -0500
Subject: Re: 5.5.x, 5.4.x: PAGE FAULT crashes the system multiple times / 24h
 <- HELP needed
To:     Udo van den Heuvel <udovdh@xs4all.nl>
References: <36e8696a-fb99-23dc-c458-21824fc807fb@xs4all.nl>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Kris Karas <linux-1993@moonlit-rail.com>
Message-ID: <c0549c08-074a-c15f-40d0-78e9d10dae4a@moonlit-rail.com>
Date:   Sat, 7 Mar 2020 21:13:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <36e8696a-fb99-23dc-c458-21824fc807fb@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Udo van den Heuvel wrote:
> I need help with this bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=206191
> How can I proceed when the bisect kernel becomes unbootable?

Hi Udo,
I have a few general suggestions you can try.

1.  Read the manpage on git-bisect(1), particularly the section about 
"git bisect skip," which attempts to ask git to bypass a test kernel 
that doesn't boot.

2.  If that doesn't work for you, when "bit bisect good/bad" tells you 
about what it will do next, try "git bisect visualize" to see a printout 
of what it will try.  Then, using that, try to pick your own place.  For 
example, you can say, "git reset --hard HEAD~3" to move the bisect 
midpoint three commits earlier, in the hope that that place will let you 
get a booting kernel.  (I'm not a wizard when it comes to git-bisect; 
I'm sure there are other people who can suggest better discipline in 
working your way through a non-booting test-case.)

3.  I have had bad luck with Gigabyte motherboards, and am not alone in 
that experience.  On my gigabyte motherboard, conflicting memory and I/O 
ranges are programmed into the BIOS in such a way that the kernel will 
attempt to allocate space that the BIOS is using but forgot to mention; 
when this happens, the kernel locks up and/or oopses.  To get around it, 
I have to patch the kernel with a "fake" resource reservation such that 
there are no overlaps.  One thing that helps here is to turn off the 
IOMMU; from your bugzilla report, it looks as if your kernel has found 
the IOMMU and is trying to use it.  The vanilla kernel runs just fine on 
my Gigabyte board, if I disable the IOMMU; but then I lose USB3 and can 
only use USB2 peripherals.

Good luck!
Kris

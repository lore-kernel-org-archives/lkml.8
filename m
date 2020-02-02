Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DF2C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 08:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BDA20863
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 08:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="BaVurHIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgBBITR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 03:19:17 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:38581 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgBBITQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 03:19:16 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 489P4b5b7lz9tyWH;
        Sun,  2 Feb 2020 09:19:11 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=BaVurHIL; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id B9NtGOyoWiNR; Sun,  2 Feb 2020 09:19:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 489P4b3vmYz9tyW9;
        Sun,  2 Feb 2020 09:19:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580631551; bh=nozbN1o9P4CquvGdWc1FeJctNG7HaAWCWuutf8WmoXU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BaVurHIL6TimjlEGYLds15Z9up+mVUQ6HV+193Whp9YFYK5rM+qPDpX1j0Fa5jLCv
         v9NWpQ21dmPmw6A/Z+xZ4BegodThZOkQUgVpRLkN0K0YjzDpsRRdSCWGxRUG3yReVW
         O72UzU/h74/kFSX47OMjhnFbv5L1NLTG6Lk2xUrA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B0F38B767;
        Sun,  2 Feb 2020 09:19:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id finORXVEXN_k; Sun,  2 Feb 2020 09:19:14 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C6DDD8B752;
        Sun,  2 Feb 2020 09:19:13 +0100 (CET)
Subject: Re: Latest Git kernel: avahi-daemon[2410]: ioctl(): Inappropriate
 ioctl for device
To:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     DTML <devicetree@vger.kernel.org>,
        Darren Stevens <darren@stevens-zone.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@ozlabs.org, "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, Christoph Hellwig <hch@lst.de>
References: <20200126115247.13402-1-mpe@ellerman.id.au>
 <CAPDyKFrbYmV6_nV6psVLq6VRKMXf0PXpemBbj48yjOr3P130BA@mail.gmail.com>
 <58a6d45c-0712-18df-1b14-2f04cf12a1cb@xenosoft.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <75aab3c9-1cb6-33bf-5de1-e05bbd98b6fb@c-s.fr>
Date:   Sun, 2 Feb 2020 09:19:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <58a6d45c-0712-18df-1b14-2f04cf12a1cb@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Le 02/02/2020 à 01:08, Christian Zigotzky a écrit :
> Hello,
> 
> We regularly compile and test Linux kernels every day during the merge 
> window. Since Thuesday we have very high CPU loads because of the avahi 
> daemon on our desktop Linux systems (Ubuntu, Debian etc).
> 
> Error message: avahi-daemon[2410]: ioctl(): Inappropriate ioctl for device

Do you know which ioctl, on which device ?
Can you take a trace of running avahi-daemon with 'strace' ?

Can you bisect ?

Christophe

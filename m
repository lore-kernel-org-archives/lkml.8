Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FD0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 05:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F12C20866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 05:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgHGFuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 01:50:44 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:26673 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725805AbgHGFuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 01:50:44 -0400
Received: from [192.168.1.41] ([92.140.224.28])
        by mwinf5d73 with ME
        id CVqc2300D0dNxE403Vqd5J; Fri, 07 Aug 2020 07:50:41 +0200
X-ME-Helo: [192.168.1.41]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 07 Aug 2020 07:50:41 +0200
X-ME-IP: 92.140.224.28
Subject: Re: [PATCH] epic100: switch from 'pci_' to 'dma_' API
To:     David Miller <davem@davemloft.net>
Cc:     kuba@kernel.org, snelson@pensando.io, mhabets@solarflare.com,
        vaibhavgupta40@gmail.com, mst@redhat.com, mkubecek@suse.cz,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200806201935.733641-1-christophe.jaillet@wanadoo.fr>
 <20200806.142311.94169513118353100.davem@davemloft.net>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <bbb337c9-7cb7-0809-2b25-b0c5bd6fd82a@wanadoo.fr>
Date:   Fri, 7 Aug 2020 07:50:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806.142311.94169513118353100.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/08/2020 à 23:23, David Miller a écrit :
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Date: Thu,  6 Aug 2020 22:19:35 +0200
> 
>> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> Christophe, the net-next tree is closed so I'd like to ask that you
> defer submitting these conversion patches until the net-next
> tree opens back up again.
> 
> Thank you.
> 
> 


Sure, sorry for the inconvenience.

CJ

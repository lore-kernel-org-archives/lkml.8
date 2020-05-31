Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8C6C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 01:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC3CC20715
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 01:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgEaBua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 21:50:30 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45536 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgEaBua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 21:50:30 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49ZLq73rVxz1qrGG;
        Sun, 31 May 2020 03:50:27 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49ZLq738d6z1r3kc;
        Sun, 31 May 2020 03:50:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id EySRwcSmJ6Xu; Sun, 31 May 2020 03:50:26 +0200 (CEST)
X-Auth-Info: i4STmeJ99b+tOLd8wRjIFzgy2TUSN36tnwgx7+SYrH4=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 31 May 2020 03:50:26 +0200 (CEST)
To:     changbin.du@gmail.com, linux-stable <stable@vger.kernel.org>
Cc:     acme@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org
References: <20200128152938.31413-1-changbin.du@gmail.com>
Subject: Re: [PATCH] perf: Make perf able to build with latest libbfd
From:   Marek Vasut <marex@denx.de>
Message-ID: <70322330-524c-14ab-aace-e460677e25e3@denx.de>
Date:   Sun, 31 May 2020 03:50:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200128152938.31413-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since commit
0ada120c883d ("perf: Make perf able to build with latest libbfd")
is in master, can it be backported to stable as well? I keep hitting
this with too new binutils on Linux 5.4.y and I have to keep
cherry-picking this commit to fix it.

Thanks

Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF34EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8719F207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L3hadNUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgESP5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 11:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgESP5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:57:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F8DC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=tTkkkLXvat2WWEItubKTjQ334RharZTntB+ctrFhAS4=; b=L3hadNUN5fAZvUhSyfc2xxUrJN
        CpVVr0Wfeb4WYagBAbi5Wld7S4mR1lnbVLZWbyNgXzLCQaAPGAyQW3VNBAXs0meRuxX4H5SEYUHEh
        z/87RZi+MpzeHMze+uTxoglfzotJh1oLer67FSFQJntHbphsGjVQPj/G5VRgD2GjNHjEJyMMiIscO
        jjtEy5cJJEcO4UDQLMVS82o5zPJaIsyTWjv2VyMAT+saNxo2ie+iP+/GONxHWqadRr+p79p9+M1ru
        ajfzqvdqvu3AIdY77YhjQW/5g/W0VzOyuTIPOg2ZWrvbM5yWe/NyKTufL0CQYmOSNzsAbAqGNze+L
        NKLxJf2w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb4c5-00063H-1v; Tue, 19 May 2020 15:57:05 +0000
Subject: Re: Difference in values of addresses in System.map and
 /proc/kallsyms
To:     Ajay Garg <ajaygargnsit@gmail.com>, linux-kernel@vger.kernel.org
References: <CAHP4M8Vj-BmDXQgF-rkLr5fthey7RVaZ-1o87yTUg=9uh4hEOw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <86ca00b0-576d-9cfe-8841-29df8d773f22@infradead.org>
Date:   Tue, 19 May 2020 08:57:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHP4M8Vj-BmDXQgF-rkLr5fthey7RVaZ-1o87yTUg=9uh4hEOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/22/19 8:28 AM, Ajay Garg wrote:
> Hi All.
> 
> My system is
> 
> ajay@latitude-3480:~$ uname -a
> Linux latitude-3480 4.13.0-38-generic #43~16.04.1-Ubuntu SMP Wed Mar
> 14 17:48:43 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
> 
> 
> When I see the address for a symbol, say linux_banner, in
> /boot/System.map-4.13.0-38-generic, it shows
> ffffffff81e00120 R linux_banner

That's a static (build-time) address.

> 
> However, when I see it in /proc/kallsyms, it shows
> ffffffffa7000120 R linux_banner
> 

That's where it actually was loaded to at boot time.

> 
> Also, I note that /proc/kallsyms addresses vary upon reboots, so I am
> a little confused as to what the entries in /proc/kallsyms really
> mean.

You forgot to provide the kernel config file.

Possibly it has this config item:
CONFIG_RANDOMIZE_BASE=y

You can read the help text for that config option in
arch/x86/Kconfig.


> So, will be grateful for some pointers from the experts :)
> 
> 
> Thanks and Regards,
> Ajay

If this doesn't explain what you are seeing, then
I don't know.  Maybe someone else can help.

-- 
~Randy


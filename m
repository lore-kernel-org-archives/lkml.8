Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3D4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54013208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbgEZIX7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:23:59 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:58404 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgEZIX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:23:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7EFA361D8DF6;
        Tue, 26 May 2020 10:23:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xAwN2BvGLLJD; Tue, 26 May 2020 10:23:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A3827608F451;
        Tue, 26 May 2020 10:23:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4FRZevMY5k1v; Tue, 26 May 2020 10:23:54 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 74FFE61D8DF6;
        Tue, 26 May 2020 10:23:54 +0200 (CEST)
Date:   Tue, 26 May 2020 10:23:54 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Sasha Levin <sashal@kernel.org>, hpa <hpa@zytor.com>,
        tglx <tglx@linutronix.de>, Don Porter <porter@cs.unc.edu>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, bp <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        chang seok bae <chang.seok.bae@intel.com>
Message-ID: <1712023835.270361.1590481434265.JavaMail.zimbra@nod.at>
In-Reply-To: <a95b490d33624d0e96198ac22d19c029@AcuMS.aculab.com>
References: <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com> <20200519164853.GA19706@linux.intel.com> <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu> <87h7w7qy18.fsf@nanos.tec.linutronix.de> <A9483B8B-C0DD-46CB-AD5D-D12EC61BB331@zytor.com> <20200524211945.GX33628@sasha-vm> <CAFLxGvxeg6+DY1LMTzvJe3=iW=zLyUj4xTRda99DurKdS6TDWw@mail.gmail.com> <a95b490d33624d0e96198ac22d19c029@AcuMS.aculab.com>
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: Enable FSGSBASE instructions
Thread-Index: AQHWMgPzfS83L7jCjkmVt+IA3E+z2Ki3rUyAgACxb4CAAacDQJpcrz9d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "David Laight" <David.Laight@ACULAB.COM>
> An: "Richard Weinberger" <richard.weinberger@gmail.com>, "Sasha Levin" <sashal@kernel.org>
> CC: "hpa" <hpa@zytor.com>, "tglx" <tglx@linutronix.de>, "Don Porter" <porter@cs.unc.edu>, "Jarkko Sakkinen"
> <jarkko.sakkinen@linux.intel.com>, "Andi Kleen" <ak@linux.intel.com>, "linux-kernel" <linux-kernel@vger.kernel.org>,
> "bp" <bp@alien8.de>, "Andy Lutomirski" <luto@kernel.org>, "Dave Hansen" <dave.hansen@intel.com>, "Tony Luck"
> <tony.luck@intel.com>, "Ravi V Shankar" <ravi.v.shankar@intel.com>, "chang seok bae" <chang.seok.bae@intel.com>
> Gesendet: Dienstag, 26. Mai 2020 10:12:02
> Betreff: RE: Re: [PATCH v12 00/18] Enable FSGSBASE instructions

> From: Richard Weinberger
>> Sent: 25 May 2020 08:55
> ...
>> P: Sadly too. Mostly because customer has custom module and forgot to set it GPL
> 
> You want us to lie that custom modules are GPL?

No. Of course not.

But after thinking twice most guys realize that the have to use GPL
no matter whether they are using just EXPORT_SYMBOL() stuff or not.

But this is a completely different topic and something for company lawyers.

Thanks,
//richard

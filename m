Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B552C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 02:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C47206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 02:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=notmuch.email header.i=@notmuch.email header.b="BKAvCzrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbgEWCRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 22:17:47 -0400
Received: from mx.h4ck.space ([159.69.146.50]:55142 "EHLO mx.h4ck.space"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387413AbgEWCRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 22:17:46 -0400
Date:   Sat, 23 May 2020 04:17:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=notmuch.email;
        s=mail; t=1590200260;
        bh=tN0lzgWw1Y9SSXfLcncf8bC5dsKRRwfu7rERCQfQIDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=BKAvCzrf+p7FHgEsSRBDVfJ8SOfxx2aEKb8D9wm1HnxUeItIS6w3dacmZ84IzcVcF
         gkjEmgulhm8JJJ/SGlIHg5N3zFyRy3/+F2flauAQ/LoBLIB88TfSLfnSsvB+gcWbcu
         6uAHdq20PYSRdFUxZnp1a3EX4rmXlgNgStjXfpYE=
From:   Andreas Rammhold <andi@notmuch.email>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Brendan Shanks <bshanks@codeweavers.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: umip: AMD Ryzen 3900X, pagefault after emulate SLDT/SIDT
 instruction
Message-ID: <20200523021739.bbq5m6ze63ctouh6@wrt>
References: <20200519143815.cpsd2xfx2kl3khsq@wrt>
 <2330FAB4-A6CE-49E7-921C-B7D55763BDED@codeweavers.com>
 <20200519194320.GA25138@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200519194320.GA25138@ranerica-svr.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:43 19.05.20, Ricardo Neri wrote:
> I have a patch for this already that I wrote for testing purposes:
> https://github.com/ricardon/tip/commit/1692889cb3f8accb523d44b682458e234b93be50
> Perhaps it can be used as a starting point? Not sure what the spoofing
> value should be, though. Perhaps 0?

I tried the above patch (in modified/rebased version; hope that didn't
kill it [0]). The results are negative, as without the patch.

[0] https://github.com/andir/linux/commit/bda858f44a860762bc484da62833f57462220874

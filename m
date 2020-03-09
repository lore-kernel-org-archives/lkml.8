Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C50AC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEC62072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgCIKRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:17:32 -0400
Received: from bny206.haproxy.com ([37.58.153.206]:33756 "EHLO
        smtp.exceliance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIKRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:17:32 -0400
X-Greylist: delayed 1588 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2020 06:17:31 EDT
Received: by azote.haproxy.local (Postfix, from userid 509)
        id 2F304305A9; Mon,  9 Mar 2020 10:51:02 +0100 (CET)
Date:   Mon, 9 Mar 2020 10:51:02 +0100
From:   Willy TARREAU <wtarreau@haproxy.com>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, miguel.ojeda.sandonis@gmail.com,
        ksenija.stanojevic@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, mpm@selenic.com,
        herbert@gondor.apana.org.au, jonathan@buzzard.org.uk,
        benh@kernel.crashing.org, davem@davemloft.net,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com
Subject: Re: [PATCH RFC 0/3] clean up misc device minor numbers
Message-ID: <20200309095102.GA13722@haproxy.com>
References: <20200309021747.626-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309021747.626-1-zhenzhong.duan@gmail.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 10:17:44AM +0800, Zhenzhong Duan wrote:
> Some the misc device minor numbers definitions spread in different
> local c files, specially some are duplicate number with different
> name, some are same name with conflict numbers, some prefer dynamic
> minors.
> 
> This patchset try to address all of them.

Thanks for this! When I initially created panel.c about 20 years ago
I didn't even realize there was a miscdevice.h to centralize all this.
It's definitely cleaner this way.

> To be honest, I didn't try build on arm or sparc arch which some
> drivers depend on as I have little experience on cross-compile.
> But I still checked the patch carefully to ensure it builds
> in theory. Appreciate if anyone willing to test build on those arch.

So I've built for ARM to check, I could enable and successfully build
these modules that you touched: charlcd, panel, applicom, devsynth,
speakup_soft. The other ones might require less obvious configs to be
build-tested.

Willy

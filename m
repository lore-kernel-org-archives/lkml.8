Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DC6C47434
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FBC422CAE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgHFIQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:16:32 -0400
Received: from elvis.franken.de ([193.175.24.41]:36318 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbgHFIQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 04:16:26 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1k3b4Z-0000ze-00; Thu, 06 Aug 2020 10:16:23 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 7F708C0C58; Thu,  6 Aug 2020 10:16:05 +0200 (CEST)
Date:   Thu, 6 Aug 2020 10:16:05 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     WANG Xuerui <git@xen0n.name>,
        Serge Semin <fancer.lancer@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        Liangliang Huang <huanglllzu@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Provide Kconfig option for default IEEE 754
 conformance mode
Message-ID: <20200806081605.GA5715@alpha.franken.de>
References: <20200801061147.1412187-1-jiaxun.yang@flygoat.com>
 <d03a350c-842c-c041-f11b-017ec68e3de4@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d03a350c-842c-c041-f11b-017ec68e3de4@flygoat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 09:59:15PM +0800, Jiaxun Yang wrote:
> 
> 
> 在 2020/8/1 14:11, Jiaxun Yang 写道:
> >Requested by downstream distros, a Kconfig option for default
> >IEEE 754 conformance mode allows them to set their mode to
> >relaxed by default.
> >
> >Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >Reviewed-by: WANG Xuerui <git@xen0n.name>
> >Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> >Reviewed-by: Huacai Chen <chenhc@lemote.com>
> >
> >--
> >v2: Reword according to Xuerui's suggestion.
> >---
> Hi Thomas,
> 
> Is it possible to get this patch into 5.9 merge window?
> I think it have got enough review tag, and the config option was requested
> by a Debian developer. The next Debian release will take 5.9 lts kernel and
> they don't want to ship a non-bootable kernel in a major release.

no I won't include it into 5.9, I need to first go through links pointed
to by Maciej and fully understand what a proper solution could be.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

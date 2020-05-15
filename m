Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4076C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF01206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgEOQ4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:56:36 -0400
Received: from elvis.franken.de ([193.175.24.41]:54429 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEOQ4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:56:35 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jZddK-0003Kr-00; Fri, 15 May 2020 18:56:26 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 20A7AC04A2; Fri, 15 May 2020 18:55:57 +0200 (CEST)
Date:   Fri, 15 May 2020 18:55:57 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     jiaxun.yang@flygoat.com, Huacai Chen <chenhc@lemote.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v2 2/2] MIPS: Fix build errors under
 CONFIG_HAVE_STD_PC_SERIAL_PORT
Message-ID: <20200515165557.GA19106@alpha.franken.de>
References: <1589512985-27419-1-git-send-email-yangtiezhu@loongson.cn>
 <1589512985-27419-2-git-send-email-yangtiezhu@loongson.cn>
 <20200515073938.GA8289@alpha.franken.de>
 <7715fe64-5d28-f8c8-3b04-0bf2b9f16497@loongson.cn>
 <5AA0EB3A-DF33-4BE7-804C-45F6B51A0CF7@flygoat.com>
 <db6fda56-27da-3705-1270-805e61defe4b@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db6fda56-27da-3705-1270-805e61defe4b@loongson.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 04:54:09PM +0800, Tiezhu Yang wrote:
> Because CONFIG_HAVE_STD_PC_SERIAL_PORT is not used anymore,
> (2) Should we remove this arch/mips/kernel/8250-platform.c?

lets get rid of it.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

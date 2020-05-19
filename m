Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C06C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D997A20709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgESQb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:31:56 -0400
Received: from elvis.franken.de ([193.175.24.41]:59328 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbgESQbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:31:55 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jb59m-0001aq-01; Tue, 19 May 2020 18:31:54 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 81EFCC013A; Tue, 19 May 2020 18:04:00 +0200 (CEST)
Date:   Tue, 19 May 2020 18:04:00 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Zhi Li <lizhi01@loongson.cn>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Remove useless parameter of bootcmdline_init()
Message-ID: <20200519160400.GB16307@alpha.franken.de>
References: <1589785688-10426-1-git-send-email-lizhi01@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1589785688-10426-1-git-send-email-lizhi01@loongson.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 03:08:08PM +0800, Zhi Li wrote:
> The parameter "cmdline_p" is useless in bootcmdline_init()，remove it.
> 
> Signed-off-by: Zhi Li <lizhi01@loongson.cn>

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

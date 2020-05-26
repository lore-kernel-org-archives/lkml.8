Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3BBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A352084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgEZNHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 09:07:16 -0400
Received: from elvis.franken.de ([193.175.24.41]:39897 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgEZNHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 09:07:15 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jdZIW-00088o-02; Tue, 26 May 2020 15:07:12 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id DA835C041A; Tue, 26 May 2020 15:05:25 +0200 (CEST)
Date:   Tue, 26 May 2020 15:05:25 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Lichao Liu <liulichao@loongson.cn>
Cc:     YuanJunQing <yuanjunqing66@163.com>, paulburton@kernel.org,
        chenhc@lemote.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix IRQ tracing when call handle_fpe()
Message-ID: <20200526130525.GC8487@alpha.franken.de>
References: <20200525033123.13114-1-yuanjunqing66@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525033123.13114-1-yuanjunqing66@163.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 02:03:14PM +0800, Lichao Liu wrote:
> From: YuanJunQing <yuanjunqing66@163.com>
> 
> Register "a1" is unsaved in this function,
>  when CONFIG_TRACE_IRQFLAGS is enabled,
>  the TRACE_IRQS_OFF macro will call trace_hardirqs_off(),
>  and this may change register "a1".
>  The variment of register "a1" may send SIGFPE signal
>  to task when call do_fpe(),and this may kill the task.
> 
> Signed-off-by: YuanJunQing <yuanjunqing66@163.com>

if you send patches from other people, please add your
Signed-off-by.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

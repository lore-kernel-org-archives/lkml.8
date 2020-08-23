Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE8DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 04:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBFA20767
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 04:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgHWE4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 00:56:08 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:40577 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgHWE4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 00:56:07 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 07N4txw6025979;
        Sun, 23 Aug 2020 06:55:59 +0200
Date:   Sun, 23 Aug 2020 06:55:59 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     richard clark <richard.xnu.clark@gmail.com>
Cc:     linux-kernel@vger.kernel.org, andreyknvl@google.com
Subject: Re: Why KASAN doesn't detect this stack oob fault?
Message-ID: <20200823045559.GA25758@1wt.eu>
References: <CAJNi4rPKTarta5rfhNWSsLqa+Z6qo=FGFygfmT7kuZi11sr3VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJNi4rPKTarta5rfhNWSsLqa+Z6qo=FGFygfmT7kuZi11sr3VQ@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 11:04:34AM +0800, richard clark wrote:
> Hi guys,
> 
> I ins a kmod with below code in a KASAN enabled kernel (
> 5.7.0,
> CONFIG_KASAN=y
> CONFIG_KASAN_GENERIC=y
> CONFIG_KASAN_OUTLINE=y):
> 
> static int kmod_init(void)
> {
>     int i;
>     int arr[4];
> 
>     for (i = 0; i < 20; i++) {
>         arr[i] = i;
>         printk("arr[%d] = %d\n", i, arr[i]);
>     }
>     return 0;
> }
> 
> The output is after insmod:
> 
> [ 1511.800683] arr[0] = 0
> [ 1511.800685] arr[1] = 1
> [ 1511.800686] arr[2] = 2
> [ 1511.800687] arr[3] = 3
> [ 1511.800688] arr[4] = 4
> [ 1511.800690] arr[5] = 5
> [ 1511.800691] arr[6] = 6
> [ 1511.800692] arr[7] = 7
> [ 1511.800693] arr[8] = 8
> [ 1511.800694] arr[9] = 9
> [ 1511.800695] arr[10] = 10
> [ 1511.800696] arr[11] = 11
> [ 1511.800697] arr[12] = 12
> [ 1511.800699] arr[13] = 13
> [ 1511.800700] arr[14] = 14
> [ 1511.800701] arr[15] = 15
> [ 1511.800702] arr[16] = 16
> [ 1511.800704] arr[17] = 17
> [ 1511.800705] arr[18] = 18
> [ 1511.800706] arr[19] = 19
> 
> The kernel is not tainted and the gcc version is 7.5 used to build the kernel.
> The question is:
> 1. Why the stack out-of-bound can work?
> 2. Why the KASAN doesn't detect this?

Have you verified in the output code that the compiler didn't optimize
the stack access away since it doesn't need it ?

Just to make sure, do it in two distinct loops so that there are more
chances for the stack to be really used:

 static int kmod_init(void)
 {
     int i;
     int arr[4];
 
     for (i = 0; i < 20; i++)
         arr[i] = i;

     for (i = 0; i < 20; i++)
         printk("arr[%d] = %d\n", i, arr[i]);

     return 0;
 }

Willy

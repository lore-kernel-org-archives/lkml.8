Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E4FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 07:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4762081A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 07:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgF0Hbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 03:31:33 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:47333 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgF0Hbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 03:31:33 -0400
Received: from [192.168.42.210] ([93.22.39.58])
        by mwinf5d41 with ME
        id w7XV2200A1FGr9H037XViA; Sat, 27 Jun 2020 09:31:31 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 27 Jun 2020 09:31:31 +0200
X-ME-IP: 93.22.39.58
Subject: Re: [PATCH V3] firmware: stratix10-svc: Fix some error handling code
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     richard.gong@linux.intel.com, atull@kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <0ecc14c7-b4df-1890-fbe7-91307c2db398@wanadoo.fr>
 <20200626193720.949431-1-christophe.jaillet@wanadoo.fr>
 <20200627051556.GD233327@kroah.com>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <eb3ed7ba-902e-8ecf-1246-82ce88efd436@wanadoo.fr>
Date:   Sat, 27 Jun 2020 09:31:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200627051556.GD233327@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 27/06/2020 à 07:15, Greg KH a écrit :
> On Fri, Jun 26, 2020 at 09:37:20PM +0200, Christophe JAILLET wrote:
>> ---
>> v2: takes Dan's comment into account and fix another resource leak.
>> v3: merge the previous 4 patches in a single one to ease review
>
> No, 4 small patches are _MUCH_ easier to review than one larger one that
> mixes everything together.  Who told you to put them together?

The cover letter of v2 serie can be found at [1].
The request for merging them in 1 patch is in [2].

V3, should be the same as v2, but all in one.

[1]: https://lkml.org/lkml/2020/4/29/77
[2]: https://lkml.org/lkml/2020/5/5/541

CJ

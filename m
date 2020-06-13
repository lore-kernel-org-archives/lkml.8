Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67623C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491B32074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgFMTWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 15:22:10 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:35372 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726304AbgFMTWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 15:22:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 96E1E1F08;
        Sat, 13 Jun 2020 19:22:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rain66_2f09add26de7
X-Filterd-Recvd-Size: 1517
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat, 13 Jun 2020 19:22:07 +0000 (UTC)
Message-ID: <fa8b72be8316e6ed50371e24be1a7ad9c6be5127.camel@perches.com>
Subject: Re: [PATCH v2 20/24] dyndbg: WIP towards debug-print-class based
 callsite controls
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, akpm@linuxfoundation.org,
        gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk
Date:   Sat, 13 Jun 2020 12:22:06 -0700
In-Reply-To: <20200613155738.2249399-21-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
         <20200613155738.2249399-21-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-06-13 at 09:57 -0600, Jim Cromie wrote:
> 3- pr_class:5 gives 32 print-classes
>    we can map [1-9a-w] to select any pr_class with 1 char
>    then "12", "af" work as noted.
>    it is succinct, but arcane.

arcane generally isn't useful.

>    but it does allow mnemonic choices of pr_class
>    - l,m,h	low, mid, hi
>    - l,r	left right

I believe there to be no value in mnemonic input
to debug_<class>

I think 0x<hex_mask>, 0b<binary_bits>, 0<octal_bits>
and <decimal> level is more than enough.

And likely just 0x<hex> and <decimal> is enough.


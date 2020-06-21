Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8638C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 19:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9707E25231
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 19:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgFUTM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 15:12:57 -0400
Received: from smtprelay0207.hostedemail.com ([216.40.44.207]:45460 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729279AbgFUTM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 15:12:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E526018224D6E;
        Sun, 21 Jun 2020 19:12:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cows87_5b0326926e2c
X-Filterd-Recvd-Size: 1505
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun, 21 Jun 2020 19:12:54 +0000 (UTC)
Message-ID: <cb10e0a1a35e7dfc4f6a27dacb7883eaa3864811.camel@perches.com>
Subject: Re: kbuild: separate kerneldoc warnings from compiler warnings
From:   Joe Perches <joe@perches.com>
To:     Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 21 Jun 2020 12:12:53 -0700
In-Reply-To: <591473.1592679153@turing-police>
References: <591473.1592679153@turing-police>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-06-20 at 14:52 -0400, Valdis Klētnieks wrote:
> This patch introduces a new build flag 'K=1' which controls whether kerneldoc
> warnings should be issued, separating them from the compiler warnings that W=
> controls.
[]
> diff --git a/Makefile b/Makefile
[]
> @@ -1605,6 +1605,7 @@ PHONY += help
>  	@echo  '                       (sparse by default)'
>  	@echo  '  make C=2   [targets] Force check of all c source with $$CHECK'
>  	@echo  '  make RECORDMCOUNT_WARN=1 [targets] Warn about ignored mcount sections'
> +	@echo  '  make K=1   [targets] Warn about problems in kerneldoc comments'

Seems sensible. Thanks.



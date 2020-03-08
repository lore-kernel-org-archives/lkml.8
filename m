Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21C2C10F25
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 03:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F6420656
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 03:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCHDDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 22:03:31 -0500
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:39111 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726269AbgCHDDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 22:03:31 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 22264180A884B;
        Sun,  8 Mar 2020 03:03:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: paste19_58aa84c038c29
X-Filterd-Recvd-Size: 1337
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Mar 2020 03:03:29 +0000 (UTC)
Message-ID: <4304de54a44b7c8c22d8c2d9249d716664cf5ce8.camel@perches.com>
Subject: Re: [PATCH] cvt_fallthrough: A tool to convert /* fallthrough */
 comments to fallthrough;
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com
Date:   Sat, 07 Mar 2020 19:01:52 -0800
In-Reply-To: <576fe2ab-7937-4698-b32a-8599813d6ad1@embeddedor.com>
References: <b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com>
         <576fe2ab-7937-4698-b32a-8599813d6ad1@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-03-07 at 15:30 -0600, Gustavo A. R. Silva wrote:
> Some people consistently add blank lines as part of their code style,
> and if I were
> one of those people, I wouldn't like to have such lines removed.

It's a patch generator, it's not perfect.
Nothing is nor ever will be.
It's quite simple to add blank lines if that's
what any maintainer desires.



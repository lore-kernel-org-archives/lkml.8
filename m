Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866EDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 06:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F2D207F7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 06:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbgEWGOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 02:14:50 -0400
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:33310 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387446AbgEWGOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 02:14:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 71542182CED28;
        Sat, 23 May 2020 06:14:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: list31_1c0598526d2d
X-Filterd-Recvd-Size: 1471
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 23 May 2020 06:14:48 +0000 (UTC)
Message-ID: <bebc39aff642692e63f52874a9b5bbd212611abf.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update my maintainer entries to reorder
 email addresses
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     davem@davemloft.net, robh@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 May 2020 23:14:47 -0700
In-Reply-To: <20200523075720.64e24d11@coco.lan>
References: <20200523021928.67126-1-skhan@linuxfoundation.org>
         <20200523075720.64e24d11@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-05-23 at 07:57 +0200, Mauro Carvalho Chehab wrote:
> Hi Shuah,
> 
> Em Fri, 22 May 2020 20:19:28 -0600
> Shuah Khan <skhan@linuxfoundation.org> escreveu:
> 
> > get_maintainer.pl picks only the first email address found in the file.
> > Reorder my email addresses so it finds my linuxfoundation.org email.
> 
> Next time someone would run the ordering script again, this patch
> would need to be re-applied.

Not so.
Reordering does not change maintainer emails entries.
Reordering only happens to file patterns.



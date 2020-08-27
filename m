Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DECC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5EEC20848
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgH0Ws0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:48:26 -0400
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:49820 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727906AbgH0WsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:48:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id DC5BC181D330D;
        Thu, 27 Aug 2020 22:48:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: oven23_04042e627070
X-Filterd-Recvd-Size: 1848
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Aug 2020 22:48:17 +0000 (UTC)
Message-ID: <773aa01add27d7c5595f5cda9d3d2b791190c374.camel@perches.com>
Subject: Re: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cocci <cocci@systeme.lip6.fr>,
        accessrunner-general@lists.sourceforge.net,
        Alex Dewar <alex.dewar90@gmail.com>
Date:   Thu, 27 Aug 2020 15:48:16 -0700
In-Reply-To: <adfca3f2-561a-9d91-c064-cf01c2b573e7@linux.com>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
         <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
         <20200827071537.GA168593@kroah.com>
         <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
         <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
         <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
         <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
         <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
         <5853c58e-7d26-2cf9-6cbf-698ecd93cbf9@linux.com>
         <alpine.DEB.2.22.394.2008272334500.2482@hadrien>
         <d6d5836196208d5280cedf5837952096c3518852.camel@perches.com>
         <adfca3f2-561a-9d91-c064-cf01c2b573e7@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-28 at 01:38 +0300, Denis Efremov wrote:
> > This will match it (the difference is in the ';'):

thanks.



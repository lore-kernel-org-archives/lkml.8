Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5E4C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A86320848
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgH0WMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:12:02 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:35818 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726256AbgH0WMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:12:02 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 854B78123E2F;
        Thu, 27 Aug 2020 22:12:01 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 74415182CED34;
        Thu, 27 Aug 2020 22:12:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fly24_1910e5127070
X-Filterd-Recvd-Size: 2747
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Aug 2020 22:11:58 +0000 (UTC)
Message-ID: <ca08f34a5aaa3e9031a934296dd97fc806dab66f.camel@perches.com>
Subject: Re: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        cocci <cocci@systeme.lip6.fr>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "accessrunner-general@lists.sourceforge.net" 
        <accessrunner-general@lists.sourceforge.net>
Date:   Thu, 27 Aug 2020 15:11:57 -0700
In-Reply-To: <c3926f18f98e446daad957cd66a94890@AcuMS.aculab.com>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
         <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
         <20200827071537.GA168593@kroah.com>
         <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
         <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
         <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
         <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
         <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
         <cf9b1ea3716305447be43bffc8f90b7ef7292f5b.camel@perches.com>
         <c3926f18f98e446daad957cd66a94890@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-27 at 22:03 +0000, David Laight wrote:
> From: Joe Perches
> > Sent: 27 August 2020 21:30
> ...
> > Perhaps what's necessary is to find any
> > appropriate .show function and change
> > any use of strcpy/sprintf within those
> > function to some other name.
> > 
> > For instance:
> > 
> > drivers/isdn/mISDN/core.c-static ssize_t name_show(struct device *dev,
> > drivers/isdn/mISDN/core.c-                       struct device_attribute *attr, char *buf)
> > drivers/isdn/mISDN/core.c-{
> > drivers/isdn/mISDN/core.c:      strcpy(buf, dev_name(dev));
> > drivers/isdn/mISDN/core.c-      return strlen(buf);
> > drivers/isdn/mISDN/core.c-}
> > drivers/isdn/mISDN/core.c-static DEVICE_ATTR_RO(name);
> 
> That form ends up calculating the string length twice.
> Better would be:
> 	len = strlen(msg);
> 	memcpy(buf, msg, len);
> 	return len;

or given clang's requirement for stpcpy

	return stpcpy(buf, dev_name(dev)) - buf;

(I do not advocate for this ;)


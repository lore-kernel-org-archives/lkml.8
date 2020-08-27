Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D28EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33A620B80
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgH0VoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 17:44:07 -0400
Received: from smtprelay0012.hostedemail.com ([216.40.44.12]:40380 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726147AbgH0VoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 17:44:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B0C1F181D337B;
        Thu, 27 Aug 2020 21:44:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: paper52_5f066c127070
X-Filterd-Recvd-Size: 4701
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Aug 2020 21:44:02 +0000 (UTC)
Message-ID: <d6d5836196208d5280cedf5837952096c3518852.camel@perches.com>
Subject: Re: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cocci <cocci@systeme.lip6.fr>,
        accessrunner-general@lists.sourceforge.net,
        Alex Dewar <alex.dewar90@gmail.com>
Date:   Thu, 27 Aug 2020 14:44:01 -0700
In-Reply-To: <alpine.DEB.2.22.394.2008272334500.2482@hadrien>
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
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-27 at 23:36 +0200, Julia Lawall wrote:
> On Fri, 28 Aug 2020, Denis Efremov wrote:
[]
> Regarding current device_attr_show.cocci implementation, it detects the functions
> > by declaration:
> > ssize_t any_name(struct device *dev, struct device_attribute *attr, char *buf)
> > 
> > and I limited the check to:
> > "return snprintf"
> > pattern because there are already too many warnings.
> > 
> > Actually, it looks more correct to check for:
> > ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
> > {
> >         <...
> > *       snprintf@p(...);
> >         ...>
> > }
> > 
> > This pattern should also highlight the snprintf calls there we save returned
> > value in a var, e.g.:
> > 
> > ret += snprintf(...);
> > ...
> > ret += snprintf(...);
> > ...
> > ret += snprintf(...);
> > 
> > return ret;
> > 
> > > Something like
> > > 
> > > identifier f;
> > > fresh identifier = "sysfs" ## f;
> > > 
> > > may be useful.  Let me know if further help is needed.
> > 
> > Initially, I wrote the rule to search for DEVICE_ATTR(..., ..., func_name, ...)
> 
> This is what I would have expected.
> 
> > functions. However, it looks like matching function prototype is enough. At least,
> > I failed to find false positives. I rejected the initial DEVICE_ATTR() searching
> > because I thought that it's impossible to handle DEVICE_ATTR_RO()/DEVICE_ATTR_RW()
> > macroses with coccinelle as they "generate" function names internally with
> > "##". "fresh identifier" should really help here, but now I doubt it's required in
> > device_attr_show.cocci, function prototype is enough.
> 
> It's true that it is probably unique enough.

I tried:
@@
identifier f_show =~ "^.*_show$";
identifier dev, attr, buf;
const char *chr;
@@
ssize_t f_show(struct device *dev, struct device_attribute *attr, char
*buf)
{
	<...
(
-	sprintf
+	sysfs_sprintf
	(...);
|
-	snprintf(buf, PAGE_SIZE,
+	sysfs_sprintf(buf,
	...);
|
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_sprintf(buf,
	...);
|
	strcpy(buf, chr);
	sysfs_strcpy(buf, chr);
)
	...>
}

which finds direct statements without an assign
but that doesn't find

arch/arm/common/dmabounce.c:static ssize_t dmabounce_show(struct device *dev, struct device_attribute *attr, char *buf)
arch/arm/common/dmabounce.c-{
arch/arm/common/dmabounce.c-    struct dmabounce_device_info *device_info = dev->archdata.dmabounce;
arch/arm/common/dmabounce.c-    return sprintf(buf, "%lu %lu %lu %lu %lu %lu\n",
arch/arm/common/dmabounce.c-            device_info->small.allocs,
arch/arm/common/dmabounce.c-            device_info->large.allocs,
arch/arm/common/dmabounce.c-            device_info->total_allocs - device_info->small.allocs -
arch/arm/common/dmabounce.c-                    device_info->large.allocs,
arch/arm/common/dmabounce.c-            device_info->total_allocs,
arch/arm/common/dmabounce.c-            device_info->map_op_count,
arch/arm/common/dmabounce.c-            device_info->bounce_count);
arch/arm/common/dmabounce.c-}



Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA85BC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 16:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54F720707
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 16:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgH3QFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 12:05:24 -0400
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:33336 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725993AbgH3QFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 12:05:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1E88F100E7B42;
        Sun, 30 Aug 2020 16:05:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: skin10_3613be727088
X-Filterd-Recvd-Size: 3306
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sun, 30 Aug 2020 16:05:15 +0000 (UTC)
Message-ID: <09bacd3b3da948df632a0ffb4d7ca90603a45d06.camel@perches.com>
Subject: Re: [PATCH V2] sysfs: Add sysfs_emit and sysfs_emit_at to format
 sysfs output
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 30 Aug 2020 09:05:13 -0700
In-Reply-To: <8b01dc3a-3642-bc12-ae4d-42b90ec208f1@linux.com>
References: <a9054fb521e65f2809671fa9c18e2453061e9d91.1598744610.git.joe@perches.com>
         <c22b7006813b1776467a72e716a5970e9277b4b7.camel@perches.com>
         <8b01dc3a-3642-bc12-ae4d-42b90ec208f1@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-08-30 at 18:25 +0300, Denis Efremov wrote:
> 
> On 8/30/20 3:43 AM, Joe Perches wrote:
> > $ cat sysfs_emit.cocci
> > @@
> > identifier d_show =~ "^.*show.*$";
> 
> I think this additional pattern will allow to take more functions into the scope. 
> 
> @da@
> identifier show, store;
> expression name, mode;
> @@
> 
> (
>   DEVICE_ATTR(name, mode, show, store)
>   DEVICE_ATTR_PREALLOC(name, mode, show, store)
>   DEVICE_ATTR_IGNORE_LOCKDEP(name, mode, show, store)
> )

Thanks Denis.

I'll try that out too.

A trivial grep shows there are at least 130+
DEVICE_ATTR functions that have a show function
that doesn't include "show" in the function name.

$ grep-2.5.4 -rP --include=*.[ch] '\bDEVICE_ATTR\s*\(\s*\w+\s*,\s*[^,]+,\s*[^,]*,[^;]+;' * | \
  perl -p -e 's/[[:space:]]*//g; s/;/;\n/g' | \
  cut -f3 -d, | \
  grep -v show | \
  sort | uniq | wc -l
139

> @@
> // I think device_show_ulong, device_show_int, device_show_bool
> // functions deserve explicit handling because they are somewhat
> // reference implementations.

Those reference implementations could be send as
a separate patch but this preliminary script does
already handle them.

I do like the idea below of renaming the show
functions without _show in the name adding _show.

> identifier d_show = { da.show, device_show_ulong, device_show_int, device_show_bool };
> identifier dev, attr, buf;
> @@
> 
> * ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
>   {
>      ...
>   }
> 
> 
> I tried also to handle DEVICE_ATTR_RW, but I failed to use fresh identifier.
> This doesn't work:
> 
> @darw@
> identifier name;
> @@
> 
> (
>   DEVICE_ATTR_RW(name)
>   DEVICE_ATTR_RO(name)
>   DEVICE_ATTR_WO(name)
> )
> 
> @@
> identifier darw.name;
> fresh identifier d_show = name ## "_show"; // <== parse error
> identifier dev, attr, buf;
> @@
> 
> * ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
>   {
>      ...
>   }
> 
> 
> Regards,
> Denis


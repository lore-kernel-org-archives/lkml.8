Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D49C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 02:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370E520727
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 02:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbgEWC1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 22:27:02 -0400
Received: from smtprelay0043.hostedemail.com ([216.40.44.43]:54470 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387427AbgEWC1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 22:27:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E1340837F24A;
        Sat, 23 May 2020 02:27:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hook24_400a8fc26d2c
X-Filterd-Recvd-Size: 2265
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sat, 23 May 2020 02:26:59 +0000 (UTC)
Message-ID: <7366c990d4352e093ff7d17953079d7f0420c3a9.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update my maintainer entries to reorder
 email addresses
From:   Joe Perches <joe@perches.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, mchehab+huawei@kernel.org,
        davem@davemloft.net, robh@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 22 May 2020 19:26:58 -0700
In-Reply-To: <20200523021928.67126-1-skhan@linuxfoundation.org>
References: <20200523021928.67126-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-22 at 20:19 -0600, Shuah Khan wrote:
> get_maintainer.pl picks only the first email address found in the file.
> Reorder my email addresses so it finds my linuxfoundation.org email.

OK.

btw:  --noremove-duplicates is also an option.  For instance:

$ ./scripts/get_maintainer.pl -f Documentation/usb/usbip_protocol.rst
Valentina Manea <valentina.manea.m@gmail.com> (maintainer:USB OVER IP DRIVER)
Shuah Khan <shuah@kernel.org> (maintainer:USB OVER IP DRIVER)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
linux-usb@vger.kernel.org (open list:USB OVER IP DRIVER)
linux-doc@vger.kernel.org (open list:DOCUMENTATION)
linux-kernel@vger.kernel.org (open list)

vs:

$ ./scripts/get_maintainer.pl --noremove-duplicates -f Documentation/usb/usbip_protocol.rst
Valentina Manea <valentina.manea.m@gmail.com> (maintainer:USB OVER IP DRIVER)
Shuah Khan <shuah@kernel.org> (maintainer:USB OVER IP DRIVER)
Shuah Khan <skhan@linuxfoundation.org> (maintainer:USB OVER IP DRIVER)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
linux-usb@vger.kernel.org (open list:USB OVER IP DRIVER)
linux-doc@vger.kernel.org (open list:DOCUMENTATION)
linux-kernel@vger.kernel.org (open list)




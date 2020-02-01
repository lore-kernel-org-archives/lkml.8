Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA391C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942592067C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgBASnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:43:22 -0500
Received: from smtprelay0246.hostedemail.com ([216.40.44.246]:56011 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726335AbgBASnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:43:22 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 86BAF181D3025;
        Sat,  1 Feb 2020 18:43:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: yard08_571b1ee802d3a
X-Filterd-Recvd-Size: 3410
Received: from XPS-9350 (unknown [172.58.95.93])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sat,  1 Feb 2020 18:43:18 +0000 (UTC)
Message-ID: <08d88848280f93c171e4003027644a35740a8e8e.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: correct entries for ISDN/mISDN section
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     isdn4linux@listserv.isdn4linux.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 01 Feb 2020 10:41:39 -0800
In-Reply-To: <20200201124301.21148-1-lukas.bulwahn@gmail.com>
References: <20200201124301.21148-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-01 at 13:43 +0100, Lukas Bulwahn wrote:
> Commit 6d97985072dc ("isdn: move capi drivers to staging") cleaned up the
> isdn drivers and split the MAINTAINERS section for ISDN, but missed to add
> the terminal slash for the two directories mISDN and hardware. Hence, all
> files in those directories were not part of the new ISDN/mISDN SUBSYSTEM,
> but were considered to be part of "THE REST".

Not really.

> Rectify the situation, and while at it, also complete the section with two
> further build files that belong to that subsystem.
> 
> This was identified with a small script that finds all files belonging to
> "THE REST" according to the current MAINTAINERS file, and I investigated
> upon its output.

I believe the MAINTAINERS file will be better with the
proposed patch.

Perhaps this is a defect in the small script as
get_maintainer does already show the directory and
files as being maintained.

ie: get_maintainer.pl does this:

		##if pattern is a directory and it lacks a trailing slash, add one
		if ((-d $value)) {
		    $value =~ s@([^/])$@$1/@;
		}

So:

$ ./scripts/get_maintainer.pl -f drivers/isdn/mISDN
Karsten Keil <isdn@linux-pingi.de> (maintainer:ISDN/mISDN SUBSYSTEM)
netdev@vger.kernel.org (open list:ISDN/mISDN SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

and

$ ./scripts/get_maintainer.pl -f drivers/isdn/mISDN/dsp.h
Karsten Keil <isdn@linux-pingi.de> (maintainer:ISDN/mISDN SUBSYSTEM)
netdev@vger.kernel.org (open list:ISDN/mISDN SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

> Fixes: 6d97985072dc ("isdn: move capi drivers to staging")

And this patch likely does not warrant a 'Fixes:' tag.

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Arnd, please ack or even pick it.
> It is no functional change, so I guess you could simply pick in your own
> tree for minor fixes.
> 
>  MAINTAINERS | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f77fb8cdde3..b6a0c4fa8cfd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8908,8 +8908,10 @@ L:	isdn4linux@listserv.isdn4linux.de (subscribers-only)
>  L:	netdev@vger.kernel.org
>  W:	http://www.isdn4linux.de
>  S:	Maintained
> -F:	drivers/isdn/mISDN
> -F:	drivers/isdn/hardware
> +F:	drivers/isdn/mISDN/
> +F:	drivers/isdn/hardware/
> +F:	drivers/isdn/Kconfig
> +F:	drivers/isdn/Makefile
>  
>  ISDN/CMTP OVER BLUETOOTH
>  M:	Karsten Keil <isdn@linux-pingi.de>


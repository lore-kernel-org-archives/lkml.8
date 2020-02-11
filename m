Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9135C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C387B2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBKVpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:45:23 -0500
Received: from smtprelay0002.hostedemail.com ([216.40.44.2]:35935 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727361AbgBKVpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 16:45:22 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id F0EAE45BC;
        Tue, 11 Feb 2020 21:45:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dad09_4b9b27a703123
X-Filterd-Recvd-Size: 1989
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue, 11 Feb 2020 21:45:19 +0000 (UTC)
Message-ID: <161f395543309adb94475cbfbdd442616b68cda9.camel@perches.com>
Subject: Re: [PATCH 07/22] staging: exfat: Rename variable "MilliSecond" to
 "milli_second"
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Pragat Pandya <pragat.pandya@gmail.com>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Tue, 11 Feb 2020 13:44:03 -0800
In-Reply-To: <20200127115530.GZ1847@kadam>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
         <20200127101343.20415-8-pragat.pandya@gmail.com>
         <20200127115530.GZ1847@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-01-27 at 14:55 +0300, Dan Carpenter wrote:
> On Mon, Jan 27, 2020 at 03:43:28PM +0530, Pragat Pandya wrote:
> > Change all the occurrences of "MilliSecond" to "milli_second" in exfat.
> > 
> > Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
> > ---
> >  drivers/staging/exfat/exfat.h       |  2 +-
> >  drivers/staging/exfat/exfat_super.c | 16 ++++++++--------
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
> > index 85fbea44219a..5c207d715f44 100644
> > --- a/drivers/staging/exfat/exfat.h
> > +++ b/drivers/staging/exfat/exfat.h
> > @@ -228,7 +228,7 @@ struct date_time_t {
> >  	u16      hour;
> >  	u16      minute;
> >  	u16      second;
> > -	u16      MilliSecond;
> > +	u16      milli_second;
> 
> Normally we would just call it "ms".

msec is a bit more common.



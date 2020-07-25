Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCED1C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE65206E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgGYSja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 14:39:30 -0400
Received: from smtprelay0169.hostedemail.com ([216.40.44.169]:37382 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727034AbgGYSja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 14:39:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 610AD182CED2A;
        Sat, 25 Jul 2020 18:39:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spoon68_5e0c79a26f52
X-Filterd-Recvd-Size: 2538
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat, 25 Jul 2020 18:39:27 +0000 (UTC)
Message-ID: <d4427fb12f9d4735ec82355bbe99f7b3098fc1a4.camel@perches.com>
Subject: Re: [PATCH 1/1] STAGING - REALTEK RTL8188EU DRIVERS: Fix Coding
 Style Error
From:   Joe Perches <joe@perches.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anoop S <anoop.skumar1507@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Merwin Trever Ferrao <merwintf@gmail.com>,
        Rahul Gottipati <rahul.blr97@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 25 Jul 2020 11:39:26 -0700
In-Reply-To: <aab59eb1-baff-5de1-4e14-88ffc42db1fe@lwfinger.net>
References: <20200725122041.5663-1-anant.thazhemadam@gmail.com>
         <aab59eb1-baff-5de1-4e14-88ffc42db1fe@lwfinger.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-07-25 at 12:47 -0500, Larry Finger wrote:
> On 7/25/20 7:20 AM, Anant Thazhemadam wrote:
> > Running the checkpatch.pl script on the file for which patch was created, the
> > following error was found to exist.
> > ERROR: space required after that ',' (ctx:VxV)
> > 
> > Fixed the above error which was found on line #721 by inserting a blank
> > space at the appropriate position.
[]
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
[]
> > @@ -718,7 +718,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
> >   				res = _FAIL;
> >   			}
> >   		} else {
> > -			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo==NULL!!!\n",__func__));
> > +			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo==NULL!!!\n", __func__));
> >   			res = _FAIL;
> >   		}
> >   	}
> 
> In fixing one checkpatch.pl condition, you introduced another - the resulting 
> line is too long. You should fix only one such condition, but you should fix any 
> others that are introduced. You do need to document it.

I think that doesn't matter as it was also too long
before this change.

> Patch subjects for this driver should be written as "staging: rtl8188eu: .....".

How likely is it that this driver would ever be
moved to drivers/net/wireless/realtek/rtlwifi?



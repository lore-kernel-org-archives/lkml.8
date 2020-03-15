Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE59C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 04:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFE920722
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 04:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgCOEeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 00:34:17 -0400
Received: from smtprelay0212.hostedemail.com ([216.40.44.212]:33592 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726136AbgCOEeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 00:34:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 8B2AC837F24C;
        Sun, 15 Mar 2020 04:34:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: blood54_7c668a58d7328
X-Filterd-Recvd-Size: 1907
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sun, 15 Mar 2020 04:34:14 +0000 (UTC)
Message-ID: <1c31f0e1a0fe8ee268f27289f6f820c7e48596d5.camel@perches.com>
Subject: Re: [Outreachy kernel] [PATCH v2] Staging: rtl8723bs: rtw_mlme:
 Remove unnecessary conditions
From:   Joe Perches <joe@perches.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        sbrivio@redhat.com, daniel.baluta@gmail.com,
        nramas@linux.microsoft.com, hverkuil@xs4all.nl,
        Larry.Finger@lwfinger.net
Date:   Sat, 14 Mar 2020 21:32:29 -0700
In-Reply-To: <4deeaef8f8e0f23a9adbfd7d98840624e2994cf2.camel@gmail.com>
References: <20200313102912.17218-1-shreeya.patel23498@gmail.com>
         <25a1aca2c993ecb70ba7cd9c9e38bce9170a98b0.camel@perches.com>
         <4deeaef8f8e0f23a9adbfd7d98840624e2994cf2.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-03-14 at 16:58 +0530, Shreeya Patel wrote:
> This could be:
> >  	if ((!(phtpriv->ampdu_enable) && pregistrypriv->ampdu_enable ==
> > 1)) ||
> > 	    pregistrypriv->ampdu_enable == 2)
> > 		phtpriv->ampdu_enable = true;
> > 
> > Though it is probably more sensible to just set
> > phtpriv->ampdu_enable without testing whether or
> > not it's already set:
> > 
> > 	if (pregistrypriv->ampdu_enable == 1 ||
> > 	    pregistrypriv->ampdu_enable == 2)
> > 		phtpriv->ampdu_enable = true;
> 
> But the else-if block which I removed in v2 of this patch had nothing
> in the block.
> It was not assigning any value to "phtpriv->ampdu_enable". ( basically
> it was empty and useless)

Right, I misread the deletions from patch.



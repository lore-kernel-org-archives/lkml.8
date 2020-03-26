Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D62C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720F42073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgCZAKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 20:10:40 -0400
Received: from smtprelay0253.hostedemail.com ([216.40.44.253]:39390 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727525AbgCZAKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 20:10:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 2F914100E8420;
        Thu, 26 Mar 2020 00:10:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hose84_3fbcf8ba85931
X-Filterd-Recvd-Size: 1625
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Mar 2020 00:10:37 +0000 (UTC)
Message-ID: <9b369028adca4105c376094db569637cf8bb1fa2.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8188eu: cleanup long line in odm.c
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 25 Mar 2020 17:08:46 -0700
In-Reply-To: <20200325215940.9225-1-straube.linux@gmail.com>
References: <20200325215940.9225-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-25 at 22:59 +0100, Michael Straube wrote:
> Cleanup line over 80 characters by removing unnecessary parentheses.
[]
> diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
[]
> @@ -590,7 +590,7 @@ void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm)
>  	if (pDM_Odm->bLinked) {
>  		if (pDM_Odm->RSSI_Min > 25) {
>  			CurCCK_CCAThres = 0xcd;
> -		} else if ((pDM_Odm->RSSI_Min <= 25) && (pDM_Odm->RSSI_Min > 10)) {
> +		} else if (pDM_Odm->RSSI_Min <= 25 && pDM_Odm->RSSI_Min > 10) {

The test above this already guarantees pDM_Odm->RSSI_Min <= 25
so the block could be written just

		} else if (pDM->RSSI_Min > 10) {

>  			CurCCK_CCAThres = 0x83;
>  		} else {
>  			if (FalseAlmCnt->Cnt_Cck_fail > 1000)


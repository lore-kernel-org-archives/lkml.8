Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3433C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 22:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994C620789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 22:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407459AbgFYWNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 18:13:18 -0400
Received: from smtprelay0024.hostedemail.com ([216.40.44.24]:35756 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406337AbgFYWNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 18:13:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 9ED4F837F24A;
        Thu, 25 Jun 2020 22:13:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: soap97_08148e526e50
X-Filterd-Recvd-Size: 1802
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jun 2020 22:13:15 +0000 (UTC)
Message-ID: <049f51497b84e55e61aca989025b64493287cbab.camel@perches.com>
Subject: Re: [PATCH 2/2] staging: qlge: fix else after return or break
From:   Joe Perches <joe@perches.com>
To:     Coiby Xu <coiby.xu@gmail.com>, devel@driverdev.osuosl.org
Cc:     Manish Chopra <manishc@marvell.com>,
        "supporter:QLOGIC QLGE 10Gb ETHERNET DRIVER" 
        <GR-Linux-NIC-Dev@marvell.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:QLOGIC QLGE 10Gb ETHERNET DRIVER" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 25 Jun 2020 15:13:14 -0700
In-Reply-To: <20200625215755.70329-3-coiby.xu@gmail.com>
References: <20200625215755.70329-1-coiby.xu@gmail.com>
         <20200625215755.70329-3-coiby.xu@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-06-26 at 05:57 +0800, Coiby Xu wrote:
> Remove unnecessary elses after return or break.

unrelated trivia:

> diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
[]
> @@ -1391,12 +1391,11 @@ static void ql_dump_cam_entries(struct ql_adapter *qdev)
>  			pr_err("%s: Failed read of mac index register\n",
>  			       __func__);
>  			return;
> -		} else {
> -			if (value[0])
> -				pr_err("%s: CAM index %d CAM Lookup Lower = 0x%.08x:%.08x, Output = 0x%.08x\n",
> -				       qdev->ndev->name, i, value[1], value[0],
> -				       value[2]);

looks like all of these could use netdev_err

				netdev_err(qdev, "etc...",
					   i, value[1], value[0], value[2]);

etc...



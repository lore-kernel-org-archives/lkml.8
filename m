Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805ACC83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D6F82083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgD3Bvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:51:53 -0400
Received: from smtprelay0228.hostedemail.com ([216.40.44.228]:48620 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726282AbgD3Bvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:51:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 51CBD182CED28;
        Thu, 30 Apr 2020 01:51:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lock88_4a60899a54114
X-Filterd-Recvd-Size: 1288
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 Apr 2020 01:51:50 +0000 (UTC)
Message-ID: <d03d6118f6640ac170c8e55fb0846b73f75f6f3c.camel@perches.com>
Subject: Re: [PATCH v2 0/7] staging: qlge: Checkpatch.pl indentation fixes
 in qlge_main.c
From:   Joe Perches <joe@perches.com>
To:     Rylan Dmello <mail@rylan.coffee>,
        Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 29 Apr 2020 18:51:49 -0700
In-Reply-To: <cover.1588209862.git.mail@rylan.coffee>
References: <cover.1588209862.git.mail@rylan.coffee>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-29 at 21:31 -0400, Rylan Dmello wrote:
> This patchset fixes some indentation- and style-related issues in qlge_main.c
> reported by checkpatch.pl, such as:
> 
>   WARNING: Avoid multiple line dereference
>   WARNING: line over 80 characters
>   WARNING: suspect code indent for conditional statements

All of this looks reasonable to me.



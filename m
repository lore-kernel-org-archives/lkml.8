Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD36C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 11:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380C2207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 11:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgEXLR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 07:17:59 -0400
Received: from smtprelay0186.hostedemail.com ([216.40.44.186]:35582 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725873AbgEXLR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 07:17:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 2BCA318006CF4;
        Sun, 24 May 2020 11:17:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: eyes43_3a0b98a26d37
X-Filterd-Recvd-Size: 1344
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sun, 24 May 2020 11:17:56 +0000 (UTC)
Message-ID: <9ac5f51837a2e4e86fc4009ebc4d56ecfe733598.camel@perches.com>
Subject: Re: [PATCH v2 2/2] staging: rtl8188eu: make some arrays static const
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 24 May 2020 04:17:55 -0700
In-Reply-To: <20200524101514.20557-2-straube.linux@gmail.com>
References: <20200524101514.20557-1-straube.linux@gmail.com>
         <20200524101514.20557-2-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-24 at 12:15 +0200, Michael Straube wrote:
> Make some arrays in phy_iq_calibrate() static const and adjust
> the functions that take these arrays as parameters accordingly.
> Reduces object file size by 84 bytes (GCC 9.3.1 x86_64).

You could also do drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
and reduce data by a fair amount there too.

Just change the prototype for _rtl92d_phy_calc_curvindex there.


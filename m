Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A67C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 05:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55DA92067B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 05:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgFHFq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 01:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgFHFq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 01:46:26 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AE5C08C5C3;
        Sun,  7 Jun 2020 22:46:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jiAbu-00529k-5Y; Mon, 08 Jun 2020 05:46:14 +0000
Date:   Mon, 8 Jun 2020 06:46:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Rodolfo C. Villordo" <rodolfovillordo@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Forest Bond <forest@alittletooquiet.net>,Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,devel@driverdev.osuosl.org,linux-kernel@vger.kernel.org
Message-ID: <20200608054614.GO23230@ZenIV.linux.org.uk>
References: <20200607224156.GA24090@ip-172-31-24-31.ec2.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607224156.GA24090@ip-172-31-24-31.ec2.internal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 10:41:56PM +0000, Rodolfo C. Villordo wrote:
> Multiple line over 80 characters fixes by splitting in multiple lines.
> Warning found by checkpatch.pl

I doubt that checkpatch.pl can catch the real problems there:

* Hungarian Notation Sucks.  Really.
* so does CamelCase, especially for wonders like s_uGetRTSCTSRsvTime
* local variables are useful
* if a long expression keeps cropping up all over the place, you
probably are missing an inline helper.

PS: this
> -			buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, wCurrentRate);
> -			buf->time_stamp_off_b = vnt_time_stamp_off(pDevice, pDevice->byTopCCKBasicRate);
> +			buf->time_stamp_off_a =
> +				vnt_time_stamp_off(pDevice, wCurrentRate);
> +			buf->time_stamp_off_b =
> +				vnt_time_stamp_off(pDevice,
> +						   pDevice->byTopCCKBasicRate);
is no improvement.

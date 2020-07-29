Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0A0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B432076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596008726;
	bh=bw1/Arb/2b6w1pJkHqZYV38vMRfsiNEx/wIM0DDNp2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BSrMCgBK9giLrgYcsW8uzoXarnXSqnwhkhaXn4vNuU/Tf+IC9aYTFntGxjLMUjK4s
	 WRagjMFGHbXK3v6eTDUjY00wbQ2q2lwLPBNssVdFW+rv9bCfDccJTBlyKQS7Yaiv5S
	 8y6+9QhLNUQVGpvfAkOgx0IwX46iIhqz3ZBnU5TY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgG2HpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgG2HpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:45:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12C7C2076E;
        Wed, 29 Jul 2020 07:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596008724;
        bh=bw1/Arb/2b6w1pJkHqZYV38vMRfsiNEx/wIM0DDNp2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NL9UVLc6ikjjZauImbC/h5+dC/RQA9IL7yQuVoxtTvH4x/YBoFGEhQKK5VmxM7sMu
         9eJ+ODtqI1/RzY5LVVXXTniX4saTwFwUZVG36tu/3c2Zfe+Lc+BZNFciNcigkrIM5u
         v84A5cr2x8N1USJqrmHB3Pms+hfjNRCENk7lXn7A=
Date:   Wed, 29 Jul 2020 09:45:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ankit Baluni <b18007@students.iitmandi.ac.in>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v3] Staging : media : atomisp : fixed a brace coding
 sytle issue
Message-ID: <20200729074516.GA497024@kroah.com>
References: <20200728225935.28880-1-b18007@students.iitmandi.ac.in>
 <20200729073902.1704-1-b18007@students.iitmandi.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729073902.1704-1-b18007@students.iitmandi.ac.in>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 01:09:02PM +0530, Ankit Baluni wrote:
> Removed braces for a 'if' condition as it contain only single line & 
> there is no need for braces for such case according to coding style
> rules.
> 
> Signed-off-by: Ankit Baluni <b18007@students.iitmandi.ac.in>
> 
> ---
> Changes in v2:
> 	-Added more description about the patch.
> 	-Added space before the symobol '<' in 'From'
> 	 and 'Signed-off-by' line.
> Changes in v3:
> 	-Removed space before ':' in subject line.

No you did not :(

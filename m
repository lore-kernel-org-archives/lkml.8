Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A737C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2CB21D79
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585946442;
	bh=A/b6WcEW+sgH9ELmZUWFVlvFcBJ6Y5ZwDFeJXrdljgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xV3jUGP8FenRMzS3cqEeXMP2JNzfjQhjzoVMtyVhXsmJvoVg9Orgc1YuyMR1TQrIY
	 jEeud68qQ4fAxMLj3XV2aWHIbo13KM/NLmPvwcf/RyOqyWLL7Ozq4kO2Fry900ovKz
	 Y0DA92c/9R/0c96MlE/klRTTOTweXvt6c/xlU8bA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgDCUkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728108AbgDCUkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:40:40 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A98F621D6C;
        Fri,  3 Apr 2020 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585946439;
        bh=A/b6WcEW+sgH9ELmZUWFVlvFcBJ6Y5ZwDFeJXrdljgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCtSW77DmOIggT9pPUwNw/yxTO2kMUimvir19ZiIiCURT6k8tIAOAnJeo20VJE6PJ
         8TneIQB00aX2wLWdofO3lisn97vK/2swAHw2d1a9lPIq3aoEoVBRnd/nR2fnU1550R
         fB84Qety3Ov5CLHFyr/lEOEBm1MRkZajQBFLSS4w=
Received: by pali.im (Postfix)
        id 9DB575DE; Fri,  3 Apr 2020 22:40:37 +0200 (CEST)
Date:   Fri, 3 Apr 2020 22:40:37 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'namjae.jeon@samsung.com'" <namjae.jeon@samsung.com>,
        "'sj1557.seo@samsung.com'" <sj1557.seo@samsung.com>,
        "'viro@zeniv.linux.org.uk'" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Message-ID: <20200403204037.hs4ae6cl3osogrso@pali>
References: <TY1PR01MB15782019FA3094015950830590C70@TY1PR01MB1578.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB15782019FA3094015950830590C70@TY1PR01MB1578.jpnprd01.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 April 2020 02:18:15 Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp wrote:
> > I guess it was designed for 8bit types, not for long (64bit types) and
> > I'm not sure how effective it is even for 16bit types for which it is
> > already used.
> 
> In partial_name_hash (), when 8bit value or 16bit value is specified, 
> upper 8-12bits tend to be 0.
> 
> > So question is, what should we do for either 21bit number (one Unicode
> > code point = equivalent of UTF-32) or for sequence of 16bit numbers
> > (UTF-16)?
> 
> If you want to get an unbiased hash value by specifying an 8 or 16-bit value,

Hello! In exfat we have sequence of 21-bit values (not 8, not 16).

> the hash32() function is a good choice.
> ex1: Prepare by hash32 () function.
>    hash = partial_name_hash (hash32 (val16,32), hash);
> ex2: Use the hash32() function directly.
>    hash + = hash32 (val16,32);

Did you mean hash_32() function from linux/hash.h?

> > partial_name_hash(unsigned long c, unsigned long prevhash)
> > {
> >	return (prevhash + (c << 4) + (c >> 4)) * 11;
> > }
> 
> Another way may replace partial_name_hash().
> 
> 	return prevhash + hash32(c,32)
> 

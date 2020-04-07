Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADECC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18ED220771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586254014;
	bh=V9cZtdFZm4vp72AYlH0hCNozkSgOmUMQmfD7R0ja7VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OPAc5ZXjg8UJrx+Or/BfeBNCa2mglelb0f/m9DZhLtWln8gRbzpUWRpJQJw8KcL77
	 yr+8vVbQCi9/JCAEbOuObo0Nu2oufDYzMz4HAJ9/NERx+/W1/UjNLL+WnHFTYc/aoK
	 httEqu7dBYNoeiD93NacoOPwfPGOyZaUu4ctfEwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgDGKGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbgDGKGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:06:52 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09B772074B;
        Tue,  7 Apr 2020 10:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586254012;
        bh=V9cZtdFZm4vp72AYlH0hCNozkSgOmUMQmfD7R0ja7VY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x0bR0HrultTum5d1bG8ab+EPJyodFKlXKthf0O7D580Md4C/2E3YhDaDzx+ekGLwG
         w5svOwJbVmQmleIrjgLhDwNK5MecCA3ykdw78ppmoI0dnnBZGKFlagVOO2Iar4xd8s
         B3rzQaDzSmMCpxUHwhCcF7Otvyt+x6jg3ftI5VYs=
Received: by pali.im (Postfix)
        id 75F8B5F1; Tue,  7 Apr 2020 12:06:48 +0200 (CEST)
Date:   Tue, 7 Apr 2020 12:06:48 +0200
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
Message-ID: <20200407100648.phkvxbmv2kootyt7@pali>
References: <TY1PR01MB15782019FA3094015950830590C70@TY1PR01MB1578.jpnprd01.prod.outlook.com>
 <20200403204037.hs4ae6cl3osogrso@pali>
 <TY1PR01MB1578D63C6F303DE805D75DAA90C20@TY1PR01MB1578.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1578D63C6F303DE805D75DAA90C20@TY1PR01MB1578.jpnprd01.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 April 2020 09:37:38 Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp wrote:
> > > If you want to get an unbiased hash value by specifying an 8 or 16-bit
> > > value,
> > 
> > Hello! In exfat we have sequence of 21-bit values (not 8, not 16).
> 
> hash_32() generates a less-biased hash, even for 21-bit characters.
> 
> The hash of partial_name_hash() for the filename with the following character is ...
>  - 21-bit(surrogate pair): the upper 3-bits of hash tend to be 0.
>  - 16-bit(mostly CJKV): the upper 8-bits of hash tend to be 0.
>  - 8-bit(mostly latin): the upper 16-bits of hash tend to be 0.
> 
> I think the more frequently used latin/CJKV characters are more important
> when considering the hash efficiency of surrogate pair characters.
> 
> The hash of partial_name_hash() for 8/16-bit characters is also biased.
> However, it works well.
> 
> Surrogate pair characters are used less frequently, and the hash of 
> partial_name_hash() has less bias than for 8/16 bit characters.
> 
> So I think there is no problem with your patch.

So partial_name_hash() like I used it in this patch series is enough?

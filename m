Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25608C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE17520674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SSs2z12w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbgCPSqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:46:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732266AbgCPSqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=lykDkKuyOM3l9z/KLSOUCUyrIWWCYuYYMI2I8XCSJ9s=; b=SSs2z12wUEMFqXAMM2YxYy4BzE
        lSaWyhyjRS69av7RlhiAO8/wOS87ZAe8hPsnRnUqTP5wG3nsPwbgSZorUk2B3/gApFfgUrOD94oly
        jr7AYJmc558NJYJZnSwM0PIGzlm2QKeVNSt9i6VJx3iC2Q464Kt3gWDh+53PHZJYoajLiZz/+ymDn
        uzj/D6E8qDCn7tpsSg2kz+ege7V6fG0bKDTLy9uYvdjnmMvp/L9TnEuTvgJ6V/hpln9vgzi7SLC04
        7+aCa+B4rnluMg260EaS52vn+OgIGn9cmHs16aj6DEvY8f1/mTEHcPn2ugwj3W7keX2NTdAT8G7z4
        0Do0RNcg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDuka-0004Sn-S7; Mon, 16 Mar 2020 18:46:08 +0000
Subject: Re: KASAN: stack-out-of-bounds Write in mpol_to_str
To:     Entropy Moe <3ntr0py1337@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org
References: <CALzBtjLSqFhSNAf4YusxuE1piUTzOSLFGFD4RrhPLQAmgpyL5g@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9e699198-d1e4-f285-f4ed-15fbf8a8c16e@infradead.org>
Date:   Mon, 16 Mar 2020 11:46:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CALzBtjLSqFhSNAf4YusxuE1piUTzOSLFGFD4RrhPLQAmgpyL5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/20 12:57 PM, Entropy Moe wrote:
> Hello team,
> how are you ?
> I wanted to report a bug on mempolicy.c. I found the bug on the latest version of the kernel.
> 
> which is stack out of bound vulnerability.
> 
> I am attaching  report. 
> 
> If you need the POC crash code, I can provide.

Hi Moe,

Please post the POC code and your kernel .config file.

thanks.
-- 
~Randy


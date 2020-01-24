Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D74C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 03:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BE322522
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 03:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L4O5QTiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgAXD0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:26:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgAXD0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 22:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XJlLerOD1UXkhLb5gIq84QnCCCTCIxpF0oz9emc+tIM=; b=L4O5QTiVqaE4EluqUDvTF4rM4
        jTJB5jGbVRriECwque4buwL2qCIvN7CM9dSHkPcNmkwcldUIvXvl9Kq12SzQKbIfHeARPMP/0Bm4R
        IceciDoTkTLvKotdSd+LusVxT2W0GssLnPiowT2B0FSw0XuB7B671vYbr3j5+bLwo2oqZKLsceM4u
        XvINZthomGmSYd6ncN8ewvXxy7eM9fAJuIdIj7Ymhb+AeoK8L4y2kXE1ODyYJCSL9uxi21QJPinYo
        Lg00lKLFo3SjFBmyJnpcDfgB4YKYRPXwpi5g6BmSnjgEcxbGK/hQdorrzeAOBL5UwEbimQSVgD4DU
        8QtecEmTA==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iupcA-0002lP-1C; Fri, 24 Jan 2020 03:26:34 +0000
Subject: Re: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v5.6
To:     Olof Johansson <olof@lixom.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <CAK7LNASEaiFia8NKZN8++-9RfGXOPKSFuCkdukBk9Jy7+nHecQ@mail.gmail.com>
 <CAK7LNAT721bVwVQif--UY1dXMhq8NSRpkPOYTN-=nxyBSBOn2Q@mail.gmail.com>
 <CAOesGMgyh2NmR_AbEzC2jQe070e_u3zozWi=v7RjMXszXgetZg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f0109bf4-67b8-25b3-8035-dd651638dc7d@infradead.org>
Date:   Thu, 23 Jan 2020 19:26:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAOesGMgyh2NmR_AbEzC2jQe070e_u3zozWi=v7RjMXszXgetZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/20 7:22 PM, Olof Johansson wrote:
> Hi,
> 
> On Thu, Jan 23, 2020 at 6:49 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> Hi Arnd and Olof,
>>
>> I know it is already -rc7, but
>> it would be nice if you could pull this for the next MW.
>>
>> Thanks
>>
>> Masahiro
> 
> If you don't email us at soc@kernel.org, we're unlikely to see your
> pull requests. :(

Pray tell us where that is documented, please.
I am not familiar with it.
Thanks.

> In this case that's what happened. Please do so -- that way it gets
> caught in the patchtracker. I sort the patches to that alias in a
> special folder to make sure I see them too, since I get too much in my
> inbox and it easily gets lost.
> 
> Mind resending the two pull requests to that alias? That way you get
> the notification email when it's merged -- if I bounce it here I don't
> think you'll get it.
> 
> 
> Thanks,
> 
> -Olof
> 


-- 
~Randy


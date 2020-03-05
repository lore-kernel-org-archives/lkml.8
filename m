Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50F5C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E86208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583432950;
	bh=u0ta6nm59YBnC8llGbljGPYCdoxiJJKotM4+vC53CMA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Al4I3eQb1Vn6exbro+x0Tkg3fiQiFlb/3G4TBxiA2Bs0zyJ0ZoO1Lq5Uq7i9W2joU
	 YcT4afeXprG6u6k5/RqZN6NIUOui5YoS0zJx6e+EYhaf+HpIq2mxRszi/Je6cMGCrk
	 oEj6bbQwDAjBOL9XoFSuPxNncB/cbzMksm3+5S+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgCES3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:29:09 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35668 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCES3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:29:09 -0500
Received: by mail-lj1-f196.google.com with SMTP id a12so7212343ljj.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbDd5+msqmDyxpq6Lb6ucz4ESNTgElObbSpMaShcyms=;
        b=F3N0wZelss6cZK4QjAM8jWJ06sQQW3F4y8SDKE0irQdX19FJEsxMHK5XaReoIXNZ2x
         xAe1gUgz8okG6bAlHMI32BK/x7Gt3mMAGKYGD0lZomRxOWuvHYQhuJwNSVJvx+5ViBEs
         UALKk37VHLJG+gq7UTF61v3tIkdser14tfAO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbDd5+msqmDyxpq6Lb6ucz4ESNTgElObbSpMaShcyms=;
        b=c9eKA/0i4Tna++74Fv86Ge9ivVCFU3jdFDjvhnWyLmTWElkEa3/KYR/L7poiUV853y
         vVj4kRpmTpmlva3wkZtb1xycabppuGtqfbv6k7Z7QpPkWJiBkM4wSUkyMECMq3VnO9uI
         GCvlRwnCCmHkMtLlv0I7ULglPLSpHDj4qkKUPVcy0+ly33xTsOH97hYQuh5MsxASYloZ
         zCVmaAtmWHD8AV84TWzi53IeCsc95RsxfTtr4LrACiLVXfOuehFt6xoEkyuOMkMBZr4f
         sOadGud9p1EiU6tIN9KA5i3xVAY+tPtAHZxz5uEf0kCO1kbz6Rb/Qlk3NGhp/dPh/EUZ
         uUKw==
X-Gm-Message-State: ANhLgQ1xr5u/OaIwkcrhotfyxX/3W5RPBJUzLS73/quMGQda5Ew162gz
        PjlI6RapJYOiNTWjBA7AAFSJ9heKLfHocg==
X-Google-Smtp-Source: ADFU+vs8wF/ddMvqGXZAZ1G8/a5Wa98x+BmPKg6kOJDgESJkuM7M1zmUXFmO2u9aQeaukmToP6Yclg==
X-Received: by 2002:a2e:818e:: with SMTP id e14mr6050471ljg.2.1583432946288;
        Thu, 05 Mar 2020 10:29:06 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id z1sm4002000ljh.17.2020.03.05.10.29.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 10:29:06 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id e18so7207109ljn.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:29:05 -0800 (PST)
X-Received: by 2002:a05:651c:502:: with SMTP id o2mr6142302ljp.150.1583432944420;
 Thu, 05 Mar 2020 10:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20200305155901.xmstcqwutrb6s7pi@debian>
In-Reply-To: <20200305155901.xmstcqwutrb6s7pi@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Mar 2020 12:28:48 -0600
X-Gmail-Original-Message-ID: <CAHk-=wisKNsaOOCO8TfigKwmuqX83+KvntYeGq-KbOcSPunQbg@mail.gmail.com>
Message-ID: <CAHk-=wisKNsaOOCO8TfigKwmuqX83+KvntYeGq-KbOcSPunQbg@mail.gmail.com>
Subject: Re: [GIT PULL] Hyper-V commits for 5.6-rc
To:     Wei Liu <wei.liu@kernel.org>
Cc:     kys@microsoft.com, Stephen Hemminger <sthemmin@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        Sasha Levin <sashal@kernel.org>, haiyangz@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 9:59 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> This is mostly a "dry-run" attempt to sort out any wrinkles on my end.
> If I have done something stupid, let me know.

Looks fine. I generally like seeing the commits being a bit older than
these are - you seem to have applied or rebased them not all that long
before sending the pull request. I prefer seeing that they've been in
linux-next etc, but for soemthing small like this I guess it doesn't
much matter. Next time?

Also, it would generally be lovely to see signatures of the old
maintainer on the new maintainer's pgp key when transitions like this
happen, but it's not like we've really required that in the past
either. Literally just a "that would be nice"

                Linus

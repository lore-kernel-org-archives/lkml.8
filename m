Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DECC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E78F2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580853888;
	bh=ZnmhDfLnXruLaZLlXU1vlgejo+g1w30YRE0WPCBCh4w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JLSarmuJcc5R3eMsF0TfZx4fZg4ki4qE7857vg2ZkNxRk6oH3bU5FUwm4adR0lP3W
	 ye59ZpHiDSvZLE/OD/1VoDCj38nLV39oiUa6ioM6t+L4NUfQ5XoS14aRnD2DgZKjGa
	 SAFD3IxJUNw0pCfqSL7jQhKQvxjt9g8pMqpFdx0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgBDWEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 17:04:47 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43277 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgBDWEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 17:04:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so237852ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 14:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/k4/izTBIN3XubGza81OgicfYFOfcnjIp86foPKa92I=;
        b=aaOOUcqfut7eU8H+ATmPs2jGibggkqecvvvmXPHkxy9BQ9m9YPPYw3XEQjThsHPJ3d
         c5Frbx+FNmz5Kq+dXXXLUYIzq0ri5aV4sP71szy0VWxgN43j0ur0iy9Z+ZCXK2zWh48M
         iCb5LPkLM+dn5an3vw7p914L3L8K3/EUormq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/k4/izTBIN3XubGza81OgicfYFOfcnjIp86foPKa92I=;
        b=Zuy5G8uaN2xNrfQqCeVaYJ6ar4H1F+fJKaP8DlHDF/DbRO7t7fSQdk+x9YgNsfbbta
         45qnWI+7GjLYYDG7U8E19dTM3mafiKEnu/wrQNQQY/jAIpfiEDWIUEMtFKRhM6JXLvVM
         Wg3OuQUbbapj2RvoV+kARx8pt1V4vKCKp5hu71l/9YluDrFuvLJ/lXGcrPLHNpa2JOft
         irbHmbKWgzfifC6tSC4xOz6UJ5SwRxPNyAo3DGvhLBHWbZRETZMsAFJcKPb6ZFYFbi/Y
         i6XdqKywXhU+VTykGAfVPdL0U7aMCCnFTDTDo4WxiPBw7SiNdNmM5IaKKbM/9vjY7DOB
         f6Qw==
X-Gm-Message-State: APjAAAXBjT/10JUU3W0t3edrK8WFSBDSROhxJQqI0ox+uWo9sgtShOdS
        I0dpAK/FKlhVy1Dw+Cnqc4tS4KgYU5pwtA==
X-Google-Smtp-Source: APXvYqylkyICkwdP2h5Q0Gz9TxLKRCVbkYl77oLhd2eZOu0uKkGr9xKSu8ac0MbKDkwt3k4Tc9/t8A==
X-Received: by 2002:a2e:b5a5:: with SMTP id f5mr18063843ljn.162.1580853884565;
        Tue, 04 Feb 2020 14:04:44 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id h24sm12212389ljc.84.2020.02.04.14.04.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 14:04:42 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id t23so13332955lfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 14:04:41 -0800 (PST)
X-Received: by 2002:a19:f514:: with SMTP id j20mr16008847lfb.31.1580853881597;
 Tue, 04 Feb 2020 14:04:41 -0800 (PST)
MIME-Version: 1.0
References: <92cc6617-e2c3-e3b8-cf20-c8ccf748d37a@monstr.eu>
 <CAHk-=wiFMsSnjERZno13XbTF6m3pk2beAH5R-9RGct7hXzG3ig@mail.gmail.com> <f2b951c9-f904-58d7-0634-0a0d42f71066@monstr.eu>
In-Reply-To: <f2b951c9-f904-58d7-0634-0a0d42f71066@monstr.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Feb 2020 22:04:25 +0000
X-Gmail-Original-Message-ID: <CAHk-=wj1xRXSKMPt-y=A6-nUqDQQwK2eHHfF96zdk0bWkfUCzQ@mail.gmail.com>
Message-ID: <CAHk-=wj1xRXSKMPt-y=A6-nUqDQQwK2eHHfF96zdk0bWkfUCzQ@mail.gmail.com>
Subject: Re: [GIT PULL] arch/microblaze patches for 5.6-rc1
To:     Michal Simek <monstr@monstr.eu>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 5:37 PM Michal Simek <monstr@monstr.eu> wrote:
>
> Sorry about it. All that patches has been sent and done till the mid of
> January. Some of them even earlier.
> I just needed to remove one patch from queue which we found is causing
> the issue. That's why instead of revert I completely remove it and
> rebase the rest of the tree.
> I will handle that differently next time.

Note that if this happens again, and you have a really good reason to
rebase, please _mention_ that reason.

The whole taking me by surprise when I notice after-the-fact that I've
pulled something that was committed just hours before is about the
worst thing that can happen (always excepting obviously untested code
- me finding that the code doesn't even compile is even worse, of
course, even if it wasn't recently committed).

So if there's a good reason why something is very recent, and you
mention it, and it's not a common pattern, I get much less upset.

              Linus

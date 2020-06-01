Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA993C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 22:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BC12073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 22:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591051969;
	bh=L7pJH4radjiJjB/3uWqUplnKODxKG/Oi+cNaWRk7BpA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Lx2Fq4E+GAtr2WrGkUBllgzOMDNZrAtxLloA4tYaE9jmL7T/NYi4zT6nXSnWhH/bH
	 ViBn2M8YKxPXdcPO56YnzM8BHAJRdqdILJV/adF1OP+IzhK8YQ4EDyLOi3qPe0mZ+s
	 fOY2+yzIWnSdU/w6luQ56UBIwSRcAQrIqYO+maPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgFAWws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 18:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgFAWwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 18:52:47 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E41C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 15:52:46 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x27so4933131lfg.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 15:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYJP1jvhbQqjZ7HxRCF2xjLa+SLIL/UXCR0WcX2oCsU=;
        b=c2hTz1qFtXtSVlGaKWP+5+sQr31EQt3V0U6w6ST5lIG3zH1AYu01cZavADmHQYbi1g
         MRqjFBFVnQZ1yrYWIse/RwNRPx9ardLvER1f7ikdkgJy7tS6x2VfVhg1F/d51zssmvmj
         DBVJq9at7+4eVbC2zO1WqpQCa0+k+GHG4haHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYJP1jvhbQqjZ7HxRCF2xjLa+SLIL/UXCR0WcX2oCsU=;
        b=Emuul1oQHfGe+tltdWWXoY4swl66Kct7KKS4GzBtoxML69wIHQbrAV3hlP7bNQbUs1
         zKM1G+mdzk3lFuMieb4Rhe4q5x+BcqWT5GmIs+yaK/mEtN61xP7U3zbOyz/wzUZ5x6Z5
         zRM9r5QdWp2UYjiCJKuqtRAApQ+Nf5Nnj2RnuUU7JmNBkn1oM5dpAZg2WzeKF1DgK+KM
         k+c8NNnR/J1cZN2COR7PT/QIPh12SyMoSS7itYb2/YdokAo18ZmEBCQCQC++7XlnJ5KS
         p7gdkVExxsUCABtQucyqckciB+bW16Lt5Il/VSss/12lkoG2krh1BeYmadbi5kBNZZ5G
         c0iw==
X-Gm-Message-State: AOAM532wQthmEe2KJidot1ZdLZU3Nj2TjejBM5fM0Tvi21ADYKWbfXX/
        XoMKTGcSJbfuPesLnUb7gVOsNETb+Yo=
X-Google-Smtp-Source: ABdhPJzyDi5iIs63d1eOA+VIErqIiC7Qob0Fapi+kmclubQqyLT7TItE+soibmiTJULWuhHqgPPnKw==
X-Received: by 2002:ac2:4562:: with SMTP id k2mr12438953lfm.5.1591051964924;
        Mon, 01 Jun 2020 15:52:44 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id q15sm222248lfc.44.2020.06.01.15.52.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 15:52:44 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id m18so10230578ljo.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 15:52:43 -0700 (PDT)
X-Received: by 2002:a2e:150f:: with SMTP id s15mr11260953ljd.102.1591051963161;
 Mon, 01 Jun 2020 15:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200601094600.19c6fe0b@lwn.net>
In-Reply-To: <20200601094600.19c6fe0b@lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Jun 2020 15:52:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNQwW8LEb-ZDFuYphFxuJW0+tzE1jsYC64LQeGjB7aHg@mail.gmail.com>
Message-ID: <CAHk-=wiNQwW8LEb-ZDFuYphFxuJW0+tzE1jsYC64LQeGjB7aHg@mail.gmail.com>
Subject: Re: [GIT PULL] Documentation for 5.8
To:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 8:46 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> There will be, alas, more of the usual trivial merge conflicts.

Heh. And one of those conflicts was just due to the arm64 people
fixing some warnings differently from the doc people.

I took the doc version that kept the allegedly "unexpected
indentation", and fixed it by just adding the proper blank lines. That
seemed to be the more sphinx-aware fix.

Funnily enough, the commit from the arm64 tree that re-indented those
lines _also_ added the blank lines, so that's presumably what really
fixed the warning, and the re-indentation was just due to the warning
language implying it was needed.

             Linus

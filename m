Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516B6C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2853C20863
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583145526;
	bh=0mvRf+SAaOE7Usyf6yLvIyPFGpMahiDu5R9HVRI5Mcg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CiculkEZSAKgvl3QBwjlh0pyk26JMaHORRVElsvgbOIJBamLouawQL9Yhvd+FREIK
	 ok96g+862niIizqaBBEKHVA/yqf055QvONQ/CEzwHQhpoM6qGm8Ulovo5r+XCRhrQL
	 X97bNgI1vyggjtIMoi1a407DcrqEUBAOlRFEHc24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgCBKip convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:38:45 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45611 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbgCBKio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:38:44 -0500
Received: by mail-ot1-f67.google.com with SMTP id f21so629100otp.12;
        Mon, 02 Mar 2020 02:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MwWsoH3lbguISoV3Xmb+APpQTE7w8muFrbuI4gr/DUc=;
        b=MNRvfqPYfSDoi1ID6LgQ+c6vyDPkEN/TJuw6KfXrPs3mhLVoUzMsqMHKRNny9VxCXw
         eBY+PfOwIpiQ0hy7NvuMlmDtMZv7f+Y51JAJfEPaFfHzGaavhxSA4B4jPfY0Y6ZoWyRC
         ekKj5ZNiHsaY+0vHyn9ZPOIB/phtHj8Il83/5PQMLfOOa9lTPXVktQeX0Sw9koIvY7FX
         UO49livVATS0eHT1ysX7YQmRpIf07k4ILGh4TUueWrUcB7TpMCZsVzrfERboSXjf/IYn
         MDiRrVpvFLHbj8F0OnyyiqswoPZONzmmifXfU9Jqbi1yeVMnePEevGK2ajbkzyOXnXmr
         F/9Q==
X-Gm-Message-State: APjAAAVsz4U3CDzQgz/6ow5x2I4MztOBiIgQRTNhBYEry6oAX00U8oyJ
        JPCphGTKyv4apdoL0JQs78BJrqVgjHk2zAY5wXhX2j3i
X-Google-Smtp-Source: APXvYqwuqeK4Mzm3RU2tsEbKB/ADLbtbRGkvKRUCWJZj2FRf77xO4xC3hxyCGIR8gyg4OX3X8h7AqaxfpZbfqbHhNew=
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr12866890otn.262.1583145524239;
 Mon, 02 Mar 2020 02:38:44 -0800 (PST)
MIME-Version: 1.0
References: <2094703.CetWLLyMuz@kreacher> <CAD8Lp46VbG3b5NV54vmBFQH2YLY6wRngYv0oY2tiveovPRhiVw@mail.gmail.com>
 <CAPpJ_edfTg11QZs25MrThj2+FKUo2103rv7iYNzo=kr-jeg1MA@mail.gmail.com>
In-Reply-To: <CAPpJ_edfTg11QZs25MrThj2+FKUo2103rv7iYNzo=kr-jeg1MA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Mar 2020 11:38:32 +0100
Message-ID: <CAJZ5v0gB9yuVmPjJ_MvfT8aFpvP-X5JRsNfZn8+Mv5RwTednGg@mail.gmail.com>
Subject: Re: [PATCH 0/6] ACPI: EC: Updates related to initialization
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Drake <drake@endlessm.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 6:54 AM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
>
> Daniel Drake <drake@endlessm.com> 於 2020年2月28日 週五 下午5:43寫道：
> >
> > On Thu, Feb 27, 2020 at 10:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > The purpose of this series of update of the ACPI EC driver is to make its
> > > initialization more straightforward.
> > >
> > > They fix a couple of issues, clean up some things, remove redundant code etc.
> > >
> > > Please refer to the changelogs of individual patches for details.
> > >
> > > For easier access, the series is available in the git branch at
> > >
> > >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > >  acpi-ec-work
> > >
> > > on top of 5.6-rc3.
> >
> > Jian-Hong, can you please test this on Asus UX434DA?
> > Check if the screen brightness hotkeys are still working after these changes.
>
> Hi Rafael,
>
> Thanks for your patches, but we found an issue:
> The laptops like ASUS UX434DA's screen brightness hotkeys work before
> this patch series.  However, the hotkeys are failed with the patch
> "ACPI: EC: Unify handling of event handler installation failures".

So I have modified the series to avoid the change that can possibly break this.

Can you please pull the new series from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-ec-work

(same branch) and retest?

I'll post the updated patches later this week, but it would be good to
try them on now if possible.

Thanks!

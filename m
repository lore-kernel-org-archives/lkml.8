Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B98C83005
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40CEA206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVi818O1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgD1DVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 23:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgD1DVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:21:16 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFC1C03C1A9;
        Mon, 27 Apr 2020 20:21:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y4so19897061ljn.7;
        Mon, 27 Apr 2020 20:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/KX6i1az01qEnInKFuUccobP96F3x7Gqm3MaoBdJ1Q=;
        b=UVi818O1g/ys1qy9aULO5Os7hjcuazADOhDicMJbdwxPYfKJ0KXenLnaHZ/EVAjfyI
         VhHPvEDSPICTW84/LuGvbfbcirm05QOSXCLwtWN2SrMNQruewqCFlk8HE148KcpKyzOZ
         Wt0Mi4hWm0E+XfmCqAOJtUyBXcMwktVuTttJ5hMBEfP4TezrmrMJoB6bdRvHtvf+bYlo
         OIQ9/Z/RjL6b3s933PBPt4fgi2gng5FzJxsPHMZ006EPAdpKDQopz1rZBIF/kzTkR1Nh
         HIfAOv6iVSZKEqF1OKAOBSq5gDlDgiDrWO70TZzK6udJl8XQ2vpzRPZ+Pf151IF9cmNU
         MkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/KX6i1az01qEnInKFuUccobP96F3x7Gqm3MaoBdJ1Q=;
        b=MV0bMm51WaQm88A5JP1IJBCd7ztjC40sDSciqT1rbjobEbpMVM3ohwJZ5p9RAY+4N+
         YlUk47+EFHtD0aXxlQPid7RGeVDsr6+jX+BLMfXKiMhKFzwyjkEDeCRUTj4wd4lkuVgc
         6sxQwzC4AXAtm7AQ1qUhcBTGrP83XQsJdhmEfbsOb3HyjdHIyuGK1BaggW/NuA2V6Qy5
         VdbTcITfV+n6kR4g3g5HDFVKAmx494Oo5YBcPbojmwzb+NI3s+WxdemxvzsSOd70H3Zm
         fqVtt7nz6tWPjcw95fy8B2JHAYKeL42pCmPSG6ihpaTKSKzyCKDQBvaqekTRpWvgsZch
         aAxg==
X-Gm-Message-State: AGi0PuZ9ScIV20uDR9WNqTdwRv2GYkoLBBgd4js7BK4no1GGbyqhkoRU
        PP+QTnlDk98eVmVmVeH4oT+RVcBscLfD5TKHtAg=
X-Google-Smtp-Source: APiQypILa/9TL4Q9y6eHfQLCYco80j1PteU65bPrjee3cUAWC4E6yZG8jsBsMkLJqfyHL2969E9h0fnNTN/tC33+olU=
X-Received: by 2002:a05:651c:2011:: with SMTP id s17mr15147194ljo.242.1588044074054;
 Mon, 27 Apr 2020 20:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <8d29eba045ef18c5489e122b3668afc20431f15d.1588043236.git.baolin.wang7@gmail.com>
 <4b224e7bb703e15469e5cd79a54f7bc00a790fc5.1588043236.git.baolin.wang7@gmail.com>
 <62b3d9fc-1cc9-ac42-69e5-1c7bdac7bd0c@infradead.org>
In-Reply-To: <62b3d9fc-1cc9-ac42-69e5-1c7bdac7bd0c@infradead.org>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 28 Apr 2020 11:21:03 +0800
Message-ID: <CADBw62pRRqMW2c0OASS5KbwpjENr-kVnZwXcdLom5-sHUhntXw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mailbox: sprd: Add Spreadtrum mailbox driver
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     robh+dt@kernel.org, jassisinghbrar@gmail.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:16 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 4/27/20 8:10 PM, Baolin Wang wrote:
> > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> > index 5a577a6734cf..e03f3fb5caed 100644
> > --- a/drivers/mailbox/Kconfig
> > +++ b/drivers/mailbox/Kconfig
> > @@ -236,4 +236,12 @@ config SUN6I_MSGBOX
> >         various Allwinner SoCs. This mailbox is used for communication
> >         between the application CPUs and the power management coprocessor.
> >
> > +config SPRD_MBOX
> > +     tristate "Spreadtrum Mailbox"
> > +     depends on ARCH_SPRD || COMPILE_TEST
> > +     help
> > +       Mailbox driver implementation for the Spreadtrum platform. It is used
> > +       to send message between application processors and MCU. Say Y here if
> > +       you want to build the Spreatrum mailbox controller driver.
>
>                                 ^^typo^^

Ah, should be 'Spreadtrum', thanks for pointing it out.
Let's wait for Jassi's comments for this patch.

-- 
Baolin Wang

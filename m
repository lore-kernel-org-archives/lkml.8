Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293D2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032282080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lapb6oYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHTIJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgHTIIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:08:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294F5C061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 01:08:35 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so566064plk.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 01:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UyQuqwn4RZF56iSes2DwNieBx5SpVLzHQWszhjrntHk=;
        b=Lapb6oYHVPL5HNLwcPNs8MoFKbXLSYE2HQX+VtwSg4ZyjFXq7XlQltoIe56HYn9XBU
         LgwdfPt8FCiCKiRbg3IIeQgysyw919rVQUDSW3IajjJ4Bcb4v2VdKddnHiiHjmJkfgte
         vGNQRL95MAlkFXlYw11QN+/MX2YrmkdaJNPn3RX9kQKH1etDLseHML/CHfTp/SCPCwGw
         iDhSewBo6cWlO1VA8xkTEW5sYfnlr5ET52plBb+3U82O3jAIEDhQL3CziQeoxCA+45m8
         w/f5FVvfNttV9zaQbMZb3OubH8Q7zAW8LJ0J3oNih7c0jn0yUjeNIij+iKML5/wJG/Bc
         j1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UyQuqwn4RZF56iSes2DwNieBx5SpVLzHQWszhjrntHk=;
        b=RJ38Lb2l3EH1dCejlWSjKn7sAw39H/EbRamTqR4IEmqG63BbYdSXOkablePTMetJdx
         giI5dsRp/NNdCcAltjIl9TUE5BqczxD5FIyomRBMetWiPjtV/BD2Isl+3AnBYvDGEaWj
         +bh9ip/XQLeeiyCfyOWH5q7mnv8OBAzAkF27ZlI+Za8+kf0ESFHqrsjP7Fa+Ufi79bzk
         DbpAaeU6+XsbeZClBE8Y0pBgOHRdiw2TiPWP8rRQy+7LxGqoGgLCzt5qPRbzCPlq5du9
         ELktq80GDORt1G9Y5RP4BMwcHptMdjLopZOatp+duju123lOOn0B1l2YbQGvGxkZkRx5
         VKGA==
X-Gm-Message-State: AOAM530KJDZl/kofxqLk6f4fSIEw5ggQcPrCMsP78pOBx7m0ec4Ivu/O
        xKtWORFhyIqqiUXc3TFRAkRup7ZzKvau1Hgnq2r0pw==
X-Google-Smtp-Source: ABdhPJz0kFzwDoyHPV/MtXyJ7awqCWpml+jMHDpurrzZKfWF2c7tPKWf1HaPIVFCZtqGF9x1K04HyBAeG+49r9IiS7I=
X-Received: by 2002:a17:90a:f98e:: with SMTP id cq14mr1645144pjb.51.1597910914013;
 Thu, 20 Aug 2020 01:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200819161907.1155110-1-enric.balletbo@collabora.com>
 <C9E59107-CE83-4554-9447-5DE5BEE09A3B@fw-web.de> <CAGETcx9_A-E5b-JxT2G142mGxqoo8xqFNEgT+CNWt=oOv0Z5+w@mail.gmail.com>
 <a23bac35d20eb002bdfb5263bf5dd213@kernel.org>
In-Reply-To: <a23bac35d20eb002bdfb5263bf5dd213@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 20 Aug 2020 01:07:58 -0700
Message-ID: <CAGETcx-NpRzzeXYN-UBP1eAsC3s_AofSQ9rXOEmCjhLhKLnxWg@mail.gmail.com>
Subject: Re: [PATCH] Revert "irqchip/mtk-sysirq: Convert to a platform driver"
To:     Marc Zyngier <maz@kernel.org>
Cc:     Frank Wunderlich <wichtig@fw-web.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 12:56 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-08-19 19:51, Saravana Kannan wrote:
> > On Wed, Aug 19, 2020 at 9:52 AM Frank Wunderlich <wichtig@fw-web.de>
> > wrote:
> >>
> >> hi,
> >>
> >> does the fix you've linked to my revert [1] not work in your case?
> >>
> >> [1] https://patchwork.kernel.org/patch/11718481/
> >
> > Thanks for pointing it out Frank. Also, might want to avoid top
> > posting in the future.
> >
> > Enric, Can you please try that other fix and see if that solves your
> > issue?
>
> I think Enric was clear that the driver does probe correctly
> (meaning that he has the fix in his tree). It is everything else
> that breaks, because none of the drivers on the platform are
> equipped to defer their own probing.
>
> I think we need to change this works right now, meaning that we can't
> blindly change the behaviour of *built-in* drivers. I'll see if I can
> come up with something quickly, but I'll otherwise take Enric patch.

Sounds fair Marc.

Btw, Enric, out of curiosity, can you try adding "fw_devlink=on" to
your kernel command line to see if it helps? It basically ensures
proper probe ordering without depending on the drivers. There are some
corner cases where it still can't work properly (too much to explain
for a late night email), but if the platforms don't have those corner
cases it'll work perfectly.

I'm fine with the revert if Marc isn't able to find a quick fix to the
drivers, but this might also fix your problem right away.

-Saravana

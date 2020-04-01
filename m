Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E61CC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFA62063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zofr2vJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387697AbgDAQwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:52:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43130 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388734AbgDAQwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:52:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id n20so234355lfl.10;
        Wed, 01 Apr 2020 09:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=553GZqyaFPyqL10GOEToovkxhGg1gD8CyFbmDXNpEsw=;
        b=Zofr2vJFHVCyXWGqu/mMhPG1Xd4CKbNXMtKR8h9hTLZwvQJa88jCBrXU/AcrpoFH5P
         mYQ/Tlw6KbYvgQSn0qPZAs8VzO2Yt1Zfy+DOR8VCbreI2ylCrtnZGMHo44zaqd7/HYRK
         sZbb36XpH8kM0/VCRZ3VtA8dn/SNn0GR3oe67wdRFvI0gsI7zhf/uO1usD/eOSQhO7T5
         KYyosbohxMLYPXQIH2NML5udu4H72k9HOFvW4SORCN7Kk67l28U0U7ZUcJWA4IEn143f
         fCVYc1fGQMezi07Vr38H3/hv9bpRjXp/9DLeE68o+nXKbDrR3bLT8undI7AlOIHxhqDf
         BQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=553GZqyaFPyqL10GOEToovkxhGg1gD8CyFbmDXNpEsw=;
        b=gNfhVhk9eqOjVZiw18JPvdPabFTb8f6KYY1oNXDSiNjWb1jprP1FckJlMah6XoKXaL
         egUVbl+gwy2CYkjjZVI5E2wNTL76Bk2k+OYLBvkzvPmNSigfX+j6PYKKHOGHNl316nT0
         mTOq6lsgaAXxxkSHRinmA0Lhsf/X0XaJgZQxKKR91IDt+lEOnTboOaiwlJyrlKlTBjSH
         /b7CHqIe0wbxlWnjvaz/E8vjjjldGVzn3fCKjOqgpR06NePpBXh2yEtkNUZdSWMw56nV
         kZAWNlHiiGw0Ag8lWLcV+ry2lbAA9vGB34jhyjUmUnU65Zu+CMBG7tQ9rb57tfLOGAQ6
         CWRw==
X-Gm-Message-State: AGi0PuY3zQqql9fuyEVV/yWM7s7dQKtSFsPt85eIBU5TfBJ7Lc+el8K2
        0EWK8MJdPEIJhszwqFvSLiwj6XEcmRQQoOVL0Hs=
X-Google-Smtp-Source: APiQypKpqgYCAmngBbsQvHWSwrN84DODr5lhSm+9neIuBkZf9n631TEe2XQ2wNvQU/b7bVMLuE269O5DFA3DZd1QusM=
X-Received: by 2002:a19:ec15:: with SMTP id b21mr15311077lfa.28.1585759936420;
 Wed, 01 Apr 2020 09:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191122000926.19408-1-jdk@ti.com> <20191204193421.GA15784@bogus>
In-Reply-To: <20191204193421.GA15784@bogus>
From:   Drew Fustini <pdp7pdp7@gmail.com>
Date:   Wed, 1 Apr 2020 18:52:44 +0200
Message-ID: <CAEf4M_B31u_0_oLD-1xAJ3YTfJPZYYJnganiHs9=4KqfbGFSPg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: Add vendor prefix for BeagleBoard.org
To:     Rob Herring <robh@kernel.org>
Cc:     Jason Kridner <jkridner@gmail.com>, devicetree@vger.kernel.org,
        Robert Nelson <robertcnelson@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jyri Sarha <jsarha@ti.com>, linux-kernel@vger.kernel.org,
        Caleb Robey <c-robey@ti.com>, Jason Kridner <jdk@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 8:39 PM Rob Herring <robh@kernel.org> wrote:
> On Thu, Nov 21, 2019 at 07:09:26PM -0500, Jason Kridner wrote:
> > Add vendor prefix for BeagleBoard.org Foundation
> >
> > Signed-off-by: Jason Kridner <jdk@ti.com>
> > ---
> > Changes in v2:
> >   - Use 'beagle' rather than 'beagleboard.org' to be shorter and avoid
> >     needing to quote within a yaml regular expression.
> >   - Assign 'from' to author e-mail address.
>
> Still not right...

Hi Rob, is the issue that it needs to be sent from "Jason Kridner
<jdk@ti.com>" if the SoB is " Jason Kridner <jdk@ti.com>"?

Thanks,
Drew

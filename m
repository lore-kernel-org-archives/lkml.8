Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122CBC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA25222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrbDf18P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390504AbgBNSqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:46:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36840 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389723AbgBNSqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:46:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id 185so5299907pfv.3;
        Fri, 14 Feb 2020 10:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcAo2cRFw8x17fP3aIkMxC2GnRGns7uCksHDMjRNXaw=;
        b=RrbDf18PWY+2fPPPQRCgyupMcufV7Ny4wcwsGdOEEtsxZ8n4SIz0nQ15AsuI8LKx6z
         MJ8q3fbC03jYi1t/U7E53gh122fpTd8gehcq8oh4HGQdd54PshFBi2u0WhbgBUIXvfXF
         BNPispvDrlbRxPl/8EcYvO0C3qEowmJZ8uHiVjoxssrmVmcy9xN8o+gS6FFhK2Wmjz+8
         +2+b5ZlZoiwfVjpEprNai/LE5rtCB2hXQYMJPKTtA3OtrQswlomQ+NLhGHRKz9mGP34q
         iurjMAKWExIUYE2f3A6NL19yI+YOHOoJsl3W+5MRRpgTqUNA9etGO5eriI4pdaLIVx3L
         ndCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcAo2cRFw8x17fP3aIkMxC2GnRGns7uCksHDMjRNXaw=;
        b=ceIfjNpz9JtKKWCuWcZM+qfk4hQPjCYcOSAi3INokVLgdHU/LujHIECxQ9WftvTYwx
         lnS69w8WdstQkN1Ai31xa/WaLylPIll5Q3evhPpX8JOufBwUuAydhn973rSvirtFJixy
         uTj1s63xk37C2JS9ZEJg276a7teEqeeKUcOiXEZFhk9IDoggAaKdJnDrZX0RRAhVVFLP
         3+dZylmUy678IwK7q1uJRDRYnM35tyaK/d7rmVqRMutXSsllxWTNFOV7Mkn2oz+eUAst
         cbf9IjXViNi+r1W6ZIRXMfc5bTg3BAk4chZHqBEEKQp9D8pc3QMP+RKDF1nwnCy3X8qn
         u/1A==
X-Gm-Message-State: APjAAAU3zRXmDS5STERyiaBvSbGKaj/L2GjvZ/bQQPCPH97yLC6bX/he
        CUUI475LdAHfj5Nretzopda4II0CzKqW6sIGzssAfq5a/ds=
X-Google-Smtp-Source: APXvYqxBFH0CC58Eqsz0AVHcO9xbju+Mjk3tQbBjybssL0kk6NvWWHu+bwSV1YNeofoXZI9LmQpR1MhmnPV/lORZNDo=
X-Received: by 2002:a62:1a09:: with SMTP id a9mr4854899pfa.64.1581705968117;
 Fri, 14 Feb 2020 10:46:08 -0800 (PST)
MIME-Version: 1.0
References: <20191104143713.11137-1-alexandre.torgue@st.com>
 <20200206133918.15012-1-youling257@gmail.com> <0c4a37a9-0a2e-e698-f423-53060854ea05@ti.com>
 <CAOzgRdb5QfJDQzbtoHQry4wxUg52LwX5XFCPzzaYa=z+RqNWOQ@mail.gmail.com>
 <8bd72269-16ae-b24a-7144-44d22d668dc6@ti.com> <1cd5885d-7db4-59b9-ef2d-e3556f60ca68@st.com>
In-Reply-To: <1cd5885d-7db4-59b9-ef2d-e3556f60ca68@st.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 14 Feb 2020 20:46:00 +0200
Message-ID: <CAHp75VcbPYNKfrnkuSfdN8t100kZFdq05hkbWxJKgRWJknRgxQ@mail.gmail.com>
Subject: Re: [PATCH] phy: core: Add consumer device link support
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        youling 257 <youling257@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>, saravanak@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 1:32 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> On 2/10/20 9:08 AM, Kishon Vijay Abraham I wrote:
> > On 07/02/20 12:27 PM, youling 257 wrote:
> >> test this diff, dwc3 work for my device, thanks.
> >>
> >> 2020-02-07 13:16 GMT+08:00, Kishon Vijay Abraham I <kishon@ti.com>:
> >>> On 06/02/20 7:09 PM, youling257 wrote:
> >>>> This patch cause "dwc3 dwc3.3.auto: failed to create device link to
> >>>> dwc3.3.auto.ulpi" problem.
> >>>> https://bugzilla.kernel.org/show_bug.cgi?id=206435

+1 to the report.
Please revert for v5.6 or provide a fix ASAP!

> >>>
> >>> I'm suspecting there is some sort of reverse dependency with dwc3 ULPI.
> >>> Can you try the following diff?
> >>>
> >>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> >>> index 2eb28cc2d2dc..397311dcb116 100644
> >>> --- a/drivers/phy/phy-core.c
> >>> +++ b/drivers/phy/phy-core.c
> >>> @@ -687,7 +687,7 @@ struct phy *phy_get(struct device *dev, const char
> >>> *string)
> >>>
> >>>          get_device(&phy->dev);
> >>>
> >>> -       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
> >>> +       link = device_link_add(dev, &phy->dev, DL_FLAG_SYNC_STATE_ONLY);
> >>>          if (!link) {
> >>>                  dev_err(dev, "failed to create device link to %s\n",
> >>>                          dev_name(phy->dev.parent));
> >>> @@ -802,7 +802,7 @@ struct phy *devm_of_phy_get(struct device *dev,
> >>> struct device_node *np,
> >>>                  return phy;
> >>>          }
> >>>
> >>> -       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
> >>> +       link = device_link_add(dev, &phy->dev, DL_FLAG_SYNC_STATE_ONLY);
> >>>          if (!link) {
> >>>                  dev_err(dev, "failed to create device link to %s\n",
> >>>                          dev_name(phy->dev.parent));
> >>> @@ -851,7 +851,7 @@ struct phy *devm_of_phy_get_by_index(struct device
> >>> *dev, struct device_node *np,
> >>>          *ptr = phy;
> >>>          devres_add(dev, ptr);
> >>>
> >>> -       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
> >>> +       link = device_link_add(dev, &phy->dev, DL_FLAG_SYNC_STATE_ONLY);
> >>>          if (!link) {
> >>>                  dev_err(dev, "failed to create device link to %s\n",
> >>>                          dev_name(phy->dev.parent));Parent
> >
> > Can you check if this doesn't affect the suspend/resume ordering?
>
> With this fix, suspend/resume ordering is broken on my side. What do you
> think to keep the STATELESS flag and to only display a warn if
> "device_link_add" returns an error ? It's not "smart" but it could
> solved our issue.
>
> As a lot of improvements have been recently done on device link topic by
> Saravana, we could check with him what is the way to follow.
>
> Regards
> Alex
>
> >
> > Thanks
> > Kishon
> >



-- 
With Best Regards,
Andy Shevchenko

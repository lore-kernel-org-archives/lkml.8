Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE63C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05BC520708
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwjUpQaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEHKfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725825AbgEHKfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:35:18 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A5AC05BD43;
        Fri,  8 May 2020 03:35:18 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id i185so278766vki.12;
        Fri, 08 May 2020 03:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g1M0dnG6X/ZdLSaJc75kcj4nbxBb95KPAtfkHekjG3Y=;
        b=rwjUpQaWLzhBubkUR3QhhSNC734GFsOjNbxX0y3QmIcvzKwwfQD2+aVBaoi08yh0qR
         gvATQlHOwvq/YQWOxHj+yB/0n0zDaR2bAFpWJvaZYBKm9eTKbHJnTW90L8JMYSxYfCma
         NhZ2K9EIkQeMhhgKQb04Z5L+AKgNCjodZS14PlAhl2S46xL7yBNDJIdxEZ9YkTwXwYdo
         HaWF/a+50wkr9HAXYVN9w7fQ1+UElfIvrpYAx4iqF/D+S6QUweieE6mbUObdYDr+y8gt
         0FkiCWy2jD7KhYusK5DHGYnqC2xiBbG9oBQZqerFrHINpLIgRMg46Vk7U4wZGy9VgOWf
         4cfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1M0dnG6X/ZdLSaJc75kcj4nbxBb95KPAtfkHekjG3Y=;
        b=cSIBl5P2lZYbCTCB7ICPPj1PqMjFbkw8kLMD+F/rfELpLuHrMg0pA2uJ4+dJJiU4jm
         X8QSAbembVcPGIqKqnYxvzUm8fGxGtE3XTpJFg0+4BVg5Ds0cV37LNhhKYY20/LZ+lNJ
         PE1UC1Uhkrtn3ZucXUMyLgtHh3iYV2KCRDwH/XXHElKpQ68UU/S2xWmLN/MCXzHjQGG+
         kH44xhLg3JEaRTAq+MI2wEUATZIzW28r/UF9KLuP2YcJaRY2xJGZ4Uc9q7du0b+6DJCA
         AQ9OG3Y0RumeoBvlqktxf/ICHtHF4H0HfYTHyGR2UHzTlafQYEuKY0L5Oms005zIYnYQ
         I5rQ==
X-Gm-Message-State: AGi0PubDMuho+gWQtIJAtKZQYDeZxJ7OgQ9vx+yGLR0HXpX24dyVu6T5
        WI78CKEjgwwsO1DS0J95nEbjRTd/yInlgoK0WVM=
X-Google-Smtp-Source: APiQypJuxr9P/KgaH27GjKEizVyEI5TXONbIe2ekMNjmGWVrroekHLlyMkSERXmjpBua2nXn55i9IHzLgAfA3Cda0OQ=
X-Received: by 2002:a1f:2f91:: with SMTP id v139mr1139060vkv.22.1588934117720;
 Fri, 08 May 2020 03:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200430192746.1866325-1-paul.kocialkowski@bootlin.com>
 <20200430192746.1866325-3-paul.kocialkowski@bootlin.com> <CACvgo51mRse3su4exyTqXYJRPPc0VqaX9+tRyKUuBPtm5Q+6XQ@mail.gmail.com>
 <20200507201103.GH2422122@aptenodytes>
In-Reply-To: <20200507201103.GH2422122@aptenodytes>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Fri, 8 May 2020 11:32:46 +0100
Message-ID: <CACvgo52dMPk_KPyNYhBTDOo_+s7hJuGDNjoWun63Jj4uMidszA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] drm: Add support for the LogiCVC display controller
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 at 21:11, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi Emil,
>
> Thanks for the review!
>
> On Mon 04 May 20, 14:28, Emil Velikov wrote:
> > Just had a casual quick look for custom KMS properties, since new
> > drivers made that mistake in the past.
> > Thanks for not including any o/
>
> Yeah I made sure not to include any, I know it easily gets very problematic and
> creates disparity between drivers while needing to be kept alive even when a
> standard way arises due to the no API breakage policy.
>
> The not-for-merge patch that I've sent does introduce some for the colorkey,
> and that's why they are marked as such :)
>
> > I made a couple of trivial suggestions - if you agree, feel free to
> > keep them as follow-up patches.
> >
> > On Thu, 30 Apr 2020 at 20:28, Paul Kocialkowski
> > <paul.kocialkowski@bootlin.com> wrote:
> >
> > > +int logicvc_of_property_parse_u32(struct device_node *of_node,
> > > +                                 const char *name, u32 *target)
> > > +{
> > > +       struct logicvc_of_property *property;
> > > +       const char *string;
> > > +       u32 value;
> > > +       int ret;
> > > +
> > > +       property = logicvc_of_property_lookup(name);
> > > +       if (!property)
> > > +               return -EINVAL;
> > > +
> > One could have the logicvc_of_properties[] entries indexed with the
> > logicvc_of_property_parse_{u32,bool} caller, using that instead of the
> > name string.
>
> Do I understand correctly that you're suggesting passing each entry's
> struct logicvc_of_property pointer to the function?
>
> I went for strings to make the code explicit and easy to read so I'd really
> like to keep it that way and avoid passing things like
> &logicvc_of_properties[4] or an index integer.
>
Add a some #define/enum and go to town. Example with sub-optimal names below:

enum foobar {
 LVC_OF_DISP_INTF,
 LVC_OF_DISP_CLRSPC,
...
};

static struct logicvc_of_property logicvc_of_properties[] = {
[LVC_OF_DISP_INTF]  = {
               .name           = "xylon,display-interface",
...
       },
[LVC_OF_DISP_CLRSPC] = {
               .name           = "xylon,display-colorspace",
...
       },
...
}

While the callers are:

       ret = logicvc_of_property_parse_u32(of_node, LVC_OF_DISP_INTF,
                                           &config->display_colorspace);
       ret = logicvc_of_property_parse_u32(of_node, LVC_OF_DISP_CLRSPC,
                                           &config->display_depth);

-Emil

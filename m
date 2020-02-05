Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08358C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08F82051A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJCR3NEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgBEJIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:08:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41572 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgBEJIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:08:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id j9so865470pfa.8;
        Wed, 05 Feb 2020 01:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0v1lrfXw+9q9IsVuSI8BJbjOKN6uDM0H4yQTOe+6Ceo=;
        b=PJCR3NEQ2xkNMT/biatsNmyCM/Ov2phAX9foTEaUYuqArTEtPvTXqzSyOQmRPgXzBS
         M70jrqnjDx0AwLwLflsBZQa9YPJ/EJydU3gejFoRy/qBA6tLW0vKX8pme/4dcnC0yPem
         qvu5RoLwhOiB4OLHDdvWyyxzNDdNmfx5j5IxBBuRHRah/Eu+dC8LXnZ8V0pl4TPpTLCB
         m9cBT92gcbCJhuV6ZD4ETBrCh7gHdBkB+xylTlTZ+vK/KbAU1pFCXXVgZ1jKuIw/SuyG
         UKrJy/4b+LgfvBH3X5nuCT4iC+SRBclihq/XYk8IXTTfvLhW+mTNyARuG8qsMAWGb9A+
         XMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0v1lrfXw+9q9IsVuSI8BJbjOKN6uDM0H4yQTOe+6Ceo=;
        b=imf4YHDxK29riOqpeI7T10OeYqgfUQsm0OHBvVUf4leezVDXvStcYlIOGZRTIWPgZ2
         4dikv2kMIzvJ3AXMFIBayZaNufqHEUp14HyNtWhufW6Ix9T8ra1yCXXIMYVu+bJsTx1g
         XWsXPKDH2puPlHQb28QVxrm/Q+8ytVZcx7Ch09El0tCIXe/G64SxNJEAjzxcloLZi5mV
         i58Z92OwH3fWNY8vnGIHq0REBy3d4GaHd31qm3/vub2aY3aRb6bkqyEPpiE2zqJZ27uh
         im1F8O/GEAmmt4uTfRO920A88Bey+qpwLV2vyMWZaGdG54+wPlLZFuytRuaTwfBZpXjE
         7u/Q==
X-Gm-Message-State: APjAAAUzdaX2SYYKcohZIYYYz6wNrOMD59iu9Cto0JkkgmfhJTV/Nqni
        l99szosl0f7FrFTOQq9PRHzQWQ6+IPn8g1WxFCs=
X-Google-Smtp-Source: APXvYqwNaSZ3iUfyqTpiY9znyAsLA1WhalvszG/X62JZLAtAWuAjGnTljfB1cdyH7+Pp0cL4e3zXSMYv1Ys1EDbf3Ng=
X-Received: by 2002:a63:5a23:: with SMTP id o35mr35320982pgb.4.1580893718791;
 Wed, 05 Feb 2020 01:08:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579890793.git.gayatri.kammela@intel.com>
 <CAHp75Vfb38BEh2OZkO2EoQgCyBxaLoiwh8S_qKiPQRX1g+ZA2Q@mail.gmail.com>
 <BL0PR11MB31071AD85775C09B8EC26608F20B0@BL0PR11MB3107.namprd11.prod.outlook.com>
 <CAHp75VeRAWsqxfjOxw97SBPRLvcyF=SGrN84hT=UUNC6yQ6-_A@mail.gmail.com>
 <BL0PR11MB3107F8D50FCADD168EAA9E7BF2030@BL0PR11MB3107.namprd11.prod.outlook.com>
 <20200204113414.GB10400@smile.fi.intel.com> <BYAPR11MB362427151E22D623A1B48E37F2030@BYAPR11MB3624.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB362427151E22D623A1B48E37F2030@BYAPR11MB3624.namprd11.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Feb 2020 11:08:30 +0200
Message-ID: <CAHp75VdPxtKMEBaV7__LXHgpG_VMtrZDq20mXuXa4y=qzREVmQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] platform/x86: intel_pmc_core: Add debugfs entries
To:     "Kammela, Gayatri" <gayatri.kammela@intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        "Westerberg, Mika" <mika.westerberg@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Box, David E" <david.e.box@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 5, 2020 at 1:11 AM Kammela, Gayatri
<gayatri.kammela@intel.com> wrote:

...

> > I'm wondering how did you check it?
> > The branch location is in this [1] tree.
>
> Thank you for your patience Andy. I apologize for the mishap as I was checking in the wrong tree. I have rebased the series on for-next branch on right tree this time and sent v2.

No worries, thanks for the update!

> > [1]: http://git.infradead.org/linux-platform-drivers-x86.git

-- 
With Best Regards,
Andy Shevchenko

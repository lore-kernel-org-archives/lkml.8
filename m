Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518E3C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381E22173E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgG2OSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:18:03 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:59325 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgG2OSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:18:02 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MiIhU-1kfugA3JI6-00fOI2; Wed, 29 Jul 2020 16:18:00 +0200
Received: by mail-qk1-f178.google.com with SMTP id l23so22352992qkk.0;
        Wed, 29 Jul 2020 07:18:00 -0700 (PDT)
X-Gm-Message-State: AOAM532nSyBZKOZO5vyqFRwB4VwyPUxDWG+xjvaGYwolLyFpQD65IiEm
        RQ0IaqQVBky7zqw+6EWI5nUh+TOtl57tvmBzwtk=
X-Google-Smtp-Source: ABdhPJxsIJU5w4wLy+KR4GpV+X6sB3XcHYwhz0oY1jKqcaeEHvFG8yEhQ7ab2ImVNFG+l/dUTfvri4ILyFs7skCNozA=
X-Received: by 2002:a37:9004:: with SMTP id s4mr32780216qkd.286.1596032279538;
 Wed, 29 Jul 2020 07:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200728100321.1691745-1-daniel@0x0f.com> <20200728100321.1691745-2-daniel@0x0f.com>
 <20200728191842.GB2778962@bogus> <CAFr9PXkwpNAhQvOJFqLUm-uWoaH=nsNiq_y+OgTf8Z60i4RhRw@mail.gmail.com>
 <CAK8P3a0-rZq_aJxWY2+009C91igzC4nHG7XJFwXkbB8bJBertA@mail.gmail.com> <CAFr9PXnuMCjhzYQWGBiw3ayDD36qrUc433DsSphyF5+tqetnNg@mail.gmail.com>
In-Reply-To: <CAFr9PXnuMCjhzYQWGBiw3ayDD36qrUc433DsSphyF5+tqetnNg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Jul 2020 16:17:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0iA_VQ42H6jKKTsO7Nw5NSHrvT_h2Gj9JrtJDYtYRHFQ@mail.gmail.com>
Message-ID: <CAK8P3a0iA_VQ42H6jKKTsO7Nw5NSHrvT_h2Gj9JrtJDYtYRHFQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: arm: mstar: Add binding details for mstar,pmsleep
To:     Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
Cc:     Rob Herring <robh@kernel.org>, SoC Team <soc@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:tuuxp+D+4sNZzIwWgJ3bIOFSpLlfV8j/1+kZxXWNqgEE9D67ILh
 G3uj+GmTw/cyr82sxAQ3c1VCCvoMbXBpWjWcvIVosXw96gJXPesSHnPrC9YIvJcffHwlb6B
 i5VOxXUCVaRl/2T19Axi1p+ehAocRDoCpCEePBSWQ0K27g83auQPQHBbR1vxN+kj7KGHzE7
 15iE7zg4xqd5P3lgtBXSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1eIEBqndKoc=:Lf6w8JfrEZjICTEUvsJl1L
 8ySjr4orIZwvOhvdMRDGBwqS6Y6qua/cx8nqI9kxPW6qsajqItNnkCfreTuwoJVAhBrkaXlcE
 BLMZpJyhbY2vO3Nf4ho1A+y34Eosd2oPvo/3OaG0pGxaXrHMyIs7SJLfHm4W0wrVP2DoppzBD
 hyQVhUGSh8hbX0D+ObGUiVxtAKYU77NGQ9bCdZfth7fdYA35DmVhcfF2/bZLqsXU/4oTL6tCO
 dbz8CxxL9tWAK2BgTpK4L7XpwL/hBDibDNHBAl3WN4Y3QPTf0jflBjkewWnNrNHESdwNYNxiF
 X/gPtLz9JYiIQ5VFTJ+M1YPRnHT9OYZzSw7KAjDTdO8GafaRJ2j2tiHaYs8JPAxQori5cbP+U
 8MVO/Z2S3eLjZNtfACEri7lSbeBEBQvPhDWUiqo3awCMPbDta3rPyKjjOBBxTKBOySm3DX63v
 xPGbn9ESUHZcAXqTOLXEjhbZ4VQ1wlQqshn6Y7Xf9mBtzsjT77pAFALfBB5Ovi/JYPn/ZBAWi
 953gaKejaaTC5yHSaHtg/aYabWFjactSNqCIRBhgWppLUCXhkAsF2+rnbesDBMHnpIgCH3j04
 D3Sv+wZU8bo+sALlulusFXB4wbmF23Ex+HMBXWE6PudeqFmWO2m9vLB4TxfKomCjD+UAD7w7i
 oOQuF5sQLSrN1KUgX4y8XR/vWwohW0GZC+7TbqwwQ5r4f2Kq+pvK56EMhjmRN10CUFoL9cW1U
 K5PyFlhiHClxXKftT4AsgLNySHvq5PHjHIqtrIELsyyUqf0IJvN7CdR1a5BWd5+if5lGJHFvf
 K1dIiq0cmOgWiIHhRJj28mpMYzcjDjgGBdeDQsJNxQJJm1LhVlyhpNjPzT2QRbE7x4C08J/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 2:34 PM Daniel Palmer <daniel@0x0f.com> wrote:
>
> On Wed, 29 Jul 2020 at 21:14, Arnd Bergmann <arnd@arndb.de> wrote:
> > > Does calling it "mstar,pmsleepv7" make more sense? I'm not sure what
> > > to call it really.
> >
> > Use the name of the oldest chip you know that supports it in there,
> > such as "mstar,msc313-pmsleep" if this one is specific to msc313.
>
> That makes sense. I think the original patch got merged to soc/arm/newsoc.
> Should I recreate the series or create a new patch to do the corrections?

Please send an incremental patch.

> Slightly off topic but I'm working on the series for the interrupt controller
> and I've just renamed it from mstar,msc313e-intc to mstar,v7intc.
> I originally called it msc313e because I only knew of that chip but the
> same controller is present at the same place in all of the chips so far.
> I guess I should probably rename it to mstar,msc313-intc to keep with
> the first chip it appeared in pattern?

Yes, correct. If you have multiple chips using this controller, use the
name of the oldest chip as the generic identifier and then add a more
specific one for each the later chips that also use it, so the driver is
able to tell the difference if it ever needs to, something like:

(on msc313)
compatible = "mstar,msc313-intc";

(on msc314)
compatible = "mstar,msc314-intc", "mstar,msc313-intc";

(on msc315)
compatible = "mstar,msc315-intc", "mstar,msc313-intc";

   Arnd

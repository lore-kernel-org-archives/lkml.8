Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8CCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 23:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FBD6207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 23:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A+imL3Xu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgFPXcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 19:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgFPXcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 19:32:02 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBFDC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 16:32:02 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a3so121965oid.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 16:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZR76zTcu1z7oLJO1oPo6x5h1/7W/tIAc9DNWun2Jro=;
        b=A+imL3Xumi3VRZIxUfyQtYqL4SA7G7E/2giwMRBcbO409QXLbYKBmCEsGUcJqa4TAY
         HU+A+AmsENld/FcXObD2qTY0vt+cbLiaGJm9qbyZw0vkmsaJ7NDYQPWy1JEpm6ihyqYo
         pS10I8MeABTV+7Z6yUApqXhNqxg3tpLAJIdzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZR76zTcu1z7oLJO1oPo6x5h1/7W/tIAc9DNWun2Jro=;
        b=O0/ewYqTeGguQu1s2mCwa49LLl26mEgNuD85kwjLZL8VLAnEswgsZEiJYTNTGBsCgX
         ha+HW9OIwzLQa1BkMub1jHLCECKTy7RJqbzD+rFteRgWdoZJBAl3LkVM3pK8QME4Q+At
         1dB7i8Ua2HKeDcSMudM7H9gW8UT3RMlUWbbsI+QzuEn2FYQL4MAJzUtZ0YS7edSBjmn/
         qMYIpB6lLvh+UWmaxQoOf1yG+9K/afsbzkKYE/NKsTHPOzNjJOZInHAiimhCWAnajaRQ
         EtH6d6hKY7Z96HCAaBAqWNz2qtRAnykZ4v6zJuR2h7kLw6qsJChqtAsvBVg2dDecxtdr
         jx7Q==
X-Gm-Message-State: AOAM531We052TExNgh1A9LccFOwKVeOyTCKsipW/jqDPgF65eLIYCC1O
        bknq2kYFWshIiTfz78W5bOuPWtEfB4PW/l1soO74nQ==
X-Google-Smtp-Source: ABdhPJwe8HlKioFRvrB52wPJ2kMSEumu6r/YnRkn+Sg0kQa3w4uatWgIq71dkjgVv5uf+tX4zvqmniNxH4IY0WgJjkk=
X-Received: by 2002:a05:6808:aa3:: with SMTP id r3mr5645675oij.170.1592350321223;
 Tue, 16 Jun 2020 16:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200612164632.25648-1-nsaenzjulienne@suse.de>
 <20200612164632.25648-5-nsaenzjulienne@suse.de> <CAPnjgZ2jarQArKN=0h0mNnxE7gAL0juvGhMxMF4a0CehqxWcRw@mail.gmail.com>
 <d3346d7cb9655eb111b4126d72a08499c6254fef.camel@suse.de>
In-Reply-To: <d3346d7cb9655eb111b4126d72a08499c6254fef.camel@suse.de>
From:   Simon Glass <sjg@chromium.org>
Date:   Tue, 16 Jun 2020 17:31:49 -0600
Message-ID: <CAPnjgZ3PwTWBQ2Vi4=Sc7JB699TrSxr=PAJupL_3POhJ00qSsA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dm: pci: Assign controller device node to root bridge
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Matthias Brugger <mbrugger@suse.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>,
        lk <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Tue, 16 Jun 2020 at 08:09, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Tue, 2020-06-16 at 07:43 -0600, Simon Glass wrote:
> > Hi Nicolas,
> >
> > On Fri, 12 Jun 2020 at 10:47, Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > There is no distinction in DT between the PCI controller device and the
> > > root bridge, whereas such distinction exists from dm's perspective. Make
> > > sure the root bridge ofnode is assigned to the controller's platform
> > > device node.
> > >
> > > This permits setups like this to work correctly:
> > >
> > >         pcie {
> > >                 compatible = "...";
> > >                 ...
> > >                 dev {
> > >                         reg = <0 0 0 0 0>;
> > >                         ...
> > >                 };
> > >         };
> > >
> > > Without this the dev node is assigned to the root bridge and the
> > > actual device search starts one level lower than expected.
> > >
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > ---
> > >  drivers/pci/pci-uclass.c | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > Can you update the tests to handle this case please?
>
> I'd be glad to, but I'm not familiar with the test FW in u-booy, coud give me
> some pointers on where/how to test this?
>

Yes it is at test/dm/pci.c and the device tree is test.dts

'make qcheck' to run all tests. To run one test, build for sandbox and
then something like

u-boot -T -c "ut dm pci_swapcase"

for example.

You can perhaps use an existing PCI controller in test.dts but feel
free to add one more if you need it for your test. Make sure that you
don't break other tests.

Regards,
Simon

Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F57CC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F5D0206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdQ0zl1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGXPRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgGXPRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 11:17:24 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B22BC0619D3;
        Fri, 24 Jul 2020 08:17:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k71so5403671pje.0;
        Fri, 24 Jul 2020 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HUROjGo9h0QzPmA8W6RC42jkLEEb02wgdrCu4KyC3eQ=;
        b=QdQ0zl1wnw3H/JKPangxnKC11AjASvBxZZMsKId7lwLQ0A8nihM3y0ieEVvXrT8kY8
         nd+1fFqNjs1ENzcCdxqkka04SkG+Eyr1L3yXxoQKDkdx3u9r0WHNbW8uELDk7QEgxLrB
         2dhVCq2Jp16khl1lQ+ehugu0megd6Fx0YlL7ddeke/HIzjE6pWP2eG9Q1AN7s1KgV/Gg
         DY7Xs1PYyfOnqmQ9H8U1P2RgrB6rAH193ZrqfioIKMFZ7a1g7AyuHspvrCxT02aDwSzz
         pcYMBfLF2OMfWVFHtIQ0LOy5nC3RXgG8/3Ff7uftIsU6+cMoxREIPxU9HQawqZFyUEPJ
         7WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HUROjGo9h0QzPmA8W6RC42jkLEEb02wgdrCu4KyC3eQ=;
        b=XjT2HmJGZMioGAnonwAFALawuedcmIMgLc9upq9EEmPJ3tR+wbJbnPey43t+7gTqPG
         SsI6TO7NK45gbsijdWnNjGMSBoskb9X3uB591INE8SsZoL3bqoGX5cVZ04TSqCD5MNAi
         hXIPck673SMDIdEcz1vQ/UstzYstfOV5RqpBw0rh2ykN1rgjxr4Xr4Gof11X7zzh8Mcl
         IWzIy1H5Hip+s+2aozZ2gOUeXkuJ2LRKbUnk2sIGbrhJVCI+okjvvKh5ioxQgIXFi1uL
         VPmm8SZLsJl1KFVw0vd6bGJJUjYJPjtsHvomnQ8nN5DADfBGpkC/LwGiZWheqSiZoUod
         WTXw==
X-Gm-Message-State: AOAM531bQ7bnn5xhrBfTIKobTgnREY007A00y6QPV1R0Zc93f1tV2vh1
        VrqZPTnMt3etHv3uRw1LIYQ=
X-Google-Smtp-Source: ABdhPJwLwZPCwLH/Vq4Ur1Dg/VbJQuvtBuiU2evxy0VSK8+5L4tI0fouUwBZG0eWsbnKGuDz8zgB6Q==
X-Received: by 2002:a17:90b:19d4:: with SMTP id nm20mr6352197pjb.206.1595603843811;
        Fri, 24 Jul 2020 08:17:23 -0700 (PDT)
Received: from gmail.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id m6sm6728647pjb.34.2020.07.24.08.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 08:17:23 -0700 (PDT)
Date:   Fri, 24 Jul 2020 20:46:01 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v1] spi: spi-topcliff-pch: use generic power management
Message-ID: <20200724151601.GA3642@gmail.com>
References: <20200720155714.714114-1-vaibhavgupta40@gmail.com>
 <CAHp75Vdh-ssrmGgTc=gE9dWLhWDAw7_QHJKFeWKHpO-JqBdsEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Vdh-ssrmGgTc=gE9dWLhWDAw7_QHJKFeWKHpO-JqBdsEA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 01:51:49PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 20, 2020 at 7:31 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> >
> > Drivers using legacy PM have to manage PCI states and device's PM states
> > themselves. They also need to take care of configuration registers.
> >
> > With improved and powerful support of generic PM, PCI Core takes care of
> > above mentioned, device-independent, jobs.
> >
> > This driver makes use of PCI helper functions like
> > pci_save/restore_state(), pci_enable/disable_device(), pci_enable_wake()
> > and pci_set_power_state() to do required operations. In generic mode, they
> > are no longer needed.
> >
> > Change function parameter in both .suspend() and .resume() to
> > "struct device*" type. Use dev_get_drvdata() to get drv data.
> 
> > Compile-tested only.
> 
> Yeah...
> 
> ...
> 
> > +static int __maybe_unused pch_spi_suspend(struct device *dev)
> >  {
> > +       struct pch_pd_dev_save *pd_dev_save = dev_get_drvdata(dev);
> >
> > +       dev_dbg(dev, "%s ENTRY\n", __func__);
> >
> >         pd_dev_save->board_dat->suspend_sts = true;
> >
> > +       return 0;
> >  }
> >
> > +static int __maybe_unused pch_spi_resume(struct device *dev)
> >  {
> > +       struct pch_pd_dev_save *pd_dev_save = dev_get_drvdata(dev);
> >
> > +       dev_dbg(dev, "%s ENTRY\n", __func__);
> >
> 
> > +       device_wakeup_disable(dev);
> 
> Here I left a result. Care to explain (and perhaps send a follow up
> fix) where is the counterpart to this call?
> 
Hello Andy,
I didn't quite understand what you are trying to point at. And the result part.

Yes, it seem I forgot to put device_wakeup_disable() in .suspend() when I
removed pci_enable_wake(pdev, PCI_D3hot, 0); from there. It doesn't seem that
.suspend() wants to enable-wake the device as the bool value passed to
pci_enable_wake() is zero.

Am I missing something else?

Thanks
Vaibhav Gupta
> > +       /* set suspend status to false */
> > +       pd_dev_save->board_dat->suspend_sts = false;
> 
> > +       return 0;
> >  }
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko

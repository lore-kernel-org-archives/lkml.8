Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEF8C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5671621D7D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mII34r67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgBQQsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:48:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43272 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgBQQsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:48:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id u12so9120098pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 08:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+dYalRSbOahcygIG/bZllcSeh3ymAP3k2AyUse0dYCI=;
        b=mII34r67/bufhqQd9dQqCetitoqHTrrbW8vRZnRPg1PwUkd8tJ+8Mr9084zNVxlzib
         3eua/qF0W6iJnkf8IokoO56nKIcoKjslAX9TSz5rfujDwzvMlTseZms//itB13ofLcD3
         gL0Dp869sIiemJpyWxNXuX29oPqTYwUI3cKdOe61cmflx30o1nNgxDBvbsbfdUGqTZPB
         Nfik4yKH5vQA0JpniYGamAhEIzL74N6Jzkw/EPnT0elR5oLnt8gx35VUnFNEiRDpZQJe
         kObADUG9G7Zf+mudNN4VvOfvQW5u6eiA9TQFXxT7Zjt/wW3+whiNuUBf5NKoD2Sbkbuh
         OClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+dYalRSbOahcygIG/bZllcSeh3ymAP3k2AyUse0dYCI=;
        b=ZB63owvxhIprz42Z1EzIEV9W9NFd5TbtrkXX852MdRIZANmvfsCY+XnxmgTnknp1Hm
         FlDaXMBvMNUpVptRoqsryEtD8xThgdAlcnWVWivsO03IBgcsIyRsie1HRmzoDTROmeXI
         MBnTaY+4bmd8G9dh4lOIFf85dnpSOtuNLXbrJBScH66TE1SAke9KKt8FDzpg+3DKa90K
         sVaIyv7oDFhF5nNNq1uz2FAyOnk9w0MxmGLfpvDwK/y8ElHxqy+cjHpF0XlPM24A0kUX
         puTI58o9YhpARU29D4SMVPg6m6ZO1OUllevbwNCQcziwcE8RsqQ41M2cRLz2SyUFIMPe
         GvPQ==
X-Gm-Message-State: APjAAAWAI8IfQUEMIZmMVgFCq6k8YD/6o7saIP3SaRRaSnZ1zuW+28vD
        Qz3/zH2CWgkIlF1MZWx81trD
X-Google-Smtp-Source: APXvYqww9hFwhQhDFppuNnetXE1spR5nHeV2J6H2V98O42q2hVUMGmmNA52WaqDLYhTNvRfQi+jCEA==
X-Received: by 2002:a17:90a:30e8:: with SMTP id h95mr21154101pjb.30.1581958081234;
        Mon, 17 Feb 2020 08:48:01 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:48d:3349:2df9:3778:ccac:a356])
        by smtp.gmail.com with ESMTPSA id ev5sm19278pjb.4.2020.02.17.08.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Feb 2020 08:48:00 -0800 (PST)
Date:   Mon, 17 Feb 2020 22:17:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>, smohanad@codeaurora.org,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        hemantk@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/16] bus: mhi: core: Add support for data transfer
Message-ID: <20200217164751.GA7305@Mani-XPS-13-9360>
References: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org>
 <20200131135009.31477-12-manivannan.sadhasivam@linaro.org>
 <CAK8P3a1DOta5Uj3dNFWVqwgyPKs0cQsoymXE7svcOZoPiY+YGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1DOta5Uj3dNFWVqwgyPKs0cQsoymXE7svcOZoPiY+YGw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Feb 17, 2020 at 05:13:37PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 31, 2020 at 2:51 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> 
> > @@ -648,6 +715,31 @@ static int parse_ch_cfg(struct mhi_controller *mhi_cntrl,
> >                 mhi_chan->db_cfg.pollcfg = ch_cfg->pollcfg;
> >                 mhi_chan->xfer_type = ch_cfg->data_type;
> >
> > +               switch (mhi_chan->xfer_type) {
> > +               case MHI_BUF_RAW:
> > +                       mhi_chan->gen_tre = mhi_gen_tre;
> > +                       mhi_chan->queue_xfer = mhi_queue_buf;
> > +                       break;
> > +               case MHI_BUF_SKB:
> > +                       mhi_chan->queue_xfer = mhi_queue_skb;
> > +                       break;
> > +               case MHI_BUF_SCLIST:
> > +                       mhi_chan->gen_tre = mhi_gen_tre;
> > +                       mhi_chan->queue_xfer = mhi_queue_sclist;
> > +                       break;
> > +               case MHI_BUF_NOP:
> > +                       mhi_chan->queue_xfer = mhi_queue_nop;
> > +                       break;
> > +               case MHI_BUF_DMA:
> > +               case MHI_BUF_RSC_DMA:
> > +                       mhi_chan->queue_xfer = mhi_queue_dma;
> > +                       break;
> > +               default:
> > +                       dev_err(mhi_cntrl->dev,
> > +                               "Channel datatype not supported\n");
> > +                       goto error_chan_cfg;
> > +               }
> > +
> 
> While looking through the driver to see how the DMA gets handled, I came
> across the multitude of mhi_queue_* functions, which seems like a
> layering violation to me, given that they are all implemented by the
> core code as well, and the client driver needs to be aware of
> which one to call. Are you able to lift these out of the common interface
> and make the client driver call these directly, or maybe provide a direct
> interface based on mhi_buf_info to replace these?
> 

It sounds reasonable to me. Let me discuss this internally with Qcom guys to
see if they have any objections.

Thanks,
Mani

>       Arnd

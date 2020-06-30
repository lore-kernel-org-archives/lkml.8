Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EC8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C9012053B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQ+3Bpe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgF3VIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgF3VIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:08:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC70C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:08:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j1so9951581pfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TztK3Rxr7Fn5cSwLph8w89UZSXGdiaGuD8YdgAZBLhc=;
        b=oQ+3Bpe1J49+YLFni4XKFQ3sa+QK/5kDOZgXHaTp/mNo/nfT4Jl8WEoDZoGiqe2yqY
         ztdhanr9s4Em/BqMGX5oakTrwq22JKROPHNQHFkPnhIUEMxk3eg1TQViyJtSnP5gEcmC
         NHLbYmEGMn9WmX3NI2dl+MGasn+a6NsvaEl5/w0gyCrQmWIq6SbbNKalnU08ZxlgE5Fm
         vuZ4lT6Q0V/jBEFPYU+2Eh04WgRyaxmAgtU7zBejXK3+O0bNACuLgAAzHfIeFFlPA89s
         5PMCVE2hyQhbSCnqR3L++ETZb7lAJ4ZhydHlk0E5mQCGnZaxHA8Mm3QIj//j3xKCBD7h
         4ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TztK3Rxr7Fn5cSwLph8w89UZSXGdiaGuD8YdgAZBLhc=;
        b=mZXPCgfIJctAPvHe+R9WgfJ4PlKmHenxrS7JtW2mytJED7VR9/9/wwxrwGRBcRMVie
         5RPy4UFYoUiDt4fDN4c9MdsqT52x/mfo6TIQMTEzFlVXutFNksRz8FTeUw7eIE2Pk67u
         fdE9XhYyENUIh9LQ/WK1EkIUGaiphYJAzTQMpqC171tRqdevEEcSvyJE4rZHZL1e+8co
         CIcq5kriwpa7t3t8sgUYK3omf9WcAuWmfpw8u82vbLPYHOxi0BOWJ6ign0+Ao4KLJ3wO
         /ozpJiGT5cNTHf3kXgqgW7sO+BY1UsnzLDpkfv4cptgDKY7G4a8L5vbxhcwU1lbU/vr8
         QgKQ==
X-Gm-Message-State: AOAM530iAmgoWizcTzrul/KGMeoNpMF1y74R8/lc51nlXkY+RGDZRSE0
        cCUqbbpN5c53038TjrTrc7g=
X-Google-Smtp-Source: ABdhPJzIJ1W4d01lMXP9WUjf+Cym20TVKfnvze08MwIPXiAPLCLsDGxc/7HfWssoCd2lnMp6OOM7nA==
X-Received: by 2002:a65:67d0:: with SMTP id b16mr2083343pgs.60.1593551283634;
        Tue, 30 Jun 2020 14:08:03 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:1000:7a00::1])
        by smtp.gmail.com with ESMTPSA id s15sm3548300pfm.129.2020.06.30.14.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 14:08:03 -0700 (PDT)
Date:   Tue, 30 Jun 2020 14:08:01 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mailbox: imx: Mark PM functions as __maybe_unused
Message-ID: <20200630210801.GA3920527@ubuntu-s3-xlarge-x86>
References: <20200623010403.517691-1-natechancellor@gmail.com>
 <AM6PR04MB4966C312C40364B5BCA18C8780940@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB4966C312C40364B5BCA18C8780940@AM6PR04MB4966.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:14:05AM +0000, Aisheng Dong wrote:
> > From: Nathan Chancellor <natechancellor@gmail.com>
> > Sent: Tuesday, June 23, 2020 9:04 AM
> > 
> > When CONFIG_PM and CONFIG_PM_SLEEP are unset, the following warnings
> > occur:
> > 
> > drivers/mailbox/imx-mailbox.c:638:12: warning: 'imx_mu_runtime_resume'
> > defined but not used [-Wunused-function]
> >   638 | static int imx_mu_runtime_resume(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~~~
> > drivers/mailbox/imx-mailbox.c:629:12: warning: 'imx_mu_runtime_suspend'
> > defined but not used [-Wunused-function]
> >   629 | static int imx_mu_runtime_suspend(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~~~~
> > drivers/mailbox/imx-mailbox.c:611:12: warning: 'imx_mu_resume_noirq'
> > defined but not used [-Wunused-function]
> >   611 | static int imx_mu_resume_noirq(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~
> > drivers/mailbox/imx-mailbox.c:601:12: warning: 'imx_mu_suspend_noirq'
> > defined but not used [-Wunused-function]
> >   601 | static int imx_mu_suspend_noirq(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~~
> > 
> > Mark these functions as __maybe_unused, which is the standard procedure for
> > PM functions.
> > 
> > Fixes: bb2b2624dbe2 ("mailbox: imx: Add runtime PM callback to handle MU
> > clocks")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Thanks for catching this.
> 
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Regards
> Aisheng

Thank you for the review :)

These warnings were introduced by a patch in this merge window, it would
be nice if this patch could be fixed up as a fix for that but I
understand if it is too late for that.

Cheers,
Nathan

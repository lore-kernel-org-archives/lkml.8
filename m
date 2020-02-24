Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F2CC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453D6206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="DcLj9+eR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgBXHwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:52:44 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38786 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBXHwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:52:43 -0500
Received: by mail-pj1-f67.google.com with SMTP id j17so3795806pjz.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 23:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JijnfBoe2ezLgS/FxMC63FZES23LOalpXpAlXAEnkhA=;
        b=DcLj9+eR5e8Z4uahIyGYgjyx4asQksO/6H7tqTCiZ6ERfAPF/l2l4Gx20nc21kdKSf
         Ovh7VLoKklpjR93rugpizvQciSbhNyatHlCpE8Ic4SvsREmGNVU9Kw3tIsUI8/KQnx9g
         Ok6nza4rtKo7fJTnSCu6r3udQea/Wi/osvs4JG7f+B4fZkvENiQA88Imd9D0A9wPHuaR
         tFB8FmVTv97otuDupeQIpaBmgoslav9LgPUwXsQB+e6NczzgMDJ64HBPfgeZOltQkSDR
         Xk9UIgv1f4PUZ38jiTxjrAkwEO8my1L2wo2oyEJiYGoa/1FCP7KsOf+GYhzpEbCdMB2R
         c9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JijnfBoe2ezLgS/FxMC63FZES23LOalpXpAlXAEnkhA=;
        b=Kfe1g7pafIh0oGvzAcwEdLH2PvlJRQmtPy4vHpX0lM/6MrdmOgXWUTWJ/948ArHM5G
         PtsCjtAGzYL6UcmIlRs2LFQvpaL6RbmPMiXUK5BYzyJqRAjEoUx6kQcwjzR615xef4tB
         LVBbmKSG0vTMxvm8rme3gVmnKQTNaQRgz5lpJBIp4jaH1PLnmkowzXvmWyD46+fH0fNa
         pDAA6Vg8JJ/zRIvHdVl7GTEVJjULNlzuXY0PV0R4FPe4KcNssEZ1eu93W4cBsHuksFub
         n82cxrPLE4Egt0PEgsC2Ijog52EOkwRlePQUhmFNNNUehZ750Xe9ORdJXlpSH8yZ8rzo
         Dx1w==
X-Gm-Message-State: APjAAAUvh4uNAc+zmlRQYnRnvLR4Yu1s0XRq2qXfT6I1+CaRQkz1OG39
        1Pv50fX54gWvnRzAhFog89Zarg==
X-Google-Smtp-Source: APXvYqxzheO72TA6WZPdEj47HYIj6iN5kdSApzc51FTGN+6EQ9pY76cexAxwtDaeyiTiJzQsK9ooOw==
X-Received: by 2002:a17:90a:da03:: with SMTP id e3mr19005507pjv.57.1582530757523;
        Sun, 23 Feb 2020 23:52:37 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.171])
        by smtp.gmail.com with ESMTPSA id z10sm11442677pgz.88.2020.02.23.23.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 23:52:36 -0800 (PST)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
X-Google-Original-From: Kaaira Gupta <Kaairakgupta@es.iitr.ac.in>
Date:   Mon, 24 Feb 2020 13:22:31 +0530
To:     Benjamin Poirier <benjamin.poirier@gmail.com>
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        gregkh@linxfoundation.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: add braces around macro arguments
Message-ID: <20200224075231.GA4806@kaaira-HP-Pavilion-Notebook>
References: <20200221195649.GA18450@kaaira-HP-Pavilion-Notebook>
 <20200224053225.GB312634@f3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224053225.GB312634@f3>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 02:32:25PM +0900, Benjamin Poirier wrote:
> On 2020/02/22 01:26 +0530, Kaaira Gupta wrote:
> > Fix checkpatch.pl warnings of adding braces around macro arguments to
> > prevent precedence issues by adding braces in qlge_dbg.c
> > 
> > Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
> > ---
> >  drivers/staging/qlge/qlge_dbg.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
> > index 8cf39615c520..c7af2548d119 100644
> > --- a/drivers/staging/qlge/qlge_dbg.c
> > +++ b/drivers/staging/qlge/qlge_dbg.c
> > @@ -1525,7 +1525,7 @@ void ql_dump_regs(struct ql_adapter *qdev)
> >  #ifdef QL_STAT_DUMP
> >  
> >  #define DUMP_STAT(qdev, stat)	\
> > -	pr_err("%s = %ld\n", #stat, (unsigned long)qdev->nic_stats.stat)
> > +	pr_err("%s = %ld\n", #stat, (unsigned long)(qdev)->nic_stats.stat)
> >  
> >  void ql_dump_stat(struct ql_adapter *qdev)
> >  {
> > @@ -1578,12 +1578,12 @@ void ql_dump_stat(struct ql_adapter *qdev)
> >  #ifdef QL_DEV_DUMP
> >  
> >  #define DUMP_QDEV_FIELD(qdev, type, field)		\
> > -	pr_err("qdev->%-24s = " type "\n", #field, qdev->field)
> > +	pr_err("qdev->%-24s = " type "\n", #field, (qdev)->(field))
> >  #define DUMP_QDEV_DMA_FIELD(qdev, field)		\
> >  	pr_err("qdev->%-24s = %llx\n", #field, (unsigned long long)qdev->field)
>                                                                    ^^^^
> You missed one.

It makes the line characaters greater than 80. Shall I still add braces?
I mean it's better that I add them to prevent precedence issues, but it
adds another warning, hence I wasn't sure.

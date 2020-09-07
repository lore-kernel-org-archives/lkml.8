Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D91C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B904A206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giFPadgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIGGyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgIGGyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:54:36 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471CDC061573;
        Sun,  6 Sep 2020 23:54:36 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mm21so6236488pjb.4;
        Sun, 06 Sep 2020 23:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o8g2x95/5vs9teUbA+OBdLU6ARSUU/ROuR8WWiVtU9g=;
        b=giFPadgMBYboBptsHg38rbJuFrrSa7hN5l2ZasV3JrETKlbNfqoiI2M4BTiL2/4FVl
         t3qr7tzlSXXzCyyJsCkoLasYAE3/mzHasPjNxASmT9ih5kqapZ/bSe6VPffuIpgbmsF5
         8RLannbfcmiIlYYl2nofuISkLnCX4o3PsRokxpCnfQ+W4dFG61HezklWqfwprkIg1/1s
         4qRbLkgZQfltAoPatGT7rTyb1r2rSvEVHDfa2B+3Q9+IjKULub2rgKNeVoHN1X2I08ar
         96TLIn4xcZJjfdVYsFtvVYOnU1hVeZjMGVg2+JLviy47EF62nGac8hkwDVuo+yIxQZB9
         Vj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o8g2x95/5vs9teUbA+OBdLU6ARSUU/ROuR8WWiVtU9g=;
        b=H6v/TrRDSnK0VJics8NJvkQ6nzNa40aBt5N2Ao/jjYkBceV0LDmYT37bvUb8OJGQDG
         zXj5HG6k8ocEqlvOERaF1cDTCgOfhHMGdWwzjq+HTyrWG9PbuJfVN7jvCK7okdo1DaId
         0Q6hDq+aOzNKALYO8S6S7CBV56ecDt59xUrogIEs1lgZji1YlnPZE49DBP68TfiEEovt
         F1i1zggST6WmHa5ndvOwxMilpX3yDYSSVr36wuAwY32D41yHcwHXQiGPowQYgVPyc5sv
         a3BmQSfzo7K3n8W1Al58yKaivq7wBBeDvkBciCSKfL5sc4C3XDER72dWdd35vveiLoXM
         KpIQ==
X-Gm-Message-State: AOAM531yq9pxZ4iYbJrr3DybiqVyCJZtcvnZNHFDsgMVIn3pRZwD4+0Z
        naVQTciYTK0doEIJBjtPIyQ=
X-Google-Smtp-Source: ABdhPJw55OcWofC6teQbiKEAY1os2nE0Xo3rrdLivdlVHahC5JQQHN2ViUEJwrnGbmArWTFuwtnBlg==
X-Received: by 2002:a17:90a:5283:: with SMTP id w3mr19683479pjh.201.1599461675200;
        Sun, 06 Sep 2020 23:54:35 -0700 (PDT)
Received: from gmail.com ([106.201.26.241])
        by smtp.gmail.com with ESMTPSA id q3sm14114254pfb.201.2020.09.06.23.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 23:54:34 -0700 (PDT)
Date:   Mon, 7 Sep 2020 12:22:16 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-fbdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Linux-kernel-mentees] [PATCH v1 1/2] video: fbdev: aty:
 radeon_pm: remove redundant CONFIG_PM container
Message-ID: <20200907065139.GA29423@gmail.com>
References: <20200806072256.585705-1-vaibhavgupta40@gmail.com>
 <20200806072658.592444-1-vaibhavgupta40@gmail.com>
 <20200806072658.592444-2-vaibhavgupta40@gmail.com>
 <20200907063347.GB29062@gmail.com>
 <20200907064810.GB284261@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907064810.GB284261@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 08:48:10AM +0200, Greg KH wrote:
> On Mon, Sep 07, 2020 at 12:03:47PM +0530, Vaibhav Gupta wrote:
> > 
> 
> Why did you send empty emails out?
> 
> greg k-h
I was trying to re-ping the patches. Guess it went empty. I will send patches
again.

Vaibhav

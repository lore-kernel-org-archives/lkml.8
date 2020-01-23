Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58777C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C81D2467F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEyMGAeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgAWNaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:30:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33448 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgAWNaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:30:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so1379133plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 05:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c3Jf7YornRWAcLPIhzKeqbQgyPavsrhhAxYWXcZAFbQ=;
        b=DEyMGAeWS1/dCHnfqvubuElHzwpwoHrxLr1c2h4oYR0RbGR2X54v5m7I+bXyLqI9uI
         JnzxuyDNAjCST4K/hvvOD9FKhuv/2UYfvOFmzW0VtSna7dqiCx54Cd88hrfME/wG1ivG
         cDlLbz63wJt517U3IpkeOnCXc5p+jukIT88/29CqI360gZCzQv6Q3gAPXpOJTE6KEXl/
         vpgPT4LAYpscBQaNh/aJUfHH2dHFIvvFtpJBb8R86G5Cn+iyU6YnafU3TNpJVRfaxOub
         cPtxmYWWY6ka7GINgvGUcANfLVQGXMeeBkW8ThFAYvxXUFNByRYGnrUT/q9d/btyjnpT
         +6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c3Jf7YornRWAcLPIhzKeqbQgyPavsrhhAxYWXcZAFbQ=;
        b=rIiT7fIpYs+c3hXbXlksQysPHDB0p2nFBPJPVQeS+RF2jclixBzCtAFfNeWxVS2Rfe
         bPw12H6wb9WTnR6A/XGcNpJVObVbHg0VzCfCA1s9QcaWzlBRfiVQx3/XJKD0+ObPJ9uW
         2Y8Hpo3xpZSAEZASxyIclok7FGUYt5KmSiR3grJZm/5deizyfYeF9ZyYFa++pmVcqxQt
         wZx6QXQadMlHxgx0zMSvkso1wHOqr/A4wpR8hQgm2NDA5PwYYS3pYIZtciNWVPEL3pD4
         M6QHOA+W5r4NaWqNgeFfcCdvJq5YX0f6fSKq3i6+H9nYHZOSFC2Qir8QzeEWrH84qsea
         yejg==
X-Gm-Message-State: APjAAAXz7h38vZfP0WUdFEtziXTmurAqkD3/rSHu6GiDVX3GTHuPlYUX
        uxngEaDdcqoqNBExPS/Gg6lB
X-Google-Smtp-Source: APXvYqzRrhC1Pol+miUZIGuk11fLm1hNtBXeyIm++eRIHyMx6m2gejJxb0JJSeRXLweMpEAMiTxILg==
X-Received: by 2002:a17:90a:8001:: with SMTP id b1mr4503509pjn.39.1579786218610;
        Thu, 23 Jan 2020 05:30:18 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id r6sm2755819pfh.91.2020.01.23.05.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jan 2020 05:30:17 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:00:10 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>, smohanad@codeaurora.org,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        hemantk@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 01/16] docs: Add documentation for MHI bus
Message-ID: <20200123133010.GB11366@mani>
References: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
 <20200123111836.7414-2-manivannan.sadhasivam@linaro.org>
 <CAK8P3a3Nxr3yqDjZDV1b0e0mdWEEsktwrmKXxZgsnq7Kv82mhw@mail.gmail.com>
 <20200123131015.GA11366@mani>
 <CAK8P3a1z7mVEpxbk47Q3A-tLDhqHUid2_S4tE3NQuf_2_UCOcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1z7mVEpxbk47Q3A-tLDhqHUid2_S4tE3NQuf_2_UCOcg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 02:19:51PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 23, 2020 at 2:10 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Thu, Jan 23, 2020 at 01:58:22PM +0100, Arnd Bergmann wrote:
> > > On Thu, Jan 23, 2020 at 12:18 PM Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > I don't see any callers of mhi_register_controller(). Did I just miss it or did
> > > you not post one? I'm particularly interested in where the configuration comes
> > > from, is this hardcoded in the driver, or parsed from firmware or from registers
> > > in the hardware itself?
> > >
> >
> > I have not included the controller driver in this patchset. But you can take a
> > look at the ath11k controller driver here:
> > https://git.linaro.org/people/manivannan.sadhasivam/linux.git/tree/drivers/net/wireless/ath/ath11k/mhi.c?h=ath11k-qca6390-mhi#n13
> >
> > So the configuration comes from the static structures defined in the controller
> > driver. Earlier revision derived the configuration from devicetree but there are
> > many cases where this MHI bus is being used in non DT environments like x86.
> > So inorder to be platform agnostic, we chose static declaration method.
> >
> > In future we can add DT/ACPI support for the applicable parameters.
> 
> What determines the configuration? Is this always something that is fixed
> in hardware, or can some of the properties be changed based on what
> firmware runs the device?
> 

AFAIK, these configurations are fixed in hardware (this could come from
the firmware I'm not sure but they don't change with firmware revisions
for sure)

The reason for defining in the driver itself implies that these don't
change. But I'll confirm this with Qcom folks.

Thanks,
Mani

> If this is determined by the firmware, maybe the configuration would also
> need to be loaded from the file that contains the firmware, which in turn
> could be a blob in DT.
> 
>      Arnd

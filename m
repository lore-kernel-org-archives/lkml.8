Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9279C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC0720752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEV6EJQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgCROxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:53:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39833 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgCROx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:53:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id b22so7820187pgb.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bSaxZBsVRIea8O40s0gHrKvIQTpUv4EQDwjpsfPtStE=;
        b=NEV6EJQW31fosLEZPUCOokfdbTYH1j7rUiseYyd6QgUgtHrRqj+93AzTz7m8uRrRiG
         4BreEt+HW0kBLtONJiUYNkgJCVLQ5zU1GlIF1w7mRlvmuRmDywBS5NkXXZjZAnog54vc
         IeLrTSzY9OnB73V/xqqS3Al9r61Flh5u4JmurAG5NsRru5gRIu8ZsYFf54BDm8j3/OFC
         GNWDOdEIU8ubLKh5KQFeWhvKKex+wG0fPPbmX5hifT/GlpUsSph6VGdRNvpU0N4GmWXe
         wJ1H4mJflNc27T+PaCXgu3u4Te/n39pbHVI5UCaYAxhzsONBST58vgGUqB0oTaoSng5/
         yEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bSaxZBsVRIea8O40s0gHrKvIQTpUv4EQDwjpsfPtStE=;
        b=jnk9FLJotcbCpc3VwBB6PugCgNMH7dCCw1sRdTxDLpdPf2dflY67HiR3SW403M9LCZ
         5OXEYvHjArmTDezeLJzDeVRQ77TGfcKMxgureZype1ziVmLisiPzZOpY7QZjf+I2SsXu
         C5BfFSM4p1gubtJoz3uEOgYO8biM0Xh5DXUbqsg8MICi5iyD1BMbvw1d5Hd93dx9d6n0
         eIXmRuRbvYzGsujIOIfmUNqKe0KOz6u1zxuCAzUqGC7ud7R1ndwD/WPB2VKCBSLvuIfT
         tgq+0ssG6/IrOUhOSEx5qRmlSUI9ULbTiDczi67r0FPt9uQIsEhCsXpXIgPCYAz9hoUE
         viZA==
X-Gm-Message-State: ANhLgQ3O5KmvAcCZCv/QZrEL3V/JtjUVEXJPokhQYTCdZVFnj0FTJGWM
        xAujgSdTSVHEJ/ukXmCNiST8
X-Google-Smtp-Source: ADFU+vuXpSmTOZZFpFy5a3s/b2DTUpsn73W0gqi1O00Pb7jORAvFfNssj1yafPoPZwYiilrn4OdSrw==
X-Received: by 2002:a63:e551:: with SMTP id z17mr5003569pgj.21.1584543206241;
        Wed, 18 Mar 2020 07:53:26 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:199:25eb:1005:91b8:c500:d4b4])
        by smtp.gmail.com with ESMTPSA id u9sm3085926pfn.116.2020.03.18.07.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 07:53:25 -0700 (PDT)
Date:   Wed, 18 Mar 2020 20:23:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     arnd@arndb.de, smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 14/16] net: qrtr: Add MHI transport layer
Message-ID: <20200318145315.GA12709@Mani-XPS-13-9360>
References: <20200220095854.4804-1-manivannan.sadhasivam@linaro.org>
 <20200220095854.4804-15-manivannan.sadhasivam@linaro.org>
 <20200318144246.GA2859404@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318144246.GA2859404@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Mar 18, 2020 at 03:42:46PM +0100, Greg KH wrote:
> On Thu, Feb 20, 2020 at 03:28:52PM +0530, Manivannan Sadhasivam wrote:
> > MHI is the transport layer used for communicating to the external modems.
> > Hence, this commit adds MHI transport layer support to QRTR for
> > transferring the QMI messages over IPC Router.
> > 
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  net/qrtr/Kconfig  |   7 ++
> >  net/qrtr/Makefile |   2 +
> >  net/qrtr/mhi.c    | 209 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 218 insertions(+)
> >  create mode 100644 net/qrtr/mhi.c
> 
> I stopped here in this series, as I do not feel comfortable merging
> stuff under net/.
> 
> Can you get some review by the networking developers and then I will be
> ok with taking it through my tree.
> 

Sure.

Dave, can you please look into this patch? Greg merged the remaining patches
to his char-misc-testing branch. And if you can provide review, all can go
through Greg's tree.

Thanks,
Mani

> thanks,
> 
> greg k-h

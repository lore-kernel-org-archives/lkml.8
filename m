Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D22C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D63E2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594916471;
	bh=2/veCRo1GAvC2FMAn2m0uqdjRlhG3W7tu3R91NPEvyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iInqRi803pOWKJspYVpezsDqCAdmVheyf9wyUWIaVPi8eBr81x/aG2Y7G8SGmkOfL
	 lFky5n+mIDd2uGjRUNWgfFaVQ0/y/aCRyHfeddV2LjO2narRzGoYij1s2LSrcPMzuG
	 +Yb+N7MeKS5nUhW15tIWy4IcPCIrRyXA23hChfIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgGPQVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbgGPQVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:21:09 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69B0220739;
        Thu, 16 Jul 2020 16:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594916469;
        bh=2/veCRo1GAvC2FMAn2m0uqdjRlhG3W7tu3R91NPEvyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asiZJxytY0Wqqr+C5R3NblliWNjbWXCqivglMG6bn1rtY/0XqVSVT4cPrmDf6D/15
         cHEL3dKfxPYMWbGJR5cmeoSQg/6gmNKUDkrWn4Rm1ZhoQp36m0/G4uGJ1aY4vB1bmJ
         b64dEhFIc7K/DdVPLP40hcRNITA/csA1v29Q1uxY=
Date:   Thu, 16 Jul 2020 09:21:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Avi Shchislowski <Avi.Shchislowski@wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sang-yoon Oh <sangyoon.oh@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Adel Choi <adel.choi@samsung.com>,
        BoRam Shin <boram.shin@samsung.com>
Subject: Re: [PATCH v6 0/5] scsi: ufs: Add Host Performance Booster Support
Message-ID: <20200716162106.GA865@sol.localdomain>
References: <CGME20200713103423epcms2p8442ee7cc22395e4a4cedf224f95c45e8@epcms2p8>
 <963815509.21594636682161.JavaMail.epsvc@epcpadp2>
 <SN6PR04MB38720C3D8FC176C3C7FB51B89A7E0@SN6PR04MB3872.namprd04.prod.outlook.com>
 <4174fcf4-73ec-8e3f-90a5-1e7584e3e2d0@acm.org>
 <SN6PR04MB3872FBE1EAE3578BFD2601189A7F0@SN6PR04MB3872.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB3872FBE1EAE3578BFD2601189A7F0@SN6PR04MB3872.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:00:57AM +0000, Avi Shchislowski wrote:
> > On 2020-07-15 11:34, Avi Shchislowski wrote:
> > > My name is Avi Shchislowski, I am managing the WDC's Linux Host R&D team
> > in which Avri is a member of.
> > > As the review process of HPB is progressing very constructively, we are getting
> > more and more requests from OEMs, Inquiring about HPB in general, and host
> > control mode in particular.
> > >
> > > Their main concern is that HPB will make it to 5.9 merge window, but the host
> > control mode patches will not.
> > > Thus, because of recent Google's GKI, the next Android LTS might not include
> > HPB with host control mode.
> > >
> > > Aside of those requests, initial host control mode testing are showing
> > promising prospective with respect of performance gain.
> > >
> > > What would be, in your opinion, the best policy that host control mode is
> > included in next Android LTS?
> > 
> > Hi Avi,
> > 
> > Are you perhaps referring to the HPB patch series that has already been posted?
> > Although I'm not sure of this, I think that the SCSI maintainer expects more
> > Reviewed-by: and Tested-by: tags. Has anyone from WDC already taken the
> > time to review and/or test this patch series?
> > 
> > Thanks,
> > 
> > Bart.
> 
> Yes, I am referring to the current proposal which I am replying to:
> [PATCH v6 0/5] scsi: ufs: Add Host Performance Booster Support This proposal
> does not contains host mode, hence our customers concern.
> What would be, in your opinion, the best policy that host control mode is
> included in next Android LTS  assuming it will be based on kernel v5.9 ?
> 
> Thanks,
> Avi

Generally, the Android kernel team will accept backports of upstream patches.
So just keep working on this and get it upstream as soon as you can, but it
doesn't have to be 5.9.

- Eric

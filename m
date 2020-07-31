Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3C120838
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596176473;
	bh=Blyl629R0rSAITfg2RV8ZN7IJy1nXeWFtckxB9vWUvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2aZCp+LpnJQ6wjx+t3lfB6B1zyzWsNL6C/UxOddQ6O4ulH50nsf/vN43AgPZQ+LbL
	 p366WlslwFWu2s11clA+5bViPLURofl0KMMMqvndeh4V1OKX9PozUICKxH+WF/Qf1Z
	 FdNrv9w/JCIs26v1xshCg7Daf0iRzk5a3FsIAcQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbgGaGVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 02:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731152AbgGaGVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 02:21:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F55207F5;
        Fri, 31 Jul 2020 06:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596176470;
        bh=Blyl629R0rSAITfg2RV8ZN7IJy1nXeWFtckxB9vWUvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KbiLWGbTe5xiVd/jsXPTlxW6rM4LsoqTLKCGKz8fvq76VkTkBH0KLvtXeLKpo93EO
         zRSJ5YV/enJL6IKR7UjWmBFW6gVVvUV0JZJSQ3id7vzzu2f+34E+W6vjFae4l3uhNE
         pxi5FlBjpzGoMnb6bhlosGz8RTnbqN/6ECSmHxOk=
Date:   Fri, 31 Jul 2020 08:20:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Colin King <colin.king@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>, Tomer Tayar <ttayar@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        kernel-janitors@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] habanalabs: fix incorrect check on failed
 workqueue create
Message-ID: <20200731062057.GC1508201@kroah.com>
References: <20200730082022.5557-1-colin.king@canonical.com>
 <CAFCwf101gsf3GK6f_ggNgPeKTFXEDdCYz-LugNq5mY342zc2Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf101gsf3GK6f_ggNgPeKTFXEDdCYz-LugNq5mY342zc2Hw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 01:51:48PM +0300, Oded Gabbay wrote:
> On Thu, Jul 30, 2020 at 11:20 AM Colin King <colin.king@canonical.com> wrote:
> >
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > The null check on a failed workqueue create is currently null checking
> > hdev->cq_wq rather than the pointer hdev->cq_wq[i] and so the test
> > will never be true on a failed workqueue create. Fix this by checking
> > hdev->cq_wq[i].
> >
> > Addresses-Coverity: ("Dereference before null check")
> > Fixes: 5574cb2194b1 ("habanalabs: Assign each CQ with its own work queue")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/misc/habanalabs/common/device.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
> > index be16b75bdfdb..35214a186913 100644
> > --- a/drivers/misc/habanalabs/common/device.c
> > +++ b/drivers/misc/habanalabs/common/device.c
> > @@ -288,7 +288,7 @@ static int device_early_init(struct hl_device *hdev)
> >         for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++) {
> >                 snprintf(workq_name, 32, "hl-free-jobs-%u", i);
> >                 hdev->cq_wq[i] = create_singlethread_workqueue(workq_name);
> > -               if (hdev->cq_wq == NULL) {
> > +               if (hdev->cq_wq[i] == NULL) {
> >                         dev_err(hdev->dev, "Failed to allocate CQ workqueue\n");
> >                         rc = -ENOMEM;
> >                         goto free_cq_wq;
> > --
> > 2.27.0
> >
> 
> This patch is:
> Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
> 
> Greg, can you please apply it directly to the char-misc-next branch ?
> I don't want to send a pull request for 1 patch.

Already merged :)

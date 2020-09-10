Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C9EC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355452075A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbgIJPAY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 11:00:24 -0400
Received: from mail.v3.sk ([167.172.186.51]:45208 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730434AbgIJO5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:57:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B8A80DF8B0;
        Thu, 10 Sep 2020 14:55:44 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hDs2K46TAbBt; Thu, 10 Sep 2020 14:55:44 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 33F22DFA68;
        Thu, 10 Sep 2020 14:55:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OceZyqVHEt8l; Thu, 10 Sep 2020 14:55:44 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id E3691DF8B0;
        Thu, 10 Sep 2020 14:55:43 +0000 (UTC)
Date:   Thu, 10 Sep 2020 16:57:02 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     corbet@lwn.net, mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] media: marvell-ccic: Fix -Wunused-function warnings
Message-ID: <20200910145702.GA1118779@demiurge.local>
References: <20200910080933.40684-1-yuehaibing@huawei.com>
 <20200910082221.GA1115782@demiurge.local>
 <b7206784-15ea-9790-0c70-eea99bbab34a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7206784-15ea-9790-0c70-eea99bbab34a@huawei.com>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 05:18:15PM +0800, Yuehaibing wrote:
> On 2020/9/10 16:22, Lubomir Rintel wrote:
> > On Thu, Sep 10, 2020 at 04:09:33PM +0800, YueHaibing wrote:
> >> If CONFIG_PM is n, gcc warns:
> >>
> >> drivers/media/platform/marvell-ccic/mmp-driver.c:347:12: warning: ‘mmpcam_resume’ defined but not used [-Wunused-function]
> >>  static int mmpcam_resume(struct device *dev)
> >>             ^~~~~~~~~~~~~
> >> drivers/media/platform/marvell-ccic/mmp-driver.c:338:12: warning: ‘mmpcam_suspend’ defined but not used [-Wunused-function]
> >>  static int mmpcam_suspend(struct device *dev)
> >>             ^~~~~~~~~~~~~~
> >> drivers/media/platform/marvell-ccic/mmp-driver.c:324:12: warning: ‘mmpcam_runtime_suspend’ defined but not used [-Wunused-function]
> >>  static int mmpcam_runtime_suspend(struct device *dev)
> >>             ^~~~~~~~~~~~~~~~~~~~~~
> >> drivers/media/platform/marvell-ccic/mmp-driver.c:310:12: warning: ‘mmpcam_runtime_resume’ defined but not used [-Wunused-function]
> >>  static int mmpcam_runtime_resume(struct device *dev)
> >>             ^~~~~~~~~~~~~~~~~~~~~
> >>
> >> Mark them as __maybe_unused to fix this.
> >>
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > 
> > Your colleague seems to sent out an equivalent patch:
> > https://lore.kernel.org/lkml/20200910080933.40684-1-yuehaibing@huawei.com/
> 
> This is my patch, paste an wrong link?

Indeed, sorry for the confusion.

The original mail only went to linux-media, not lkml, which is why I
picked the wrong one from the archive. Here's the patch:

https://lore.kernel.org/linux-media/20200909112921.5116-1-weiyongjun1@huawei.com/

Take care
Lubo

> 
> > 
> > Cheers
> > Lubo
> > 
> >> ---
> >>  drivers/media/platform/marvell-ccic/mmp-driver.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/marvell-ccic/mmp-driver.c b/drivers/media/platform/marvell-ccic/mmp-driver.c
> >> index c4b28a00a3a2..032fdddbbecc 100644
> >> --- a/drivers/media/platform/marvell-ccic/mmp-driver.c
> >> +++ b/drivers/media/platform/marvell-ccic/mmp-driver.c
> >> @@ -307,7 +307,7 @@ static int mmpcam_platform_remove(struct platform_device *pdev)
> >>   * Suspend/resume support.
> >>   */
> >>  
> >> -static int mmpcam_runtime_resume(struct device *dev)
> >> +static int __maybe_unused mmpcam_runtime_resume(struct device *dev)
> >>  {
> >>  	struct mmp_camera *cam = dev_get_drvdata(dev);
> >>  	struct mcam_camera *mcam = &cam->mcam;
> >> @@ -321,7 +321,7 @@ static int mmpcam_runtime_resume(struct device *dev)
> >>  	return 0;
> >>  }
> >>  
> >> -static int mmpcam_runtime_suspend(struct device *dev)
> >> +static int __maybe_unused mmpcam_runtime_suspend(struct device *dev)
> >>  {
> >>  	struct mmp_camera *cam = dev_get_drvdata(dev);
> >>  	struct mcam_camera *mcam = &cam->mcam;
> >> @@ -335,7 +335,7 @@ static int mmpcam_runtime_suspend(struct device *dev)
> >>  	return 0;
> >>  }
> >>  
> >> -static int mmpcam_suspend(struct device *dev)
> >> +static int __maybe_unused mmpcam_suspend(struct device *dev)
> >>  {
> >>  	struct mmp_camera *cam = dev_get_drvdata(dev);
> >>  
> >> @@ -344,7 +344,7 @@ static int mmpcam_suspend(struct device *dev)
> >>  	return 0;
> >>  }
> >>  
> >> -static int mmpcam_resume(struct device *dev)
> >> +static int __maybe_unused mmpcam_resume(struct device *dev)
> >>  {
> >>  	struct mmp_camera *cam = dev_get_drvdata(dev);
> >>  
> >> -- 
> >> 2.17.1
> >>
> >>
> > 
> > .
> > 
> 

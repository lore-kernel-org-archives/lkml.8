Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CEBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AFFE2071B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgGNDYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:24:02 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39260 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbgGNDYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:24:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U2gNrnC_1594697032;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U2gNrnC_1594697032)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Jul 2020 11:23:52 +0800
Date:   Tue, 14 Jul 2020 11:23:52 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Remove redundant validation in nvme_start_ctrl()
Message-ID: <20200714032352.GA111285@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <710eb90d9c1c125bdb37aae31ddc41a0f9782fa6.1594621435.git.baolin.wang@linux.alibaba.com>
 <BYAPR04MB49655C05950BC7BDAD30629F86600@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49655C05950BC7BDAD30629F86600@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 11:58:18PM +0000, Chaitanya Kulkarni wrote:
> On 7/12/20 23:31, Baolin Wang wrote:
> > We've already validated the 'kato' in nvme_start_keep_alive(), thus no
> > need to validate it again in nvme_start_ctrl(). Remove it.
> > 
> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > ---
> >   drivers/nvme/host/core.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 3d00ea4..a95e26e 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -4313,8 +4313,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> >   
> >   void nvme_start_ctrl(struct nvme_ctrl *ctrl)
> >   {
> > -	if (ctrl->kato)
> > -		nvme_start_keep_alive(ctrl);
> > +	nvme_start_keep_alive(ctrl);
> >   
> >   	nvme_enable_aen(ctrl);
> >   
> > 
> 
> Since start keep alive is so small to make a function call how about we 
> in-line the call ? untested patch :-

I am Okay about your suggestion. Will send v2 with your suggested-by tag
if no other objection. Thanks.

> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 09abf2ca33f5..c7289c23658a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4311,8 +4311,9 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
> 
>   void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   {
> +       /* if ctrl keep alive time out is set start keep alive */
>          if (ctrl->kato)
> -               nvme_start_keep_alive(ctrl);
> +               queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * 
> HZ);
> 
>          nvme_enable_aen(ctrl);
> 
> root@iouring nvme (xarray) # git diff
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 09abf2ca33f5..08e1a6826b08 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1031,14 +1031,6 @@ static void nvme_keep_alive_work(struct 
> work_struct *work)
>          }
>   }
> 
> -static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
> -{
> -       if (unlikely(ctrl->kato == 0))
> -               return;
> -
> -       queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
> -}
> -
>   void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
>   {
>          if (unlikely(ctrl->kato == 0))
> @@ -4311,8 +4303,9 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
> 
>   void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   {
> +       /* if ctrl keep alive time out is set start keep alive */
>          if (ctrl->kato)
> -               nvme_start_keep_alive(ctrl);
> +               queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * 
> HZ);
> 
>          nvme_enable_aen(ctrl);
> 
> 

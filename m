Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0443AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BF220721
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388206AbgDBQbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:31:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44666 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732569AbgDBQbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:31:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 0D2C6297DC3
Message-ID: <530189e1af69fb04168cf1237aa2990895e471dd.camel@collabora.com>
Subject: Re: [PATCH 1/3] rkisp1: Get rid of unused variable warning
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Robin Murphy <robin.murphy@arm.com>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, kernel@collabora.com
Date:   Thu, 02 Apr 2020 13:31:27 -0300
In-Reply-To: <b994a6fe-865b-d5c4-7f3f-ed6b1815f37f@arm.com>
References: <20200401213721.24173-1-ezequiel@collabora.com>
         <20200401213721.24173-2-ezequiel@collabora.com>
         <b994a6fe-865b-d5c4-7f3f-ed6b1815f37f@arm.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-02 at 10:47 +0100, Robin Murphy wrote:
> On 2020-04-01 10:37 pm, Ezequiel Garcia wrote:
> > If CONFIG_OF is not selected, the compiler will complain:
> > 
> > drivers/staging/media/rkisp1/rkisp1-dev.c: In function ‘rkisp1_probe’:
> > drivers/staging/media/rkisp1/rkisp1-dev.c:457:22: warning: unused variable ‘node’ [-Wunused-variable]
> >    457 |  struct device_node *node = pdev->dev.of_node;
> > 
> > Rework the code slightly and make the compiler happy.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> >   drivers/staging/media/rkisp1/rkisp1-dev.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/media/rkisp1/rkisp1-dev.c b/drivers/staging/media/rkisp1/rkisp1-dev.c
> > index b1b3c058e957..5e7e797aad71 100644
> > --- a/drivers/staging/media/rkisp1/rkisp1-dev.c
> > +++ b/drivers/staging/media/rkisp1/rkisp1-dev.c
> > @@ -454,7 +454,6 @@ static void rkisp1_debug_init(struct rkisp1_device *rkisp1)
> >   
> >   static int rkisp1_probe(struct platform_device *pdev)
> >   {
> > -	struct device_node *node = pdev->dev.of_node;
> >   	const struct rkisp1_match_data *clk_data;
> >   	const struct of_device_id *match;
> >   	struct device *dev = &pdev->dev;
> > @@ -463,7 +462,7 @@ static int rkisp1_probe(struct platform_device *pdev)
> >   	unsigned int i;
> >   	int ret, irq;
> >   
> > -	match = of_match_node(rkisp1_of_match, node);
> > +	match = of_match_node(rkisp1_of_match, pdev->dev.of_node);
> 
> FWIW you could clean up "match" too by using of_device_get_match_data().
> 

Ah, that's nicer.

Thanks,
Ezequiel


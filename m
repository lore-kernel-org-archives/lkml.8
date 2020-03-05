Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8509FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E523207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="ipHhDMSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCESqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:46:35 -0500
Received: from forward501p.mail.yandex.net ([77.88.28.111]:45698 "EHLO
        forward501p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbgCESqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:46:34 -0500
Received: from mxback30g.mail.yandex.net (mxback30g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:330])
        by forward501p.mail.yandex.net (Yandex) with ESMTP id E27733500531;
        Thu,  5 Mar 2020 21:46:27 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback30g.mail.yandex.net (mxback/Yandex) with ESMTP id iGuMvhqZaa-kQYi1aoQ;
        Thu, 05 Mar 2020 21:46:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1583433987;
        bh=WbDDv6qYTqWmJsP3qfohS0aAr3PAr4lOdDNrBRZ/zy8=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=ipHhDMSs/4/WhzPQcS4NsH6Fqom/ChEWJK8QdMv5iXS+oV6rBy30120HjwOyBNt5t
         mUAmwqLxUU5qvsdfQ4GCFVpREBaLoKGLT1NvHO99TNyNdhFzax2k4JT+gbUd9e21cK
         Mn581akDZSmN+GZfCnzfca8SnNumZTpfYVGVEi14=
Authentication-Results: mxback30g.mail.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt3-605d5ea4bc20.qloud-c.yandex.net with HTTP;
        Thu, 05 Mar 2020 21:46:26 +0300
From:   nikita.shubin@maquefel.me
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Nikita Shubin <nshubin@topcon.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CANLsYkyHaZFrCYFxWZVGqy=QwU86i2E2o9ENZ7k2mv70jU9pqg@mail.gmail.com>
References: <20200304142628.8471-1-NShubin@topcon.com> <CANLsYkzPROdphvmtpZ6YiajZ2dYLrojC-rGYkq4jK2yzTnAJ5A@mail.gmail.com>
         <264561583429111@sas1-438a02fc058e.qloud-c.yandex.net> <CANLsYkxj=1o8Y0V0WedbVirj9seZSArWeCvQvwk+N7wZa2_hPQ@mail.gmail.com>
         <266371583430956@iva3-67f911cb3a01.qloud-c.yandex.net> <CANLsYkyHaZFrCYFxWZVGqy=QwU86i2E2o9ENZ7k2mv70jU9pqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] remoteproc: imx_rproc: dummy kick method
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 05 Mar 2020 21:46:26 +0300
Message-Id: <272401583433950@myt4-c14277df27e9.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's totally okay - thank you for review.

05.03.2020, 21:36, "Mathieu Poirier" <mathieu.poirier@linaro.org>:
> On Thu, 5 Mar 2020 at 11:07, <nikita.shubin@maquefel.me> wrote:
>>  05.03.2020, 20:54, "Mathieu Poirier" <mathieu.poirier@linaro.org>:
>>  > On Thu, 5 Mar 2020 at 10:29, <nikita.shubin@maquefel.me> wrote:
>>  >> 05.03.2020, 19:17, "Mathieu Poirier" <mathieu.poirier@linaro.org>:
>>  >> > On Wed, 4 Mar 2020 at 07:25, Nikita Shubin <NShubin@topcon.com> wrote:
>>  >> >> add kick method that does nothing, to avoid errors in rproc_virtio_notify.
>>  >> >>
>>  >> >> Signed-off-by: Nikita Shubin <NShubin@topcon.com>
>>  >> >> ---
>>  >> >> drivers/remoteproc/imx_rproc.c | 6 ++++++
>>  >> >> 1 file changed, 6 insertions(+)
>>  >> >>
>>  >> >> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
>>  >> >> index 3e72b6f38d4b..796b6b86550a 100644
>>  >> >> --- a/drivers/remoteproc/imx_rproc.c
>>  >> >> +++ b/drivers/remoteproc/imx_rproc.c
>>  >> >> @@ -240,9 +240,15 @@ static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
>>  >> >> return va;
>>  >> >> }
>>  >> >>
>>  >> >> +static void imx_rproc_kick(struct rproc *rproc, int vqid)
>>  >> >> +{
>>  >> >> +
>>  >> >> +}
>>  >> >> +
>>  >> >
>>  >> > If rproc::kick() is empty, how does the MCU know there is packets to
>>  >> > fetch in the virtio queues?
>>  >>
>>  >> Well, of course it doesn't i understand this perfectly - just following documentation citing:
>>  >>
>>  >> | Every remoteproc implementation should at least provide the ->start and ->stop
>>  >> | handlers. If rpmsg/virtio functionality is also desired, then the ->kick handler
>>  >> | should be provided as well.
>>  >>
>>  >> But i as i mentioned in "remoteproc: Fix NULL pointer dereference in rproc_virtio_notify" kick method will be called if
>>  >> "resource_table exists in firmware and has "Virtio device entry" defined" anyway, the imx_rproc is not in control of what
>>  >> exactly it is booting, so such situation can occur.
>>  >
>>  > If I understand correctly, the MCU can boot images that have a virtio
>>  > device in its resource table and still do useful work even if the
>>  > virtio device/rpmsg bus can't be setup - is this correct?
>>
>>  Yes, this assumption is correct.
>>
>>  Despite this situation is not i desire at all - such thing can happen.
>>  I am currently using co-proc as a realtime part of UGV control,
>>  so it must immediately stop the engines, if not provided with navigational information.
>>
>>  The imx7d MCU have access to the most periphery that have the main processor.
>>
>>  Of course the kick method should do real work, but i decided to submit step by step if i am allowed to do so.
>
> Ok, the situation is clearer now and I have put your patches back in
> my queue. I am seriously back-logged at this time so it will take a
> little while before I get to them.
>
>>  >
>>  > Thanks,
>>  > Mathieu
>>  >
>>  >> >
>>  >> >> static const struct rproc_ops imx_rproc_ops = {
>>  >> >> .start = imx_rproc_start,
>>  >> >> .stop = imx_rproc_stop,
>>  >> >> + .kick = imx_rproc_kick,
>>  >> >> .da_to_va = imx_rproc_da_to_va,
>>  >> >> };
>>  >> >>
>>  >> >> --
>>  >> >> 2.24.1

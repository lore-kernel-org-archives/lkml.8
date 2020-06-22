Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFCEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F27DD206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="tcKWWO9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgFVJRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:17:04 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:21832 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726546AbgFVJRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:17:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592817422; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=ooirKCjR7lwlB/4N/A1gnewRijD2y6yusHKO21HgUNE=; b=tcKWWO9aRiCqqvIItbzAKN+7/jJHDBIwdEzoyiZdIFaaCSISrVFB5alAA0F4Hqa9VAW+FOTi
 V0YAHXyksaDFu/5ieLGFKhecItIBAlFRAXAaXsirowvAHts1U3WBdY4OWZUr6iNWEE7SmuHm
 cQ7be59kaTwCdXVmDiH6CzvCB2c=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5ef0770df3deea03f3a4ed69 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 09:17:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8F8EDC433CB; Mon, 22 Jun 2020 09:17:01 +0000 (UTC)
Received: from Pillair (unknown [183.83.71.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D8F2C433C8;
        Mon, 22 Jun 2020 09:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D8F2C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   "Rakesh Pillai" <pillair@codeaurora.org>
To:     "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Evan Green'" <evgreen@chromium.org>
Cc:     "'open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS'" 
        <devicetree@vger.kernel.org>,
        "'linux-arm Mailing List'" <linux-arm-kernel@lists.infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-msm'" <linux-arm-msm@vger.kernel.org>
References: <1589946996-31264-1-git-send-email-pillair@codeaurora.org> <CAE=gft5pcHwK8yjObNSSH=U_B6Pz++bDaeUxZhPyJfG2E7LRAg@mail.gmail.com> <CAE=gft5So9Uk2UqRWs2zFO_iD+6ofMy97bKP4HpgM1Wu6Duxvw@mail.gmail.com> <20200621190602.GL128451@builder.lan>
In-Reply-To: <20200621190602.GL128451@builder.lan>
Subject: RE: [PATCH v11] arm64: dts: qcom: sc7180: Add WCN3990 WLAN module device node
Date:   Mon, 22 Jun 2020 14:46:54 +0530
Message-ID: <000001d64875$e28615a0$a79240e0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG/PI1FMT9lT4wFnqoECWl87ZLpcgLOq7cUAp/L6tUBMLjXYajdeP/A
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> Sent: Monday, June 22, 2020 12:36 AM
> To: Evan Green <evgreen@chromium.org>
> Cc: Rakesh Pillai <pillair@codeaurora.org>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-arm
> Mailing List <linux-arm-kernel@lists.infradead.org>; LKML <linux-
> kernel@vger.kernel.org>; linux-arm-msm <linux-arm-
> msm@vger.kernel.org>
> Subject: Re: [PATCH v11] arm64: dts: qcom: sc7180: Add WCN3990 WLAN
> module device node
> 
> On Wed 17 Jun 15:45 PDT 2020, Evan Green wrote:
> 
> > On Thu, May 21, 2020 at 9:19 AM Evan Green <evgreen@chromium.org>
> wrote:
> > >
> > > On Tue, May 19, 2020 at 8:57 PM Rakesh Pillai <pillair@codeaurora.org>
> wrote:
> > > >
> > > > Add device node for the ath10k SNOC platform driver probe
> > > > and add resources required for WCN3990 on sc7180 soc.
> > > >
> > > > Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> > >
> > > Reviewed-by: Evan Green <evgreen@chromium.org>
> >
> > Looks like this never landed anywhere. Is it blocked on something?
> 
> I remember waiting for some reviews, but I see those are in place. Then
> as I was applying this I saw that a v12 had shown up, with regulators.
> 
> So, I applied v12.


Thanks Bjorn.


> 
> Thanks,
> Bjorn


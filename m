Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5613CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37260207DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgFCK1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:27:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36130 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCK1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:27:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 53CE52A3AC2
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Adrian Pop <pop.adrian61@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Philippe CORNU <philippe.cornu@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [Linux-stm32] [PATCH v8 08/10] drm: stm: dw-mipi-dsi: let the
 bridge handle the HW version check
In-Reply-To: <CACvgo51QyzEa8LFpGq5zjYV-0TifQRtNh4WhMYy8jNtaswxd7Q@mail.gmail.com>
References: <20200427081952.3536741-1-adrian.ratiu@collabora.com>
 <20200427081952.3536741-9-adrian.ratiu@collabora.com>
 <4acc09e8-0610-01f6-b18d-3ffc390c45a3@st.com>
 <87blm387vt.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
 <CACvgo51QyzEa8LFpGq5zjYV-0TifQRtNh4WhMYy8jNtaswxd7Q@mail.gmail.com>
Date:   Wed, 03 Jun 2020 13:28:54 +0300
Message-ID: <878sh48mu1.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jun 2020, Emil Velikov <emil.l.velikov@gmail.com> 
wrote:
> Hi Adrian, 

Hi Email,

> 
> On Mon, 1 Jun 2020 at 10:14, Adrian Ratiu 
> <adrian.ratiu@collabora.com> wrote: 
>> 
>> On Fri, 29 May 2020, Philippe CORNU <philippe.cornu@st.com> 
>> wrote: 
>> > Hi Adrian, and thank you very much for the patchset.  Thank 
>> > you also for having tested it on STM32F769 and STM32MP1. 
>> > Sorry for the late response, Yannick and I will review it as 
>> > soon as possible and we will keep you posted.  Note: Do not 
>> > hesitate to put us in copy for the next version 
>> > (philippe.cornu@st.com, yannick.fertre@st.com) Regards, 
>> > Philippe :-) 
>> 
>> Hi Philippe, 
>> 
>> Thank you very much for your previous and future STM testing, 
>> really appreciate it! I've CC'd Yannick until now but I'll also 
>> CC you sure :) 
>> 
>> It's been over a month since I posted v8 and I was just gearing 
>> up to address all feedback, rebase & retest to prepare v9 but 
>> I'll wait a little longer, no problem, it's no rush. 
>> 
> Small idea, pardon for joining so late: 
> 
> Might be a good idea to add inline comment, why the clocks are 
> disabled so late.  Effectively a 2 line version of the commit 
> summary. 
> 
> Feel free to make that a separate/follow-up patch.

Thanks, I'll add the comment to this patch in v9.

>
> -Emil
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

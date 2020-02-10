Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265A5C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92E120715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=serbinski.com header.i=@serbinski.com header.b="vvcUgFrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgBJNoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:44:38 -0500
Received: from mail.serbinski.com ([162.218.126.2]:34280 "EHLO
        mail.serbinski.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgBJNoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:44:37 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.serbinski.com (Postfix) with ESMTP id 0DB0AD006F9;
        Mon, 10 Feb 2020 13:44:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at serbinski.com
Received: from mail.serbinski.com ([127.0.0.1])
        by localhost (mail.serbinski.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CtK7mfW-1BDu; Mon, 10 Feb 2020 08:44:31 -0500 (EST)
Received: from mail.serbinski.com (localhost [127.0.0.1])
        by mail.serbinski.com (Postfix) with ESMTP id B5D6DD00693;
        Mon, 10 Feb 2020 08:44:31 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.serbinski.com B5D6DD00693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serbinski.com;
        s=default; t=1581342271;
        bh=zoaUdtUdAwbS6W/qIOBURXTRFBcaTr0B8ofCyG3hjjw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vvcUgFrbvvVbBiV8cAwNiGEhy7uaAKlWb93nxC7EAozNJol/8FnH6LclBYzz9RWM3
         Gch97PXEEO9SY26Glk7blM68U4i1+UL1IieXWRg+6pm31uNkDVPlz2HortA8N5H61H
         2wKj988HcHOKIs2dJMG/uu5MraB0px8kCJo2J72E=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 Feb 2020 08:44:31 -0500
From:   Adam Serbinski <adam@serbinski.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] ASoC: qdsp6: db820c: Add support for external and
 bluetooth audio
In-Reply-To: <20200210121747.GB7685@sirena.org.uk>
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
 <20200210121747.GB7685@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4-beta
Message-ID: <007098fa20e161bf94d65e248955ff6c@serbinski.com>
X-Sender: adam@serbinski.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-10 07:17, Mark Brown wrote:
> On Sun, Feb 09, 2020 at 10:47:40AM -0500, Adam Serbinski wrote:
>> Changes from V1:
>> 
>> 	Rename patch:
>> 		from: dts: msm8996/db820c: enable primary pcm and quaternary i2s
> 
> Please don't send new serieses in reply to old ones, it can make it
> confusing what's going on and what the current version is.

My apologies. Its my first time doing this. Thank you for the advice.

-Adam

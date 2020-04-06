Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD80DC2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9425F248A0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RoKNtoxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgDFPfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:35:47 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11346 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbgDFPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:35:47 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8b4c440000>; Mon, 06 Apr 2020 08:35:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 06 Apr 2020 08:35:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 06 Apr 2020 08:35:45 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr
 2020 15:35:45 +0000
Received: from [10.2.164.193] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr 2020
 15:35:44 +0000
Subject: Re: [RFC PATCH v6 6/9] media: tegra: Add Tegra210 Video input driver
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <sakari.ailus@iki.fi>, <helen.koike@collabora.com>
CC:     <sboyd@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1585963507-12610-1-git-send-email-skomatineni@nvidia.com>
 <1585963507-12610-7-git-send-email-skomatineni@nvidia.com>
 <38d921a7-5cdf-8d0a-2772-4399dd1a96a0@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <9b8cf37b-d2ad-9df2-aad8-216c2c954e69@nvidia.com>
Date:   Mon, 6 Apr 2020 08:35:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <38d921a7-5cdf-8d0a-2772-4399dd1a96a0@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586187332; bh=5xUdeFe+tsnvL5IQpFJYpz5Hc6UjFOqVctZRzHoI4l8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=RoKNtoxE20Gnm62y7RzwoPimN0Vsf3JEhU7OkkkjnLgK5hI9vWg9l2FlR0O7eRGrc
         lddPB7iclnDsMrDeSyc/CU+vb2Ajzq6tBAyo9I9qLrCh2A60RJCi7DWsdvW2/t2/WJ
         o9WDqvYFk2ZrzU1/FcNlHFZf5xswGQaBaBofLt7m8ySt9iacd3CbKHSk8LgXduBv3t
         uBEasTaHe9f8fBjQ4gSVwgAwn4x8Xoj7UXCP3K1sFMbP7cy6Lvaf7h4VERsWqD5L6e
         kaWrruKHg3dY4jUf9kmqx3OzQjDt2mgiB0n6DY7jtE7iyZ31TPEr8/MIxsMHpQgSGu
         rFhLLUdLr9etw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/5/20 1:35 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 04.04.2020 04:25, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
>> +static int tegra_channel_capture_frame(struct tegra_vi_channel *chan,
>> +                                    struct tegra_channel_buffer *buf)
>> +{
>> +     int err =3D 0;
>> +     u32 thresh, value, frame_start, mw_ack_done;
>> +     int bytes_per_line =3D chan->format.bytesperline;
>> +
>> +     /* program buffer address by using surface 0 */
>> +     vi_csi_write(chan, TEGRA_VI_CSI_SURFACE0_OFFSET_MSB,
>> +                  (u64)buf->addr >> 32);
>> +     vi_csi_write(chan, TEGRA_VI_CSI_SURFACE0_OFFSET_LSB, buf->addr);
>> +     vi_csi_write(chan, TEGRA_VI_CSI_SURFACE0_STRIDE, bytes_per_line);
>> +
>> +     /*
>> +      * Tegra VI block interacts with host1x syncpt for synchronizing
>> +      * programmed condition of capture state and hardware operation.
>> +      * Frame start and Memory write acknowledge syncpts has their own
>> +      * FIFO of depth 2.
>> +      *
>> +      * Syncpoint trigger conditions set through VI_INCR_SYNCPT registe=
r
>> +      * are added to HW syncpt FIFO and when the HW triggers, syncpt
>> +      * condition is removed from the FIFO and counter at syncpoint ind=
ex
>> +      * will be incremented by the hardware and software can wait for
>> +      * counter to reach threshold to synchronize capturing frame with =
the
>> +      * hardware capture events.
>> +      */
>> +
>> +     /* increase channel syncpoint threshold for FRAME_START */
>> +     thresh =3D host1x_syncpt_incr_max(chan->frame_start_sp, 1);
>> +
>> +     /* Program FRAME_START trigger condition syncpt request */
>> +     frame_start =3D VI_CSI_PP_FRAME_START(chan->portno);
>> +     value =3D VI_CFG_VI_INCR_SYNCPT_COND(frame_start) |
>> +             host1x_syncpt_id(chan->frame_start_sp);
>> +     tegra_vi_write(chan, TEGRA_VI_CFG_VI_INCR_SYNCPT, value);
>> +
>> +     /* increase channel syncpoint threshold for MW_ACK_DONE */
>> +     buf->mw_ack_sp_thresh =3D host1x_syncpt_incr_max(chan->mw_ack_sp, =
1);
>> +
>> +     /* Program MW_ACK_DONE trigger condition syncpt request */
>> +     mw_ack_done =3D VI_CSI_MW_ACK_DONE(chan->portno);
>> +     value =3D VI_CFG_VI_INCR_SYNCPT_COND(mw_ack_done) |
>> +             host1x_syncpt_id(chan->mw_ack_sp);
>> +     tegra_vi_write(chan, TEGRA_VI_CFG_VI_INCR_SYNCPT, value);
>> +
>> +     /* enable single shot capture */
>> +     vi_csi_write(chan, TEGRA_VI_CSI_SINGLE_SHOT, SINGLE_SHOT_CAPTURE);
>> +     chan->capture_reqs++;
>> +
>> +     /* wait for syncpt counter to reach frame start event threshold */
>> +     err =3D host1x_syncpt_wait(chan->frame_start_sp, thresh,
>> +                              TEGRA_VI_SYNCPT_WAIT_TIMEOUT, &value);
>> +     if (err) {
>> +             dev_err(&chan->video.dev,
>> +                     "frame start syncpt timeout: %d\n", err);
>> +             /* increment syncpoint counter for timedout events */
>> +             host1x_syncpt_incr(chan->frame_start_sp);
> Why incrementing is done while hardware is still active?
>
> The sync point's state needs to be completely reset after resetting
> hardware. But I don't think that the current upstream host1x driver
> supports doing that, it's one of the known-long-standing problems of the
> host1x driver.
>
> At least the sp->max_val incrementing should be done based on the actual
> syncpoint value and this should be done after resetting hardware.

upstream host1x driver don't have API to reset or to equalize max value=20
with min/load value.

So to synchronize missed event, incrementing HW syncpt counter.

This should not impact as we increment this in case of missed events only.

>> +             spin_lock(&chan->sp_incr_lock);
>> +             host1x_syncpt_incr(chan->mw_ack_sp);
>> +             spin_unlock(&chan->sp_incr_lock);
>> +             /* clear errors and recover */
>> +             tegra_channel_capture_error_recover(chan);
>> +             release_buffer(chan, buf, VB2_BUF_STATE_ERROR);
>> +             return err;
>> +     }

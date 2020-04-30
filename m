Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADAEC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA24C20774
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ashNi4iv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgD3UL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:11:27 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14216 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgD3UL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:11:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eab30720000>; Thu, 30 Apr 2020 13:09:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 Apr 2020 13:11:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 Apr 2020 13:11:26 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Apr
 2020 20:11:26 +0000
Received: from [10.2.165.152] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Apr
 2020 20:11:25 +0000
Subject: Re: [RFC PATCH v11 6/9] media: tegra: Add Tegra210 Video input driver
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <sakari.ailus@iki.fi>, <helen.koike@collabora.com>
CC:     <sboyd@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1588197606-32124-1-git-send-email-skomatineni@nvidia.com>
 <1588197606-32124-7-git-send-email-skomatineni@nvidia.com>
 <eadf3a5a-f305-4561-10e1-1b9241b9c5c2@gmail.com>
 <bfd82642-9648-96f1-737d-4b9a869d34a3@nvidia.com>
Message-ID: <52b98347-4b78-f637-04f4-cc730ad336f3@nvidia.com>
Date:   Thu, 30 Apr 2020 13:09:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bfd82642-9648-96f1-737d-4b9a869d34a3@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588277362; bh=KUYq48abhJkd8ZVPLEcyM2FZjGIskbxNUttIp0WPjzk=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=ashNi4ivzUfGGFMK/QS2UgeBL7ggdCBCB6zUn0NLfqSpCQNhd070KlZz2MMZ0Yn8d
         E5xb/4u3nUkcnAW+7E3yGNTKSg/ruhzouo+HUcFdX02BajCQsHyN7UTa8iVEGDFffL
         GTsJEPrqd4sea+EimqDLKEvpTzsSNHmz2k17kRX0WQSwMSSLycs7s2VBW7s45Nc8cD
         ZqaGLiSpT9RmUJb7A8W8fDLz/5wLjHrUAulxsRXxRDfxIOfiUPmhk3KJdxE+Vy1qIb
         Tqq1304C4UCIok34Gw4Hs/eGSp8LjI5NgJ5ao6/QKzYckzJt9KTVGyZaf3jQ+BncyK
         ebjysIeQh4/HA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/30/20 1:08 PM, Sowjanya Komatineni wrote:
>
> On 4/30/20 1:06 PM, Dmitry Osipenko wrote:
>> 30.04.2020 01:00, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> +static int chan_capture_kthread_start(void *data)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct tegra_vi_channel *chan =3D data;
>>> +=C2=A0=C2=A0=C2=A0 struct tegra_channel_buffer *buf;
>>> +=C2=A0=C2=A0=C2=A0 int err =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 set_freezable();
>>> +
>>> +=C2=A0=C2=A0=C2=A0 while (1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try_to_freeze();
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Source is not strea=
ming if error is non-zero.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * So, do not dequeue =
buffers on error and let the thread=20
>>> sleep
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * till kthread stop s=
ignal is received.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_event_interruptible(ch=
an->start_wait,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kthread_should_stop() |=
|
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (!list_empty(&chan->cap=
ture) &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !err));
>> ...
>>> +static void tegra_channel_buffer_queue(struct vb2_buffer *vb)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct tegra_vi_channel *chan =3D vb2_get_drv_priv(=
vb->vb2_queue);
>>> +=C2=A0=C2=A0=C2=A0 struct vb2_v4l2_buffer *vbuf =3D to_vb2_v4l2_buffer=
(vb);
>>> +=C2=A0=C2=A0=C2=A0 struct tegra_channel_buffer *buf =3D to_tegra_chann=
el_buffer(vbuf);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* put buffer into the capture queue */
>>> +=C2=A0=C2=A0=C2=A0 spin_lock(&chan->start_lock);
>>> +=C2=A0=C2=A0=C2=A0 list_add_tail(&buf->queue, &chan->capture);
>>> +=C2=A0=C2=A0=C2=A0 spin_unlock(&chan->start_lock);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* wait up kthread for capture */
>>> +=C2=A0=C2=A0=C2=A0 wake_up_interruptible(&chan->start_wait);
>>> +}
>> The V4L doc says that buffers could be enqueued before streaming is
>> started. I guess it should be a trouble here, shouldn't it?
>>
>> https://elixir.bootlin.com/linux/v5.7-rc3/source/include/media/videobuf2=
-core.h#L379=20
>>
>
> what trouble are you referring here?
>
> I dont think so as we set min buffers needed as 2 always there will be=20
> 2 per-queued buffers.
typo* pre-queued buffers before streaming start
>
> But buffers from this queue will be dequeued only when ready to=20
> processes in the capture thread
>

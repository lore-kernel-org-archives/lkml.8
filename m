Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A494AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807792076E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="V4wg9ffy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgHSO0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:26:34 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:46775 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726560AbgHSO0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:26:32 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 8P2qkdNUQuuXO8P2skhYkN; Wed, 19 Aug 2020 16:26:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1597847190; bh=an3aoXCY68YNrYl4FDHok9+pDEZ07hbqUHPLmI5S0vk=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=V4wg9ffyl/o9q1L5mENqFFbl8Om746bPg8zZg+Hhx3quf+IOpOAPnA6ebP4UvobaE
         F1leL+ue06IJ2eRhBTXK0C+p1pvY7D/gWvHzmyxHduzgPTcPD7jaeZ4iOBtbsHnkut
         pCuvSvKs5lkLxW0+fFQOnkbb31ERmk/KvWEkEpm2A/PweuorsJ2+zzPVRgusyGS6d9
         373t+yutCMNoV0seFRbUJgnNKisLuzkYur5vtMVsK5SnWjX7rZ7GvR3mhp6g8fvpX2
         UQlKMedfLSEkwO1q4BtmZF1u8UiQUx7HNIOYk2cU7alKiUIk3Ti9pkICdEAMIQL6Ur
         yqCnn8DOt3Bbg==
Subject: Re: [Linux-kernel-mentees] [PATCH] v4l2-tpg: Fix global-out-of-bounds
 read in precalculate_color()
To:     Peilin Ye <yepeilin.cs@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
References: <20200810050532.640075-1-yepeilin.cs@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <774bcf2d-c8eb-086a-3569-c7e530d8a63d@xs4all.nl>
Date:   Wed, 19 Aug 2020 16:26:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810050532.640075-1-yepeilin.cs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLzFeNLHyasxr8oleW+BAR5uLvlXTgWwhA2CzkB9O/O8uyO62GobzotEAlxa27V4vG2py1+kQEjsTWoR5uT+gWH6JZJMW6axa26jZRgY6tE+10xrfCwC
 YRyf6JVVsbfyt6MKNxFWEoQYjxaaEJf2MjWFJl/mTMAkICS3b/2zd4xbT3v2mipyXazJBfsFUYvTYj9YtMSxIpIbDMsf1GIJyQe4CvbO4vkt2JvvbmEMiLfg
 hnJpE9t7Q2ZR0p8/zC/XMOpVekD04dAhyY8FjukO0MlWue5mLfa4QlViUHhQAu/iop8X9qZBvGyWkHbk3z57S4nM3h4xrHkl6c52YrI18gNZFlistti+lqDT
 9vIpa1tc6CPUbs7L3LjUJOixwK+iecS/zGh967dyiIQiD2ehewHgQ/Cd7agMVmefNTvnEMbyB4u2iHQzINbL+EvCR3kc5XwDfhm2dneybFVv/WdI6mMWFYm9
 3C76Q4n6AfmPdzTK6lHaF0MXGl+EduWZVTpxu5fiyZkpsWDlIzPbJTCoqVZYnJ9E0qEh+CzsR45jPEr/bdbH3MBJMTuRyj5yln0kzQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peilin,

On 10/08/2020 07:05, Peilin Ye wrote:
> precalculate_color() is reading out of `sin` since `tpg->hue` is not being
> properly checked. Fix it. `cos` is safe, as long as `tpg->hue` is higher
> than or equal to -192.

Thank you for this patch, but there is something I don't understand, namely
just *how* tpg->hue can be out-of-range.

From what I can see vivid sets hue via tpg_s_hue() when the V4L2_CID_HUE control
is set. But that control has a range of -128...128, so ctrl->val should always be in
that range.

I would really like to know 1) what the value of tpg->hue actually is when it goes
out of range, and 2) who is changing it to that value. Can you do a bit more digging?

That said, it makes sense that precalculate_color() avoids reading out-of-bounds.

> 
> Fixes: 63881df94d3e ("[media] vivid: add the Test Pattern Generator")
> Reported-and-tested-by: syzbot+02d9172bf4c43104cd70@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=db50123c788e2cc5a9d90de569c398b66293ee48
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> ---
>  drivers/media/common/v4l2-tpg/v4l2-tpg-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
> index 50f1e0b28b25..52205fe096f7 100644
> --- a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
> +++ b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
> @@ -930,6 +930,9 @@ static void precalculate_color(struct tpg_data *tpg, int k)
>  		/* Implement these operations */
>  		int tmp_cb, tmp_cr;
>  
> +		if (tpg->hue < -128 || tpg->hue > 128)
> +			return;

Rather than returning here, I prefer to just clamp tpg->hue to the valid range.

I'd be willing to merge a patch that clamps tpg->hue (it certainly doesn't hurt),
but I also would like to understand how it can be out of range in the first place.
I have the feeling that this is a symptom of another problem elsewhere.

Regards,

	Hans

> +
>  		/* First convert to YCbCr */
>  
>  		color_to_ycbcr(tpg, r, g, b, &y, &cb, &cr);
> 


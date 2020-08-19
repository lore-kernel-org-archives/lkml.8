Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396EDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F332E2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ZkihLY9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgHSOiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:38:06 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:44285 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbgHSOiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:38:03 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 8PE0kdShfuuXO8PE1khbsC; Wed, 19 Aug 2020 16:38:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1597847881; bh=ZCCtfWWwbC+xmzzR83OhJZTEWK6QQn8jjpzmrcAeEqo=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=ZkihLY9qrlW1OU5Q12mGO5KUwgY42fO1fBmQb2UWDMidlXxka6ypkfIUgocS8agPZ
         8+oTmpUFAGNfr+Fw8mNQfqf3KfGmrFx/7j/XcHK+o6Ru+QU0aQcjWcykssfcBQbHM0
         u0atx3ZcnTqS6eUsMqkTYQVvwBWpIj9sdMdM5iqCWy5NQ7DAi5Dfb9L9miYTVY1oxj
         hfZgp+0pzi2BQd7rvHXp1KCmi1LCj45OzH0m2Jihq1QL421JswXKMgSQEW+n/KnmbO
         aXo5jzQUk3r2t2ffU9ekFfa1epc7T10Yp/2+XzMWmGu8X8mScVgbxgijZdBNisAwwu
         G/ur+uz6Q+Ocg==
Subject: Re: [PATCH] media: pvrusb2: fix parsing error
To:     Tong Zhang <ztong0001@gmail.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org, isely@pobox.com
References: <20200816064901.977682-1-ztong0001@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <75b8354b-362a-0215-8038-45bd68be7de5@xs4all.nl>
Date:   Wed, 19 Aug 2020 16:38:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200816064901.977682-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHBMkT9YYsm1Z+wBgCVQqK/RITDoBMSaHCcElI+SP3gEA+4WuWQvrO+BAfDvPtuTQ2KwE3ANSM3Jy/EmuP+CiEljDI5C0ZTqmr2YgzbNqz6jLJJKJ7BF
 E8eXmk8xbB+2jTwlUl84VX2uZlgw0Nt0c0V5f59qqYWtYNKz+ZSWBnJnRsspakBYW3Y0W8blUDthIu2/io2LMuSo+HPTNEgCj4E0COzXgnbRb44J8rUIfdFm
 v5R+csIEJ6Me3zkwDMlLCEJryNgqooEXtPysFsRaAYykauNryG0NLplEvVF9q236bGMwa4PEBJMqgCasn5nIobIYAdttDXRm53mb+7pgL1b3k9FyQ1S0W2v1
 HxHIgyic01HxTSBk0yXiscsEgYNyTTgRBreqsMj0+KmMT6Eqvxs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tong,

On 16/08/2020 08:49, Tong Zhang wrote:
> pvr2_std_str_to_id() returns 0 on failure and 1 on success,
> however the caller is checking failure case using <0
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/media/usb/pvrusb2/pvrusb2-hdw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
> index 1cfb7cf64131..db5aa66c1936 100644
> --- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
> +++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
> @@ -867,7 +867,8 @@ static int ctrl_std_sym_to_val(struct pvr2_ctrl *cptr,
>  	int ret;
>  	v4l2_std_id id;
>  	ret = pvr2_std_str_to_id(&id,bufPtr,bufSize);
> -	if (ret < 0) return ret;
> +	if (ret == 0)
> +		return ret;

But now you return 0 instead of an error when pvr2_std_str_to_id failed.

Just do this:

	if (!pvr2_std_str_to_id(&id,bufPtr,bufSize))
		return -EINVAL;

And you can drop the ret variable as well since that's no longer needed.

Regards,

	Hans

>  	if (mskp) *mskp = id;
>  	if (valp) *valp = id;
>  	return 0;
> 


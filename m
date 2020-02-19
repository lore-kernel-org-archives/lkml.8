Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C8FC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182BE24654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UFmYVY80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgBSQhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:37:18 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45178 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgBSQhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:37:18 -0500
Received: by mail-yw1-f67.google.com with SMTP id a125so358782ywe.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 08:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xtlz+dlJikUb4ZnNucrBnixJNmT9nKl8DYS8PWnrPks=;
        b=UFmYVY80kD8Zpa0fkSTywbUnughoihSs+csgeDuTp+c/g/itb9Gfh2GXQv2waX1obE
         o8fIcHknv6cYoBq6n9E4Op23peq0J2ac2B0Imhbsw9i3LJdcWwvR96hOFpUgKnvwxecE
         A0WaXCr8X3lRnsiND4fpQMFQKauoE328soDOxzUj2XrZNdEE4/Cnsbw1TQyiNFJI/0K8
         tiHcJj5I17xBtRqVehSpsTF2O1MIoCVxu+whM5mGowf/wCmH3aCYqmpuV7B/ap6QeqoH
         cP7PI7a4cqJQ5/Ls9HL7wPfVopzr4qtBJDae0A9gyMal+67BDkKh3mqcJZb2FQ9ryoTN
         ECnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xtlz+dlJikUb4ZnNucrBnixJNmT9nKl8DYS8PWnrPks=;
        b=qkV8rg3sFO9Jtiwll+hnNpkPXyr0Pv2qVMRMZv/8poyw0YXTNE3siV2XdqwrI3uw07
         5eWRennXhWaO0VBnNL0u0fLSKROj2jJkW9k/nb1PRe/Eexuaft21Gxmhjh2L76Cel5Vm
         pgw+NZ+vUsP8sXYpoESmCXHV3PEncMX9jb+Rb0KXGXe7FqHoSJJN138aNOLOqokepqCA
         jzav52M6XFh3RuiTSPedE/Gqr22Pv+AggvcMyaaaZ+ElgK8DbWbNWZtJhI0B36ZzHli8
         YKQ2W+h0b4xCH0u1fl7cV02eal/HnV/91ii9n6bAD1ml6eYafRkSOd5AG0UyaEw4JkL1
         UtqA==
X-Gm-Message-State: APjAAAXr/V+oEhgDwgHKWEwScai/t98unwZcQptidc1wprJ0IK0IF+NV
        WT3oy7sWpADgtc06O7qzhi/fSfFM/7bcLUtZn9A5RPQ=
X-Google-Smtp-Source: APXvYqw+sWWLtoya0aqsby68wILs0otsorSLejO/NcRgvSQt3H6dM5w4m5mdB8kR65XJF2pW3FvouYM/9lWgkilCLFQ=
X-Received: by 2002:a0d:e155:: with SMTP id k82mr20972841ywe.168.1582130237017;
 Wed, 19 Feb 2020 08:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20200213213007.17023-1-jkardatzke@google.com> <b471217a-1877-eaed-55c2-084f4b126bb4@linaro.org>
 <CA+ddPcPjtv_9s4+t_1jkoGSZihVu2cVLyW102WuoLMy-RGkKPw@mail.gmail.com> <b0c8653a-314e-bab9-9dc8-8c33b8d1efc9@linaro.org>
In-Reply-To: <b0c8653a-314e-bab9-9dc8-8c33b8d1efc9@linaro.org>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Wed, 19 Feb 2020 08:37:05 -0800
Message-ID: <CA+ddPcMWK58QvnAeonWTO0Zg5DvFyEoCfX0=VJuxev8EbU++PQ@mail.gmail.com>
Subject: Re: [PATCH] media: venus: support frame rate control
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, Andy Gross <agross@kernel.org>,
        "Mauro Carvalho Chehab )" <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it, thanks. I'll submit a new patch with that.

On Tue, Feb 18, 2020 at 11:56 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Jeff,
>
> On 2/18/20 9:09 PM, Jeffrey Kardatzke wrote:
> > Sorry for the duplicate, accidentally used HTML format and it got
> > bounced from the mailing lists so resending.
> >
> > On Mon, Feb 17, 2020 at 2:15 AM Stanimir Varbanov
> > <stanimir.varbanov@linaro.org> wrote:
> >>
> >> Hi Jeff,
> >>
> >> Thanks for the patch!
> >>
> >> On 2/13/20 11:30 PM, Jeffrey Kardatzke wrote:
> >>> Frame rate control is always enabled in this driver, so make it silently
> >>> support the V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE.
> >>>
> >>> Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> >>> ---
> >>>  drivers/media/platform/qcom/venus/venc_ctrls.c | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> >>> index 877c0b3299e9..9ede692f77c5 100644
> >>> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> >>> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> >>> @@ -199,6 +199,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
> >>>               }
> >>>               mutex_unlock(&inst->lock);
> >>>               break;
> >>> +     case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:
> >>> +             // Silently ignore, it's always enabled.
> >>
> >> Please, use C comments and follow the kernel coding style.
> >
> > OK, hopefully I've got that now. I didn't see any issues aside from
> > the comment style though.
> > I'll upload a new patch shortly.
> >>
> >>
> >> I wonder shouldn't it be better to add rc_enable field in struct
> >> venc_controls and give the user choice to disable the rate control? We
> >> can keep the default to be "enabled".
> >>
> > That'd be fine. Is there a way to actually disable the rate control though?
>
> The rate control property values are here [1], and [2] is where we set
> the control.
>
> --
> regards,
> Stan
>
> [1]
> https://elixir.bootlin.com/linux/v5.6-rc2/source/drivers/media/platform/qcom/venus/hfi_helper.h#L229
> [2]
> https://elixir.bootlin.com/linux/v5.6-rc2/source/drivers/media/platform/qcom/venus/venc.c#L734



-- 
Jeffrey Kardatzke
jkardatzke@google.com
Google, Inc.

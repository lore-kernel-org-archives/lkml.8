Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61402C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3823024125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qovnlbRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgBRTKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:10:00 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44891 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:09:59 -0500
Received: by mail-yb1-f196.google.com with SMTP id b4so217458ybk.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qeorF66mv+JIUZaS3AMTj0IO3heKZoxThrG2n1kjzlk=;
        b=qovnlbRzx1igvMhQ565tAtQyznXMVvWct8U3SM+uDqfBD+an3ZUGaGISXXwSKPLzct
         +zNBofzSkFBSOxRiwEdzL2UaCSfHcM5C9S28iYYxgdrmFS5/B/c+6l7RaN1pUv4hmuAf
         HwTTGHPL6ycfmMXT49g9KAyAC8eK3Sgpo1sc+U4NeycTx7FbdvgmawefXXz2PjRfSUFG
         9X6KECg1/SMI/2ueQDdsMdC9d6Pw3N1in+woa6r46IPw10tV4502oQ2vgdoZ7wnJm9yq
         TF6o/PGgGCpiWbeBbLXN+sjR2hbtKM5BMPLdd4glb3igGjA+YMuUwbYgbXJcdtipl+Jk
         7RSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qeorF66mv+JIUZaS3AMTj0IO3heKZoxThrG2n1kjzlk=;
        b=IxQm9YxYNFbdaYXZekUZ0foHmu6bnakPexKIb7IvwnNK/03P054ul/e0jIXhIb/UNN
         mnxYisiVhLGHrgTSfjhDqmZMLStdKrZJsKWMqBeodfDVfKLDkHUoGamuafWy5BTTGbxN
         SKfN2WBG2CEAv1mXvFrarc+zdaGNen7MlpWCGdiKUe475a21SVNLdgdCGItRdo29S4Ct
         XvMgcF7rm2Vuh5DhNgeFUeiZ1rsedDYoPrUqAq6Z2fLyFrBOOLXDn88veukQDLRXhF0v
         jpJ1KR8Kv1cdDqri8OGovUCbtHpKfEmGE/zkPu3BCg0m2JhkUMo3AC3e/lQjVG5unW9A
         g3aw==
X-Gm-Message-State: APjAAAUDvKdFviFCdUKLTcTbOKzsATrJ86vMhvkSYGmLeapXGoWOHi/n
        EDrb54ugepSBqVC+Q+dSK4YI8e97gxC2yZeheFJ9
X-Google-Smtp-Source: APXvYqxuLKYpUsudTRTHEte6C+QLhn15lQclX2NB6yo8irU6bb8VPo0z7TLRbjilvL/j3ceFV3crupN0fqGL5aYCifc=
X-Received: by 2002:a25:5ed6:: with SMTP id s205mr3646063ybb.190.1582052998643;
 Tue, 18 Feb 2020 11:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20200213213007.17023-1-jkardatzke@google.com> <b471217a-1877-eaed-55c2-084f4b126bb4@linaro.org>
In-Reply-To: <b471217a-1877-eaed-55c2-084f4b126bb4@linaro.org>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Tue, 18 Feb 2020 11:09:47 -0800
Message-ID: <CA+ddPcPjtv_9s4+t_1jkoGSZihVu2cVLyW102WuoLMy-RGkKPw@mail.gmail.com>
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

Sorry for the duplicate, accidentally used HTML format and it got
bounced from the mailing lists so resending.

On Mon, Feb 17, 2020 at 2:15 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Jeff,
>
> Thanks for the patch!
>
> On 2/13/20 11:30 PM, Jeffrey Kardatzke wrote:
> > Frame rate control is always enabled in this driver, so make it silently
> > support the V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE.
> >
> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> > ---
> >  drivers/media/platform/qcom/venus/venc_ctrls.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> > index 877c0b3299e9..9ede692f77c5 100644
> > --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> > +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> > @@ -199,6 +199,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
> >               }
> >               mutex_unlock(&inst->lock);
> >               break;
> > +     case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:
> > +             // Silently ignore, it's always enabled.
>
> Please, use C comments and follow the kernel coding style.

OK, hopefully I've got that now. I didn't see any issues aside from
the comment style though.
I'll upload a new patch shortly.
>
>
> I wonder shouldn't it be better to add rc_enable field in struct
> venc_controls and give the user choice to disable the rate control? We
> can keep the default to be "enabled".
>
That'd be fine. Is there a way to actually disable the rate control though?
>
> > +             break;
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -351,6 +354,9 @@ int venc_ctrl_init(struct venus_inst *inst)
> >       v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
> >                         V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME, 0, 0, 0, 0);
> >
> > +     v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
> > +                       V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE, 0, 1, 1, 1);
> > +
>
> you forgot to increment the number of controls in the call to
> v4l2_ctrl_handler_init.
>
Done, thanks.
>
> >       ret = inst->ctrl_handler.error;
> >       if (ret)
> >               goto err;
> >
>
> --
> regards,
> Stan

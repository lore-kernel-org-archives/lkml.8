Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D335EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A025E207CD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VR39J7E9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHXN5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXN5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:57:37 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DB7C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 06:57:36 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id x2so5203615ybf.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 06:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Oo7EoEwOiZey2I4RU2qQv+WisYvPVkgt+M+WNJhnTL8=;
        b=VR39J7E9tFxK+yB+ezFY8PMyDn5TLnBx+Lonea3XzBXf1UQSI8p4U9ZR2KrimEgyuc
         5UYegxnSxkvgUqQXCxozkV97e/FrgEZ+Y52E2Enw5Qf+aLqp1Vnd/9e9iMM3KBAm8tL/
         3ASVmLfiuE6c/w/dic7iBCPA7XwfQBDOADADP19Y8N4A6camHjP5QxjD6he2hRN7X6Jn
         Q0FnfGgOuL6SqTCexzKC4v+qhTw8oYaLoMMFDe7uqIz7Ut0+SKw2cgO4M+L1v1AoUHcd
         30WnuJHXS3BsvwJieXSdaFsy95ruhUTSLGdLtMHVeUnpIBhcW86NcN4/IykuI+1YaGEB
         2xDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Oo7EoEwOiZey2I4RU2qQv+WisYvPVkgt+M+WNJhnTL8=;
        b=j0DbBFJMJK/IgPTQkQx2jVypIzGpDPoiJTugXJXWvdyuQcr7ofmQ9ZLXJ3cGyyC39I
         caX98yfsVln/f+ItxdKhTrxMqHavyq20rVa8AazFKOj+/2aAib0Y6gpX6IlaI2DxqqvS
         3ZpGWyz+1RD+BPOPo/rsDiciXGnJyn2oFzTgsI449wLSTUSHz042zWa/XNa3Vhae6U2c
         NvQFVzav02YUCGA4jLBKrNfBpDpivTfSZ9km2W9p+UKSNltlUg67QILAyaDKSikW2Fbi
         0J8NpHpomVEOD3xcXOFpmr6QYfU6QC7z7fs/xYoUfuPA7GpPI99JWAmbKxT/KJQFY/AR
         k5IA==
X-Gm-Message-State: AOAM532U7dejXOJ3l0XqYtuy+qFoAKpuNVH6htzSpowc/VFq4R+/AO78
        3eM3MkIJm+h8GwIKdNTXUCzu4yt9F4BDL9oNaQwt7A==
X-Google-Smtp-Source: ABdhPJw8s6GiaXKF5L8TlRTLSe0reZhdlDG+9HnMh9dOcWz4zRHL695zACntxCw6DNBUp6B0OXpaqnWOAiDerCfYw1I=
X-Received: by 2002:a25:854c:: with SMTP id f12mr7927467ybn.130.1598277455386;
 Mon, 24 Aug 2020 06:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200823012134.3813457-1-agoode@google.com> <20200823012134.3813457-2-agoode@google.com>
 <20200823145417.GC6002@pendragon.ideasonboard.com> <20200823150822.GD6002@pendragon.ideasonboard.com>
 <5a2882e5-c029-dde7-c6ff-bd6f57aa7850@xs4all.nl>
In-Reply-To: <5a2882e5-c029-dde7-c6ff-bd6f57aa7850@xs4all.nl>
From:   Adam Goode <agoode@google.com>
Date:   Mon, 24 Aug 2020 09:56:59 -0400
Message-ID: <CAOf41NnrfW6h++nR42R1OxR0B3DVrKg9RVLTQVJ=nEkn3GW4aw@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: uvcvideo: Convey full ycbcr colorspace
 information to v4l2
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 4:48 AM Hans Verkuil <hverkuil-cisco@xs4all.nl> wro=
te:
>
> On 23/08/2020 17:08, Laurent Pinchart wrote:
> > Hi Adam,
> >
> > (CC'ing Hans Verkuil)
> >
> > On Sun, Aug 23, 2020 at 05:54:24PM +0300, Laurent Pinchart wrote:
> >> Hi Adam,
> >>
> >> Thank you for the patch.
> >>
> >> On Sat, Aug 22, 2020 at 09:21:34PM -0400, Adam Goode wrote:
> >>> The Color Matching Descriptor has been present in USB cameras since
> >>> the original version of UVC, but it has never been fully used
> >>> in Linux.
> >>>
> >>> This change informs V4L2 of all of the critical colorspace parameters=
:
> >>> colorspace (called "color primaries" in UVC), transfer function
> >>> (called "transfer characteristics" in UVC), ycbcr encoding (called
> >>> "matrix coefficients" in UVC), and quantization, which is always
> >>> LIMITED for UVC, see section 2.26 in USB_Video_FAQ_1.5.pdf.
> >>
> >> Isn't this valid for MJPEG only though ? There's not much else we can =
do
> >> though, as UVC cameras don't report quantization information. Shouldn'=
t
> >> we however reflect this in the commit message, and in the comment belo=
w,
> >> to state that UVC requires limited quantization range for MJPEG, and
> >> while it doesn't explicitly specify the quantization range for other
> >> formats, we can only assume it should be limited as well ?
> >>

Yes, I am happy to improve the comment to be clearer.


> >> The code otherwise looks good to me.
> >>
> >> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>
> >> Please let me know if you'd like to address the above issue.
> >>
> >>> The quantization is the most important improvement for this patch,
> >>> because V4L2 will otherwise interpret MJPEG as FULL range. Web browse=
rs
> >>> such as Chrome and Firefox already ignore V4L2's quantization for USB
> >>> devices and use the correct LIMITED value, but other programs such
> >>> as qv4l2 will incorrectly interpret the output of MJPEG from USB
> >>> cameras without this change.
> >>>
> >>> Signed-off-by: Adam Goode <agoode@google.com>
> >>> ---
> >>>  drivers/media/usb/uvc/uvc_driver.c | 52 +++++++++++++++++++++++++++-=
--
> >>>  drivers/media/usb/uvc/uvc_v4l2.c   |  6 ++++
> >>>  drivers/media/usb/uvc/uvcvideo.h   |  5 ++-
> >>>  3 files changed, 58 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/u=
vc/uvc_driver.c
> >>> index 431d86e1c94b..c0c81b089b7d 100644
> >>> --- a/drivers/media/usb/uvc/uvc_driver.c
> >>> +++ b/drivers/media/usb/uvc/uvc_driver.c
> >>> @@ -248,10 +248,10 @@ static struct uvc_format_desc *uvc_format_by_gu=
id(const u8 guid[16])
> >>>     return NULL;
> >>>  }
> >>>
> >>> -static u32 uvc_colorspace(const u8 primaries)
> >>> +static enum v4l2_colorspace uvc_colorspace(const u8 primaries)
> >>>  {
> >>> -   static const u8 colorprimaries[] =3D {
> >>> -           0,
> >>> +   static const enum v4l2_colorspace colorprimaries[] =3D {
> >>> +           V4L2_COLORSPACE_DEFAULT,  /* Unspecified */
> >>>             V4L2_COLORSPACE_SRGB,
> >>>             V4L2_COLORSPACE_470_SYSTEM_M,
> >>>             V4L2_COLORSPACE_470_SYSTEM_BG,
> >>> @@ -262,7 +262,43 @@ static u32 uvc_colorspace(const u8 primaries)
> >>>     if (primaries < ARRAY_SIZE(colorprimaries))
> >>>             return colorprimaries[primaries];
> >>>
> >>> -   return 0;
> >>> +   return V4L2_COLORSPACE_DEFAULT;  /* Reserved */
> >>> +}
> >>> +
> >>> +static enum v4l2_xfer_func uvc_xfer_func(const u8 transfer_character=
istics)
> >>> +{
> >>> +   static const enum v4l2_xfer_func xfer_funcs[] =3D {
> >>> +           V4L2_XFER_FUNC_DEFAULT,  /* Unspecified */
> >>> +           V4L2_XFER_FUNC_709,
> >>> +           V4L2_XFER_FUNC_709,      /* BT.470-2 M */
> >>> +           V4L2_XFER_FUNC_709,      /* BT.470-2 B, G */
> >>> +           V4L2_XFER_FUNC_709,      /* SMPTE 170M */
> >>> +           V4L2_XFER_FUNC_SMPTE240M,
> >>> +           V4L2_XFER_FUNC_NONE,     /* Linear (V =3D Lc) */
> >>> +           V4L2_XFER_FUNC_SRGB,
> >>> +   };
> >>> +
> >>> +   if (transfer_characteristics < ARRAY_SIZE(xfer_funcs))
> >>> +           return xfer_funcs[transfer_characteristics];
> >>> +
> >>> +   return V4L2_XFER_FUNC_DEFAULT;  /* Reserved */
> >>> +}
> >>> +
> >>> +static enum v4l2_ycbcr_encoding uvc_ycbcr_enc(const u8 matrix_coeffi=
cients)
> >>> +{
> >>> +   static const enum v4l2_ycbcr_encoding ycbcr_encs[] =3D {
> >>> +           V4L2_YCBCR_ENC_DEFAULT,  /* Unspecified */
> >>> +           V4L2_YCBCR_ENC_709,
> >>> +           V4L2_YCBCR_ENC_601,      /* FCC */
> >
> > I may have spoken a bit too fast. Doesn't FCC differ from BT.601 ?
> > According to https://en.wikipedia.org/wiki/Talk%3AYCbCr, the former use=
s
> >
> >  E'Y =3D 0.59 E'G + 0.11 E'B + 0.30 E'R
> >  E'PB =3D =E2=80=93 0.331 E'G + 0.500 E'B =E2=80=93 0.169 E'R
> >  E'PR =3D =E2=80=93 0.421 E'G =E2=80=93 0.079 E'B + 0.500 E'R
> >
> > while the latter uses
> >
> >  E'Y =3D 0.587 E'G + 0.114 E'B + 0.299 E'R
> >  E'PB =3D =E2=80=93 0.331 E'G + 0.500 E'B =E2=80=93 0.169 E'R
> >  E'PR =3D =E2=80=93 0.419 E'G =E2=80=93 0.081 E'B + 0.500 E'R
> >
> > We seems to be missing FCC in the V4L2 color space definitions.
>
> The differences between the two are minuscule. Add to that that NTSC 1953
> hasn't been in use for many decades. So I have no plans to add another YC=
C
> encoding for this. I'll double check this in a few weeks time when I have
> access to a better book on colorimetry.
>

I can add a comment directly to clarify, but I am following the
mappings described in videodev2.h (with the assumption that "FCC" is
close enough to 601):

/*
* Mapping of V4L2_XFER_FUNC_DEFAULT to actual transfer functions
* for the various colorspaces:
*
* V4L2_COLORSPACE_SMPTE170M, V4L2_COLORSPACE_470_SYSTEM_M,
* V4L2_COLORSPACE_470_SYSTEM_BG, V4L2_COLORSPACE_REC709 and
* V4L2_COLORSPACE_BT2020: V4L2_XFER_FUNC_709
*
* V4L2_COLORSPACE_SRGB, V4L2_COLORSPACE_JPEG: V4L2_XFER_FUNC_SRGB
*
* V4L2_COLORSPACE_OPRGB: V4L2_XFER_FUNC_OPRGB
*
* V4L2_COLORSPACE_SMPTE240M: V4L2_XFER_FUNC_SMPTE240M
*
* V4L2_COLORSPACE_RAW: V4L2_XFER_FUNC_NONE
*
* V4L2_COLORSPACE_DCI_P3: V4L2_XFER_FUNC_DCI_P3
*/

/*
* Mapping of V4L2_YCBCR_ENC_DEFAULT to actual encodings for the
* various colorspaces:
*
* V4L2_COLORSPACE_SMPTE170M, V4L2_COLORSPACE_470_SYSTEM_M,
* V4L2_COLORSPACE_470_SYSTEM_BG, V4L2_COLORSPACE_SRGB,
* V4L2_COLORSPACE_OPRGB and V4L2_COLORSPACE_JPEG: V4L2_YCBCR_ENC_601
*
* V4L2_COLORSPACE_REC709 and V4L2_COLORSPACE_DCI_P3: V4L2_YCBCR_ENC_709
*
* V4L2_COLORSPACE_BT2020: V4L2_YCBCR_ENC_BT2020
*
* V4L2_COLORSPACE_SMPTE240M: V4L2_YCBCR_ENC_SMPTE240M
*/

We could potentially do with some more xfer functions, though.

> >
> >>> +           V4L2_YCBCR_ENC_601,      /* BT.470-2 B, G */
> >>> +           V4L2_YCBCR_ENC_601,      /* SMPTE 170M */
> >>> +           V4L2_YCBCR_ENC_SMPTE240M,
> >>> +   };
> >>> +
> >>> +   if (matrix_coefficients < ARRAY_SIZE(ycbcr_encs))
> >>> +           return ycbcr_encs[matrix_coefficients];
> >>> +
> >>> +   return V4L2_YCBCR_ENC_DEFAULT;  /* Reserved */
> >>>  }
> >>>
> >>>  /* Simplify a fraction using a simple continued fraction decompositi=
on. The
> >>> @@ -704,6 +740,14 @@ static int uvc_parse_format(struct uvc_device *d=
ev,
> >>>             }
> >>>
> >>>             format->colorspace =3D uvc_colorspace(buffer[3]);
> >>> +           format->xfer_func =3D uvc_xfer_func(buffer[4]);
> >>> +           format->ycbcr_enc =3D uvc_ycbcr_enc(buffer[5]);
> >>> +           /* All USB YCbCr encodings use LIMITED range as of UVC 1.=
5.
> >>> +            * This is true even for MJPEG, which V4L2 otherwise assu=
mes to
> >>> +            * be FULL.
> >>> +            * See section 2.26 in USB_Video_FAQ_1.5.pdf.
>
> Not true. I checked the FAQ: the FAQ describes what happens when a video =
renderer
> incorrectly interprets the decoded JPEG color components as limited range=
 instead
> of full range (which they are to be JPEG compliant). JPEG always encodes =
YCbCr as
> full range.
>

Here is what the FAQ says:

"If the images are encoded with the luma and chroma units in the 0-255
range that is used
for typical JPEG still images, then the saturation and contrast will
look artificially boosted
when the video is rendered under the assumption that the levels were
in the YCbCr color
space. BT601 specifies eight-bit coding where Y is in the range of 16
(black) to 235 (white)
inclusive."

I read this as saying "if you encode MJPEG the same as typical JPEG
still images, it is wrong because Y must be in the range 16-235". Am I
reading this incorrectly?

> >>> +            */
> >>> +           format->quantization =3D V4L2_QUANTIZATION_LIM_RANGE;
>
> What about sRGB? That uses full range.
>

It is a little confusing in the code, but I only set the quantization
explicitly when we get a Color Matching descriptor from the device. My
reading of the spec says that this descriptor isn't present for RGB
formats, only YCrCb. When the spec mentions sRGB in Color Matching, it
is referring only to primaries or gamma.

> Regards,
>
>         Hans
>
> >>>
> >>>             buflen -=3D buffer[0];
> >>>             buffer +=3D buffer[0];
> >>> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc=
/uvc_v4l2.c
> >>> index 7f14096cb44d..79daf46b3dcd 100644
> >>> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> >>> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> >>> @@ -279,6 +279,9 @@ static int uvc_v4l2_try_format(struct uvc_streami=
ng *stream,
> >>>     fmt->fmt.pix.sizeimage =3D probe->dwMaxVideoFrameSize;
> >>>     fmt->fmt.pix.pixelformat =3D format->fcc;
> >>>     fmt->fmt.pix.colorspace =3D format->colorspace;
> >>> +   fmt->fmt.pix.xfer_func =3D format->xfer_func;
> >>> +   fmt->fmt.pix.ycbcr_enc =3D format->ycbcr_enc;
> >>> +   fmt->fmt.pix.quantization =3D format->quantization;
> >>>
> >>>     if (uvc_format !=3D NULL)
> >>>             *uvc_format =3D format;
> >>> @@ -315,6 +318,9 @@ static int uvc_v4l2_get_format(struct uvc_streami=
ng *stream,
> >>>     fmt->fmt.pix.bytesperline =3D uvc_v4l2_get_bytesperline(format, f=
rame);
> >>>     fmt->fmt.pix.sizeimage =3D stream->ctrl.dwMaxVideoFrameSize;
> >>>     fmt->fmt.pix.colorspace =3D format->colorspace;
> >>> +   fmt->fmt.pix.xfer_func =3D format->xfer_func;
> >>> +   fmt->fmt.pix.ycbcr_enc =3D format->ycbcr_enc;
> >>> +   fmt->fmt.pix.quantization =3D format->quantization;
> >>>
> >>>  done:
> >>>     mutex_unlock(&stream->mutex);
> >>> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc=
/uvcvideo.h
> >>> index 6ab972c643e3..6508192173dd 100644
> >>> --- a/drivers/media/usb/uvc/uvcvideo.h
> >>> +++ b/drivers/media/usb/uvc/uvcvideo.h
> >>> @@ -370,7 +370,10 @@ struct uvc_format {
> >>>     u8 type;
> >>>     u8 index;
> >>>     u8 bpp;
> >>> -   u8 colorspace;
> >>> +   enum v4l2_colorspace colorspace;
> >>> +   enum v4l2_xfer_func xfer_func;
> >>> +   enum v4l2_ycbcr_encoding ycbcr_enc;
> >>> +   enum v4l2_quantization quantization;
> >>>     u32 fcc;
> >>>     u32 flags;
> >>>
> >
>

Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12B9C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA732080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSJCb7AL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgAJJ6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:58:33 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:40651 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgAJJ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:58:33 -0500
Received: by mail-io1-f45.google.com with SMTP id x1so1432206iop.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 01:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MC2yDT7bVRQ00/2dFwgrArtXlomnbSSK16fUetQC/GM=;
        b=YSJCb7AL7jtl8aGhFxXDHMmsuN2xj79bxmN+qAjWh0hQij/b23OVFg8jPsiCz30f4B
         FOvUAjJ7XUzKjxwhyy/e4DD5mRWSQ0/34ew133j1ELIaaAwr7NVzk3UrXCZAHYtUNCCG
         ySd0zvi3SmpjuDc8sOeBDqI193oOVJ1UEvrTRrX9s6LhG2OrjiXc18dtw+NPmL7Yg7kM
         JyVUIbZSWH0ug3SfQLtvEJuTKeVAkuhQuddEf2vUl0QoGoHTg+nicJvr2P68fnS7Yd8g
         v46qdKgeVy1Ben9REEj6B/qPWyy0s+236lGoix0ras40VqqfC0eAthnlj+H2MOP5GujY
         J9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MC2yDT7bVRQ00/2dFwgrArtXlomnbSSK16fUetQC/GM=;
        b=XaQJG7UHJEorjPIBRjLVn9F7XpYrtGZqZtCsB1qDkwaDyHkVE/IK1tCgTutAP0wLS/
         5emIm3N/+eFaBOcBlvx0owVh6ONodKMXHcJn0zm7UPiMk6D7s1FoInwk2J0bEk1KquTg
         x2c5edEsYC5Jr2iu1G2o1AwrC/6zLO2tdUu+9LIuS1/sh90Ze/HY14Hd7iJfYHqyyhYm
         MMvi7//Ju9d3sQgyMzj3WclPxNCWQ4+l3TfNQb16IROSrk77LBmFX6XNE5YNSTukRTxd
         DrtuWGCjDhnptc0eOB5bWba81bWPE/oOP0tJkOUk1RtDkD26PBX0AJLGvzuOmrNEw7Ae
         h18Q==
X-Gm-Message-State: APjAAAXYp4JeQpkEl3iXIfHa6ARgjdpqCANCV4sWgLdY/KAYzbfVyEIW
        TxewPT1eKTOZIql/tCfppz59oi+tvCS4oEYXqzQ=
X-Google-Smtp-Source: APXvYqwU6sSRWpJw3LxUtKC1YtspJLgt1olDGc3V1XCQc2LaOZQu60Q0RDoyCWYPepj0PB1w//ydN/pYGZPYPm0KYrs=
X-Received: by 2002:a6b:4e08:: with SMTP id c8mr1660037iob.64.1578650312415;
 Fri, 10 Jan 2020 01:58:32 -0800 (PST)
MIME-Version: 1.0
References: <1578482416650.67283@xiaomi.com> <d48d8d65-1308-278c-db86-0806a0c3637a@huawei.com>
In-Reply-To: <d48d8d65-1308-278c-db86-0806a0c3637a@huawei.com>
From:   xiong ping <xp1982.06.06@gmail.com>
Date:   Fri, 10 Jan 2020 17:58:21 +0800
Message-ID: <CAOqdbhdyaNg3RoGF0+gJ=6wX4YDrgpfuVDsuAg05BSp3dmZKww@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] resize.f2fs: add option for large_nat_bitmap feature
To:     Chao Yu <yuchao0@huawei.com>
Cc:     =?UTF-8?B?UGluZzEgWGlvbmcg54aK5bmz?= <xiongping1@xiaomi.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chao Yu <yuchao0@huawei.com> =E4=BA=8E2020=E5=B9=B41=E6=9C=889=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2020/1/8 19:20, Ping1 Xiong =E7=86=8A=E5=B9=B3 wrote:
> > From d5b8411dbae37180c37d96bf164fab16138fc21a Mon Sep 17 00:00:00 2001
> >
> > From: xiongping1 <xiongping1@xiaomi.com>
> > Date: Wed, 8 Jan 2020 17:20:55 +0800
> > Subject: [PATCH] resize.f2fs: add option for large_nat_bitmap feature
>
> Thanks for your contribution.
>
> The patch format is incorrect, I guess it was changed by email client or =
when
> you paste patch's content, could you check it?
>
I have resend the patch with this email account yesterday, can you check it=
?
> >
> > resize.f2fs has already supported large_nat_bitmap feature, but has no
> > option to turn on it.
> >
> > This change add a new '-i' option to control turning on/off it.
>
> We only add a option to turn on this feature, right? rather than turning
> on or off it?
>
yes, the feature is off by default, so we need an option to enable it.
> Thanks,
>
> >
> > Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
> > ---
> >  fsck/main.c   | 6 +++++-
> >  fsck/resize.c | 5 +++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/fsck/main.c b/fsck/main.c
> > index 9a7d499..e7e3dfc 100644
> > --- a/fsck/main.c
> > +++ b/fsck/main.c
> > @@ -104,6 +104,7 @@ void resize_usage()
> >          MSG(0, "\nUsage: resize.f2fs [options] device\n");
> >          MSG(0, "[options]:\n");
> >          MSG(0, "  -d debug level [default:0]\n");
> > +       MSG(0, "  -i extended node bitmap, node ratio is 20%% by defaul=
t\n");
> >          MSG(0, "  -s safe resize (Does not resize metadata)");
> >          MSG(0, "  -t target sectors [default: device size]\n");
> >          MSG(0, "  -V print the version number and exit\n");
> > @@ -449,7 +450,7 @@ void f2fs_parse_options(int argc, char *argv[])
> >                                  break;
> >                  }
> >          } else if (!strcmp("resize.f2fs", prog)) {
> > -               const char *option_string =3D "d:st:V";
> > +               const char *option_string =3D "d:st:iV";
> >
> >                  c.func =3D RESIZE;
> >                  while ((option =3D getopt(argc, argv, option_string)) =
!=3D EOF) {
> > @@ -476,6 +477,9 @@ void f2fs_parse_options(int argc, char *argv[])
> >                                          ret =3D sscanf(optarg, "%"PRIx=
64"",
> >                                                          &c.target_sect=
ors);
> >                                  break;
> > +                       case 'i':
> > +                               c.large_nat_bitmap =3D 1;
> > +                               break;
> >                          case 'V':
> >                                  show_version(prog);
> >                                  exit(0);
> > diff --git a/fsck/resize.c b/fsck/resize.c
> > index fc563f2..88e063e 100644
> > --- a/fsck/resize.c
> > +++ b/fsck/resize.c
> > @@ -519,6 +519,11 @@ static void rebuild_checkpoint(struct f2fs_sb_info=
 *sbi,
> >          else
> >                  set_cp(checksum_offset, CP_CHKSUM_OFFSET);
> >
> > +       if (c.large_nat_bitmap) {
> > +               set_cp(checksum_offset, CP_MIN_CHKSUM_OFFSET);
> > +               flags |=3D CP_LARGE_NAT_BITMAP_FLAG;
> > +       }
> > +
> >          set_cp(ckpt_flags, flags);
> >
> >          memcpy(new_cp, cp, (unsigned char *)cp->sit_nat_version_bitmap=
 -
> > --
> > 2.7.4
> >
> >
> >
> >
> > #/******=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=
=E5=90=AB=E6=9C=89=E5=B0=8F=E7=B1=B3=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=
=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=
=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=BA=
=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=81=E6=
=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=BB=E4=BD=
=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BD=86=
=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=86=E5=
=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E6=88=96=E6=95=
=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=
=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=
=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=8B=E5=8D=B3=E7=94=
=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=
=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=81 Th=
is e-mail and its attachments contain confidential information from XIAOMI,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you re=
ceive this e-mail in error, please notify the sender by phone or email imme=
diately and delete it!******/#
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

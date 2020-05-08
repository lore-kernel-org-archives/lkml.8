Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C76DC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5A0207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941332;
	bh=pALps1Jxm/+WOhQxg8hNkKb98br61bdG69sV4vDTzzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=G3/A4J/vJEjT0rUT6EYzjnUX3sJqUjGTXns4XHJmyWTg79Bbk5VOGZK9axjhgh9b2
	 69HZh1tsIVpbHFWV0VtSvhSYjM1IU44PteEH39s3l4oR9K16oH7VYeYtGq8wDlJ2mP
	 0WTpEN8hdrgfwYFV3otAwRJEPeD8Ew2L+EVgTiHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgEHMfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgEHMfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:35:30 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE8AC05BD43;
        Fri,  8 May 2020 05:35:30 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id o14so429926ljp.4;
        Fri, 08 May 2020 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=71j6PMRO3vVpRcVHQ+g+fJbWnjsKtLz5FDZRpYbeeK8=;
        b=tUWQeYARS4BEfMt1TTgN71TJ1Ksnk5T7uMRPVcYKyhA9yTWNuzH14mt/1ju4/2WgLS
         b1oGaW517E8BRXHtASVU3CtT4eIw9x7lG5x9+jaSniyfUMtMhv2iocA6ho2nRXTfDqZo
         Y5Nbb4/q6TBxX4ezIB86poffH9bCEhp3VvgrrwGP/gn9LFNx2jVuQoLfvjOSpWtfUJmJ
         oup+kMx5pDf0Y86dglBhOEXzfEDaoCGCj3OttCjet8wLmcRZwLt1YYgbGzhxN0OHIluh
         BkdlcVZpYsUb1Esyuo+pTvjfEMlURRsR1g9GySepXqPoWUE8QL7hhOZNc5lgXvtQkz3g
         j0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=71j6PMRO3vVpRcVHQ+g+fJbWnjsKtLz5FDZRpYbeeK8=;
        b=mS8D8FKGfQmZGfsnmpU2leN3jO/KEMz+dGcEWlMv7CgvBAx/3govULClb6n1/3urbs
         xUJJ/ZMuXuu612K8p30Q1AGSOj9khDFoAMQiZJF+yeuiX4kS4PmNNk4rnu9bm2oPvV8Z
         SHtDjW1kBMZLb/stPtrwB3Afp40/5SOwNAkjQyz0qkHxGKWpfESZ2tZgFe7nJecBqeAO
         aJ3NcSnaH3k1cl0F6Txzq0nLGkU/ScSnBM1ml0TkMYkaExyx1kYunMZjbmlD6PVyjMJd
         98cIflgUwiA4QK/e8SoQAVouWn0oU+r+zU976vIazcv8vyTug67rkkXBYDijVH6N1aO5
         1suQ==
X-Gm-Message-State: AOAM5313GAk8ZE6ZgHLU846zu5G6uvUyqaSoPRBJlo5GWw8oARpQgjO4
        sZ0q8PmVBYTsL66iUK7m1vJsWSVl+tA=
X-Google-Smtp-Source: ABdhPJxsv7NTezQmck9qlgIe5r3q6ecB/xo+T0lF2eq4Eu2MIUjdpMOJFVlge4LwafjYuN2i6rQIiA==
X-Received: by 2002:a2e:9258:: with SMTP id v24mr1557337ljg.109.1588941328356;
        Fri, 08 May 2020 05:35:28 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id s7sm1107753lfb.40.2020.05.08.05.35.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 May 2020 05:35:27 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Jun Li <lijun.kernel@gmail.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by device controller
In-Reply-To: <CAKgpwJVU9m6G8PRdray2fGCp_peOU9C-ZAVKTk7pmSdq6z4NiA@mail.gmail.com>
References: <20191028215919.83697-1-john.stultz@linaro.org> <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com> <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com> <CAKgpwJVaKpsgMjKcnYyJsfNj0ibkPt=mdn-NxfOkeX1jfL=9iQ@mail.gmail.com> <CALAqxLVXauXP0r4Hv2Axa4PNf_F9wp644peYV06bdsPtMKGmLA@mail.gmail.com> <CAKgpwJU7VDx90STE7bhx9VZ5p1jtqCyyLavmhXfpaicyDAYt_g@mail.gmail.com> <CAKgpwJVU9m6G8PRdray2fGCp_peOU9C-ZAVKTk7pmSdq6z4NiA@mail.gmail.com>
Date:   Fri, 08 May 2020 15:35:23 +0300
Message-ID: <87eerumwok.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

Jun Li <lijun.kernel@gmail.com> writes:
> Jun Li <lijun.kernel@gmail.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=887=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8811:08=E5=86=99=E9=81=93=EF=BC=9A
>>
>> John Stultz <john.stultz@linaro.org> =E4=BA=8E2020=E5=B9=B45=E6=9C=887=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=886:27=E5=86=99=E9=81=93=EF=BC=
=9A
>> >
>> > On Wed, May 6, 2020 at 2:00 AM Jun Li <lijun.kernel@gmail.com> wrote:
>> > > John Stultz <john.stultz@linaro.org> =E4=BA=8E2019=E5=B9=B410=E6=9C=
=8830=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=885:18=E5=86=99=E9=81=93=
=EF=BC=9A
>> > > > On Tue, Oct 29, 2019 at 2:11 AM Felipe Balbi <balbi@kernel.org> wr=
ote:
>> > > > > John Stultz <john.stultz@linaro.org> writes:
>> > > > > > From: Yu Chen <chenyu56@huawei.com>
>> > > > > >
>> > > > > > It needs more time for the device controller to clear the CmdA=
ct of
>> > > > > > DEPCMD on Hisilicon Kirin Soc.
>> > > > >
>> > > > > Why does it need more time? Why is it so that no other platform =
needs
>> > > > > more time, only this one? And which command, specifically, causes
>> > > > > problem?
>> > >
>> > > Sorry for my back to this so late.
>> > >
>> > > This change is required on my dwc3 based HW too, I gave a check
>> > > and the reason is suspend_clk is used in case the PIPE phy is at P3,
>> > > this slow clock makes my EP command below timeout.
>> > >
>> > > dwc3_gadget_ep_cmd: ep0out: cmd 'Set Endpoint Configuration' [401]
>> > > params 00001000 00000500 00000000 --> status: Timed Out
>> > >
>> > > Success case takes about 400us to complete, see below trace(44.286278
>> > > - 44.285897 =3D 0.000381):
>> > >
>> > > configfs_acm.sh-822   [000] d..1    44.285896: dwc3_writel: addr
>> > > 000000006d59aae1 value 00000401
>> > > configfs_acm.sh-822   [000] d..1    44.285897: dwc3_readl: addr
>> > > 000000006d59aae1 value 00000401
>> > > ... ...
>> > > configfs_acm.sh-822   [000] d..1    44.286278: dwc3_readl: addr
>> > > 000000006d59aae1 value 00000001
>> > > configfs_acm.sh-822   [000] d..1    44.286279: dwc3_gadget_ep_cmd:
>> > > ep0out: cmd 'Set Endpoint Configuration' [401] params 00001000
>> > > 00000500 00000000 --> status: Successful
>> > >
>> > > Hi John,
>> > >
>> > > Do you still have this problem? if yes, What's the value of
>> > > USBLNKST[21:18] when the timeout happens?
>> >
>> > Sorry. As I mentioned, I was working to upstream a patchset that I
>> > hadn't created, so the context I had was limited. As I couldn't
>> > reproduce an issue without the change on the device I had, I figured
>> > it would be best to drop it.
>>
>> That was fine.
>> >
>> > However, as you have some analysis and rational for why such a change
>> > would be needed, I don't have an objection to it. Do you want to
>> > resubmit the patch with your explanation and detailed log above in the
>> > commit message?
>>
>> Sure, I will resubmit the patch with my explanation added in commit mess=
age.
>
> Hi John
>
> A second think of this, I feel use readl_poll_timeout_atomic() to wait by=
 time
> is more proper here, so I create a new patch to address this also other
> registers polling, see below patch with you CCed:
>
> https://patchwork.kernel.org/patch/11536081/

Fixing a bug has nothing to do with using
readl_poll_timeout_atomic(). Please don't mix things as it just makes
review time consuming.

Let's find out what the bug is all about, only then should we consider
moving over to readl_poll_timeout_atomic().

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl61UgsACgkQzL64meEa
mQbuBA//dEmweQ1Dhcmw8Sut1NUrlcQMQrzZdVo9W36wzV03PjQ8ycIqdiuQ8e+i
ZzlTZJkLVkHTICp7ksAcTwma7rJummOyXjuI9niBE7B/zkRB13bYZh7kQ2NgNoPj
+vDa5e050OsrpWyzIP1k64jAtz7KReUMRuIQtMxl1xYDuVxjWjXe91Z71R4BDIza
QQET0+jPqyinzXEhsC1Gh9yuoyyzfzU+XQjWoa5m70S9RFvH3FPv0Y8LXBWCb9lN
7++e7RUKzlOlGu973kXWgH8sN9dxxFjxZQnY3wELfirDDN0+9/bpJfFg0lYW9mHH
UNtPcYD7TPXGfzz2wxM0MO3AOi17HXJ6mdG2DlDcJ9Desw1wn2GXt46mJoRODG3o
7qnrkp7zBs59MnTomBmgAoF3L2eylMCDCKmn9feaJy85FJDB3a0b5hgUpcegwbF6
JG9iff08jmIrfawITlFsbUVhA2hLL9YYj903JxoU7NEyoqdwXZzjY7Jd4Jz3QW4N
9myaG5DiJ+zFglnj83awlH1rBAoPwfKZ1Ojv57zGBDHWpjKT+3LoJ/gtE6eEv0Kk
Vzb9Na1D3dCBD0x4SVdiYAf9yocFsQqkjZnjlxu4X8LzZC7eYM7aV9vS7+FpTuxe
58u16XtqKkFuq5EYWcNIZVlJYPyo6KOlMatddTVO+cvzkLDrEsc=
=0L/w
-----END PGP SIGNATURE-----
--=-=-=--

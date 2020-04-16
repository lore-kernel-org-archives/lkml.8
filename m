Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80409C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55186206F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587025299;
	bh=jg+2v8O7scxJu9A/EajFIG31HFq5V5EHIhMtZNNQgxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=k4sn6aLQUZDYO1DWqnwaKFruXWmlmhneSjiT5XJz239FGHXB60vNeYCm8CeH83XZS
	 yWwmqxMsMSR359HsVl8iKdWA4plomOH2nqMZofFk+dVPKp1UZxJgckEyWM3NotFeAK
	 gEramJbNd9K8XVTqUbkfwaLmvp6gt4i7YWsMKkyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441350AbgDPIV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441314AbgDPITo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:19:44 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40876C061A0C;
        Thu, 16 Apr 2020 01:19:40 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x23so4921156lfq.1;
        Thu, 16 Apr 2020 01:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=W9MHtlxfWV5esFp8UKV1MC7UI06aVGBVOqmz4l0oTUE=;
        b=ekIM/u0NoCzuOjB4d6swF8ik0SYVawZsVAjeK6ZOTzHDqRKmxUGGpbAQRb69YI57/7
         YEqsZN10/mLKAn6BtkUdM1WK8dVWGAQdDpaQuO543EzMkkzJvviObNWiJ8/Ha/8HBkoy
         ZAENdBwsq9LFQ5Ptrb6TNeh0GMtga64a8+JGMRNFlajv7ScuXbjNvTJStjTztaBsiaaZ
         vChOMOsZys+sxL/SZpaBOCM58aOMNiPqHxYssLjPFvaVEhPC9dq9cIOv8j/6IrWjUQH1
         P/qe5mJeR21JKRCD+xrzqOx5+hImvOv1sy2s2dtInXfyAh73EN9mdq1j4lbK+oKI4a9p
         OLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=W9MHtlxfWV5esFp8UKV1MC7UI06aVGBVOqmz4l0oTUE=;
        b=FxN9dw2mN7kgHf4h4QAslvVb9IinEeMXCfT3GoadnVZzHlE6C7e/nJBmvrqdSbV+sA
         R6I3FFFzeoaPDTsol0/6CoJ0XaP+DZrbVDGjlTOzV0toYsmtbeGrOmIckX8y/cVc4SY9
         80bMDLynONX1q/t01hR+ETX1snbGWqRPEkaMihu4W7NG13RcJGmUJQgXjWtHlyn1xDcs
         kT4U2n3o0RBD01FflK81A75wK6aEAIqKZo3U6f4fUQvJm2d3u6RfrVEABCScRXvsiqKE
         YLm4mqJLrgvnoMBfPHcdRp7ST4yHpteSsS093bin8VNT4u+NwC1MSEjnbP+61VAAPoTN
         /jFA==
X-Gm-Message-State: AGi0PubhyRio16Is1WvlSECSpLBQp8uIBOjtFvX8zZzYNY/CNYAvBq3b
        OtoI8yOdOuPqFnaZEUMTUxn8FvVBaU4=
X-Google-Smtp-Source: APiQypLK+ZBdTA6YWUvfPtEFGDAvT6JMxGw/IpftO7xZ2urY+CCasg81Mye5Zos0vqS/yhGnfr3f8A==
X-Received: by 2002:ac2:5192:: with SMTP id u18mr5335277lfi.114.1587025178168;
        Thu, 16 Apr 2020 01:19:38 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id o25sm14233941lfg.41.2020.04.16.01.19.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 01:19:37 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Josh Gao <jmgao@google.com>, YongQin Liu <yongqin.liu@linaro.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Yang Fei <fei.yang@intel.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jack Pham <jackp@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: More dwc3 gadget issues with adb
In-Reply-To: <CALAqxLW2R4d=Zm=TKbFprN-uYrerL1oCYsVC3VedEKtW0gCsyA@mail.gmail.com>
References: <CALAqxLW2R4d=Zm=TKbFprN-uYrerL1oCYsVC3VedEKtW0gCsyA@mail.gmail.com>
Date:   Thu, 16 Apr 2020 11:19:27 +0300
Message-ID: <877dyfsv00.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

John Stultz <john.stultz@linaro.org> writes:
> Hey Felipe,
>   Last week or so, a change[1] in AOSP to adbd seemingly uncovered
> another issue with dwc3 gadget scatter-gather support on HiKey960.
>
> Interestingly it doesn't seem to affect the Dragonboard 845c, which
> uses the same dwc3 driver and has had its own issues in the past.
>
> The behavior is the same as we saw last time around with both devices.
> After booting the device, running "adb logcat -d" (or really any adb
> command that transfers more than a trivial amount of data) on the host
> will result in the adb output seeming to stall. Any further adb
> invocations to the device will hang indefinitely.
>
> I've captured trace events for before the change (works), after the
> change (broken), and after the change with the sg_enabled flag turned
> off (which works around the problem).
>
> Let me know if there is anything else useful for me to share.

First the obvious questions: Which kernel version is this? What does
"before" and "after" refer to in our traces? What are first working and
first failing versions? Can you run git bisect?

One thing I noticed is that we're missing a giveback on ep1out. Here's a
working case:

   UsbFfs-worker-580   [002] d..1    66.704886: dwc3_alloc_request: ep1out:=
 req 0000000011c55648 length 0/0 zsI =3D=3D> 0
   UsbFfs-worker-580   [002] d..2    66.704889: dwc3_ep_queue: ep1out: req =
0000000011c55648 length 0/16384 zsI =3D=3D> -115
   UsbFfs-worker-580   [002] d..2    66.704892: dwc3_prepare_trb: ep1out: t=
rb 000000003559c11c (E27:D7) buf 000000008843b000 size 16384 ctrl 00000819 =
(HlcS:sC:normal)
   UsbFfs-worker-580   [002] d..2    66.704897: dwc3_gadget_ep_cmd: ep1out:=
 cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status=
: Successful
     irq/65-dwc3-522   [000] d..1    66.705053: dwc3_event: event (00006084=
): ep1out: Transfer In Progress [0] (SIm)
     irq/65-dwc3-522   [000] d..1    66.705054: dwc3_complete_trb: ep1out: =
trb 000000008c350fb3 (E27:D8) buf 0000000089d6b000 size 16360 ctrl 00000818=
 (hlcS:sC:normal)
     irq/65-dwc3-522   [000] d..1    66.705058: dwc3_gadget_giveback: ep1ou=
t: req 0000000001b9ed3f length 24/16384 zsI =3D=3D> 0
   kworker/u16:2-260   [001] ....    66.705097: dwc3_free_request: ep1out: =
req 0000000001b9ed3f length 24/16384 zsI =3D=3D> 0

and the failure point:

   UsbFfs-worker-580   [002] d..1    66.705129: dwc3_alloc_request: ep1out:=
 req 0000000067a34de4 length 0/0 zsI =3D=3D> 0
   UsbFfs-worker-580   [002] d..2    66.705131: dwc3_ep_queue: ep1out: req =
0000000067a34de4 length 0/16384 zsI =3D=3D> -115
   UsbFfs-worker-580   [002] d..2    66.705134: dwc3_prepare_trb: ep1out: t=
rb 00000000f3db4076 (E28:D8) buf 000000008843f000 size 16384 ctrl 00000819 =
(HlcS:sC:normal)
   UsbFfs-worker-580   [002] d..2    66.705141: dwc3_gadget_ep_cmd: ep1out:=
 cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status=
: Successful
     irq/65-dwc3-522   [000] d..1    66.705309: dwc3_event: event (00006084=
): ep1out: Transfer In Progress [0] (SIm)
     irq/65-dwc3-522   [000] d..1    66.705310: dwc3_complete_trb: ep1out: =
trb 0000000092deef41 (E28:D9) buf 00000000ba8f1000 size 4072 ctrl 0000001c =
(hlCS:sc:normal)
     irq/65-dwc3-522   [000] d..1    66.705318: dwc3_gadget_ep_cmd: ep1out:=
 cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status=
: Successful
     irq/65-dwc3-522   [000] d..1    66.705323: dwc3_gadget_ep_cmd: ep1out:=
 cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status=
: Successful
     irq/65-dwc3-522   [000] d..1    66.705329: dwc3_gadget_ep_cmd: ep1out:=
 cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status=
: Successful
     irq/65-dwc3-522   [000] d..1    66.705334: dwc3_gadget_ep_cmd: ep1out:=
 cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status=
: Successful
     irq/65-dwc3-522   [000] d..1    66.705339: dwc3_gadget_ep_cmd: ep1out:=
 cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status=
: Successful
     irq/65-dwc3-522   [000] d..1    66.705344: dwc3_gadget_ep_cmd: ep1out:=
 cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status=
: Successful
     irq/65-dwc3-522   [000] d..1    66.705349: dwc3_gadget_ep_cmd: ep1out:=
 cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status=
: Successful
     irq/65-dwc3-522   [000] d..1    66.705354: dwc3_gadget_ep_cmd: ep1out:=
 cmd 'Update Transfer' [20007] params 00000000 00000000 00000000 --> status=
: Successful

One interesting thing is that TRB addresses are "odd". I can't find a
proper lifetime for these TRBs. Do you have IOMMU enabled? Can you run
without it? For example, nowhere in the log can I find the place where
trb 0000000092deef41 was first enqueue. I'm assuming the log to be
ordered, which means that trb is the same as 00000000f3db4076. But why
are the addresses different?

Another weird thing is that even though we CHN bit being set in
0000000092deef41, we don't see where the second trb (the one its chained
to) was prepared. It seems like it was *never* prepared, what gives?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6YFQ8ACgkQzL64meEa
mQaIqxAA2vxUnm+Omf8K/N5jvZbIQHW5HcTdVXcznXApCA73acgUGZ6H599/XB2V
LXwkb//ezD8QtY84tC12cDEXSqh2WrwLKyXef8Zhr8aeJ8YPyWIYr50Jx6qzAS2e
PU9KZFtmU3SXhlImihGeWM1eYV0ojhYOpCNUNEWqQ3Hwlmcp5RzINUPCSqYNUVdz
rLZsRllXS/68OEkQarvCRc87b/dJok3k2czcETy+6R69weLeHkJ1gUr+MRVoOUf7
boLSjJX8nrb1xweRmSqD27gXmPw+5yAm+OD++KSM9aVDh67i0VHq1pF/X11ULVxt
03hb6VcEkjUzFznfJrRD7ye7EuXiUwSxJwX+i6bRA0bBU83SoX7Kwb3i8gI3x9vT
l3HvhaL9fUMEnacupHYLzKtHxRHFG0GyBBnbP6KGOgBQutbwQzX/IYWR8mdl4AmO
myTiwgMCgQR54IhchmmrnCBeVvWTA9cyov983sjwhlkZt72+Y/TuLJGU73qWCamb
babTgDZo1FRaRN2SawTJw/qpLGqGM9fOuCX8FW8qTlyG/rPyg0FRgjLMuO3v0F2X
D0hbkSrlpKkCa8i4vdEEWIF9fw4BaYsyXCUCJIUEP3QOpMkIfNC+j8WRAcIdUsDR
GWEK8eaPF4mJ07GBpPt8stsZeTgE1ADys75u/184GrMm5zkKUto=
=mTHT
-----END PGP SIGNATURE-----
--=-=-=--

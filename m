Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760CFC33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 15:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55090206F0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 15:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgBAPbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 10:31:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:40766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgBAPbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 10:31:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0A254AD48;
        Sat,  1 Feb 2020 15:31:13 +0000 (UTC)
Message-ID: <4027e959e17ce8a6aeef34fc6ae4725ad875a740.camel@suse.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
From:   Dario Faggioli <dfaggioli@suse.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?ISO-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Date:   Sat, 01 Feb 2020 16:31:09 +0100
In-Reply-To: <CANaguZDDpzrzdTmvjXvCmV2c+wBt6mXWSz4Vn-LJ-onc_Oj=yw@mail.gmail.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
         <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>
         <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
         <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
         <09b279683e1b5ba1759ac3e9f644d290564902d3.camel@suse.com>
         <CANaguZDDpzrzdTmvjXvCmV2c+wBt6mXWSz4Vn-LJ-onc_Oj=yw@mail.gmail.com>
Organization: SUSE
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-rHsQwCrJavAjq91LmpU1"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rHsQwCrJavAjq91LmpU1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-01-31 at 09:44 -0500, Vineeth Remanan Pillai wrote:
> > Basically, core-scheduling would prevent VM-to-VM attacks while ASI
> > would mitigate VM-to-hypervisor attacks.
> >=20
> > Of course, such a solution would need to be fully implemented and
> > evaluated too... I just wanted to toss it around, mostly to know
> > what
> > you think about it and whether or not it is already on your radar.
>=20
> We had this discussion during LPC.=20
>
I know. I wanted to be there, but couldn't. But I watched the
recordings of the miniconf. :-)

> Its something on the radar, but we
> haven't yet spend any dedicated time looking into it.
> Theoretically it is very promising. While looking into practical
> aspects,
> the main difficulty is to determine what is safe/unsafe to expose in
> the kernel when the sibling is running in userland/VM. Coming up with
> a
> minimal pagetable for the kernel when sibling is running untrusted
> code
> would be non-trivial.
>=20
It is. And this is exactly my point. :-)

I mean, what you're describing is pretty much what the memory isolation
efforts are mostly (all?) about, at least AFAIUI.

Therefore, I think we should see about "joining forces".

FWIW, there's a talk about ASI going on right now at FOSDEM2020:
https://fosdem.org/2020/schedule/event/kernel_address_space_isolation/
(this is also video recorded, so it will be possible for everyone to
watch it, in a few days time).

> Its definitely worth spending some time and effort on this idea.
>=20
Cool! Happy to hear this. :-)

Regards
--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)


--=-rHsQwCrJavAjq91LmpU1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl41mb4ACgkQFkJ4iaW4
c+7SRRAA1Fze8EfcTiwcSGqlwIo0Uer8IucvgpPP3x2TSYj9Kc9gqY8yFBSByRuL
knfH81MFPGZfMBMsOctdaAfRZOwNps+TzipTRthGQh86UMqeU8TgRpY18ZdqJtHq
AD4EgUGgW/RjLtac+81gEZ1apTjcPyEf5vlN/xZXKkzh4kZcW8SQKuTzkTZfYKWL
DCsxEVw/zj8XAoW6IJilK+oyubvbvn4qejDjKz/XsS7JNntTUmoGSktwBsw3OG1+
xOYpl+RYUe95dfsHR4AQYSY9eGt8jMSgGh1wTtdBtwbhaG7TbNovkHMaSkAIRiCk
960Xk/E5tP9Ah4LxKzDaL5k4vxQqSeg7UG/87SqKzYQZl9Gl82Bu5EDO7uUMKNQ5
z642DloOmLb4M5PiYn1gEnkxAB+h/7utDQaYwptVHNR1C4k8Fsk67UE9OaesuCkj
4W/s0V80a0bP277/7BxkgDVlLMrRJY3t66sbsyTgHcCL3oYInDCtwCMffPMvwNxT
sa4//FfyA124O697WbJXe7UpWMHY3F3tXqMAPEDevFlObonNCc9uGxmPg4Uw6fGw
plfXLh4kH9ImJbdVm2cLQwJii4pbanSnwkfUpwN4W/x/9FdLwdHnbBtNHJRLtHZa
aRwXeX754EorOMhWxjztKT1PyKp8Zt5NVuWKI4HefhuQIKDGYxM=
=5dus
-----END PGP SIGNATURE-----

--=-rHsQwCrJavAjq91LmpU1--


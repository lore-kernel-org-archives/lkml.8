Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B64EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DA620727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589461209;
	bh=3YB2PlClmWWHHL7lA2CsDaPrtsOSWCLyW5Yldb5v+a4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=ZYVAV70Cejt6JrNdtfgbMR18jBVIK5s031U1wNswNqGiF1VuGjhIwonuqVbDfi0Ql
	 /OLc9W3iR3XzmvX/2CYKLBwWyxWQ1bcHBaLfvks1OiSfIN3bAVyH53c77/ErDHpNxG
	 S9a3BHglGAPuPh2oRIw2Z6IZwzZe8Bo1IRSQie/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgENNAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726056AbgENNAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:00:06 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75754C061A0C;
        Thu, 14 May 2020 06:00:05 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h188so1803092lfd.7;
        Thu, 14 May 2020 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ROR9+95dsTUL1CeIysEpgW1DhBAJL0UZ2A95+lwDUiw=;
        b=KO6z1RYlRErR/eWlNzvzQ1S4WAxi9GPRDFuqfPtP3FkEatHRkZJJYMDLbVWyrzKM05
         kdvUfgzIXmLo9llmPsA0bTlpcoZPlGa1gQ1i1M3P2LWLtEY5ERlIUn+AVfptSlpLbwVI
         8TT6ZW7OHWOzgTPcBdcMCweELyx/ku0oW8s0fbHOiKfYMSDGHJaGcVwKSpYVVg6mEI9p
         IseVRHYjX7nj0CCb+CDXaxSmi8RCuNUFUnnvPBkx/33a3PNl4IzvkfzHCPM/8KeTdf1q
         AxOnnkTEJH1IWW99opQOR1zBslGDQ3EMeU4aMmxxT3o2eaiXj6SPSxUT6BfOnoWNMlm9
         HZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=ROR9+95dsTUL1CeIysEpgW1DhBAJL0UZ2A95+lwDUiw=;
        b=gPchzb3oXJBkBat5/pPBSDkRRX7c5vjsr824NBgUPxrpT+FlV9ZdJT/Lmt/1dCErdy
         /17gWdDfWG3Pv58GTOkO0F6S1NnHlLz3ZmuZFtcDsJfyN+1epPPtBhJxeOctOB9cCq29
         UBSibJqP18O9lbO/Lbn3PSoOHvhf5iCO8x050N0jyQw7ppwg6YB7dHA/97Zc2IoIINJe
         i8HKgkN11KUPaMyzpDmnl+zQzhvbJXhRQCzedjESts8pFsQqF1wJ3buppZLPOtZ/FMOq
         9v30X0dJVke/OAdt+vwTefCgIgA77y2uGMHFk2fHmb6ZCozR2UscxKrkSV0qZs6Y+f5a
         f95w==
X-Gm-Message-State: AOAM53265zX+WC6kpoBbFiHx+9r6n1nfQmlqZ/CM3HC85KHwiogDLCv7
        jtw7tfqQPODBiX5h7tUTr0z4wPEiHXdhsg==
X-Google-Smtp-Source: ABdhPJxNerIfBcvLmQHYutWMRmJg9p7efJMIVDi65EtZZ3Y4oVoOZUA65oO9+bwhonnVNLfMWyzKiQ==
X-Received: by 2002:ac2:5999:: with SMTP id w25mr3194661lfn.196.1589461203516;
        Thu, 14 May 2020 06:00:03 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id g3sm1894755ljk.27.2020.05.14.06.00.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 May 2020 06:00:02 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>, kishon@ti.com,
        khilman@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] usb: dwc3: meson: add OTG support for GXL/GXM
In-Reply-To: <8404c7a0-fca7-9e28-b65a-312ed09ecdd3@baylibre.com>
References: <20200324102030.31000-1-narmstrong@baylibre.com> <87369rfo7l.fsf@kernel.org> <87r1vm4xyq.fsf@kernel.org> <8404c7a0-fca7-9e28-b65a-312ed09ecdd3@baylibre.com>
Date:   Thu, 14 May 2020 15:59:52 +0300
Message-ID: <87wo5e3c53.fsf@kernel.org>
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

Neil Armstrong <narmstrong@baylibre.com> writes:

> Hi,
>
> On 14/05/2020 12:23, Felipe Balbi wrote:
>> Felipe Balbi <balbi@kernel.org> writes:
>>=20
>>> Neil Armstrong <narmstrong@baylibre.com> writes:
>>>
>>>> The USB support was initialy done with a set of PHYs and dwc3-of-simple
>>>> because the architecture of the USB complex was not understood correct=
ly
>>>> at the time (and proper documentation was missing...).
>>>>
>>>> But with the G12A family, the USB complex was correctly understood and
>>>> implemented correctly.
>>>> But seems the G12A architecture was derived for the GXL USB architectu=
re,
>>>> with minor differences and looks we can share most of the USB DWC3 glue
>>>> driver.
>>>>
>>>> This patchset refactors and adds callbacks to handle the architecture
>>>> difference while keeping the main code shared.
>>>>
>>>> The main difference is that on GXL/GXM the USB2 PHY control registers
>>>> are mixed with the PHY registers (we already handle correctly), and
>>>> the GLUE registers are allmost (99%) the same as G12A.
>>>>
>>>> But, the GXL/GXM HW is buggy, here are the quirks :
>>>> - for the DWC2 controller to reset correctly, the GLUE mux must be swi=
tched
>>>>   to peripheral when the DWC2 controlle probes. For now it's handled b=
y simply
>>>>   switching to device when probing the subnodes, but it may be not eno=
ugh
>>>> - when manually switching from Host to Device when the USB port is not
>>>>   populated (should not happen with proper Micro-USB/USB-C OTG switch)=
, it
>>>>   makes the DWC3 to crash. The only way to avoid that is to use the Ho=
st
>>>>   Disconnect bit to disconnect the DWC3 controller from the port, but =
we can't
>>>>   recover the Host functionnality unless resetting the DWC3 controller.
>>>>   This bit is set when only manual switch is done, and a warning is pr=
inted
>>>>   on manual switching.
>>>>
>>>> The patches 1-8 should be applied first, then either waiting the next =
release
>>>> or if the usb maintainer can provide us a stable tag, we can use it to=
 merge
>>>> the DT and bindings.
>>>
>>> it's unclear to me if this series is ready to be merged. Can someone
>>> confirm? If it is, can you resend with all reviewed by tags in place?
>>=20
>> Are we getting a v2 for this?
>>=20
>
> Yes, even a v3 with reviews on all patches:
> http://lkml.kernel.org/r/20200416121910.12723-1-narmstrong@baylibre.com

In that case, can you check that I have applied everything correctly in
testing/next?

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl69QMoACgkQzL64meEa
mQZ7CBAAjOVQDtFwDKrzgDZRhyR2kgFRKf9TzlbXviaZij9EeWPBy1HaR0b+/2eX
SgIO6RsGUiDD0dBt92WLGnvIxt2JecaAdUNbjUzQBeIkuvEyAuJq0M3qkaMLUU+h
6t6yJZBfO+MyOoFzUS7o+jKQn96KrQLHxcUB69ubZChlNHJUG5nBXpJ2D8xeehnW
Jz3VvJRqBTtN6X8Cgox6e+X7xq42E+VJz9/vwEqQuMA8R85Ay+fxKbX20GdEj0+P
8mhZVbe/Anwpksh5RDLAYeP6tOwz5XeAxotB6Iav81HY//gw2HwVuLdhG4t7sm8h
lfzOa/MkbeoLwT2NacYaZ6eQbBWNpe0+JhX74FL08/P+S5JiHw/DoejbYJL4u8v5
vfA9kWfkrgEQem/MxNAD8dI+HtFMAnNemLsXMATSrNepVNJiEFACyR9fPA76tf1A
OPd9sztw4TMDhVi7rPFjnkRYacG7eNkY814OI39975lRc2VI24GjkzBELJMILhqo
u6EFJcd5vUJcsE47LNyn+hnEFZdkzjxnDXRIJhFfHIyuHaBWYF7chXbkj/TohCQi
NnLdxEIHnHTXLsD+zN79KNx+UB+4JmRoMVyGlipjaGcgiPWTark9gXyxqOzJNYGG
Ag7n5Rbxrlh80c2pOZnK4dHKjpUSLf8pcbXgK4rvLr5uWZEvT9A=
=1kRq
-----END PGP SIGNATURE-----
--=-=-=--

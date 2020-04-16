Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6778AC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AEA020771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587028291;
	bh=cq7TORbSy5Y9jQZrayfK6hSr3QmJCfPHO7C1ZVqSf/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=Jo028r9rzvVX6AZkmlH6fIUiD4oCRqyXkuMJ9HSD0LBL/X/NnBoym3JU7bI16oWtH
	 WNNzmFgJOQv41nEcR2zxK6iQHWUrTcV4OB2ggs1RY2srNQIHaErf7SnsKh5AkvsU42
	 /qCqHxrPN273A5yfo8JTLOUFjvpg6FPzZduqP8gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502634AbgDPIjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502254AbgDPIgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:36:20 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B68EC061A0C;
        Thu, 16 Apr 2020 01:22:36 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j14so4903993lfg.9;
        Thu, 16 Apr 2020 01:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=5XivUy7FYVNBF2ALrQWWddiXZG0r/RtMEsTQOMXoZEw=;
        b=hrxyamFeaN5opbMcHQIxgyojWXXgF0/AxSdT61mtPK/9nuopn2X3w+Eo7DmP8MgRrW
         cyaf9xt2UXlInW++gbOBn+B5WwIovU/cUwpTbDaABwoFf6xwgWIz3NH8KkrePTDplsKB
         ooSPWlZBuCE8bUqqRkYUK9MfI6BmkvmvP2sRVcs6zVmHnu7c6cQoGlTWZmFc5xx6D6JD
         XqNOkrRYtWq0NW4zllmDjBajqjgPIDlFtp/AzA1F5KJdrO17qnCbXArLOZjEMUkasGJo
         uPE801WBQchV6XXE8oaDAXSz06AUauSnJ4VLBZAz0TwXeyJpI6InwVpG5Hpu4/WA3ee0
         EBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=5XivUy7FYVNBF2ALrQWWddiXZG0r/RtMEsTQOMXoZEw=;
        b=G0UeX2h2pcFjrUThs+ZJXfdYbuKShaBL0C2vFtAZkinTWCsrEKmjDupnu9ectITvRR
         Dxj//Q8F3UqtRK8D8JdQNJvCKyCt+ZZW0R/l2TQX3Jb9M/7nagJszvxz7dWE2zAPbCt2
         snqB8a+4GNk0IEOVw8xiSiu/elujRbwWnegFn3iOIRRYnslV+MM+WLaM4emE5opqore8
         rLabsEQ1bZdMXC6YtXAdE6HKr0qTFUDpmvuBDN2ssvNDmwM5qFGGE3Niu0qKM0qbgxpk
         XyVfpr8irGqf4zKxfnEXHM1IzKoVhCVlqtxy21n/3bKA0CoXdcTDdq5f/4J4LJH4Aoic
         iJ2w==
X-Gm-Message-State: AGi0PuaTUiucwBO6LYrQ4clbsH/NPr6PsLcceNS4IehlQSlkzVHTZU5l
        VTR9ZKQT90qJHWreH+tyxMKmt1GVrZY=
X-Google-Smtp-Source: APiQypL8+Q52Lb0ewPp/pJoLw9OSGQ5XBl1Ni/2AkpVcoNu5RaFpOoY8wN7upjMPPDqseJD2jwRj5Q==
X-Received: by 2002:ac2:4426:: with SMTP id w6mr5381093lfl.8.1587025354320;
        Thu, 16 Apr 2020 01:22:34 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id y25sm14443965lfy.59.2020.04.16.01.22.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 01:22:33 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>
Cc:     "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Youn <John.Youn@synopsys.com>
Subject: Re: [RESENDING RFC PATCH 1/4] dt-bindings: usb: Add snps,consolidate-sgl & consolidate-sgl
In-Reply-To: <fe59318a-b3dd-c6af-702e-1ca4aed04a8b@synopsys.com>
References: <cover.1585297723.git.joglekar@synopsys.com> <8a9ca8e08d7c4957789a209c77589f1aa4bd2f06.1585297723.git.joglekar@synopsys.com> <20200405014548.GA25539@bogus> <fe59318a-b3dd-c6af-702e-1ca4aed04a8b@synopsys.com>
Date:   Thu, 16 Apr 2020 11:22:29 +0300
Message-ID: <874ktjsuuy.fsf@kernel.org>
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

Tejas Joglekar <Tejas.Joglekar@synopsys.com> writes:
> Hi,
> On 4/5/2020 7:15 AM, Rob Herring wrote:
>> On Fri, Mar 27, 2020 at 03:11:56PM +0530, Tejas Joglekar wrote:
>>> This commit adds the documentation for consolidate-sgl, and
>>> snps,consolidate-sgl property. These when set enables the quirk for
>>> XHCI driver for consolidation of sg list into a temporary buffer when s=
mall
>>> buffer sizes are scattered over the sg list not making up to MPS or tot=
al
>>> transfer size within TRB cache size with Synopsys xHC.
>>>
>>> Signed-off-by: Tejas Joglekar <joglekar@synopsys.com>
>>> ---
>>>  Documentation/devicetree/bindings/usb/dwc3.txt     | 3 +++
>>>  Documentation/devicetree/bindings/usb/usb-xhci.txt | 3 +++
>>>  2 files changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documenta=
tion/devicetree/bindings/usb/dwc3.txt
>>> index 9946ff9ba735..292d1f7969e4 100644
>>> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
>>> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
>>> @@ -104,6 +104,9 @@ Optional properties:
>>>  			this and tx-thr-num-pkt-prd to a valid, non-zero value
>>>  			1-16 (DWC_usb31 programming guide section 1.2.3) to
>>>  			enable periodic ESS TX threshold.
>>> + - snps,consolidate-sgl: enable sg list consolidation - host mode only=
. Set to use
>>> +			SG buffers of at least MPS size by consolidating smaller SG
>>> +			buffers list into a single buffer.
>>=20
>> The preference is not to keep adding properties for every single quirk=20
>> or feature. These should be implied by specific compatibles. As Synopsys=
=20
>> knows what quirks/errata/features are in each version of IP, the=20
>> compatible strings should reflect those versions. (And yes, I'm sure=20
>> there's customer ECO fixes that aren't reflected in the version, but=20
>> that's why we have SoC specific compatibles too.) This is the only way=20
>> we can fix quirks in the OS without doing DT updates. For comparison, do=
=20
>> you want to have to update your PC BIOS so an OS can work-around issues?
>>
> Yes, I understand what you want to say here. But I think this compatible =
string
> does not work with the platform drivers with PCI based systems. So based =
on the vendor=20
> id and device id then I need to set the quirk required.=20
>
> @Felipe: What do you suggest for setting up quirk without the DT update f=
or dwc3?

We have been using Synopsys controller's revision register, but that's
not visible to xhci driver and we don't have a separate compatible for
each synopsys version on the xhci driver side. One option would be to
add "snps,xhci-foo-bar" to xhci-plat and use that.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6YFcUACgkQzL64meEa
mQastxAAyArwov8WGnSblC6znvn16hE4x9d7GVKj4PyYpMBcnccppp2VGviRXfRs
BzH8B0drFGFQ5fhRGZDpm2uAssAJgdrUkw4npkVvVKFztohaAha8Q9yu02jtChXD
1AVmbd1nUH5IiIhlLPa6AuxeszA3hP1p3os1wSCIuH3NcBEx6K+I27X5zgs7uG5v
OT5oednhw3mgQBxHkh9luPlLiToFbrb1eE21w7FzCKPzbMeAnJzFVodlcVe5OTF/
cvzdLk+YhP0JG+K4trjp1bu7/nlvy5qWXQ3FBaUv6/7DzAwDKKD77wN8z1i1nebl
hhk60Kt6x1d566VvpJZNyjpYrdd5ub5HQbdp4933JBjMyNYwx2FBwjQxylV31M4s
hB1BSDtVUy+h+cD9qwNWpE9I3iuRqjqNIl0IfJRxhEzaUHU89EYKpk3XbJr83rtp
Ae/SopbpHr2GelmPhgUK0PBDeaeIIa+WWJQMqtfsVQO6z+43oBJHzYmsY8QZLj9H
Yt8IuWRMc7kbpcNQl+Dx+JCQRLhggkeLIGaIPmexAzWSRY4Cod0Q4QD6xXmOlJiE
S64Egfd9Q8d8LBY3iyFRRTMAQcCFVfaK+8Uf9kwitgHww/Hc/886/4WhBaVHTAoJ
8Pwku4qw1VePFeKWoUKqwCEWdwuFxq0eqKTWgdu5HurClw+OJEg=
=faNe
-----END PGP SIGNATURE-----
--=-=-=--

Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A2AC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2FC20737
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQVVv0Vr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgCZBUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:20:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34561 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgCZBUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 21:20:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id d37so1543761pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 18:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=e8XheT6kfmvd0PF/NNKtOa37EvHLdf90VhV5aTaHxDc=;
        b=uQVVv0VrCW4ziaRkImKz/hIt4IQAbpYDUj8SyLZUhEyE/AtUxPknfqxRPAuv8Rc2tG
         0grQAgGFdeJOU+tGOFhzaUgyn1ylHmLbuoY6lE0oHROReIP4f/1Yx3EXbhcK4Az6b3Ny
         0mKRcbkAM7+hraI5HStz2znb+nAXfEnDz1onzggyROflfKJxPj102Hx4d3v0e2143vhJ
         MVC2IBXGt9JHvBLA1Gg8D+zVSE9NceaapiXRuUBQyghhZ0tqsvX0YUCvctLnA8pT7rOY
         wyNZ4t05Ia9TELcuBcM0Irpk3bavXiMqZOk1rJM9xUNXYp3FBWPauZY6bzHkeaaEHCvI
         5zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=e8XheT6kfmvd0PF/NNKtOa37EvHLdf90VhV5aTaHxDc=;
        b=puSjF8kui1o5IrkwnTneCthFZ41rtt4WjtdI9mNXQFTZpEaLqw10tDx88k/x/MVbX1
         akjAndfUh/luMXhKfg3679GkZ3COcN1u3GM6g4sk0IYwuDjbTpVXi4nBm4GtCNvudPcr
         5xOSTAAN3diFVYP1992cCRdTggv48P+/AN1BwL99qS3c1FYvKZ62zKFimhk0uyVIeG9J
         ntBkKYwh8Lbi+VBQxI4pYYBKVvvlcI+siQ6fTZk5h9gqRhA8IcK7FMpD2/gn+yfBRLLw
         XfRw45vMhksPNatPWWU1bhiTd0lxh4we+zJgjOjaor2jAD1BFsL+zYeIz5vSm+i0/rSh
         lAHw==
X-Gm-Message-State: ANhLgQ2ZVtgiNsQaK1dZ8/Flaxq7AAN0pJaVp94RPnQvrUy+ir/+A9kn
        YwmTFg5WAHHIGEEpJ+LcPCih+8P14dM=
X-Google-Smtp-Source: ADFU+vuCLIPA717y5MwUpounWw8Gjzi1rcFZKVGs5t95fanGcoIdtlldzPcDBvaggALQlzMqCaR70w==
X-Received: by 2002:a63:e56:: with SMTP id 22mr5872162pgo.173.1585185647901;
        Wed, 25 Mar 2020 18:20:47 -0700 (PDT)
Received: from ArchLinux ([103.231.91.35])
        by smtp.gmail.com with ESMTPSA id 93sm362950pjo.43.2020.03.25.18.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 18:20:46 -0700 (PDT)
Date:   Thu, 26 Mar 2020 06:50:36 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     rdunlap@infradead.org, joe@perches.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] : kernel-chktaint : Fixed space ,cosmetic change
Message-ID: <20200326012036.GA985@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Thorsten Leemhuis <linux@leemhuis.info>, rdunlap@infradead.org,
        joe@perches.com, linux-kernel@vger.kernel.org
References: <20200324225917.26104-1-unixbhaskar@gmail.com>
 <3ca78f7a-4431-b345-85e4-eb07fa8a4038@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <3ca78f7a-4431-b345-85e4-eb07fa8a4038@leemhuis.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12:23 Wed 25 Mar 2020, Thorsten Leemhuis wrote:
>Lo! Thx for taking a look at this, but it seems a few small details need
>to be improved before this can be applied. A few general issues first:
>
>* your patch v2 is afaics on top of the first patch; when doing further
>revisions please merge all your changes into one patch so everything you
>want to do can be done in one commit (and people that see this mail
>out-of-context can easily gasp what this is all about).
>
>* tools/debugging/kernel-chktaint was added via the docs tree, thus I
>think it's best if this change takes the same route, so please CC the
>docs maintainer Jonathan Corbet <corbet@lwn.net>
> and linux-doc@vger.kernel.org
> =E2=80=93 I might be wrong with that line of thought, but Jonathan will k=
now
>for sure.
>
>Am 24.03.20 um 23:59 schrieb Bhaskar Chowdhury:
>> Space bwtween
>
>Typo
>
>> the words is fixed at the bottom of the file,sentence
>
>Missing space after the comma.
>
>> starting with "Documentation....."
>>=20
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  tools/debugging/kernel-chktaint | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-ch=
ktaint
>> index 74fd3282aa1b..1af06bc0e667 100755
>> --- a/tools/debugging/kernel-chktaint
>> +++ b/tools/debugging/kernel-chktaint
>> @@ -198,6 +198,6 @@ fi
>>  echo "Raw taint value as int/string: $taint/'$out'"
>
>This used to be the last time. Did you move it upwards on purpose?
>
>>  echo
>
>If you add a blank line here you IMHO might want to add one above the
>""Raw taint value" as well.
>
>>  echo "For a more detailed explanation of the various taint flags see be=
low pointers:"
>> -echo "1) Documentation/admin-guide/tainted-kernels.rst in  the Linux ke=
rnel sources"
>> +echo "1) Documentation/admin-guide/tainted-kernels.rst in the Linux ker=
nel sources"
>>  echo "2)  https://kernel.org/doc/html/latest/admin-guide/tainted-kernel=
s.html"
>There are two spaces here as well: "2)  https".
>
>And I for one dislike the "1)" "2)" style, as in the end it's the same
>file in different locations. How about a text like this instead:
>
>```
>For a more detailed explanation of the various taint flags see
>Documentation/admin-guide/tainted-kernels.rst in the Linux sources which
>is also available online as rendered webpage at
>https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html"
>```
>
>Feel free to improve on that, it's just a suggestion. I for one wonder
>if this cosmetic change is worth all of this, but no worries.
>
>Note, you also want to change tainted-kernels.rst, as in once place it
>shows the output of this tool (which is one more reason to route this
>via the docs tree).
>
>Ciao, Thorsten

Thanks a bunch, Thorsten ....I think we all should forget about this
event altogether ...this is not worth a single second of our time
=2E..honestly...

crapping it ...let it be what it is ..in fact it is looks good in
present form . Too many round to gain too little...nope...

Sorry for trouble.=20

~Bhaskar

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl58A2EACgkQsjqdtxFL
KRUAzQf/ewfABqBDF1hGgWdnJt7NJdZ6GcA+r8PhGjSUCCXwtw3h1TzppTmx1p3g
tXRgiGCAAYmvnMQ3wCACoAPBHRMG+gNoRDcV34v4LekHjl1re7ZLBmntikW53SJR
gP/cw6uRLixk53x0xF+eeeTnLcqPO99J/AgksVSOKoMh4DVpTo25aEjISo6ScVKl
U6SbTC1jBAdlfFOJQ8uiibi3TnJeJD+7ihvXFksEtDp7ooEPUFcjOd4Q0OI9nE4h
nVH2peBrLpQ5SzkCN778/fAnMAjSAXtckRd6iwB9efsawTtcZ6jmUdHUHR8clpKN
ZfW3GwhdN8OCqRNwN/oPfdXSFRRgSQ==
=l59c
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

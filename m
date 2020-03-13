Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5645C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92F920746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584111553;
	bh=DDXEvkQy+nGEQh7YrTTb4YfvtzoHHg0pZMYX0jjTJ6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cpgmpPf7JjxXMTMyI1ylGMbJKYVfM6XD77lCVIjrE3g3qncQ0u6bu92UlLxafKF+P
	 Q8KrhPJZtiKx1kWc5U2xtCtckHPXlrQdWsVodrrsgQskHiakSSNR3C0n+d0Dyy3OkY
	 foGWglJrlpBsZcw/M/wZcRYeOu8qZRwYADNSgPQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgCMO7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:59:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39262 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMO7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:59:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id f7so10630840wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=IsxGkk+gAgJpHcmpHDsJnPiHzi+FE2XR1Jj6QRHjerU=;
        b=Rz/soQ/C46cwaYR7aKIWsNra445H0d2rukyhMOhm1cqtBtejmO9q/JkH1BUuPHwwFE
         ygX5rHuIa5fQmteBLUkmpdbZQ+dkVdaN+Oe/vxVFY3jr52WvieJH+Ov9qgUgr5GAL5Fc
         CbOcl3yKO9e0LxwTa6LfgvUh3WrfICXp3+NN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=IsxGkk+gAgJpHcmpHDsJnPiHzi+FE2XR1Jj6QRHjerU=;
        b=E6o1+Z1pYg6C3BI0k8tAcK3RyaGqZoV1JEwIvmqfacT+4a3msGvWcmp40G+Dy9qFs6
         b2atFUltppHDG7MzF3OmG/7+aoXCjwYu0H4+GlDBGmbxbgbknX53tEJ5lnpSXRHebmvc
         b3/CKaZArzvbXn1VlnHmhNwzkkO9kItCEO6HgC3Mvy27UHECWfRtuPE7uy7ll4YCzytA
         HV/ZRBX8AjmN4ukK68pJs0j95eOTWJPGOWj5Q73K/OpKJl7AZQy6sF+L15CAaP71vqsO
         mVB4l2bHbt3s9T/+OVpsO53Oeg2tOM3e4tFZqhzY3Ne4LQ5Eh+mT1CSOsfHzL7r0PlZ1
         GUZQ==
X-Gm-Message-State: ANhLgQ2LaFHTxMbDgCKxt9/3rqT1kJYYsLAidXpLa292F7jUakWe6rTm
        49YxiST8kw7BhR6nVdUFt1KSkw==
X-Google-Smtp-Source: ADFU+vt6Ee+YrRJwJg+LkR0T2Wxbv9uAQ1pNC7GD+N+YSDX8d5qq7hUzS99JfMCrFmREdoUUQmPlRg==
X-Received: by 2002:a05:600c:218f:: with SMTP id e15mr11962354wme.152.1584111548699;
        Fri, 13 Mar 2020 07:59:08 -0700 (PDT)
Received: from chatter.i7.local ([185.220.101.34])
        by smtp.gmail.com with ESMTPSA id w204sm7508882wma.1.2020.03.13.07.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 07:59:07 -0700 (PDT)
Date:   Fri, 13 Mar 2020 10:59:03 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Greg KH <greg@kroah.com>, "Bird, Tim" <Tim.Bird@sony.com>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] Linux Foundation
 Technical Advisory Board Elections -- Change to charter
Message-ID: <20200313145903.vwdpawgcve73hdmj@chatter.i7.local>
Mail-Followup-To: Jani Nikula <jani.nikula@intel.com>,
        Greg KH <greg@kroah.com>, "Bird, Tim" <Tim.Bird@sony.com>,
        "tech-board-discuss@lists.linuxfoundation.org" <tech-board-discuss@lists.linuxfoundation.org>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6d6dd6fa-880f-01fe-6177-281572aed703@labbott.name>
 <20200312003436.GF1639@pendragon.ideasonboard.com>
 <MWHPR13MB0895E133EC528ECF50A22100FDFD0@MWHPR13MB0895.namprd13.prod.outlook.com>
 <20200313031947.GC225435@mit.edu>
 <87d09gljhj.fsf@intel.com>
 <20200313093548.GA2089143@kroah.com>
 <877dzolf7n.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4lcrcqo4orbdsa5y"
Content-Disposition: inline
In-Reply-To: <877dzolf7n.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4lcrcqo4orbdsa5y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2020 at 12:30:20PM +0200, Jani Nikula wrote:
> There is no way of knowing whether you're eligible to vote until you
> apply for a kernel.org account and either get approved or rejected.
>=20
> The current "obvious" requirement levels are not obvious to me. How many
> contributions is enough? Is everyone in MAINTAINERS eligible, or do you
> have to be a high-profile maintainer/developer? What is a high-profile
> developer? How many people in the web of trust must you have met in
> person?

Anyone listed in MAINTAINERS is eligible to get an auto-approved account=20
on kernel.org, but they *must* satisfy the web of trust requirement:

- their key is signed by 2 other people who already have a kernel.org=20
  account (marginal trust), OR
- their key is signed by one of the following people (full trust):

  - H. Peter Anvin
  - Greg Kroah-Hartman
  - Ted Ts'o
  - Linus Torvalds
  - Dirk Hohndel
  - James Bottomley

Anyone who is not in MAINTAINERS but feel they should have an account on=20
kernel.org can still apply if they provide a reason behind their=20
request. Such cases are fairly rare and usually include collaboration on=20
non-kernel projects that are also hosted on kernel.org (there aren't=20
that many, but there are a few). The web of trust requirement is exactly=20
the same, but the final approval is not automatic. I forward these=20
requests to the above 6 people and it is sufficient for at least one=20
person to say "aye" for the account to be approved.

It is also important to highlight a distinction between "having an=20
account" and having a kernel.org email forwarding address. For this=20
particular case I was requested to provide a list of people with *active=20
accounts* on kernel.org, meaning that they have performed a git+ssh=20
operation within the past 12 months.

> And it actually seems like you think it's a good thing the admin team
> can make a subjective decision on the above.

The LF IT admin team does not make any decisions -- all decisions are=20
taken by the above 6 people (unless the person is in MAINTAINERS, in=20
which case their approval is implicit).

> It may seem completely transparent and fair and objective on the
> *inside*, but it does not look that way on the *outside*. Which is kind
> of the definition of transparent. Or lack of.

I hope I helped clarify the procedure. Of course, as the person actually=20
creating accounts I'm the final arbiter of all decisions. If I had any=20
malicious intents, I could totally subvert the whole process -- so in=20
the end you just have to trust me to be on the side of "lawful good."

-K

--4lcrcqo4orbdsa5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCXmuftQAKCRC2xBzjVmSZ
bJAtAQCpHec4XGPbIsLXVSLSnco3sea7WWrflVzmUOx3OKLChgEA67pYUzWNdmDv
yVutxmm+efbawqG95EdbH1REDjLWgwg=
=k55k
-----END PGP SIGNATURE-----

--4lcrcqo4orbdsa5y--

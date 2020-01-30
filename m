Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C92C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B83214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580381584;
	bh=VInSeZzfvgmHREHYseWhKaEskYTeZJwjVw1nVI3mDSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=y7Z+dATN0b4AtJzb/Jl+dxq1/rLtJYrVptBYWg5lH0ctTE7SqZbdtEzY1yZEfrlkv
	 cDqD/JxQ0j4/AInit+mDZLLktbjs1aC/w/HM1AkzENyGxqUKJCWXVPBOh6tv6IL2oq
	 mHmZgiq4osKUtd3ZWqBYi/rmkmTf/hYcoeI1EHhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgA3KxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:53:04 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43322 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3KxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:53:03 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so2784588ljm.10;
        Thu, 30 Jan 2020 02:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=VInSeZzfvgmHREHYseWhKaEskYTeZJwjVw1nVI3mDSM=;
        b=BSL0whsJQB7pKHlTpIwBLCkb5I+yKv0mb9bqNx3DgSN0w1F5FvibJkbn+PcudtlPSk
         42yHTkhzFMCnWWGMSXFUUA2HG4bau7e+LimBepJYU8eLo0yUNE9kUiy7+60osRUyCUv5
         pLy53BA9mSVRMjk5BGySw8/DtVerKeqDA0TRiZ+57fbXBaO1aTl/TWADcxkloBX6EdqX
         1VtdALsPD2cMuoFztqcewiAL462c45MRrH7gLbLjjPSG6qihYRTOoj1HFd8SSOKj4a/u
         NGgWwS70kCwCefymZhvQf/RPF61ek4ncmffmWrmWqNHRAykOAUZVOvM567mltqETz0hN
         CzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=VInSeZzfvgmHREHYseWhKaEskYTeZJwjVw1nVI3mDSM=;
        b=NCuAQ+9R1a5J2MxdyGBhhl5Wm0+8X1PDvfHQpxRQFdRbBV5fkvmp+PuvqXoUperIIU
         vWHK8onK10VxNRc3fHLIu4kygd6+/E5BrFabnxfLE2oFeEEzmdEeXVIJwabK3GrlvcX8
         KH9Iv1wWIV/8FEF19wOrmBUEiT9+CchOXX9KnMRE0MWNnDgW9uoPxZiwnLL+V+9sXH0e
         33cO+i16esY+eZNMTw6prn03sEPLH60+ewZ8lepU+TGQVaXNFREsszUClGKzE4pe2f5r
         a/bojC6B/PwyGzbgnRRIoiE8LBIh9BI5UL7n6EzVH519w42WNKokQXPsMvPk9x+3y8vy
         /rsA==
X-Gm-Message-State: APjAAAVohmaAe8z0vs1e+poFbvtG5zsfn+321tKUXxoa/WcdSa+Dnx84
        yWPnCdDK5AoKnQleYkuhahSOK38Mr/M=
X-Google-Smtp-Source: APXvYqyW8YU5DPRtzWUe9otRvtCWmRlLF4jZgF/dLQpWz7GpFGNLMnob8wZ6nL95k2aVYKoq93G16A==
X-Received: by 2002:a2e:98c4:: with SMTP id s4mr2512389ljj.102.1580381581018;
        Thu, 30 Jan 2020 02:53:01 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id h14sm2612603lfc.2.2020.01.30.02.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Jan 2020 02:52:59 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: [GIT PULL] USB/Thunderbolt/PHY patches for 5.6-rc1
In-Reply-To: <20200130083459.206fc0d9@canb.auug.org.au>
References: <20200129101401.GA3858221@kroah.com> <CAHk-=wgwBfz0CtAFZMDy=A_Wz0+=dzrfWWiHESUD9CxnV=Xyjw@mail.gmail.com> <20200130083459.206fc0d9@canb.auug.org.au>
Date:   Thu, 30 Jan 2020 12:52:55 +0200
Message-ID: <87ftfx8bco.fsf@kernel.org>
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

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> On Wed, 29 Jan 2020 10:11:26 -0800 Linus Torvalds <torvalds@linux-foundat=
ion.org> wrote:
>>
>> Stephen, does linux-next perhaps miss these config-time warnings?
>
> I saw it when it first happened and reported it, but since I merge the
> ic2 tree before the usb tree, the warning went away for me after the
> fix was added to the i2c tree.

I wonder if we should start shuffling the order of merges in
linux-next in order to have a chance of finding these issues.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl4ytYcACgkQzL64meEa
mQazdRAA0z0M7brv/67q3vlMfMM9M8uyx+sk6vaS3NCEg1l0YXfWhwdk3fx/0FCf
DXW+S3BcjgZXUD+U6nNvjp92z7yvoPjaqAUzf4/1vs5/TsuVniJy5hrd5R2rSMR6
lZnuQ7ilCQvDiRjnSc3WM/sdVh+/mf/d7caxBwq0W6ojry9Hx8PjPoArg9iYcxfm
UYHVz8oMW3SCyBWZE0a8ZHj9jWa8AcdF8E20ulBL0z/lLpmSN6Oux8+Zd7+Nylw8
ElL8KW/I/wxQOANQYt22U6vsj4MxItHsejZr3JQ1SPAyr/VgmArGFM435CeDviMr
Y1hOByIhtT4F2wJ0LvGuIZ95/LHdvttwp2ETtbSyVHlGTiizGZaIMJplvj8ZN7O6
SNQjWI5ZdhcIIGJzlojGDhO/HBqGG9ED1/0RHG8DLaKho7ntuHifKxxRLO4jEH7T
dgZ9ResVOysGcaIQgBkh+/c3CXh5WGhjkqm9NpO270ZHW7EgUJKI/kaC/Igi/Z1i
vvinuicDmayWMOS/+6sd321AWtSIvWvQQS5YD4YmpTi7oor5YYyGfvrKG30ZT7FM
0H6VqRm+j6+TCEYwzF0yUNaibuOzcFwQ89Upc563FbvY7w2uBYP+JqM7w1/8wfaE
YCe8SpShKtN/CuDFmz2W0iBy43+mqFtgFZ7G0lhQrWz7KvZSeRg=
=Io0V
-----END PGP SIGNATURE-----
--=-=-=--

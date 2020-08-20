Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884E0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 04:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B0020786
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 04:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sg30RJgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHTEwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 00:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgHTEwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 00:52:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CCFC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 21:52:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g33so583690pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 21:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5VWHI9n0+G3Tugiglsr+/xN2YwY1eAl4mqxcjHXV038=;
        b=sg30RJgwK8Lv5XRHi/WimqIf3rB9gatyZVHbgFDOwMn7DjJxESwLjKeUKI2qYM5QF4
         nTFUfN0Y+S9GN2ac/6llvCHHe0Lo5YX0H+8ITh+k2JsR1uztzHIK2d34f0VJUrZLcyhx
         h/YQ2oVahy/2yRuf7hAaey+KgMV+xdQUgbaEBal1/4jQoYeJUk4Rr4g0BhS+79D9ezMp
         xJTz/olwauOaZme+0lHGzyRNUSwtxL9ZMJnrsIl0wGyvuNjQVIi0OkiGLi9O4xopuhkt
         /R3IbmbP/0LM91dhD9sEfL8VuuTfSlbHlt9VsqOotqNn0nXj4wwMcyCzSCFWbsn3augQ
         j93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5VWHI9n0+G3Tugiglsr+/xN2YwY1eAl4mqxcjHXV038=;
        b=KpuHnyescuweoW334MQ/izGMs4DZcA62Ko08pY7RZDCncTSYNG+3eHsvt18tv5Vt1o
         +36sLvuHo2lZC+G+U7kzj7LlvRsWmLSHcyvsr9dO7UWKtjdJGa8bP6LGiyu+/OFb04Al
         qGbSDMyXntsd+1wJe2revVGlQgP7xXYBQMWcrXNJzK5tmgqZCuNG8xY01nEU39haEKVA
         XcCBgOQ4Nf99MQt8MduL5adS2s3rVCWGj7nC9VVdHGERSVwF4greU+TjjqjiX7TwYqhi
         pjTKMD4ejMk/WqknlnL7sJY6MWw9VwBHshxZChemJ9EmgOWOqIcrcd/BkgXEdUvnUVVD
         D+Ag==
X-Gm-Message-State: AOAM531OLQQQmGw0pCXnomF7x1HnlaCeD2zcRDSBSatmMg3t4Bjf5xMY
        FkX2YRSCudxSScqZEPlIOhQ=
X-Google-Smtp-Source: ABdhPJwk8QJnC9KbOI5ziFvW6UbllAaSRg+AL5gHNG6xLAWMh2Mh0hNlihlPpcjmyT2/1uEAMMDVPg==
X-Received: by 2002:a63:64b:: with SMTP id 72mr1201470pgg.157.1597899164625;
        Wed, 19 Aug 2020 21:52:44 -0700 (PDT)
Received: from localhost ([1.23.143.142])
        by smtp.gmail.com with ESMTPSA id lk16sm572071pjb.13.2020.08.19.21.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 21:52:36 -0700 (PDT)
Date:   Thu, 20 Aug 2020 10:22:32 +0530
From:   Mrinal Pandey <mrinalmni@gmail.com>
To:     apw@canonical.com, joe@perches.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, skhan@linuxfoundation.org,
        Linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] checkpatch: Fix the usage of capture group ( ... )
Message-ID: <20200820045232.tmun7jlppeeesg4p@mrinalpandey>
References: <20200714032352.f476hanaj2dlmiot@mrinalpandey>
 <alpine.DEB.2.21.2007300746330.13710@felia>
 <a2773089a844047407855f2da7bd72c2970d2e6b.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ux4q3enrmoiq3cjy"
Content-Disposition: inline
In-Reply-To: <a2773089a844047407855f2da7bd72c2970d2e6b.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ux4q3enrmoiq3cjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20/07/30 12:31AM, Joe Perches wrote:
> On Thu, 2020-07-30 at 07:58 +0200, Lukas Bulwahn wrote:
> > Hi Joe,
> >=20
> > did you see this quick fix to checkpatch.pl? Can you comment on the=20
> > commit and can we get a quick ack on that fix, please?
>=20
> Yes, in a bit.
>=20
> > General question on patches for ./scripts/checkpatch.pl:
> > How do they travel to Linus?
>=20
> Generally via Andrew Morton.
>=20
> > Do you pick those patches and provide them to Andrew Morton?
> > Or do you just ack them and we need to send them to Andrew Morton to ge=
t=20
> > them into mainline?
>=20
> Generally, ack and forward.
>=20
>=20
Respected maintainers,

Did you get the time to check this patch out? This patch is a part of my
mentorship project and your comments on it would help me to make the
best out of this learning process.
Please review it as time permits and let me know if what I propose makes
sense at all.

Thank you.

--ux4q3enrmoiq3cjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE8DwCG1PwaC2uTI99xIwpEWwxhGQFAl8+AZAACgkQxIwpEWwx
hGSRYhAAsnHeGya+r57xffK0LAGoAC8gmK0pURMm8cSkIuwN8Q6pUQoqHR5lT6U0
HnKCqnDhdyivZLHpM2ApQtZ3eAAVyJyRwzbltybExm74IOdNTGdfvUoonDmzWq4j
9AacN7giMY5BHtrhaGuq4ULSD6Nh45wl/yYfVIqAhKZxYLAAZyQzCIwIiY62YB5z
QWF15M8GwzS5XJM3qqyuA5gmngljnQ11fd1AcRSvdBQLDVRcFO/7OwCkvZQFxsgl
wB2TF2FB6u2MP/7j2DoCfGTwSSlOp1rOQN1mMsLT+EoxWbIpX+yd1aw+4Igm07De
7R0lOcMQ6V0M1kvO+Kos38kW5HqeJ7YsSSsSx7FlFCbxVUpvK42jrAtbFY9RTofA
SBPTrb1SaFNXVZEM3yO05kkgPx5aF3IveOxZnBjT0A8IrfFERYXEEIVytOhR5IoB
xJp41qx6C8F9hhDXrvwcflxqt5vueJLth100xZaklc0/1DO4FtPcxwJYwflLz1C3
Jn+lzC6v7QBgyXHEI1lWCN2PLODjW2RZd+QkRIoMQjVCeqnDmhBEKfeAF3Ru1wux
yCDiQrmrqxHZGJLi/1oOCM+xICd6Xh89YFn24YQXv7lEw6OIdgy2fhqMoU0+Z4ab
4kbEI1D6sDan0mNjvs/iQvkU/GRpkt4JQygvafVHpJLPoZ+IRc4=
=GBtR
-----END PGP SIGNATURE-----

--ux4q3enrmoiq3cjy--

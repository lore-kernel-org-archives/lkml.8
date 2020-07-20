Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2822EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85012176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595246704;
	bh=O8+Y/4OoQju9IZHX2k1O8iC0TRyQPiiyX/cek2dOKiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2ci77xtcUXS+7iq3LwePZwap0m40fZaLV6OtTGbtZKlzskKQqEgJ8NEL+Ow/phtd4
	 JBSfMzKCvEA2DxrEKcqrZ9fGUTVa7h/TUvlWkKvbvPnFWFI2iTdshVA+eOZ+0wveus
	 y1H0xOu2uBvkdmXHP5DkfkTa6EuemqJ3VKs+F8xY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgGTMFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbgGTMFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:05:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44B582176B;
        Mon, 20 Jul 2020 12:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595246701;
        bh=O8+Y/4OoQju9IZHX2k1O8iC0TRyQPiiyX/cek2dOKiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpqpaRc0tDGqfHivGJXXxTGzj3RT28qnga2AvKg5hHLDKbl9/l6XE+HulDAbod4JX
         zqMoH3/twxhReZsxk6e8RYI9md30OmG9mWAmI2B80I+NLovWINqFD6LQZOF9cSiffc
         0NYt5+esrlHrtYrrAz5T1u1PZ+DVZ+5ofiSwgirk=
Date:   Mon, 20 Jul 2020 13:04:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2] regulator: gpio: Honor regulator-boot-on property
Message-ID: <20200720120449.GC4601@sirena.org.uk>
References: <20200720100113.6481-1-wens@kernel.org>
 <20200720110610.GA4601@sirena.org.uk>
 <CAGb2v65zdCfOP-vGzrVXuzRyUC1ejG5CX=dfrh9MGTuV00VgPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline
In-Reply-To: <CAGb2v65zdCfOP-vGzrVXuzRyUC1ejG5CX=dfrh9MGTuV00VgPQ@mail.gmail.com>
X-Cookie: Be different: conform.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 20, 2020 at 08:03:06PM +0800, Chen-Yu Tsai wrote:
> On Mon, Jul 20, 2020 at 7:06 PM Mark Brown <broonie@kernel.org> wrote:

> > There may still be out of tree users, an ABI is an ABI.

> Ok. Should I add a comment stating this should not be used in new files?
> Or just leave it as it?

A comment would be fine.

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8ViGAACgkQJNaLcl1U
h9B/NAf+P7DD/hRGoO35F35fvcuTtmqrcDlNmlsrnEmguqGPXmOv+jtQxqT/vy69
jKhJn+A0zD2daqgLMQNFZIdVQ9nVTTT8qmIjWe+VmmsIYuxI9cLESr9p0miN03LQ
sgSN5hZzACpD6wysHWUERGM+w8ysy8JvqoEFfpGwzplHbwXl5hDEMz/ltLRvFpx+
/SNL69/xh2yGWrCSly6CvvJ8TqyX37AI36KbOk4Rqq6GO5cdWGlZVwQsL+CycmAV
jah8DKxp6cy8Ag0IsMn1a1XzPW9K/uTlO8dlEoStSeyoedEdf0PWzXUrNcJeUePG
x+CB7s5GzHQqLSevLw1VR/RF8aZ8OQ==
=HQQt
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--

Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49A0C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB192146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583924490;
	bh=mgHHjoGsBSu4RcBDTdG8yJfsVpcu6E7h/NKi+LwRRYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JAh+eyKSroWVQKzQA3FDZ737M7At3UXT8ChFymbzfVsvC0wRJzg+MmsjgOoO0oMwI
	 5MDReZjuf9mCF/roGJbRJMzG68f/YnfGAlSAjU9C8sYebaBUcDbKqiTYfVavqKb2k8
	 mKPFCjeqARvoAizPCIZcH8Xb+mV3FylcdEdg5Uww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgCKLB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:01:29 -0400
Received: from foss.arm.com ([217.140.110.172]:48090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgCKLB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:01:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD15F1FB;
        Wed, 11 Mar 2020 04:01:28 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42FD33F6CF;
        Wed, 11 Mar 2020 04:01:28 -0700 (PDT)
Date:   Wed, 11 Mar 2020 11:01:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: entry-ftrace.S: Fix missing argument for
 CONFIG_FUNCTION_GRAPH_TRACER=y
Message-ID: <20200311110126.GA5411@sirena.org.uk>
References: <1583894213-7633-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <1583894213-7633-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Cookie: I'm a Lisp variable -- bind me!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2020 at 11:36:53AM +0900, Kunihiko Hayashi wrote:
> Missing argument of another SYM_INNER_LABEL() breaks build for
> CONFIG_FUNCTION_GRAPH_TRACER=y.

Acked-by: Mark Brown <broonie@kernel.org>

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5oxQMACgkQJNaLcl1U
h9CeWgf7Bzv1s2eTPsMd1oDrdWw4fbak3ACJ/ynsFM2lhEQI3DdhGMYCsAgoLlRX
HS/K+7ydBUZEEyxDPnMLPCAEB3iOAWGEaSwhFlvxJzBOZzK1fLs2JrJCHvDGN6fY
Ex7/OkteIo16ppA8UwzINYOAUX4x1zimrvWEyX8mmOQn+k+Na9SO1Zl7TUBINiir
Gtk/gv3fcM4WV15B83bFE9N4o3JLw3t+PY8rtijIqYEHqcYHuzXi7d4A+GBZlHlZ
VS0rq49bFboQ81SnbbpsLXEXXROWxD+hOfcTzxvN8W95g0+HNmNvZQlnn5SttzHl
3Q3GptTWpuPLyNU9QjL0TOuJFRDggA==
=R3/C
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

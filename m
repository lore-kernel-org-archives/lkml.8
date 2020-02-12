Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AB1C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE0B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581508836;
	bh=4U3kyUNQZkoiolbCGBcod0ynM+vltNtaxpiev9leMnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M3m8w82n5zkU7AbiefVFFReTpJZocr7pvaO9g6qV1NkZ+Qm3rnrUkogRjHmEOqRm0
	 ORmwHy1GClQBdMdjsTFacu0fxATPLhhbVVKEzYhiSGeWh1RepQ3ouCgjKH6I+SjKdb
	 SE3B9/NOcP/24hS+Na4sucLcvWg/IQXTO1XOqSDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgBLMAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:00:35 -0500
Received: from foss.arm.com ([217.140.110.172]:60106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbgBLMAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:00:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DAEE30E;
        Wed, 12 Feb 2020 04:00:34 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A54FF3F6CF;
        Wed, 12 Feb 2020 04:00:33 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:00:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     vishnu <vravulap@amd.com>
Cc:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: Buffer Size instead of MAX Buffer
Message-ID: <20200212120032.GD4028@sirena.org.uk>
References: <1581426768-8937-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20200211153847.GK4543@sirena.org.uk>
 <c4b900ee-743e-8ce0-1061-02c383bff90e@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <c4b900ee-743e-8ce0-1061-02c383bff90e@amd.com>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2020 at 02:36:32PM +0530, vishnu wrote:

> prior to this fix the value in Tx/Rx Ring Buffer Size register
> ACP_BT_TX_RINGBUFSIZE,ACP_BT_RX_RINGBUFSIZE and same in I2S RINGBUFSIZE
> registers was statically set to maximum which is wrong.
> Buffer size must be equal to actual allocated.

OK, makes sense - this is the sort of thing which should have been in
the commit message.

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5D6N8ACgkQJNaLcl1U
h9DZiQf/dWgDV9LNXeiT35fpCE0NNPfQAot1I/qWDk4lx8xnWZkk7Yst9HKWTZ45
5QMT35X8ffIrVDWwbiIWfN+ba+z89OhY5vInIfxYQQ4iRJXnOVEwN4LaCub00Iq+
XfO+f5Y0nB7aQEFeMWFC1mduSg2uGNK7+p4AXhXVI33tfl2uJhzIM7vRhdMW1+9F
SxZhZAT3SZaUwbHD3QE35wGSZvxM+902oXYLMsac9USfVNj2DjcUNvU0xXHE6p25
XES2+b++z6ihK9p4ZggZ0mSLdRwLMGatIWdXLrNvU6EQlJeAFM623z7cyskVWBEp
IpgjwHZYEkN85PbpOutNNmEaCljHEA==
=Bcit
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--

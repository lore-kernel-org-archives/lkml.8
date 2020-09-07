Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9135FC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427AB208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599501537;
	bh=/C1SFpD0i/Dhq5426QtDNAmVDIFm0D6y8r+JOIhO6Rk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CyLTsCFmrXUmR0zcXg3nhuE4Or9GOJq0WPojAEeRUB9psZCz0ncuq6vFVshtqM87M
	 H4DCTna0ELu4BcgVBPSRgc2eHls+KxCGhDYsx+Gx3gpxKiy/tMwhEAK6j/GhzdJBs+
	 vC0gmYQBiNerlgbt5jDbNxWUfuW+rfsXcFiqLlqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbgIGR6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbgIGR6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:58:53 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E73A82080A;
        Mon,  7 Sep 2020 17:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599501532;
        bh=/C1SFpD0i/Dhq5426QtDNAmVDIFm0D6y8r+JOIhO6Rk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PHRkRXZqt37rXGqaZq9Mg8WNSqM/ssrCnjxh45znpJP55hWmmRY7L0N/c0yJulmoV
         rOS6gsH2MrIz0z6Zbr2lUkWwF2dI7RyNfU/Ng29EpTHOKaZdMiIvtUa4AsPyMOLUq/
         MiTh5dAEfdJIGnxUZ5CL9cfj2Ltb6TlubhlhamoU=
Date:   Mon, 7 Sep 2020 10:58:50 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Moshe Shemesh <moshe@nvidia.com>
Cc:     Jiri Pirko <jiri@resnulli.us>, Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next RFC v3 01/14] devlink: Add reload action option
 to devlink reload command
Message-ID: <20200907105850.34726158@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <6bd0fa45-68ce-b82d-98e6-327c6cd50e80@nvidia.com>
References: <1598801254-27764-1-git-send-email-moshe@mellanox.com>
        <1598801254-27764-2-git-send-email-moshe@mellanox.com>
        <20200831121501.GD3794@nanopsycho.orion>
        <9fffbe80-9a2a-33de-2e11-24be34648686@nvidia.com>
        <20200902094627.GB2568@nanopsycho>
        <20200902083025.43407d8f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20200903055729.GB2997@nanopsycho.orion>
        <20200903124719.75325f0c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20200904090450.GH2997@nanopsycho.orion>
        <20200904125647.799e66e4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <6bd0fa45-68ce-b82d-98e6-327c6cd50e80@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Sep 2020 16:46:01 +0300 Moshe Shemesh wrote:
> > In that sense I don't like --live because it doesn't really say much.
> > AFAIU it means 1) no link flap; 2) < 2 sec datapath downtime; 3) no
> > configuration is lost in kernel or device (including netdev config,
> > link config, flow rules, counters etc.). I was hoping at least the
> > documentation in patch 14 would be more precise. =20
>=20
> Actually, while writing "no-reset" or "live-patching" I meant also no=20
> downtime at all and nothing resets (config, rules ... anything), that=20
> fits mlx5 live-patching.
>=20
> However, to make it more generic,=C2=A0 I can allow few seconds downtime =
and=20
> add similar constrains as you mentioned here to "no-reset". I will add=20
> that to the documentation patch.

Oh! If your device supports no downtime and packet loss at all that's
great. You don't have to weaken the definition now, whoever needs a
weaker definition can add a different constraint level later, no?

Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE4EC54FD2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C740720714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585103821;
	bh=InTvH1FD+myof5xLImIsEz4YlekXxKWk3kYrJWkbr0Y=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=1lzn91b2E2mmqkOR4fPoB5RRWH2ovcI4/e3tACoWE/kT237bS1otL+2gy5f7t9Z9x
	 Yw39mDTdLE3OTeEzNJzD5HaVIfMhFHp4MVQme5D1xluwTxnP9oXbxI7z0wQjUfPDyv
	 Mci03kHKrvInQvl2GJiOESzNpnV8UD7QnoylPGY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgCYChA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 22:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbgCYChA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:37:00 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6A6620714;
        Wed, 25 Mar 2020 02:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585103819;
        bh=InTvH1FD+myof5xLImIsEz4YlekXxKWk3kYrJWkbr0Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=1e3i8/DIhGo0HLqrkskon5km384KJf9SoZP1feyeC+ZJmg1QQcczK8/AqfuJsP2tk
         EBYKSQk298Cdgnw0WujZwTJNmtd/ibRkzqKFcdewrIjgTCDu512l/adogDsTsumzBU
         kX8saiVwdrg/QT/7rPNSFCpDDf1uue1ZDcdu182A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200323184501.5756-1-lukas.bulwahn@gmail.com>
References: <20200323184501.5756-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust entry to ICST clocks YAML schema creation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 24 Mar 2020 19:36:58 -0700
Message-ID: <158510381898.125146.5862992017032580482@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lukas Bulwahn (2020-03-23 11:45:01)
> Commit 78c7d8f96b6f ("dt-bindings: clock: Create YAML schema for ICST
> clocks") transformed arm-integrator.txt into arm,syscon-icst.yaml, but did
> not adjust the reference to that file in the ARM INTEGRATOR, VERSATILE AND
> REALVIEW SUPPORT entry in MAINTAINERS.
>=20
> Hence, since then, ./scripts/get_maintainer.pl --self-test complains:
>=20
>   warning: no file matches \
>   F: Documentation/devicetree/bindings/clock/arm-integrator.txt
>=20
> Update the file entry in MAINTAINERS to the new transformed yaml file.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Mauro got here already

 https://lkml.kernel.org/r/491d2928a47f59da3636bc63103a5f63fec72b1a.1584966=
325.git.mchehab+huawei@kernel.org

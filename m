Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA3EC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8FC21739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580249083;
	bh=j/NUJ+MdfToDuN75xJKIJE1vjW8I5zQX5YuatxjDXZU=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=Z9jHWl3CK4zDZ8KT6qD5i1fXjAL1KMMR9YU7V8a/xntGMXOQeAsad7JwtVThSJSWB
	 gZmvqUV3egkvbzFOF5LxwZIEcGqmgkvyfksO+Bw4A01pcOqGLx8K0D4PvNWBDg0GRB
	 WWgr+iHX8NGT7d0tOBW0QE3N8VVrOsaY6LQlcFdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgA1WEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:04:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:60786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgA1WEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:04:42 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5B9C207FD;
        Tue, 28 Jan 2020 22:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580249081;
        bh=j/NUJ+MdfToDuN75xJKIJE1vjW8I5zQX5YuatxjDXZU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=IwrA1qm7xqnE0s03KSqSfbTXcN2YGudcmBfUNBES+roQHqn3SvoPyjHkCeUeAZtGM
         9r4MwROQs+ty97TJr9BKMAx14VrFEF6WKxsZ7aph3Sb3k8kJQdH4i+d83kxcEvEemO
         EujjbRpjo6VMDtCIoxdA6yXPRrNRiwOLq3yhpoAk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200102231101.11834-1-michael@walle.cc>
References: <20200102231101.11834-1-michael@walle.cc>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/3] clk: composite: add _register_composite_pdata() variants
To:     Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>
User-Agent: alot/0.8.1
Date:   Tue, 28 Jan 2020 14:04:40 -0800
Message-Id: <20200128220441.B5B9C207FD@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Walle (2020-01-02 15:10:59)
> Add support for the new way of specifying the clock parents. Add the
> two new functions
>     clk_hw_register_composite_pdata()
>     clk_register_composite_pdata()
> to let the driver provide parent_data instead of the parent_names.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Applied to clk-next


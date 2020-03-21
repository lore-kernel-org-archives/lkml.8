Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C64C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B6E20753
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584753913;
	bh=n8yjlr1b1s9SpEYtzTJTlVAWXrwLsk7f/ZXVv70T3gY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=0Cvaz84BXBnt9Ncz6J5t4+E+oBjd6duCxIaVq4NtXTkKa/MUp962rlIbk00J00EYs
	 NsoU+7a7kOmvJxty3iiSlGyXY0AB3g/H1ZE6pZytnug2EPVIrerLcnQa3E9YhjTS80
	 of//hvXoM5UrVv975MOw2i/x+K9pFP+gzB+B5S00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgCUBZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 21:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbgCUBZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:25:12 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C27B20752;
        Sat, 21 Mar 2020 01:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584753911;
        bh=n8yjlr1b1s9SpEYtzTJTlVAWXrwLsk7f/ZXVv70T3gY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VsgEMTH0rs+SofkFeNpBwczp/5+1BYuRAc93rARWuGmr8OnnTpaZeCbTU/YnDBxhC
         WXwT2gqjuS/PhGnfx53MHI5c0CpisjD9XIak4x3eRxhyjJd2o7Zu2uKYjP5gSySbw/
         9JmIlf0Uc6x9BRXe7Uo5LEm0g+s2bSErdLwYAn94=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309194254.29009-12-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk> <20200309194254.29009-12-lkundrak@v3.sk>
Subject: Re: [PATCH v2 11/17] dt-bindings: marvell,mmp2: Add clock ids for the GPU clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Fri, 20 Mar 2020 18:25:10 -0700
Message-ID: <158475391092.125146.7678854836734974845@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-03-09 12:42:48)
> MMP2 has a single GC860 core while MMP3 has a GC2000 and a GC300.
> On both platforms there's an AXI bus interface clock that's common for
> all GPUs and each GPU core has a separate clock.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>=20
> ---

Applied to clk-next

Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830D8C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4716E20753
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584753908;
	bh=2kInnsJovIKSAGHr2E5aPdzoRLpJbwUYULYLdudGOyY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=sV4Ru6aX3M5ZQMNqMM1BNaFJaGG2b9dStXiC62fJjaUXlmLfO04TjjDVJ4MqKhwxf
	 nJ4SGgXCSwS7njjqmrqQPCXJPR1o/Go0kT0QYIrxziuETw0orbXKkATPuV8It9Ld+V
	 kFmqchubm3U7OTGvIWiIBrf24nKC4j2tcZUwat7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgCUBZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 21:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCUBZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:25:05 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DB7320752;
        Sat, 21 Mar 2020 01:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584753905;
        bh=2kInnsJovIKSAGHr2E5aPdzoRLpJbwUYULYLdudGOyY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=klzJ166FbGo5TxJyYm7ENwN3mVmG4ecwKgbx/JtC+2OJ6VgoLdhFsf6uGU9UQPjp2
         E2BjLIUkPQPbzirM4RnJn5x+1TyhfD0vT4ZPU3d8qUnWhMuLBsHbcgDVyVWL+5tNDj
         xSTK8A82IAjH4syIKy8qrmOVv7wwSyuXY/yNVw48=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309194254.29009-10-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk> <20200309194254.29009-10-lkundrak@v3.sk>
Subject: Re: [PATCH v2 09/17] clk: mmp2: Add PLLs that are available on MMP3
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Fri, 20 Mar 2020 18:25:04 -0700
Message-ID: <158475390434.125146.6482589568960006845@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-03-09 12:42:46)
> There are more PLLs on MMP3 and are configured slightly differently.
> Tested on a MMP3-based Dell Wyse 3020 machine.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-next

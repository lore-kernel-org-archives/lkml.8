Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A15CC33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 06:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F4620702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 06:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580279918;
	bh=RMW9XvEC6xztDEAPjm7/xfpZ8SdMJ1dxG571mw5qRaQ=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=hWNwcUTtQRkRgmgQqxH/j1thCTjAoJD+q0HpN4Isdp3Nd2XrgJ28p5+IQC0WQeB8D
	 w25R/OB8BXG971fynjtIEfwLB12BFZOVJfIV+xyVAGcOZdZnvKr0LF7TavEDvxB/aN
	 MUx940AiCXO0WHwvLW6jxE3WEfUdjsBWIPssSWKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgA2Gih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 01:38:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgA2Gih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 01:38:37 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C2A62064C;
        Wed, 29 Jan 2020 06:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580279916;
        bh=RMW9XvEC6xztDEAPjm7/xfpZ8SdMJ1dxG571mw5qRaQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=ZS/kFlY6dhawaQwWN3FCrAPlcSHZ/KY1ZQYcmYPFmEDWAFWP4V6vXr0EgaXnfWVv0
         xuNvmDC2+6AY9z9eTPc0ZoI2Fv4eM8WbnkIIa/2DsAZqhhKnMX2lcOmLpFoiXlcTEq
         9dIvN1Pwn8eGV/pCk8LEUlJva+uEisX4oqKCgAGc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200128072002.79250-5-brendanhiggins@google.com>
References: <20200128072002.79250-1-brendanhiggins@google.com> <20200128072002.79250-5-brendanhiggins@google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1 4/7] init: main: add KUnit to kernel init
To:     Brendan Higgins <brendanhiggins@google.com>,
        akpm@linux-foundation.org, alan.maguire@oracle.com,
        anton.ivanov@cambridgegreys.com, arnd@arndb.de,
        davidgow@google.com, frowand.list@gmail.com, jdike@addtoit.com,
        keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com,
        skhan@linuxfoundation.org, yzaikin@google.com
Cc:     gregkh@linuxfoundation.org, logang@deltatee.com, mcgrof@kernel.org,
        knut.omang@oracle.com, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
User-Agent: alot/0.8.1
Date:   Tue, 28 Jan 2020 22:38:35 -0800
Message-Id: <20200129063836.6C2A62064C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brendan Higgins (2020-01-27 23:19:59)
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().
>=20
> Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Although, why can't it be squashed with the previous patch?


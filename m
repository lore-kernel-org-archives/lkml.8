Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D71C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FDA420787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595443775;
	bh=gO3cXOzvy7Hq12xriUJlLk8YeDSUw0K4gKPAY31EVvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WQ0R7mFpER3WtrjH4NUqKtrr4LTl5OQ0jO66h0OVRNF7i04qMt1LJs6v83RPY1RJY
	 Xnhsqok/IH3+Qjc7PIl9gPrr52Kn26BTG511J38Lp2y+7EqKPUoy8u+d9cHzZ+aXKq
	 ZhxYrrv+9EKXc47cRAzYvPHYbQSInIqNr0FJYs3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732420AbgGVSte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731267AbgGVStb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:49:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 341D120737;
        Wed, 22 Jul 2020 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595443770;
        bh=gO3cXOzvy7Hq12xriUJlLk8YeDSUw0K4gKPAY31EVvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zKmNT3LVGoJm6irB1/Z7Ez+GKGkn+3h7Hy+fkbvlJOrmU66C965ch3Amy8F6s6dAh
         h0rm22i1E6GpdqviWExH9yw7iB32rx1YAVTlHQ2hXkgvHwg76hza6XLrfNGhv1BHFh
         cd6QPXs9uv9UoVIR39dM6UEmT2K0Z2AKX5Sr79j4=
Date:   Wed, 22 Jul 2020 20:49:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mei: Avoid the use of one-element arrays
Message-ID: <20200722184935.GA581127@kroah.com>
References: <20200714214516.GA1040@embeddedor>
 <5198b29f-2e62-4910-4a4d-52c7991915c5@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5198b29f-2e62-4910-4a4d-52c7991915c5@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 01:27:10PM -0500, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this? :)

I will, give me a chance...

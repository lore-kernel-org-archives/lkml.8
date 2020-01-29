Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFECC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 06:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DAC20702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 06:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580279898;
	bh=igzXSD+i/BUOTNjEhBzvGFgosW6UsPn3MYnWYPPr584=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=Aj0vhq2EOTUEibgCvRHgQ0wx6azhGqFHPHye9Oj9XPJ1JokPH7XW+jZPPABcRquxK
	 EKON7v+Ibs/FgekGGCNa7nmH7wVX3DTx3OplnlDj8YB8K0LceE6lr18uSDiirbVAE4
	 iAG1J7YBIsC0KIGiMEWTygDu54mZUKdCQS3/JJN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgA2GiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 01:38:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgA2GiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 01:38:18 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E1BA2064C;
        Wed, 29 Jan 2020 06:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580279897;
        bh=igzXSD+i/BUOTNjEhBzvGFgosW6UsPn3MYnWYPPr584=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=xiWwiGuk8lYNmW+eBP/+gr9yInn1cPjsco52iuZ9S6JXKnAomKSJfupwmKOw5pxzz
         G25KAASmOaSBSHmvgg3bfNN0uJl1iS37fZYcmRuxDWSv9xcjD0yZa4glNu7iBFBdIq
         ocgTvBUvE8BLu4TOUrnFbXui9GIX6ftD2fnOLpJs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200128072002.79250-4-brendanhiggins@google.com>
References: <20200128072002.79250-1-brendanhiggins@google.com> <20200128072002.79250-4-brendanhiggins@google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1 3/7] kunit: test: create a single centralized executor for all tests
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
Date:   Tue, 28 Jan 2020 22:38:16 -0800
Message-Id: <20200129063817.3E1BA2064C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brendan Higgins (2020-01-27 23:19:58)
> From: Alan Maguire <alan.maguire@oracle.com>
>=20
> Add a centralized executor to dispatch tests rather than relying on
> late_initcall to schedule each test suite separately.  Centralized
> execution is for built-in tests only; modules will execute tests
> when loaded.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> Co-developed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>


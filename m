Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F4AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 04:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D006A20756
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 04:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590122406;
	bh=t23ctuDSgz2OOgMg3dDJXiz8kK2YLj/V3oe4CBnrEqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=X0F8XYhP6EDNTozgEOI/0y+qUhW1QscMeSFfUelPeDla/j9OSFHJzGLGnLsyBf6Zu
	 dPC5bTafZXyAZ3qEtnz1twnjtnWQR6yQhokSXWCqF+pkuK346Jv3yKa/RXhOdu/+XP
	 FiM04xnvfFqcHjM8Qh/brDjAREX0viQfA9Aqe6sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgEVEkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 00:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgEVEkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 00:40:05 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D55D32068D;
        Fri, 22 May 2020 04:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590122405;
        bh=t23ctuDSgz2OOgMg3dDJXiz8kK2YLj/V3oe4CBnrEqg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hSYLl4INY8Kb9Gacswopf9wkJZjdZLl/1YUqQOZcjjJtVJQwDvhugF53amC9B3zvF
         5RO11pEuGGCZxDcfDVdFKERGc2DPus7SqENNfXrU+l2oElv8i+6qvO/YOX2J2pzd2i
         yH/YZQTRyFif02eK8n1rfeqkh13sTIuT9WELXp9M=
Date:   Fri, 22 May 2020 06:39:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Will Deacon <will@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 10/14] docs: move locking-specific documenta to locking/
 directory
Message-ID: <20200522063958.7e961a98@coco.lan>
In-Reply-To: <20200515120607.73ee1278@lwn.net>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
        <dd833a10bbd0b2c1461d78913f5ec28a7e27f00b.1588345503.git.mchehab+huawei@kernel.org>
        <20200515120607.73ee1278@lwn.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 15 May 2020 12:06:07 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Fri,  1 May 2020 17:37:54 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>=20
> > Several files under Documentation/*.txt describe some type of
> > locking API. Move them to locking/ subdir and add to the
> > locking/index.rst index file.
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org> =20
>=20
> I've applied this, but it really seems like this belongs in the core-api
> manual someday.

Makes sense.

Well, right now, it is at the same level as core-api, just below it:

	Kernel API documentation
	------------------------

	These books get into the details of how specific kernel subsystems work
	from the point of view of a kernel developer.  Much of the information here
	is taken directly from the kernel source, with supplemental material added
	as needed (or at least as we managed to add it =E2=80=94 probably *not* al=
l that is
	needed).
=09
	.. toctree::
	   :maxdepth: 2
=09
	   driver-api/index
	   core-api/index
	   locking/index

Not too bad.

Btw, there are other doc sets that could also fit into the core-api, like:

	...
	   accounting/index
	...
	   security/index
	...
	   bpf/index
	...
	   scheduler/index

while most of the rest should likely be inside driver-api.

Some care should be taken when moving stuff, though: there is a
reason why they weren't moved to driver-api in the first place:
they may contain stuff for the admin guide mixed there.

Thanks,
Mauro

Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83594C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE5520CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583219393;
	bh=25tK8WOoFxs0713ihIp2v/ZITVby64PNqh7BHCke+Yc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vBYZeFylsE8/TBk/BX7MPbSihhfkVqGBDelX+Prf8jr4RcBr+1sqCq18S1oXsDwR0
	 b2AOEG8fV7G6NgURrAM6nezqdcl8W8EwOza6566BXpYAbtAVlwk2a5nZ58BkijE6JM
	 0Z7oABFBOrwOIMefCovS4UsGKeVyJ5OUJlpODG1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgCCHJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:09:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgCCHJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:09:52 -0500
Received: from onda.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6196A20CC7;
        Tue,  3 Mar 2020 07:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583219391;
        bh=25tK8WOoFxs0713ihIp2v/ZITVby64PNqh7BHCke+Yc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZbJbnpZz2MfKVFBPbmxrq+1xY9Pdkkw/QUQp9bomOyWUw/rJb6q+yiJPtpjPlhC+c
         HdpxKkmIGdmb8A75J6BmmPcZ6cm/Z5Ag2Z823D5MBBix+R6E6ip8SHUlCvshtm7aRK
         bUSTNRkHrZ6tvkDBrlLApaZ0wenZ3dUqkkRyUXlw=
Date:   Tue, 3 Mar 2020 08:09:47 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 00/12] Convert some DT documentation files to ReST
Message-ID: <20200303080947.5f381004@onda.lan>
In-Reply-To: <20200302123554.08ac0c34@lwn.net>
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
        <20200302123554.08ac0c34@lwn.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 2 Mar 2020 12:35:54 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Mon,  2 Mar 2020 08:59:25 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>=20
> > While most of the devicetree stuff has its own format (with is now being
> > converted to YAML format), some documents there are actually
> > describing the DT concepts and how to contribute to it.
> >=20
> > IMHO, those documents would fit perfectly as part of the documentation
> > body, as part of the firmare documents set.
> >=20
> > This patch series manually converts some DT documents that, on my
> > opinion, would belong to it. =20
>=20
> Did you consider putting this stuff into the firmware-guide while you were
> at it?  It's not a perfect fit, I guess, but it doesn't seem too awkward
> either.

I placed it just below the firmware-guide at the main index file.

I have split thoughts about moving the files to there, though. From
one side, it may fit better from the PoV of organizing the documentation.

=46rom other side, newcomers working with DT may expect looking at the
text files inside Documentation/devicetree/.

Maybe I could add an extra patch at the end of this series with the
move, adding a "RFC" on his title. This way, we can better discuss it,
and either merge the last one or not depending on the comments.

>=20
> It also seems like it would be good to CC the devicetree folks, or at
> least the devicetree mailing list?

Yeah, that would make sense. I'm using get-maintainers script to
prepare the c/c list, as it is simply too much work to find the
right maintainers by hand, for every single patch.

I just noticed today that there's just *one entry* at MAINTAINERS
file for Documentation/devicetree, and that points to you:

	DOCUMENTATION
	M:	Jonathan Corbet <corbet@lwn.net>
	L:      linux-doc@vger.kernel.org
	S:	Maintained
	F:      Documentation/
	F:	scripts/documentation-file-ref-check
	F:	scripts/kernel-doc
	F:	scripts/sphinx-pre-install
	X:      Documentation/ABI/
	X:	Documentation/firmware-guide/acpi/
	X:	Documentation/devicetree/

So, perhaps we should add something like this to MAINTAINERS:

diff --git a/MAINTAINERS b/MAINTAINERS
index fe3ab10354c2..64deb23dbb13 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12394,6 +12394,11 @@ L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/ulp/opa_vnic
=20
+OPEN FIRMWARE
+L:	devicetree@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree
+
 OPEN FIRMWARE AND DEVICE TREE OVERLAYS
 M:	Pantelis Antoniou <pantelis.antoniou@konsulko.com>
 M:	Frank Rowand <frowand.list@gmail.com>

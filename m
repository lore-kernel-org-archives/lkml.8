Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7743C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF34206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="lLRUsp3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgFKOwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:52:02 -0400
Received: from sonic307-34.consmr.mail.gq1.yahoo.com ([98.137.64.58]:42880
        "EHLO sonic307-34.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbgFKOwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1591887119; bh=Y49V++UNOPzuYl35+NoNzvTt4SNqxDJdg4ytABKfLJY=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject; b=lLRUsp3JNW5VdCt6g6Ggd0OM7Cn8QSAglRSU0NwvMZ+5rDqEa6qLy5e6FoSHILZjwM7O4lafiUP849zqqu0SSJVPNHcmU5lqKge62xtI67UjxDMiH3OWKqryetXzqAucHNE/WQTW5sat29a45ZOuUE+cN7x1ijGM9w82OqeqgPlfXleTUoUktZ4ETSx03Akmno2zef7OV26rtoLQUuZxnQRdqEej2UXjp6QvfHaIoa24T84xo28NiAsFNX2MbHAwGozcQvKgLZC4Px0ywGSxBFHE9csaHvnRK9fTc6raDQWyTQuMDZub1N8n2qaNF2vHJ7ToxaRrb3nIXPRVTZiAlQ==
X-YMail-OSG: N_6BpMEVRDvd.miR6A7lED5GPdAEx7ojsA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Thu, 11 Jun 2020 14:51:59 +0000
Received: by smtp424.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b1fcbf8aa3997862c2f8ed0063d81657;
          Thu, 11 Jun 2020 14:49:57 +0000 (UTC)
Date:   Thu, 11 Jun 2020 10:49:53 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: [patch for-5.8] dma-pool: decouple DMA_REMAP from
 DMA_COHERENT_POOL
To:     Christoph Hellwig <hch@lst.de>,
        David Rientjes <rientjes@google.com>
Cc:     alsa-devel@alsa-project.org, bp@alien8.de, hch@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        Pavel Machek <pavel@ucw.cz>, perex@perex.cz,
        tglx@linutronix.de, tiwai@suse.com, x86@kernel.org
References: <alpine.DEB.2.22.394.2006110025250.13899@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.22.394.2006110025250.13899@chino.kir.corp.google.com>
MIME-Version: 1.0
Message-Id: <1591886384.28dd734zt4.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.16072 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from David Rientjes's message of June 11, 2020 3:25 am:
> DMA_REMAP is an unnecessary requirement for AMD SEV, which requires=20
> DMA_COHERENT_POOL, so avoid selecting it when it is otherwise unnecessary=
. =20
>=20
> The only other requirement for DMA coherent pools is DMA_DIRECT_REMAP, so=
=20
> ensure that properly selects the config option when needed.
>=20
> Fixes: 82fef0ad811f ("x86/mm: unencrypted non-blocking DMA allocations us=
e=20
> coherent pools")
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  kernel/dma/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20

Works for me with SME on or off with af7b480103, and with SME off in=20
abfbb29297. There is some regression with amdgpu and SME between those=20
two points, I need to check that out too. I haven't tested either before=20
or after with SEV (which I'm not even sure my system supports).=20
Regardless, this is a definite improvement.

Tested-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>

Thanks,
Alex.

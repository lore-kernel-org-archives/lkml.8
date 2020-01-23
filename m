Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,HK_RANDOM_REPLYTO,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBC3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 20:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6911F21569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 20:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="r5uaxjgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgAWUzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:55:37 -0500
Received: from mail-40132.protonmail.ch ([185.70.40.132]:56264 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAWUzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 15:55:37 -0500
Date:   Thu, 23 Jan 2020 20:55:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1579812935;
        bh=NjNZAbulBMS0bWKFpWF0ikCqauCTCFP1hxEyGcdzFnM=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=r5uaxjghkghLizxUOvBY5kBQkek9N37QWPekKODZybuCouwOIyidlKoo5z5rJbapY
         G52afax7GFZBqc6kyhu7V4o+wdRHUwujZw35SRRfIRWbH18kEy+ZmTZo+bZUyLOYR2
         X+Ikjz8tdaGSx//m7x7nNEfS0Yi9V6Ak8+ilRhn0=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   vcxzasdfvcxz <vcxzasdfvcxz@protonmail.com>
Reply-To: vcxzasdfvcxz <vcxzasdfvcxz@protonmail.com>
Subject: [PATCH] lib/sg_split: remove setting of offset to zero
Message-ID: <m1IikjLBNle_kj-D3TemaGqgAfGudoitlSaWdj_I21hf7jl8mJaCa-cNTuKzI6Cn94BqqCT432c7s-fEy0bfp5311oRPH5Sywj9R3KgnH7A=@protonmail.com>
Feedback-ID: UvlvX3kRdLbprDaDPeDY8WvHE6EpBSYWqfjSreuO7DE2A7sBlhSzgMmZ6eSK5y9uJfaMrV5WIdDDzR8JDS6iDw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By setting offset to zero we are losing where in the page the memory is.

--- a/lib/sg_split.c
+++ b/lib/sg_split.c
@@ -88,8 +88,6 @@ static void sg_split_phys(struct sg_splitter *splitters, =
const int nb_splits)
                        if (!j) {
                                out_sg->offset +=3D split->skip_sg0;
                                out_sg->length -=3D split->skip_sg0;
-                       } else {
-                               out_sg->offset =3D 0;
                        }
                        sg_dma_address(out_sg) =3D 0;
                        sg_dma_len(out_sg) =3D 0;


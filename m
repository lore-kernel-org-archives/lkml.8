Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE90C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D46C120786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHZegl49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbgFSJDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgFSJDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:03:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BA4C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:03:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f185so8409683wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=eqGVTaL7I09fSt8xiiKydMdPTw03g9WyqCugj1c7ZRA=;
        b=WHZegl49L3AkFCgz3WyYZZbEvupHczYEKrdM1x6tWtAezTNUXZBegkTQukvdkW707A
         6dxg9RLez7dkRHPxfd7qtiHLBdxozDGoNK24+x7iXX2VKl1f1RnGpAivJ9JeRJsaniwE
         OZA/7X9gVSsadd5s8rkvYY1MKSNo9N7Lc+sn8D5EMJi6CSECyZ4aLUAY6IrndZDHLQSK
         vsjLCnypQXQ0JN6ABfEk7UPJQXXGQDwq/B+QIJRjEw9jf7+/JZTGS7zPbPRh1xMX4A8J
         3n+p45V3dd/TzpmoWS7qrq/wIYjQ96oWWpgXUTSxv9rVlc8jdTHvADOLSSN5UuJtPlY5
         jHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
         :subject:date:message-id:mime-version:content-transfer-encoding
         :content-language:thread-index;
        bh=eqGVTaL7I09fSt8xiiKydMdPTw03g9WyqCugj1c7ZRA=;
        b=CJSSgoH+6kMAD/dq3JEFIyd4iT6UHComwsGr2d16r+hdPh5SLrb6UD2OEs/aYONA1d
         0ZK9AvIB3HE2z1YsSGTGwwnS+b1ta+5ZSwyve+GJ+2BEUlFhkSCgufnRxJCCHw8jZNFC
         funqZ3QzSV7BNL8w3jHjYLMb8kDLCDP/IPPZjYrRoj/LejFc5pj7UNulx6czAS3GKJeh
         eU+azGlENnxAGL8L3wVJF3TchBfB1BKweXmWnWOxKBQj8kjmSqR3dibhKpf0KkpRhTHv
         Uhg1r/QKY1P6nKlj8505gWgnSIedC3ktNuiy5aCbIQtwZ1TwDjVAA1edyWTSowlJP9OM
         /epA==
X-Gm-Message-State: AOAM531M9McDonKApnFFJO9p4d03FR1Rd8+UArbAO0n1A5LyGnjYYmIy
        v4QM9BsGtKClPi7Gl9ZC05mG186lDrk=
X-Google-Smtp-Source: ABdhPJzuTfHjOBExJd3YwtBUHiqSp3UHmcldRUcFGypgt2huvdymHXtQIIzqnWZVOgUAKmQBDbZxSw==
X-Received: by 2002:a1c:7f87:: with SMTP id a129mr2857945wmd.10.1592557424353;
        Fri, 19 Jun 2020 02:03:44 -0700 (PDT)
Received: from CBGR90WXYV0 ([54.239.6.188])
        by smtp.gmail.com with ESMTPSA id h188sm6418392wmh.2.2020.06.19.02.03.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 02:03:43 -0700 (PDT)
From:   Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
Reply-To: <paul@xen.org>
To:     "'Boris Ostrovsky'" <boris.ostrovsky@oracle.com>,
        "'Souptick Joarder'" <jrdr.linux@gmail.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>
Cc:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        "'John Hubbard'" <jhubbard@nvidia.com>
References: <1592363698-4266-1-git-send-email-jrdr.linux@gmail.com> <d9e8ad0f-f2aa-eea4-5bc7-a802c626ace6@oracle.com>
In-Reply-To: <d9e8ad0f-f2aa-eea4-5bc7-a802c626ace6@oracle.com>
Subject: RE: [RFC PATCH] xen/privcmd: Convert get_user_pages*() to pin_user_pages*()
Date:   Fri, 19 Jun 2020 10:03:42 +0100
Message-ID: <00a901d64618$888e12a0$99aa37e0$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQLNWdkmTQEG0NOkr/mSq3vuIFPj4QGVx8AxpuTONkA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Sent: 17 June 2020 18:57
> To: Souptick Joarder <jrdr.linux@gmail.com>; jgross@suse.com; =
sstabellini@kernel.org
> Cc: xen-devel@lists.xenproject.org; linux-kernel@vger.kernel.org; John =
Hubbard <jhubbard@nvidia.com>;
> paul@xen.org
> Subject: Re: [RFC PATCH] xen/privcmd: Convert get_user_pages*() to =
pin_user_pages*()
>=20
> On 6/16/20 11:14 PM, Souptick Joarder wrote:
> > In 2019, we introduced pin_user_pages*() and now we are converting
> > get_user_pages*() to the new API as appropriate. [1] & [2] could
> > be referred for more information.
> >
> > [1] Documentation/core-api/pin_user_pages.rst
> >
> > [2] "Explicit pinning of user-space pages":
> >         https://lwn.net/Articles/807108/
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > ---
> > Hi,
> >
> > I have compile tested this patch but unable to run-time test,
> > so any testing help is much appriciated.
> >
> > Also have a question, why the existing code is not marking the
> > pages dirty (since it did FOLL_WRITE) ?
>=20
>=20
> Indeed, seems to me it should. Paul?
>=20

Yes, it looks like that was an oversight. The hypercall may well result =
in data being copied back into the buffers so the whole pages array =
should be considered dirty.

  Paul

>=20
> >
> >  drivers/xen/privcmd.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> > index a250d11..543739e 100644
> > --- a/drivers/xen/privcmd.c
> > +++ b/drivers/xen/privcmd.c
> > @@ -594,7 +594,7 @@ static int lock_pages(
> >  		if (requested > nr_pages)
> >  			return -ENOSPC;
> >
> > -		pinned =3D get_user_pages_fast(
> > +		pinned =3D pin_user_pages_fast(
> >  			(unsigned long) kbufs[i].uptr,
> >  			requested, FOLL_WRITE, pages);
> >  		if (pinned < 0)
> > @@ -614,10 +614,7 @@ static void unlock_pages(struct page *pages[], =
unsigned int nr_pages)
> >  	if (!pages)
> >  		return;
> >
> > -	for (i =3D 0; i < nr_pages; i++) {
> > -		if (pages[i])
> > -			put_page(pages[i]);
> > -	}
> > +	unpin_user_pages(pages, nr_pages);
>=20
>=20
> Why are you no longer checking for valid pages?
>=20
>=20
> -boris
>=20
>=20
>=20



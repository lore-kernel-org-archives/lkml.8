Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCBFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 00:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD48A2078D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 00:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgk67Yhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHRAnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 20:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgHRAni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 20:43:38 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85739C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:43:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id bh1so8387706plb.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TReSrtDPzsNq+WoQZwFStfuaHHQOgZIVoWnL5a4Th7A=;
        b=Fgk67YhwLMRQW3PEclQtJ/BxQD4QfDG3ZyTtYkMoeY2jzSjFhh0ZvN5G10t6hM468w
         kKljKAPdfEwlY5qF5WScOREr7dn1jtzM9sDvXi1G6T1xDIhU0gQHP4fkJH9u/AMX6jby
         z9Ch9FWzjRqXtvQRlkRoeHT8smScxQAs3s1op0JpKugovRgbwyQUu9VabF+FgtkygMaC
         Pz4Y12go5Qby5u1+YmkJD9RYDeN2p3Alt5tyZqCSQ6dsolBmL8rS+VIG8NFPijDCdITf
         bRmMNok5fWp3kBJsO9K2sKYp+hXuYom3NIw7Bx4LNYEUqva3iz3Nn2LT199Jt/70Zg6b
         aoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=TReSrtDPzsNq+WoQZwFStfuaHHQOgZIVoWnL5a4Th7A=;
        b=gyz++JImbiYf8MTJ1zH1B+TITiXgYsQFSyv6yADCUTec3G4ZYtqejQ8BgCQ+t5ZrEN
         PWcngSb3SCHlYSwVNkq8VptbMPmPWKxxUlcw44VryEVFdZ7iZSf7TkUKRa8krthb4xGN
         3SJ2qsCa0h3ZMeaoa6EmpdxQ2rTzObkvHQ7z6f5CNgCWkygopqQzfXfd3SgVS7xTPst2
         qXeyshVXR5aikBU4sD4GqYbr11Yb3BuY7tLW8NxsDy9IiHMEd0l8cLOZdzRbXwQvQ19/
         X7jPojfEoyNh651hBkNoxA9uBbvShZcGzDUxMKgfXFSonlo1TtO6G+XWo/dN4uuaLxZN
         USIQ==
X-Gm-Message-State: AOAM530pMgTBz1Mzyv1DbqXZ+J3KUphhlzGclp8kcf3sJhQ4k8arC4Ce
        afn3B/bqEEph8M34B7FNpZyOBFhH4wxvGA==
X-Google-Smtp-Source: ABdhPJzlT3lwufa/CcQlK6X6PBzoL9tCjNwQ93a394Itzyjs7MdRIHGtmEbsRb2MUc7BkNK+8E5HlQ==
X-Received: by 2002:a17:90a:c781:: with SMTP id gn1mr14283296pjb.151.1597711416900;
        Mon, 17 Aug 2020 17:43:36 -0700 (PDT)
Received: from debian (sau-ff5be-or.servercontrol.com.au. [43.250.207.3])
        by smtp.gmail.com with ESMTPSA id e7sm18745786pgn.64.2020.08.17.17.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 17:43:35 -0700 (PDT)
Date:   Tue, 18 Aug 2020 06:13:28 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: .config file attached for your perusal..build stopped... Linux
 5.9-rc1
Message-ID: <20200818004325.GA25134@debian>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <CAHk-=wiwfkKp93C+yLqKWAU0ChBdeBDUhgOk09_=UQ8gOKbV3w@mail.gmail.com>
 <20200816225822.GA3222@debian>
 <CAHk-=wgOaEmFGYhnx7XLe8AbQKYpgMAzyuHuS8dYZoB2hS3C=A@mail.gmail.com>
 <20200817212519.GA11141@debian>
 <CAHk-=whm2fcvovhvtXceNzQGet=hZspqSBRrpoYzwe2ZhX=UNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <CAHk-=whm2fcvovhvtXceNzQGet=hZspqSBRrpoYzwe2ZhX=UNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16:32 Mon 17 Aug 2020, Linus Torvalds wrote:
>On Mon, Aug 17, 2020 at 2:25 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> =
wrote:
>>
>> Thanks, Linus ...I have attached the .config file with this mail for your
>> perusal.
>
>There's something wrong with your setup - like Randy, I cannot
>recreate the problem.
>
>I wonder if you perhaps have some buggy version of ccache installed,
>or something like that, which could mess up the build subtly?
>Corrupted ccache files can result in some really hard-to-debug stuff,
>because what the compiler sees isn't actually what you see when you
>look at the source files...
>
>                 Linus

I take your and Randy's word as it seems plausible. Let me bisect my
setup and see what bad introduced and importantly how it introduced.

Thanks a bunch to both of you!!=20

~Bhaskar=20

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl87JCoACgkQsjqdtxFL
KRXuYwgAxULLMbizxcKcotl08EvfZdnVsIsUG8clwA+P6M3/XN7Pm2KQFsfzaKw2
p2bcQMGDav48oq3lo8JpbkTwoGIPPqrfB3BVdB6vKBImRQbTqCdEIerepGR/HkzY
7KcA0w7fKitzu5wYW9OzU98I96K8M3PQSFod5duaohe4c2n88m0+SR+zxnLbHsAP
6tRqh30fl1vQpXV+OIkdva7dtTHnrark5GNAEgulWnPgmKyh/mhJX31ECtzeqiZA
kmC1ICnFvCngmVKPS23cOYF4CPFYrzSb1m6hMsE+R99Phke/SWuqzNT+HhzBdtLg
nq1XN+iWE5EeYq/JE80PHSYWQ8mhEA==
=9lp9
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

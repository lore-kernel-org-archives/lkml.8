Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40DBC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 22:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF627208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 22:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=platform.sh header.i=@platform.sh header.b="NFLRMtpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgH2Wmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 18:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgH2Wmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 18:42:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABFCC061575
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 15:42:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so2462489wrl.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 15:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platform.sh; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=o6LGzjsM2Kx7EWIT/ZnmgyA5z9nNQFr8nuwU2PjtX78=;
        b=NFLRMtpzctxQqrra1tQNwHIifdCAICA/VWcvhaaLuwuR5Es4wnTFDdDimGg+aMqn2m
         +EXi+kkK02lSw1HHwuV8AP073H7A6gTwUzGPf02GGYRaEzzumi0nO9wTiaJqAUcOwFus
         bVE9hVfCh1vVDBFK1xdtWqLOeSdnnyGMgcsqab2gmLN2d27xidriS5Zfc0SJERVfSqsC
         7VmdlfHdGSLg21add6TCDVLMuyYhqwqjyUzvpF0y+OpnhFZoOkUa2wvjUEDx9fRiQCu9
         7wzBGb6IX8G1PerezYzvDH8JrIQAd9lyvX6eRbBqkuh8eQjVwM2+DyzjWazDZkMQBpM5
         2GAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=o6LGzjsM2Kx7EWIT/ZnmgyA5z9nNQFr8nuwU2PjtX78=;
        b=OWgxwe32MSHEKeANp8/5W5ZmusAqeihIscJ+q/6IP0eZckiroqerusIj0fwdkVuZty
         nRo0wYvQkgoFk2loAch5s6FGfeQOv0LhNTvjuwAOd657pVVQjlfpd0FYkUOhj1p/np/Q
         j2jPtoXKKRbFgSHNusU0Njpi1GWP2orUchj165cqdUnpaP4Hq/lrKbpAW7bk64Ns7lKT
         hFnmN3KtwcBy/+MIBAvgtu7lJYmqEKIp4QG+X9+6CnuhlYEDQVWvwgb+eO8gLRIW9p3h
         iv9bjMr9AkTJSS/lEGo524qv5eUEB1FWlF0MPkqzpnMO/ES8TutChYz4vH5hTseGLha9
         LW0Q==
X-Gm-Message-State: AOAM532Kn9rsosd06gVULlFDSMlcWDhJqMzshxaFqzixTlWNI1BxbBXc
        AfOG/dqD3b58rkuvuLCHv/cxjA==
X-Google-Smtp-Source: ABdhPJxWlzRiCVA2bN1NrXJ1DA/pd10YLUnRJY6KzCx9g0vdz0TPPJhIVEyI1TPqeZ7lXMXxLcmlyg==
X-Received: by 2002:adf:8405:: with SMTP id 5mr5038094wrf.393.1598740969429;
        Sat, 29 Aug 2020 15:42:49 -0700 (PDT)
Received: from localhost ([2a01:cb1c:111:4a00:dec6:dcf6:5621:172d])
        by smtp.gmail.com with ESMTPSA id b204sm5056016wmd.34.2020.08.29.15.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 15:42:48 -0700 (PDT)
From:   Florian Margaine <florian@platform.sh>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: allow do_renameat2() over bind mounts of the same filesystem.
In-Reply-To: <20200829221204.GV14765@casper.infradead.org>
References: <871rjqh5bw.fsf@platform.sh> <20200828213445.GM1236603@ZenIV.linux.org.uk> <87wo1hf8o9.fsf@platform.sh> <20200829221204.GV14765@casper.infradead.org>
Date:   Sun, 30 Aug 2020 00:42:46 +0200
Message-ID: <87tuwlf509.fsf@platform.sh>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Matthew Wilcox <willy@infradead.org> writes:

> On Sat, Aug 29, 2020 at 11:23:34PM +0200, Florian Margaine wrote:
>> Al Viro <viro@zeniv.linux.org.uk> writes:
>>=20
>> > On Fri, Aug 28, 2020 at 10:40:35PM +0200, Florian Margaine wrote:
>> >> There's currently this seemingly unnecessary limitation that rename()
>> >> cannot work over bind mounts of the same filesystem,
>> >
>> > ... is absolutely deliberate - that's how you set a boundary in the
>> > tree, preventing both links and renames across it.
>>=20
>> Sorry, I'm not not sure I understand what you're saying.
>
> Al's saying this is the way an administrator can intentionally prevent
> renames.

Ah, ok. Thanks!

>
>>     /*
>>      * FICLONE/FICLONERANGE ioctls enforce that src and dest files are on
>>      * the same mount. Practically, they only need to be on the same file
>>      * system.
>>      */
>>     if (file_inode(file_in)->i_sb !=3D file_inode(file_out)->i_sb)
>>         return -EXDEV;
>
> clone doesn't change the contents of a file, merely how they're laid out
> on storage.  There's no particular reason for an administrator to
> prohibit clone across mount points.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEWcDV2nrrM20UJL9WhD9tdT2UlyoFAl9K2eYACgkQhD9tdT2U
lypGfgf/VElsI3XDE1+tOfSPlOivtjeal1u7UDE1z0r2z2wdlsfiFvI7cymiXmZw
dRgcJPHcg8yQaid0MPJA33av5SwOPQCZHNa5lw+lwvEILimwQWmSwz8cwVj5z3Bh
kn3231nTBMwmMlD4Cru/Mzf1tPPj6Qevdn3WJZAZMi9Kl7HzYpChiOYGJsRIuqKa
WiYdiDOMmM+sQ2h7uZuXRxdqfmJrsgQXDOPaguzQH3S6TktG3IP1T714xRLDslsk
StOzENw5FO8+v8zrjXEl/R2dcQPGSZxRZnpU9E2IpTJKXnWFUJmr5YWf7JzydRkS
W0IxTH1xoAaQKJ/2W8ojOi6AGSFTig==
=zWV3
-----END PGP SIGNATURE-----
--=-=-=--

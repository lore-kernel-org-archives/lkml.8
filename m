Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AD7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 17:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4AB2077D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 17:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590858622;
	bh=lsHZJ4aM7/Tm9SU5mk9P2gzSU7rcFDFX2zU0qgLzpFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tWnTTPgsewSj6odZE0sBsY79USy4iUqgHKmKSrk4QHK72Xp+9VQKEU2rv1qcWk3he
	 Qx7EYBpreouYEMxCSKgJWcxwt+Ft7H1AYVx/5jHcMNiXiMleWhIAQwVr1Im6HKns2t
	 pqnAQfTh22jgXQdWKuJulqs+Vg+gxpB76aCvry78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgE3RKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 13:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3RKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 13:10:20 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0547C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 10:10:20 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id v15so2588684qvr.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lsHZJ4aM7/Tm9SU5mk9P2gzSU7rcFDFX2zU0qgLzpFE=;
        b=UwbZKLxr31Dwda9wNpGfDmxL3kwCqNEXls784Bf4BURnpKSjNiH0u2pdokgjg8gWtF
         S+UFnNpK/eWD7ugG9upw6BA5gmKlIj5aTlb4xNJPUso8uE9zEkqVsMGLua3cgsQRYJYu
         NF8T6H4nBvJoUWLSSH4DteXy7fhf6SQ2DtwG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lsHZJ4aM7/Tm9SU5mk9P2gzSU7rcFDFX2zU0qgLzpFE=;
        b=ECRXxWquP5/eJ1NUR7UEtm2ZlW3+06/hulzRksx8OD8eBxk8B7ZKFYjphoNbw354Dy
         YaP1+JX9u842/RNzAnoAR5g4Klian+N9ChlLvUBAC+Rh7Yy6In71a3+foVcol23lSa33
         bTQqahkoctNaKiaqKpHgeYYQSpfa9wa2UgiI2p74PmysOHy4eMN2Vz1vEEYygQdDvyeH
         ckKp/WpGG+nATvtxC8YmsEddkhtXZwZvTKZ6Lvfl3LEcAR9XzzJ9oJlUueQJmqPjD17g
         ABywkYyu034nhhh5F5p1BTwvXUp4KHWO6LJ7yX29jAoDQgT68Nc3oa+tcHWb7G4vcAAA
         c9FA==
X-Gm-Message-State: AOAM533KzKzumE+xhSEx4jz/cJHAaZ78mvJKNADhYLSEof67ScgN2in7
        TGiPJFEbp7Q/ls9cQKSMJLkFCI2JsUkYIpEUCFXRfX1jJV8=
X-Google-Smtp-Source: ABdhPJwHfAqlBzW0Zyv3GBpXD0Gs9oGKERBwa27do0d2ZeT0fVS+64UCEpna5npgJIc+uH5uKr7lrH/2D/U00t1j4TA=
X-Received: by 2002:a0c:c605:: with SMTP id v5mr13981068qvi.102.1590858618737;
 Sat, 30 May 2020 10:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <7d5a91f3-e5bd-8410-487d-5cbcd23b174b@gmx.de> <8a425b75-cfc7-17b4-3991-63945a855715@gmx.de>
 <20200530161612.3rz42y5yyulitsdl@chatter.i7.local>
In-Reply-To: <20200530161612.3rz42y5yyulitsdl@chatter.i7.local>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Sat, 30 May 2020 13:10:06 -0400
Message-ID: <CAMwyc-TfqyLZtamqN5ELr-hceySwWZ4TPMYJLtDRPHSuGKmbMQ@mail.gmail.com>
Subject: Re: fatal: unable to access 'https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/':
 SSL certificate problem: certificate has expired
To:     =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 May 2020 at 12:16, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> > > $ curl https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> > > curl: (60) SSL certificate problem: certificate has expired
> > > More details here: https://curl.haxx.se/docs/sslcerts.html
> > >
> > > curl failed to verify the legitimacy of the server and therefore could not
> > > establish a secure connection to it. To learn more about this situation and
> > > how to fix it, please visit the web page mentioned above.
> > >
> >
> > Well, the cert is expired: "notAfter=May 30 10:48:38 2020 GMT"
>
> It's one of the intermediaries. We're replacing that cert right now.

The bad intermediate cert is gone now, so you shouldn't see this
problem any more (and the fact that you were seeing it in the first
place suggests that you should update your openssl library, see
https://calnetweb.berkeley.edu/calnet-technologists/incommon-sectigo-certificate-service/addtrust-external-root-expiration-may-2020).

-K

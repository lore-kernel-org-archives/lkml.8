Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDCBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 122E8214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="KYVTXVXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388372AbgFXBDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388117AbgFXBDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:03:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962B6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:03:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id cy7so220448edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eo5cTIL37FpYiHosBDpvR4kZAwB7mWQXF34HqE6NXHo=;
        b=KYVTXVXkCqMbcVuFTDEDKDF/vl50d6y6AVcDR3VWHAdVtg0rVF+rufFQ1wEqaxVJxh
         SIb5YPrtFiiuP3U/USOvpvsCngwFcKcauttqEoZunWAugH4tljXQUnJSNiIjDNlSZE/Y
         8vINYeh9lbMfW+YemTuHtIAKi4Sl9PXz4gZiOGRJUuGUwoyGoQmUiLV5cCSbIz4EaasJ
         92s42xO9NEEqZm68/Q83e/Ak5uUYC6GXyyuUfu/VrtqYiplckhU03c0Vgvov8YbQnCav
         /XiD58yFRrnMH13HCsgJrnDk0K6+OaiL+fWCrT5lEA0dPZE6YPGCpL2dE8+4ZxvV249D
         1a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eo5cTIL37FpYiHosBDpvR4kZAwB7mWQXF34HqE6NXHo=;
        b=OTSNUrO5s9pg+DAmlhD+m/Tn9BiuTfT7khH9+8fGxePBu9aj/RvffN4KiOyMa7QXhW
         S65VRBwfxVSKSnmiyj48tS9ANRcpRRymT/4682FWF+5U5dP7kONHGSU6k4mqBuCJGcw9
         1sBcBu4wGMP+A1axQSCexG8vNc1fTnobGOnvoj4lTy78Zv7Zmk4m84YwdCYGrHL170lS
         YmyRNjlgt0p8hB2+aMRJfOZsZVE5lFy3UQNv4a3AiLZlgS1hlL1+CRRjHwxKKNfDImRv
         7HSobFE79oUUAFu+eDnyFuHZum2Kru/fG3+8YHRDdyoWaC4XpROYRIiIMpeGMEhANGQ0
         zMsA==
X-Gm-Message-State: AOAM530FFlh2QD5bp3LWxblv7NdJEOnpovuOok/ETR3PGYQQCijnJwE0
        Lf8aimrNWV2eEUOsvWhgBw6q0cLzqcempoFAd2KHGA==
X-Google-Smtp-Source: ABdhPJwgEGyrPH+KoGgpyagYhDQWzp/X9Fcbf8BzrxMJ5Voz+JAHTmCCV7B6TldsquEEpVkTerwdy9arRqf3hvl6HiY=
X-Received: by 2002:a50:d9cb:: with SMTP id x11mr9688647edj.93.1592960627165;
 Tue, 23 Jun 2020 18:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <1503686.1591113304@warthog.procyon.org.uk> <23219b787ed1c20a63017ab53839a0d1c794ec53.camel@intel.com>
 <CAPcyv4g+T+GK4yVJs8bTT1q90SFDpFYUSL9Pk_u8WZROhREPkw@mail.gmail.com> <3015561.1592960116@warthog.procyon.org.uk>
In-Reply-To: <3015561.1592960116@warthog.procyon.org.uk>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Jun 2020 18:03:36 -0700
Message-ID: <CAPcyv4gdB6iOD8N0KAHY9WybpJtRx3EfEQCSM1zuTDkURrfuug@mail.gmail.com>
Subject: Re: [GIT PULL] General notification queue and key notifications
To:     David Howells <dhowells@redhat.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "raven@themaw.net" <raven@themaw.net>,
        "kzak@redhat.com" <kzak@redhat.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "dray@redhat.com" <dray@redhat.com>,
        "swhiteho@redhat.com" <swhiteho@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "jlayton@redhat.com" <jlayton@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "andres@anarazel.de" <andres@anarazel.de>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 5:55 PM David Howells <dhowells@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > > This commit:
> > >
> > > >       keys: Make the KEY_NEED_* perms an enum rather than a mask
> > >
> > > ...upstream as:
> > >
> > >     8c0637e950d6 keys: Make the KEY_NEED_* perms an enum rather than a mask
> > >
> > > ...triggers a regression in the libnvdimm unit test that exercises the
> > > encrypted keys used to store nvdimm passphrases. It results in the
> > > below warning.
> >
> > This regression is still present in tip of tree. David, have you had a
> > chance to take a look?
>
> nvdimm_lookup_user_key() needs to indicate to lookup_user_key() what it wants
> the key for so that the appropriate security checks can take place in SELinux
> and Smack.  Note that I have a patch in the works that changes this still
> further.
>
> Does setting the third argument of lookup_user_key() to KEY_NEED_SEARCH work
> for you?

It does, thanks.

Shall I wait for your further reworks to fix this for v5.8, or is that
v5.9 material?

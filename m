Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67E0C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907C920409
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oaL3YTt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgCILxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:53:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38353 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCILxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:53:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id n2so2765232wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A+8e1ZJvLxFvMv1z1RgLvbeZ9xImIdjD3uf9/zDP4HQ=;
        b=oaL3YTt4xI7Y5XHj5qLl3V2HPwybW5fnx9ISn59T54mho8oRaOdecnADmdEO/5MlED
         n/eiDObVT6osUEtWowhpIsOonWANHc0ZuaxiHl/Pbo42elEUr0uOiZe0EX7qVqnHlffo
         wvnX687QUdArrst4oIkJMG4TEnjlV/cvlpuoXf8VRw2ADfSo9VBAkPvfHNWOWDWQmL4P
         axyqJ4FWW3/UIjwHQEh6j4Qh90PQfmz7JOXBygX2tDuhWy7bDwISA5Spir104SpXybPG
         ZXC/seO2SuwdS9pTlPODArs+7mHWzXNE4aatJJN50QxS4as9RmUyho6hu0Auusuu8g+s
         KGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A+8e1ZJvLxFvMv1z1RgLvbeZ9xImIdjD3uf9/zDP4HQ=;
        b=d7ktdkFie6Tw8tuGtp1D4tEAQR/s1ZIC6WIL7Zfol2+S+cXsYnuwrnXakbWm16/0kX
         nNjCiPvySkIui2eutVaPCQqb0dueKV7NNdpmT92tMZ9l3rkErHzVDdUKHVx1aM9JCYNp
         6vedf6SKGA8MRMamXSlqw5hMFcxeYbtlkCkZxmBdRaZxIy7biNlnaIfdfRNL7nm5oGsU
         fCk80ktklpplndN68P5XJ1faQmipBKvDT3DF7AYb88dyfatgz7jWdpXbWQPYkaTJkq7y
         PnSXk1/AmLJkL8Phx9B3ETI13ZrVFVG+4ff0jVzhM0VaC9UghPAm6WdLhdVcTslPtZay
         W/Zg==
X-Gm-Message-State: ANhLgQ3E5b0kFnC3Aguj5WgJjjVn6CLTW08tLnnnQ7LtvQOzYVW4rY6L
        rt2V5nG7SNmPGcQLmHDPg/rkLxl7l3KCnbi5bZjObw==
X-Google-Smtp-Source: ADFU+vsvzlW7OSvkTeLOzgfo58rs5LGHa8FxbgTgp+IGRG22sPK0JWBxQHkRb8/ZvjA/96kJZL/SSEMlEcv3yr6IoXA=
X-Received: by 2002:a1c:9a41:: with SMTP id c62mr85973wme.37.1583754819857;
 Mon, 09 Mar 2020 04:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000938a57059f7cafe4@google.com> <20200307235437.GW15444@sol.localdomain>
 <20200308032434.GX15444@sol.localdomain>
In-Reply-To: <20200308032434.GX15444@sol.localdomain>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 9 Mar 2020 12:53:28 +0100
Message-ID: <CAG_fn=X8UkYx5=3ARUtW3+asc+3tEdeBg=1NKS9VzChSCp33Yg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in snapshot_compat_ioctl
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+af962bf9e7e27bccd025@syzkaller.appspotmail.com>,
        len.brown@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Looks like a KMSAN false positive?  As far as I can tell, the memory is=
 being
> > initialized by put_user() called under set_fs(KERNEL_DS).

Why? put_user() doesn't write to kernel memory, instead it copies a
value to the userspace.
That's why KMSAN performs kmsan_check_memory() on it.
It would actually be better if KMSAN printed an kernel-infoleak warning ins=
tead.

> Although, it also looks like the problematic code can just be removed, si=
nce
> always sizeof(compat_loff_t) =3D=3D sizeof(loff_t).  I'll send a patch to=
 do that...

Thanks!

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

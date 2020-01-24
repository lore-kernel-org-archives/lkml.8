Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE67C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E65D2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MbSSmh/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgAXBOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:14:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46502 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbgAXBOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 20:14:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id z124so128346pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 17:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=T82lPMEeT7UM1SWn0FhLOjESE0GLh63PpQBQKHkcM/U=;
        b=MbSSmh/lic8KUfE07R67FX2QAJtIkI14qXp9FWG/j4lSTzmAUaGQXQb95OAbeRFqsb
         z2HTcJtLAy8esVRWtINgYbUvMpgtnPox/Fv4s0FVufYtXQ4QQRLWIR0FX9dHZyYpbWHh
         ptojOQIZ2A+RmE/ZZGqJH8K1OEOuaMRFKv15s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=T82lPMEeT7UM1SWn0FhLOjESE0GLh63PpQBQKHkcM/U=;
        b=ritNt35lHTd2LjND/wL7DaxZVCA2/y4rMBUxQoUpkhqRQIi6d6wuMyToMIDJlHUap2
         w4vfn9zkZ0+NqjykYctxDMo3QIxWAb/efGnCYc4ApYid5AuShYxZCeiMR5kV6jb3kCLY
         KwAe1BZJkz4UjYPYZvak8Xho0EIStnh2Rz9Lxtrq1GE+qcRfxIEM+Zhfb03kDPyr7NgG
         SM3eF+GdljZSD9MX6rUo9MOT25OPrJy/mWNkVt8cmnrevK4l5VJAM7jTOgYJCSigVwAd
         TrMvFEt4nitHg1smY0dSDIxxX4fUh/89E7BOKLXHA6owKT/zzS+JCd/3ngdMdghqvHi6
         s9Ig==
X-Gm-Message-State: APjAAAWxnSBFZrXxbMcmSKfXFtqZEKyjDxAPalwtorEga4zYuHpKILuB
        1rLNCf/T5+yVZHmtBzSNaIcHlNcTx6Zgng==
X-Google-Smtp-Source: APXvYqzSMBnQqgFVgtw7ueNw6ZeVN160Ho+VGAV5wyHMHsIYvsZuldR5IhSBpdWrkujJeCSG9a9upA==
X-Received: by 2002:a63:ed48:: with SMTP id m8mr1219573pgk.399.1579828445253;
        Thu, 23 Jan 2020 17:14:05 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u127sm3902459pfc.95.2020.01.23.17.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 17:14:04 -0800 (PST)
Message-ID: <5e2a44dc.1c69fb81.bf89.a6e7@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87lfpx1x72.fsf@nanos.tec.linutronix.de>
References: <20200121194811.145644-1-swboyd@chromium.org> <20200121194811.145644-4-swboyd@chromium.org> <87lfpx1x72.fsf@nanos.tec.linutronix.de>
Subject: Re: [PATCH v2 3/3] alarmtimer: Always export alarmtimer_get_rtcdev() and update docs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
User-Agent: alot/0.8.1
Date:   Thu, 23 Jan 2020 17:14:03 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thomas Gleixner (2020-01-23 17:04:49)
> Stephen Boyd <swboyd@chromium.org> writes:
> > The export isn't there for the stubbed version of
> > alarmtimer_get_rtcdev(), so move the export outside of the ifdef. And
> > rtcdev isn't used outside of this ifdef so we don't need to redefine it
> > as NULL.
>=20
> This does not make any sense. Why would we export a trivial stub which
> just returns NULL?
>=20
> The right thing to do is to make that an inline function in the relevant
> header file.

Ok. Will do.

>=20
> > @@ -67,8 +67,6 @@ static DEFINE_SPINLOCK(rtcdev_lock);
> >   * alarmtimer_get_rtcdev - Return selected rtcdevice
> >   *
> >   * This function returns the rtc device to use for wakealarms.
> > - * If one has not already been chosen, it checks to see if a
> > - * functional rtc device is available.
>=20
> Unrelated comment change which is not explained in the changelog. Please
> make that a separate patch as it has absolutely nothing to do with the
> stub function issue.
>=20

Fair enough. I only mentioned it with one word in the subject, 'docs'.
Sorry about that.


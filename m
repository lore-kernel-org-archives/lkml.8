Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA26FC3404E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C355221D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VITCrzzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgBSHzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:55:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21540 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726569AbgBSHzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582098904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i1mLBd9LWHB+KH9pfrmfXQPkFdMyiuEf6cTfBeditaA=;
        b=VITCrzzh4zioa0s73dEgfHRDsVtEc3q+3Uy+FsIfj5EEeL3ppkZnNQQRzJklzvBLop7G7R
        Gz1RtoeuSppyrKe1JbbAu4DKoevQyicb9AlcnU8eoK7tzDZfwtqJIFc+AKjjmMSe7UaRYp
        WDaRg8OjGqmjYLFd0azn76Y2flQ+GtY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-9ce3ydFnPF2vm2tMxDo_Fw-1; Wed, 19 Feb 2020 02:54:58 -0500
X-MC-Unique: 9ce3ydFnPF2vm2tMxDo_Fw-1
Received: by mail-qv1-f71.google.com with SMTP id v3so14124310qvm.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 23:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1mLBd9LWHB+KH9pfrmfXQPkFdMyiuEf6cTfBeditaA=;
        b=VVpfanczBZu89olDLK+rcrpLrFK6WhkBLqwfFH6507hDU2X4fsPsiR0DVIWexVrZyy
         0g32hOaNnIngPK4rVJ4J6XCATgB469GvMhWMk+Br8CSwFhRqInXELvHkFQa/G10oXhwD
         4/laowCcLpTKDHjJw4W/Z2rOckEuZs0v5cCFflMVo9k/S4ZEKcKjew8+MaOfbsEtflAj
         RE/qN82ZHNm3mc1u+u0e2QAnpPQjPuZTyhsmZ7o4WgbA/TtwnFMHpvviItvo+DsAbXVi
         PwLnZixKpt1Eqsm6U27PAulLnkWFQGGYSsEkENF4oTBBi/iguQPQchmOUIs29bTjbCGM
         b1Mg==
X-Gm-Message-State: APjAAAWm2mUxCpz937xLkBOihp13uneDWIKSgcCYtr27KsUGNPmVB8mL
        0/lAutobCU/eg2SxewYCvai+cadYJymBqJznOprdPFUFn01X9cNOxf3tvm2Ff/4vodzfdCjYGtt
        qQm/FCyjJdL6feeWq0KIDDXE4XTJl3k4V7gv9MjZz
X-Received: by 2002:a05:620a:1366:: with SMTP id d6mr22176817qkl.230.1582098898544;
        Tue, 18 Feb 2020 23:54:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqy7039fN0rfpeY5AjhVmdUWeucyK4eyLBE67zRJtzyKFxN2zW/8mz/0vFANt1B8IQuhcyFS3m7H5RyH3TSFiQw=
X-Received: by 2002:a05:620a:1366:: with SMTP id d6mr22176812qkl.230.1582098898293;
 Tue, 18 Feb 2020 23:54:58 -0800 (PST)
MIME-Version: 1.0
References: <ae5eee33-9dfc-0609-1bf8-33fd773b9bd5@hanno.de>
 <CAO-hwJJ1sc_RAh4ytWSOmRqfVESi2dvB_Ao_Vn+6XXixxVyxrA@mail.gmail.com> <74d73ebc-0cff-768d-00b7-57bb9b44124f@hanno.de>
In-Reply-To: <74d73ebc-0cff-768d-00b7-57bb9b44124f@hanno.de>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 19 Feb 2020 08:54:47 +0100
Message-ID: <CAO-hwJL8cSJqG4TB6ZJiqoWr0RhV0zhMNK3qVwS6i9FmK7RCRA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] HID: hid-bigbenff: fixing three crash bugs in a
 gamepad driver
To:     Hanno Zulla <kontakt@hanno.de>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 12:44 PM Hanno Zulla <kontakt@hanno.de> wrote:
>
> Hi Benjamin,
>
> > I think the patches are correct (have you tested them with actual HW?).
>
> Yes, I did, and am also properly embarrassed that I didn't notice the
> double free bug in the original driver.
>
> > However, checkpatch complains that the From and Signed-off-by email
> > differ. Can you send a v2 with a fix for that?
>
> Here it is.
>

Thanks for the quick respin.

Not sure what happened, but the commit title was duplicated in all of
the commits.

Anyway, not a big deal, fixed and pushed to for-5.6/upstream-fixes

Cheers,
Benjamin

> Thanks,
>
> Hanno
>


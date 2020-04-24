Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB1DC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E12120774
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQk04QLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgDXQp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:45:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53927 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgDXQp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587746756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yy09tY/ZZlbYrJqIsbNBUE6nQ0igHKGYuqH3QoYuWS0=;
        b=AQk04QLXtwB8YJuq4FO/x6/NODIkGp/nC4oyditqkaWvdB8EPTnVj7C5Hzlc/B0cGdipeZ
        VV2Q2M+JGGkJYqk+oSyJntYsnGAP2nSX4eMfwxqIXy+e2/FsN+CfDKqEmL6WOkxgSQ9NrK
        vYPXMB+UM905sGyNxsF6TkWyK9qrDE8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-S5BMse8CPXiqoy_vRMHhWQ-1; Fri, 24 Apr 2020 12:45:52 -0400
X-MC-Unique: S5BMse8CPXiqoy_vRMHhWQ-1
Received: by mail-lj1-f197.google.com with SMTP id o21so2020281ljp.17
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Yy09tY/ZZlbYrJqIsbNBUE6nQ0igHKGYuqH3QoYuWS0=;
        b=Xkg4fVBHigceYV7SH+jEBzObyou9KCWk+DpGnIeG8oZivd3cinI8ZKsJeFmND1xkNr
         uag8AuKrrljGfg8FEAQ+9/MY4Ast1XnpO9NxeJL8IaDtAF8tWffKrBCB2tPjE1EzD8X/
         eLG9FgFt5mTTTbzN7BeHCAogvCU3gfmuyKXanDr98hYu9JfMgcqHzbuS9EQtfvmMjq5z
         j1vGqKlGOMpAFoZl8OXd21/us8aUsCKwdEuBlVyzu6I5ZsNVEah4E5DdLkpfd9/JDaNa
         E6zYu1I3lJJU6u7EXqCJBxiCPK/D8Nq5w4RjLHGp6zgJRMOZFzUXcAhQ2e9jb96niP0l
         NbLg==
X-Gm-Message-State: AGi0PubfiDmWSVHsrSAUwI+Fd7zK18DQflFW6+87+wIvWeUCGzzcqrpn
        sFukG+HjkBMlnMTWXGGT00KsGskW7cmew2FBPvejBNYZFIpcJZYAKlOdkmJjH6/F+eeT/fgeP8Q
        D4Ix6XfP7auHp053y4RAwFoXI
X-Received: by 2002:a19:d3:: with SMTP id 202mr6769754lfa.24.1587746750885;
        Fri, 24 Apr 2020 09:45:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypIvCEQLkcrKSAwJCFZgQzfgjqKywU4JSqlCnHWOvJ3JNUix5g6gKJnloODQXFxA2oPJy9aVUQ==
X-Received: by 2002:a19:d3:: with SMTP id 202mr6769739lfa.24.1587746750602;
        Fri, 24 Apr 2020 09:45:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v7sm4735362lfq.55.2020.04.24.09.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 09:45:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 09AA61814FF; Fri, 24 Apr 2020 18:45:48 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Pravin B Shelar <pshelar@ovn.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        netdev <netdev@vger.kernel.org>, dev@openvswitch.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: openvswitch: use do_div() for 64-by-32 divisions:
In-Reply-To: <CAMuHMdWVmP04cXEgAkOc9Qdb2Y2xjGd1YEOcMt7ehE70ZwdqjQ@mail.gmail.com>
References: <20200424121051.5056-1-geert@linux-m68k.org> <d2c14a2d-4e7b-d36a-be90-e987b1ea6183@gmail.com> <CAMuHMdWVmP04cXEgAkOc9Qdb2Y2xjGd1YEOcMt7ehE70ZwdqjQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Apr 2020 18:45:47 +0200
Message-ID: <87ftcs3k90.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Eric,
>
> On Fri, Apr 24, 2020 at 5:05 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>> On 4/24/20 5:10 AM, Geert Uytterhoeven wrote:
>> > On 32-bit architectures (e.g. m68k):
>> >
>> >     ERROR: modpost: "__udivdi3" [net/openvswitch/openvswitch.ko] undefined!
>> >     ERROR: modpost: "__divdi3" [net/openvswitch/openvswitch.ko] undefined!
>> >
>> > Fixes: e57358873bb5d6ca ("net: openvswitch: use u64 for meter bucket")
>> > Reported-by: noreply@ellerman.id.au
>> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> > ---
>> >  net/openvswitch/meter.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/net/openvswitch/meter.c b/net/openvswitch/meter.c
>> > index 915f31123f235c03..3498a5ab092ab2b8 100644
>> > --- a/net/openvswitch/meter.c
>> > +++ b/net/openvswitch/meter.c
>> > @@ -393,7 +393,7 @@ static struct dp_meter *dp_meter_create(struct nlattr **a)
>> >                * Start with a full bucket.
>> >                */
>> >               band->bucket = (band->burst_size + band->rate) * 1000ULL;
>> > -             band_max_delta_t = band->bucket / band->rate;
>> > +             band_max_delta_t = do_div(band->bucket, band->rate);
>> >               if (band_max_delta_t > meter->max_delta_t)
>> >                       meter->max_delta_t = band_max_delta_t;
>> >               band++;
>> >
>>
>> This is fascinating... Have you tested this patch ?
>
> Sorry, I should have said this is compile-tested only.
>
>> Please double check what do_div() return value is supposed to be !
>
> I do not have any openvswitch setups, let alone on the poor m68k box.

I think what Eric is referring to is this, from the documentation of
do_div:

 * do_div - returns 2 values: calculate remainder and update new dividend
 * @n: uint64_t dividend (will be updated)
 * @base: uint32_t divisor
 *
 * Summary:
 * ``uint32_t remainder = n % base;``
 * ``n = n / base;``
 *
 * Return: (uint32_t)remainder


Specifically that last part :)

-Toke


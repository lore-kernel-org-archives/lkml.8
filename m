Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7D8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548F2206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF8gv1FE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgCMQWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:22:49 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:55463 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgCMQWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:22:47 -0400
Received: by mail-wm1-f51.google.com with SMTP id 6so10647718wmi.5;
        Fri, 13 Mar 2020 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hyBmDCgZ8uYUx/tXy78bJ2J5Y1NhGOC7ce7yPgKrfvI=;
        b=GF8gv1FEwooSfzQKpStBbtBOdSqazE2H9nslRPWKIRHQGSfQJDjwZ+a9u28tCxukUR
         xA5Al4QanP8WDDY5hBBjHCgirulfY7CvDsOAvLf+/Yku72bcSjS0yauOP5BLh+6DHaMc
         VQ4BBrJ5K7JWGGigNmfR6StuPI+NZ0T9FT2vZOz4lTpgqfW1xD5QXoNU8xlG1yDitsVm
         ngJdofvxs5zJHiTeHVSabmzk/rqdNuxgFxT7CP2teeCzwdbZSrfvIAxbOsoJggudLpgd
         IlhsfBcg+NfEmF20KgdPxN1Is0x+CNWQlcX+zNeMznHdJ3wrJdBW8fFK3Qpc2+1Vh6F4
         vfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hyBmDCgZ8uYUx/tXy78bJ2J5Y1NhGOC7ce7yPgKrfvI=;
        b=Gig1NMrost3ZJ0ubidpx7WZssHVRt/Mkabzhzo/KHV0Fy97aumQWdpdpBtc2LjMdlL
         aKqPRinXZPgxRl47h5MQM3aCA73C1QH51Xaagtm7FXQZmh5RPf6Oc7L8z0xqYOTxNEis
         Pjv86FWfFq5HfmVlJRRBvw2xvsEDH1OBbIL/O7oUN+3wdF/CSPP+J8AxTUIWhB55olCQ
         b5vRkbDmmKRQZxTVYoOOlu8yU1aBoXO94K6zdjjjc+8dfBVQKokN0H7NrAEjbxh9w2vc
         GLelrt2M/mGxfWi2giRhekBDpbfjhLBCCnX/1pLDdCgk/rKiDDd+A9DdFyLIMVH+2uqA
         ARmw==
X-Gm-Message-State: ANhLgQ1QwfyjVQktUhVTswUR4axu4WAuLQNeVGGE94TprxPCjKaPssIO
        EmWkB+mgicOmtnXD/TlDxcCNOzr/ZVWYLsV2IaljKO7mnL8=
X-Google-Smtp-Source: ADFU+vupxXWENSjqJudpb5FD1DcWZ65empCX4DOEyWuUXvChPHF/jZGByQes5gjjwlHItme0TP5nbZEtkAKJe73w6hY=
X-Received: by 2002:a1c:7209:: with SMTP id n9mr11457309wmc.188.1584116565313;
 Fri, 13 Mar 2020 09:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <b623f4a2-8b9b-edd9-3546-281155d90d4a@yandex.ru>
In-Reply-To: <b623f4a2-8b9b-edd9-3546-281155d90d4a@yandex.ru>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Fri, 13 Mar 2020 09:22:33 -0700
Message-ID: <CAKi4VAK6_vNdh3JYV11TwCDAFCBozaHhUQ-vVWj-hr63B=80HQ@mail.gmail.com>
Subject: Re: [RFE] Who's using a module?
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Jessica +Steve +lkml

On Wed, Mar 11, 2020 at 6:33 AM Konstantin Kharlamov <hi-angel@yandex.ru> w=
rote:
>
> Once in a while there's a need to remove a module (for example because yo=
u rebuilt it, or to reload it with different parameters, or whatever=E2=80=
=A6). And then doing `rmmod modulename` and `modprobe -r modulename` gives:
>
>         rmmod: ERROR: Module modulename is in use
>
> If you're lucky, firing up `lsmod | grep modulename` will get you offende=
rs inside "used by" column. But often there's nothing except the count abov=
e zero. It is very easy to reproduce if you check `lsmod` output for your g=
raphics driver. I checked it on `i915` and `amdgpu`: when graphics session =
is opened you can't remove it and `lsmod` doesn't show who's using it.
>
> There's very popular and old question on SO=C2=B9 that at the moment has =
over 55k views, and the only answer that seem to work for people is insanel=
y big and convoluted; it is using a custom kernel driver and kernel tracing=
 capabilities. I guess this amount of research means: no, currently there's=
 no easy way to get who's using a module.
>
> It would be amazing if kernel has capability to figure out who's using a =
module.

Yeah, right now this would need some work on the kernel side to record
the callers of try_module_get()/__module_get()... usually done e.g on
fops-like structs in a owner field.
The only thing we have there right now is the trace. The trace is not
so bad since it can be added in the kernel command line, but would
usually only be enabled while debugging.

For implementing such a feature I think we would need to add/remove
module owner into the mod struct whenever we have a _get()/_put().
Maybe it's worth it, but it doesn't
come without overhead. I'd like to hear what other people think.

Thanks
Lucas De Marchi


>
> 1: https://stackoverflow.com/questions/448999/is-there-a-way-to-figure-ou=
t-what-is-using-a-linux-kernel-module
>
> P.S.: please, add me to CC when replying, I'm not subscribed to the list.



--
Lucas De Marchi

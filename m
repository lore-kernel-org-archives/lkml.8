Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E58C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 699FF2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587585777;
	bh=vezgGE0FULlzWHW/sVKFB+SlsPkANQPPADxxqiakO3s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xCq75es5Q1tbNmfgglIiuG4erIuANiUoTj5M7NENLm9j+/aYigkuTHTBQAqoKA/KC
	 LU+JWN1gtJzXjxcqeGJ2xjisYvLtkK81506gt1s8x4LjQlK2nfCTKfmRKvzlf7+4jx
	 d0dTtoaAQk+PF7+T/eb0kvt96MLTueJUNJ8SznJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgDVUC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgDVUC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:02:56 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B4252075A;
        Wed, 22 Apr 2020 20:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587585775;
        bh=vezgGE0FULlzWHW/sVKFB+SlsPkANQPPADxxqiakO3s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Unghrin/L/i+H9af2BbSk1N70pX8seQPK9PJ0vkG6gJcuO6HE4qI4R39XQUmJISHL
         /SRaILbHxISbOfXhwj6Kg2hP+DTvduzPcJxcYHWmrSGc6wMaH+jjxILiINHxrlTSMz
         0H947HdAi75l3OcMojxM8TDyleDIVpkNaLyfRJc8=
Received: by mail-qv1-f52.google.com with SMTP id q2so1615208qvd.1;
        Wed, 22 Apr 2020 13:02:55 -0700 (PDT)
X-Gm-Message-State: AGi0PuYNO6wNLnDwUCrXSz6FymiVTpquJ+84Fz9Capt09gVTZqsAu+NJ
        7SWsu0urS4UqmttIdUEIrSkaeUtV12FHUZ7uXA==
X-Google-Smtp-Source: APiQypIdkXIj8AYOGffsEU3wU7ezGyaQvy4h94PQe9bmu3rIrvrj6rOjlRmAveKIGi/dWjS5sAWPpglXbVJ0fdT7dzQ=
X-Received: by 2002:a05:6214:a8a:: with SMTP id ev10mr709719qvb.20.1587585774524;
 Wed, 22 Apr 2020 13:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <87d082jtfn.fsf@collabora.com> <20200420175909.GA5810@ravnborg.org>
In-Reply-To: <20200420175909.GA5810@ravnborg.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 22 Apr 2020 15:02:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJXa8QxQmLfkCO8_SSsgYm2nTFW1J6wx4bGbZgAy8Sxog@mail.gmail.com>
Message-ID: <CAL_JsqJXa8QxQmLfkCO8_SSsgYm2nTFW1J6wx4bGbZgAy8Sxog@mail.gmail.com>
Subject: Re: Rule for bridge yaml dt binding maintainers?
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 12:59 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Adrian
>
> On Mon, Apr 20, 2020 at 02:19:24PM +0300, Adrian Ratiu wrote:
> > Hello,
> >
> > I got confused while doing the txt -> yaml conversion at [1] and it's still
> > not clear to me who should be added in the "maintainers" field.  Clearly not
> > the maintainers as returned by get_maintainer.pl. :)
> >
> > Rob mentioned that "owners" should be manintainers but I also have trouble
> > picking the persons who should be owners / yaml maintainers.
> >
> > Looking at the completed bridge conversions in the latest linux-next, I
> > couldn't find a rule and the majority of bindings are still txt:
> >
> > $ find ./devicetree/bindings/display/bridge/ -name *txt | wc -l
> > 23
> > $ find ./devicetree/bindings/display/bridge/ -name *yaml | wc -l
> > 5
> >
> > So my questions are:
> > 1. Is there a general rule for assigning yaml file owners/maintainers?
> >
> > 2. Is this vagueness specific to the bridge dt bindings only?
> >
> > 3. Who should step up and maintain these bindings? Original/new authors,
> > SoC, bridge, DRM maintainers etc.?
> >
> > It would be useful to have a rule to make it easier to do these conversions.
> > We (Collabora) are considering doing the conversion work.
>
> For the panel conversion I did recently it was simple:
> 1) If listed in MAINTAINERS - use this info
> 2) Otherwise use the person(s) that authored the original .txt file.
>    Using git log --follow foo.txt
> 3) In a few cases I may have decided otherwise, but the above covers the
>    majority.

Yes.

> I would also be great if you or someone else could:
> - teach get_maintainers about .yaml file listed maintainers

It already does to some extent. IIRC, there's a mode to extract email
addresses from files.

I was hoping that the MAINTAINERS file split happens sometime and we
can just generate a MAINTAINERS file for bindings.

> - teach checkpatch that it is OK to convert .txt to .yaml

Yeah, I should fix my bug.

> - teach checkpatch about some simple yaml validation (maybe)

I don't see checkpatch being able to check much of what comes up in
review. Maybe indentation.

> I am looking forward to the day we have more .yaml files
> than .txt files in Documentation/devicetree/binding/*

700 vs. 3000 currently. It's about 60-70 new bindings and ~100
conversions per cycle. At this point we're review limited I think and
at the current rate, we should be done in 7 years. Yay! :( We need a
faster way.

Rob

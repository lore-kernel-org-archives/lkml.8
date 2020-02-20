Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8AAC34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECD320801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDmrtEDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgBTHDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:03:39 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:42153 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgBTHDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:03:38 -0500
Received: by mail-ot1-f45.google.com with SMTP id 66so2704219otd.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 23:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5E2ab5bQfBEgY4U6KD2KRUgY16A0wGI5TupMQRDmn4=;
        b=nDmrtEDs9AWEGU6QOOeO1Pq0SISrC6XvGGGjJN6ubYHZ/pmgcmuDIeMFN35fghE5wl
         YrfGs+qfqFBTyfUjVMRMR184DSzmzTP6fPQc1yQgZ61pRem9TevWRsyTj4HE2W3Rk9km
         QCANrnmQgQ0TZFJlgIfxGYuFbjSJ76lLFbplEhE3PG/OeXjoS64xg2bIR2sEmclTLMG6
         DOUPMmHCn6D4ALa78bgrhj9F4esIvn2Xm7kV3tOImV4Jl/rRdrzWk67T6TYUpmUJVo04
         x31xSOKZR/Vealwahr44Ye0gcXJldAdN86zWM2HXoWNX/ZK8QcqVVC6p5MC2OyOLqEKn
         jX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5E2ab5bQfBEgY4U6KD2KRUgY16A0wGI5TupMQRDmn4=;
        b=Qt/ycvccbRJnr26HeMQUuoOovtIhRp3iDUZv/N4FJAepq13vCQ2YkqQLI4FJFzol2P
         Uit9c/+MUp3EO3H4mfw7ky3V61uxZTdhSif/JieMeB1rnBtN2GDyctFPasYy5peZa7lv
         IY8e1vJtQpcPc3f5szzCDm0mmY6rJ7zNHFrVcK4VC0IPhI3DIEzNvnX7GYsrpbZnUNsr
         v2mL+Tra+D8LIPpp1dGoxvjDlBPVrIwcIJthkmZa3PZ8A5AEB02xIzv+GgTiNJ61tbjH
         DjNkowd0bbgXB7/cmMeu6uat9FEciq5gMvX/DirQuPPAIa1PXttNl32A3ovZSEyZwnzn
         67bQ==
X-Gm-Message-State: APjAAAXFMf3jrdNjhXWdXilWPG88GV9OhNFyoDP1lT/O+WeVEaXVRL97
        bjpWAKTHZesXWqfzqBxxL8m3eMrVdxh16eimga9Btw==
X-Google-Smtp-Source: APXvYqxZbcuG9HhmeNcK+8F7WgI3qxbSgTDunjRomLDiasX0m/M5ym7HAQ+BurTnx668TxcJS0mr+atsf8jiWqrJNCc=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr23603776otq.231.1582182217622;
 Wed, 19 Feb 2020 23:03:37 -0800 (PST)
MIME-Version: 1.0
References: <CAGETcx_pSnC_2D7ufLRyfE3b8uRc814XEf8zu+SpNtT7_Z8NLg@mail.gmail.com>
 <CAL_JsqKWcGSzCF_ZyEo6bbuayoYks51A-JAMp_oLR1RyTUzNUA@mail.gmail.com>
 <CAGETcx_RL4hHHA2MFTVyV1ivgghaBZePROXpnC-UUJ7tcH4kSQ@mail.gmail.com>
 <CAL_JsqJB+41Sjxi-udYzw8sAq0myrcnxjSyzrxeEsoctZX6pbw@mail.gmail.com>
 <CAGETcx9T_3GKgAj=3jANb=JAa5b5hP+r4CLVm9a2LYf2CQiH9Q@mail.gmail.com> <CAGETcx-_Mewt-ZND1WkjtdvLZ9iXTZBEdSPU6kO3G_L28mCHdQ@mail.gmail.com>
In-Reply-To: <CAGETcx-_Mewt-ZND1WkjtdvLZ9iXTZBEdSPU6kO3G_L28mCHdQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 19 Feb 2020 23:03:01 -0800
Message-ID: <CAGETcx_2vdjSWc3BBN-N2WrtJP90ZnH-2vE=2iVuHuaE1YmMWQ@mail.gmail.com>
Subject: Re: Adding depends-on DT binding to break cyclic dependencies
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 10:01 PM Saravana Kannan <saravanak@google.com> wrote:
>
> So we can take our time trying to solve this in a generic fashion (new
> DT property/binding, edit_links(), letting devices probe, etc). In the
> meantime, maybe we'll run into more cycle issues that'll give us a
> better idea of which solution would be better as a generic solution.

Mainly reviving an old thread to say this to Rob and Frank: Thanks for
pushing back on "depends-on" and asking me to use the existing
bindings instead. Saved a whole bunch of time when I actually tried to
use of_devlink. Didn't have to add stupid "depends-on" for all the
existing dependencies.

But then I've also been meaning to send an RFC for this following, so
rolling it into the same email.

Thanks for also pushing back on all the earlier "meh" solutions for
solving the cyclic dependency issue. I think I have a pretty good
proposal now.

While trying to solve the "dependencies of child nodes need to be
proxied by the parents till the child devices are created" problem, I
ended up having to add a "SYNC_STATE_ONLY" device link flag that
treats those dependencies as "optional for probing". It also allows
cycles (because it only affects sync state behavior). Also,
dependencies of child nodes (whether they are actually devices or not)
are always treated as "optional for probe" dependencies by of_devlink.

So, how does this affect cyclic dependencies? Obviously, when two
devices have cyclic dependencies, they don't have cyclic probe
dependencies. Then they'd never probe even if of_devlink is not in the
picture. At least one of the dependencies is only relevant for some
"post-probe" functionality.

So let's take a simple example:

dev_a: device-a@xxxx {
   compatible = "fizzbuzz";
}

dev_b: device-b@yyyy {
   compatible = "fizzbazz";
   supplier-property-1 = <&dev_a>;
   supplier-property-2 = <&dev_c>;
}

dev_c: device-c@zzzz {
   compatible = "fizzfizz";
   supplier-property-1 = <&dev_a>;
   supplier-property-3 = <&dev_b>;
}

Let's say dev_c only doesn't depend on dev_b for probing but needs it
only for some functionality "foo" (Eg: thermal management, secure
video playback, etc. Nothing OS specific). If the DT nodes are written
as above, then there'll be a cycle with of_devlink and neither dev_b
or dev_c will probe.

However, if we can write dev_c DT as:

dev_c: device-c@zzzz {
   compatible = "fizzfizz";
   supplier-property-1 = <&dev_a>;
   foo {
      /* No compatible property */
      supplier-property-2 = <&dev_b>;
   }
}

Then of_devlink will automatically treat dev_b as an optional
requirement for dev_c. I think this is also nice from a DT perspective
because it gives a clear representation of the dependency without
really breaking or adding any DT rules. If you need some DT bindings
only for a subset functionality, just list them under a child node
with a meaningful name for that functionality.

For this to work, the framework that supports "supplier-property-2"
will have to add APIs to "get" the supplier by passing a DT node
(instead of just struct device), but:
1) That is already supported by quite a few frameworks.
2) That shouldn't be too hard to add where necessary.

And the driver needs to handle the child node explicitly (kinda obvious).

Thoughts? Like the proposal?

-Saravana

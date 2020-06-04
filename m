Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715D8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB4620734
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sop3cyur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgFDF7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 01:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgFDF7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 01:59:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D29CC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 22:59:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j10so4669316wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 22:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FO6ddmmMOTqzEQzFeNiwRnQByIoMnIpEHIfJrVL2Z1w=;
        b=sop3cyur+ogstPxGG6m32GjjmzF8BI0wyDhCKwhQZkI5/EYFy29EbLmYMk5bEBmqKj
         2LYGFwWISKuoytG/jiCbncSEp4lqvh7dm8XleRdFmNyxs7vEIG7J2VR3NfuANV9v+fGc
         lqswC78Dt8neX4JDRNgF/XDzlq2jVfK5WQDmQyeQOGNbXpXS/mk1pxJ7HHmFJjr1UgH3
         8UsCfpl3youRSWz7IVzLNfEdvfzy6p5FYu2KVK3ozXML/h7KGjgKSijKEZHBEpepPot5
         oQsIYE+8AhnI3ocEoC1cwUwS79lx0hGoSlShqZQobkJvi3PSulY1tbIRzzJln8Wc35Nu
         Bw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FO6ddmmMOTqzEQzFeNiwRnQByIoMnIpEHIfJrVL2Z1w=;
        b=JoTKCJOevz5JGX14D34xT2Dkfg50nzQcbQH7utd1TqizyeQ6oUyfCshnT7MRSY8074
         OBTT2KDCVutS4PMaum9I7Uu40FAfFK25zVXDa7x/VS5LAydTcL5G2Q0kJUIfwTiF9FBu
         tDH0k5ne86wn/Nxkct424W0fZ314I/eqFWEYUlqtFLiS11wviPed4ZPvHNywe45p7SjL
         piCH1q0HeXUgRc4pVn0JN0Si31vi+mBM7GTpa1nE0egwOtJ+ul6MAmC0fyulYG8u/I4l
         uHQChhrX1CPcO82k/EgpBHZ2TK+3FmUnu5vyGybWJeQXh5/Z4mkmbuSqYwmq+I+iscy7
         +mYw==
X-Gm-Message-State: AOAM531yKCceFaX2QaQ2h8td4fjlxsM/yjbnsBtUWVHQTING8lpO2Zu+
        ng57YE2DbxIrYPayOi8Hv3tX9WSclzugJhc+rqk=
X-Google-Smtp-Source: ABdhPJyDoKq6+ihPF6HjLDzKQXQIKUaeKz80DVGCBc7oqL4oTwXJI5n5A/shzDK+XctpcYZHdi3iwjpfbCsyaTsNgCg=
X-Received: by 2002:adf:fec8:: with SMTP id q8mr2836519wrs.2.1591250340742;
 Wed, 03 Jun 2020 22:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAOGVgQGhWSdLA5my72P-Rz6b4UFJ2-1xZcdmDm5m=by7vRWDAA@mail.gmail.com>
 <CAOGVgQEOwRZoPkXwGO1+voD4Z5sPhLs_Q7piTUy15LmwPsZh4A@mail.gmail.com>
In-Reply-To: <CAOGVgQEOwRZoPkXwGO1+voD4Z5sPhLs_Q7piTUy15LmwPsZh4A@mail.gmail.com>
From:   Idan Yadgar <idanyadgar@gmail.com>
Date:   Thu, 4 Jun 2020 08:58:08 +0300
Message-ID: <CAOGVgQF2Pmcpei1RqMk+Kbk6VFXksdKmYcKG-1bxanRWia82zA@mail.gmail.com>
Subject: Re: Capabilities are list when creating a user namespace
To:     dhowells@redhat.com
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, armijn@tjaldur.nl,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, sorry for duplicating the previous email, forgot to send it to
the mailing lists as well.
Did you miss my email?

Idan Yadgar.

On Fri, May 29, 2020 at 5:48 PM Idan Yadgar <idanyadgar@gmail.com> wrote:
>
> Hello, did you miss my mail?
>
> =D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=D7=B3, 24 =
=D7=91=D7=9E=D7=90=D7=99 2020, 15:32, =D7=9E=D7=90=D7=AA Idan Yadgar =E2=80=
=8F<idanyadgar@gmail.com>:
>>
>> Hello,
>>
>> A process which changes its user namespace (unshare or setns), or a
>> process that is created by clone with the CLONE_NEWUSER flag has all
>> capabilities inside the new namespace, and loses all its capabilities
>> in the parent/previous user namespace.
>> This poses an issue because some operations require a capability in a
>> user namespace other then the current one for the process. The man
>> states multiple times that a system call requires a capability in the
>> initial user namespace (for example, open_by_handle_at requires
>> CAP_DAC_READ_SEARCH in the initial user namespace), but this cannot
>> happen unless the process is owned by root, thus preventing
>> open_by_handle_at to be run inside a user namespace.
>>
>> Solving this problem can be done by allowing (via prctl or any other
>> mechanism) a task to save its
>> capabilities for a given user namespace, even when it isn't a member
>> in that namespace.
>>
>> We would like to hear some thoughts about this issue and our proposed so=
lution.

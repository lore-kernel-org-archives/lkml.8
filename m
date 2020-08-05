Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD15C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B85F522D00
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbdFwCww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgHEQ6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgHEQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:56:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB546C061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 09:52:46 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w17so25558138ply.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 09:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXZGtsOURmZyHZLbU5fvxhNJ7/uuuH+Jf1Odf6vVQ/Y=;
        b=LbdFwCwwQ9+ZYyYA91SbJw79q5NmfsQ584hs+WRyh/6ENT1awKjxbLxxdjwZpDO0gW
         Tr8xIPC0qYpNF56Q/Vts64nXhmUpDrmJLjoqxk/snzwrty3UkfAgqdzR5hinsLeFi6zI
         R0hscqToNuNUSjBqXpBmkZOBp4sTvJCK+24di3gbiG9OWnxJYYP1bNtXGr9Q30ftrg8q
         vPn815m/91evw5LuxWkVMSPSZo6J39FiRaqdzSkpKUsghh81J8x/r1EPU6Nb+/hb8iwv
         nY6iURyZ+psWPW05NKmkzHzYlTDuN6KZ6xlntRf6Sn4Wii2ZfodpTQ2Z15XVy28LdWcO
         rpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXZGtsOURmZyHZLbU5fvxhNJ7/uuuH+Jf1Odf6vVQ/Y=;
        b=kGnl9/jCsbFAhpZuSSQWnJMY0Jvr8pgV4L0rjQNOUHZUgoV1rF85SNztAusp/1cOli
         Co/0XEy0NHqFZNgIwojNxXzd3sE0Bx4OBsJE3gxhZwZMoyW8K3chWP265A6yEpml8Vwf
         ZWRdMOfor+s1ywmyh8lFwdKE3G6RL1dSZwWdeWPpGojHLJQsjRPm7a/02uppqKyupt2X
         3NbttArBe3E2Fwiy+XZ8TiNqCL5d5lbTupar/fi+b7SXxM8ApgonVtmFX9L/kQGcmF+6
         vNxlXA0NamUfROrI+/b7FOAWoMYwWXM7lRGuFEY0Nc4qx1/y+R4CS9rR31PgZlptv+WN
         4xsQ==
X-Gm-Message-State: AOAM533z2BGAb9JPRBR9Gv9QUPNjfyMD3ateUzMkj2zZ+67/2wXt3bmD
        c/vgPwnKYsu+AuyzB8We8PgfjJ01aPG8V7X00sQ=
X-Google-Smtp-Source: ABdhPJzq2IoaaG/XACuojhMxN71N1xV8rgh0jzB4NCZ3up/DasYj5P+gibCzFgPgwUVAYsmZlRJnUeV8JfW04Jc8fHk=
X-Received: by 2002:a17:90a:148:: with SMTP id z8mr4414464pje.197.1596646366165;
 Wed, 05 Aug 2020 09:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594290158.git.vaibhav.sr@gmail.com> <896b8e24d990f2bca5aafaebd26e37095042951e.1594290158.git.vaibhav.sr@gmail.com>
 <7cbc0daa-993f-ffc9-78f4-b1e62fd54304@linaro.org>
In-Reply-To: <7cbc0daa-993f-ffc9-78f4-b1e62fd54304@linaro.org>
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
Date:   Wed, 5 Aug 2020 22:22:09 +0530
Message-ID: <CAAs364-PFw2OGGhwBH8RB7jBPD4Xre4puu9G-7P+z6Ur_Ni-yA@mail.gmail.com>
Subject: Re: [greybus-dev] [PATCH v4 1/7] staging: greybus: audio: Update
 snd_jack FW usage as per new APIs
To:     Alex Elder <elder@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        devel@driverdev.osuosl.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 6:35 PM Alex Elder <elder@linaro.org> wrote:
>
> On 7/9/20 5:27 AM, Vaibhav Agarwal wrote:
> > snd_soc_jack APIs are modified in recent kernel versions. This patch
> > updates the codec driver to resolve the compilation errors related to
> > jack framework.
>
> Greg has already accepted this series so I won't review this now.  But
> I still wanted to provide this comment.
>
> It would be helpful in the future to provide a little more information
> about the nature of the changes to these APIs.  As a reviewer I had to
> go track them down to get a little more context about what you are doing
> here.  So you could say something like:
>
>   Audio jacks are now registered at the card level rather than being
>   associated with a CODEC.  The new card-based API allows a jack's pins
>   to be supplied when the jack is first registered.  See: 970939964c26
>   ("ASoC: Allow to register jacks at the card level")
>
> In other words, don't just say "the APIs changed," say "here is how
> the APIs have changed."  This kind of introduction can be very helpful
> and time saving for your reviewers.
>

Thanks for the feedback Alex. I'll take care of the commit message while
sharing similar patches.

--
vaibhav

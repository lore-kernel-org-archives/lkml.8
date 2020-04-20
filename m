Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE26AC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D092080C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZN+XR78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgDTFwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 01:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgDTFwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 01:52:21 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4E4C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 22:52:19 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 188so3423365wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 22:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZh9O9dQhixsKvuVGrBKDAaEpvQNnr5CZYtC1ESPopQ=;
        b=FZN+XR78yJvaJ9z+CYSP5UDBlWleRebJVDY6qFZtERFem8sZ6fD34rOLYbyyPTXwz9
         Lo1BrxIHVr/u+W1zIQOd7H/q0SpNrZFZ4G8mkZ9bXCE3glYOsfO35iDUJE3fEQ23OvrV
         tBbLxOpMYFRhXbU3hG4yp1jepB30DQ1DxM6OU1mnjZALQ8Apk+38EsxNM0MWNQTDeEa8
         q0vaHYRFKswsQwtrnRfYu8Mlkp+VH5ZHMvRIZgEsrLtZri9uSyqr79lXv4z5qyYaicum
         G8KVmz75Fk7OAsT2rrSTv/iAAiE7fcrdjgEvYEeitVuAazaRosY1yUF86wE5Sjpn4FJg
         eejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZh9O9dQhixsKvuVGrBKDAaEpvQNnr5CZYtC1ESPopQ=;
        b=Dr+fZ2HV9h5IeHq9hCHdhDmRbR2yWfUAjRzugkVSDfbIrFtPaeWOmgvTVmX1SEyAYo
         VJwzVFCAw5DGTSgVe0o9ZM3L3tKq3fcaNXcaUQdDd1JXAZe9bYyKoogJ7zgv7Xi7R5au
         SiRJMONSNW4aTrQfdyrrqqs5/LiEd43LYMTmV/LaOg6ndaXZhVeVDBUgSIoCPsfWDy08
         QSmSGXzLt0EAqeEV89bydsf2MXbCU1qV5/NlhOyr6eD1LerBi+sWSvScBK7vm+lopAuo
         QpHyrkNkktyjV9HVUpd6hwYNjsriXjLBpnEc10lml6w5X6EkHhobj1zgaJJ3Vmyiecbq
         gxXA==
X-Gm-Message-State: AGi0Puah+GSmWY80UUR4hsm+J0izjDQ6u7YNrvfsWbsNFNYtADfW8kiy
        4z3Kd0a7djVSV3yHxolEDSEHp14ToWlNCyXUnR63Brq3fMU=
X-Google-Smtp-Source: APiQypJSDJ/Suv1Ueez858bw6fLogRBFQDEyxDGd0nPz4D7wBguIEaQJPp8VpmYGpzvRW5hV7BwudiNH9SChkIuUCZE=
X-Received: by 2002:a7b:c959:: with SMTP id i25mr15527042wml.20.1587361938365;
 Sun, 19 Apr 2020 22:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200419162943.3704-1-evalds.iodzevics@gmail.com>
 <20200419162943.3704-2-evalds.iodzevics@gmail.com> <20200419165453.GB3697654@kroah.com>
In-Reply-To: <20200419165453.GB3697654@kroah.com>
From:   Evalds Iodzevics <evalds.iodzevics@gmail.com>
Date:   Mon, 20 Apr 2020 08:52:07 +0300
Message-ID: <CADqhmmc4S=BPTGuK2iCxD0ZwHf8cobyFq4f+jsBtHZZJtJD+5A@mail.gmail.com>
Subject: Re: [PATCH 2/2] Fixed broken microcode early loading on 32 bit
 platforms because it always jumps past cpuid in sync_core() as data structure
 boot_cpu_data are not populated so early in boot. This is for 4.4. Should be
 done for 4.9 too
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, basically its a fix for early microcode load on x86 for 4.4 longterm
Just tried to say same problem exists on 4.9 too

On Sun, Apr 19, 2020 at 7:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Apr 19, 2020 at 07:29:43PM +0300, Evalds Iodzevics wrote:
> > ---
> >  arch/x86/include/asm/microcode_intel.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Your subject line is really confused :(
>

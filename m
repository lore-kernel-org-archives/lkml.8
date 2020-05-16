Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FFEC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8E8206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrCt+Jj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgEPPLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 11:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgEPPK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 11:10:58 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9850C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 08:10:58 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id d26so4388583otc.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8q941dGwnJbRAvZmwG3aF699VhyM+QSFprXWpD7W5dk=;
        b=HrCt+Jj2QuVhS/wpYHUxEK7wwM5VcUm95nne6KZwJOW9ID/kkh97fnfWDa5pBKCSfM
         6jyQqAFxKGjefmfnsh1Zp5E1pPRKezHUfRd2Wxt75kFwhMRL2goVPpUPE3f33ckHDVwg
         uDcMGVz8LvQvrxMtED+2u+9ZJuvyFB0oV3eNZs9rzfBlkQJjh8EtHEelK96RC8YSKOpE
         L6hF78m+XSphI8pOaQ1ydbG0r4Bvfzm+l8T17dGO8F32xNWEiEGOxvPsl9mEc5H7gUO2
         CN9Jj/79ZSx83aspcXKMiEdubqBg/53oYfZs1WHHY/NbbJ8BPg0j2NCHBLz84K3y0qVX
         aF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8q941dGwnJbRAvZmwG3aF699VhyM+QSFprXWpD7W5dk=;
        b=qBwriVtb/NF2VpkL1YzYDZ3HfmDQEqM+RY1wl9gtBvoBfUrqjO5cnQPW24JjdpWUtn
         3XvDVTb8/JL2u/g8u5aLYI5PmRGwTOBncSO5EjV/q3MV54GxcxM7c/jxdbGFMSPOFmcg
         cYJGzWhGVK11XKaSKFeNzCXDR4gmb+F7VAUP8aavNTkJA2UgOoF8cgoTAO9X5wddHUfx
         +f+kkVqeN9A5zqvfyDXaM/tqNY6S52Phiipy7/09yVnKnsCJpFcF1ReUiAA8TzW9hmDM
         wGwCZ3pxRqH2BAMLzpQBdD2FRz9gOJ0kFBkYiD8s8L7rw0Boe+WYpB1OsV2aPXy5qoAt
         7iSg==
X-Gm-Message-State: AOAM530JST9YUcOpFx97TTn1MNh8AsFdjazA7FoBLX2Y6AdWCjMuZlJC
        ZFbRjtZsHcEAIR8iez8mrveHBZD0x+b+RP6k12A=
X-Google-Smtp-Source: ABdhPJyb6ZWbzBNG3hx7hAl1QlsyNodfaVWPEU4SLUaYJfh23WL3r/8/1qYT+AiY6nAe58Qrc/05MEcPui+FsKlInxg=
X-Received: by 2002:a9d:7d8a:: with SMTP id j10mr5431293otn.266.1589641858007;
 Sat, 16 May 2020 08:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAPY=qRQ6gzN1BWh=ianVDBQ1C9kibWHwxs5Z0+QSwGxKymLDTQ@mail.gmail.com>
 <374485.1589637193@turing-police>
In-Reply-To: <374485.1589637193@turing-police>
From:   Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Date:   Sat, 16 May 2020 20:40:45 +0530
Message-ID: <CAPY=qRQQb9OPJYw6HvRhezPS8VwVHRmg-tTMug0CMOiiVrdJ=Q@mail.gmail.com>
Subject: Re: general protection fault vs Oops
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 7:23 PM Valdis Kl=C4=93tnieks
<valdis.kletnieks@vt.edu> wrote:
>
> On Sat, 16 May 2020 18:05:07 +0530, Subhashini Rao Beerisetty said:
>
> > In the first attempt when I run that test case I landed into =E2=80=9Cg=
eneral
> > protection fault: 0000 [#1] SMP" .. Next I rebooted and ran the same
> > test , but now it resulted the =E2=80=9COops: 0002 [#1] SMP".
>
> And the 0002 is telling you that there's been 2 previous bug/oops since t=
he
> reboot, so you need to go back through your dmesg and find the *first* on=
e.
I could not find Oops: 0001 in kern.log.
Actually I captured the crash call trace by running tail -f
/var/log/kern.log. But after reboot, I could not find the same in
kern.log file. Why the kernel failed to store in kern.log? In that
case how does tail command captured? Could you please clarify on
this..

$strings /var/log/kern.log | grep -i oops

>
> > In both cases the call trace looks exactly same and RIP points to
> > =E2=80=9Cnative_queued_spin_lock_slowpath+0xfe/0x170"..
>
> The first few entries in the call trace are the oops handler itself. So..=
.
>
>
> > May 16 12:06:17 test-pc kernel: [96934.567347] Call Trace:
> > May 16 12:06:17 test-pc kernel: [96934.569475]  [<ffffffff8183c427>]__r=
aw_spin_lock_irqsave+0x37/0x40
> > May 16 12:06:17 test-pc kernel: [96934.571686]  [<ffffffffc0606812>] ev=
ent_raise+0x22/0x60 [osa]
> > May 16 12:06:17 test-pc kernel: [96934.573935]  [<ffffffffc06aa2a4>] mu=
lti_q_completed_one_buffer+0x34/0x40 [mcore]
>
> The above line is the one where you hit the wall.
>
> > May 16 12:59:22 test-pc kernel: [ 3011.405602] Call Trace:
> > May 16 12:59:22 test-pc kernel: [ 3011.407892]  [<ffffffff8183c427>] _r=
aw_spin_lock_irqsave+0x37/0x40
> > May 16 12:59:22 test-pc kernel: [ 3011.410256]  [<ffffffffc0604812>] ev=
ent_raise+0x22/0x60 [osa]
> > May 16 12:59:22 test-pc kernel: [ 3011.412652]  [<ffffffffc06b72a4>] mu=
lti_q_completed_one_buffer+0x34/0x40 [mcore]
>
> And again.
>
> However,  given that it's a 4.4 kernel from 4 years ago, it's going to be
> hard to find anybody who really cares.
>
> In fact. I'm wondering if this is from some out-of-tree or vendor patch,
> because I'm not finding any sign of that function in either the 5.7 or 4.=
4
> tree.  Not even a sign of ## catenation abuse - no relevant hits for
> "completed_one_buffer" or "multi_q" either
>
> I don't think anybody's going to be able to help unless somebody first
> identifies where that function is....
>
